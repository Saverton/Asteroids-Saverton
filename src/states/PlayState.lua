PlayState = Class{__includes = BaseState}

function PlayState:enter()
    self.player = Spaceship()
    self.level = Level({
        levelNum = 1,
        player = self.player
    })

    Event.on('split-asteroid', function(parent_asteroid)
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
        Event.dispatch('explode', {x = parent_asteroid.x, y = parent_asteroid.y})
    end)

    self.explosions = {}
    Event.on('explode', function(def)
        table.insert(self.explosions, self:genExplosion(def.x, def.y))
        self.explosions[#self.explosions]:emit(30)
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

function PlayState:genExplosion(x, y)
    local explosion = love.graphics.newParticleSystem(gTextures['particle'], 30)
    explosion:setPosition(x, y)
    explosion:setParticleLifetime(0.5, 1)
    --explosion:setSpeed(30, 50)
    --explosion:setDirection(2 * math.pi)
    explosion:setEmissionArea('normal', 3, 3, 2 * math.pi)
    return explosion
end

function PlayState:render()
    self.player:render()
    self.level:render()
    for i in pairs(self.explosions) do
        love.graphics.draw(self.explosions[i], 0, 0)
    end
end