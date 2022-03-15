Level = Class{}

function Level:init(def)
    self.levelNum = def.levelNum or 1
    self.player = def.player
    self:spawnAsteroids()
    self.ufo = Ufo({
        target = self.player,
        dead = true
    })
    Timer.every(math.max(11 - self.levelNum, 2), function()
        if self.ufo.dead and math.random(3) == 1 then
            self.ufo = Ufo({
                target = self.player,
                dead = false
            })
        end
    end)
    
    gSounds['ufo_flies']:stop()
    Event.dispatch('player_invincible')
end

function Level:spawnAsteroids()
    local num_of_asteroids = math.random(math.floor(3 + self.levelNum / 3), math.floor(4 + self.levelNum / 3))
    self.asteroids = {}
    for i = 1, num_of_asteroids, 1 do
        local asteroid
        repeat
            asteroid = Asteroid({
                size = ASTEROID_BIG,
                x = math.random(2) == 1 and math.random(0, 50) or math.random(VIRTUAL_WIDTH - 50, VIRTUAL_WIDTH),
                y = math.random(2) == 1 and math.random(0, 40) or math.random(VIRTUAL_HEIGHT - 40, VIRTUAL_HEIGHT)
            })
        until not self.player:collides(asteroid)
        table.insert(self.asteroids, asteroid)
    end
end

function Level:update(dt)
    for k, asteroid in pairs(self.asteroids) do
        asteroid:update(dt)
        if not self.player.dead and not self.player.invincible and self.player:collides(asteroid) then
            -- player dies
            Event.dispatch('player_dies')
        end
        for j, bullet in pairs(self.player.bullets) do
            if bullet:collides(asteroid) then
                table.remove(self.player.bullets, j)
                self.player.score = self.player.score + asteroid.size * 100
                if asteroid.size > 1 then
                    Event.dispatch('split-asteroid', asteroid)
                end
                table.remove(self.asteroids, k)
                gSounds['asteroid_explode']:stop()
                gSounds['asteroid_explode']:play()
                Event.dispatch('explode', {x = asteroid.x + asteroid.size / 2, y = asteroid.y + asteroid.size / 2, size = asteroid.size * 10})
                if #self.asteroids == 0 then
                    Timer.after(1, function()
                        Event.dispatch('next_level', {level = self.levelNum + 1})
                    end)
                end
            end
        end
    end

    if not self.ufo.dead then
        self.ufo:update(dt)

        for k, bullet in pairs(self.player.bullets) do
            if not self.player.dead and not self.player.invincible and bullet:collides(self.ufo) then
                table.remove(self.player.bullets, k)
                self.ufo:dies()
                break
            end
        end
    end

    Timer.update(dt)
end

function Level:render()
    for k, asteroid in pairs(self.asteroids) do
        asteroid:render()
    end
    self.ufo:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(tostring(self.levelNum), 0, 5, VIRTUAL_WIDTH, "center")
end

function Level:getLevelNum()
    return (self.levelNum)
end