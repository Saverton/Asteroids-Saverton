PlayState = Class{__includes = BaseState}

function PlayState:enter()
    self.player = Spaceship()
    self.level = Level({
        levelNum = 1,
        player = self.player
    })

    local splitHandler = Event.on('split-asteroid', function(parent_asteroid)
        table.insert(self.level.asteroids, Asteroid({
            x = parent_asteroid.x,
            y = parent_asteroid.y,
            dx = -parent_asteroid.dy * 1.5,
            dy = parent_asteroid.dx * 1.5,
            size = parent_asteroid.size - 1
        }))
        table.insert(self.level.asteroids, Asteroid({
            x = parent_asteroid.x,
            y = parent_asteroid.y,
            dx = parent_asteroid.dy * 1.5,
            dy = -parent_asteroid.dx * 1.5,
            size = parent_asteroid.size - 1
        }))
    end)

    self.explosions = {}
    local explosionHandler = Event.on('explode', function(def)
        table.insert(self.explosions, self:genExplosion(def.x, def.y, def.size))
        self.explosions[#self.explosions]:emit(def.size)
    end)

    local nextLevelHandler = Event.on('next_level', function(def)
        self.level.ufo:dies()
        self.level = Level({
            levelNum = def.level,
            player = self.player
        })
    end)

    local resetHandler = Event.on('reset_level', function()
        self.level = Level({
            levelNum = self.level:getLevelNum(),
            player = self.player
        })
    end)

    local deathHandler = Event.on('player_dies', function()
        self.player.dead = true
        Event.dispatch('explode', {x = self.player.x, y = self.player.y, size = 20})
        gSounds['ship_explode']:play()
        Timer.after(1, function()
            self.player:dies()
        end)
    end)

    local invincibleHandler = Event.on('player_invincible', function()
        self.player.invincible = true
        self.player.frameCount = 0
        Timer.after(PLAYER_INVINCIBILITY_TIMER, function()
            self.player.invincible = false
            self.player.canShoot = true
        end)
    end)

    Event.on('game_over', function()
        splitHandler:remove()
        explosionHandler:remove()
        resetHandler:remove()
        nextLevelHandler:remove()
        deathHandler:remove()
        invincibleHandler:remove()
    end)
end

function PlayState:update(dt)
    self.player:update(dt)
    self.level:update(dt)

    if love.keyboard.wasPressed('r') then
        GlobalStateMachine:change('play')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    for i, explosion in pairs(self.explosions) do
        explosion:update(dt)
        if explosion:getCount() == 0 then
            table.remove(self.explosions, i)
        end
    end
end

function PlayState:genExplosion(x, y, n)
    local explosion = love.graphics.newParticleSystem(gTextures['particle'], n)
    explosion:setPosition(x, y)
    explosion:setParticleLifetime(0.5, 1)
    explosion:setLinearAcceleration(-40, -40, 40, 40)
    explosion:setEmissionArea('normal', 3, 3)
    return explosion
end

function PlayState:render()
    self.player:render()
    self.level:render()
    for i in pairs(self.explosions) do
        love.graphics.draw(self.explosions[i], 0, 0)
    end
end

function PlayState:exit() 
    Event.dispatch('game_over')
end