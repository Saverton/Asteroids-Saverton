Level = Class{}

function Level:init(def)
    self.levelNum = def.levelNum or 1
    self.player = def.player
    self.player.x = VIRTUAL_WIDTH / 2
    self.player.y = VIRTUAL_HEIGHT / 2
    self:spawnAsteroids()
end

function Level:spawnAsteroids()
    local num_of_asteroids = math.random(math.floor(3 + self.levelNum / 3), math.floor(4 + self.levelNum / 3))
    self.asteroids = {}
    for i = 1, num_of_asteroids, 1 do
        table.insert(self.asteroids, Asteroid({
            size = ASTEROID_BIG,
            x = math.random(2) == 1 and math.random(0, 50) or math.random(VIRTUAL_WIDTH - 50, VIRTUAL_WIDTH),
            y = math.random(2) == 1 and math.random(0, 40) or math.random(VIRTUAL_HEIGHT - 40, VIRTUAL_HEIGHT)
        }))
    end
end

function Level:update(dt)
    for k, asteroid in pairs(self.asteroids) do
        asteroid:update(dt)
        if not self.player.dead and self.player:collides(asteroid) then
            -- player dies
            self.player.dead = true
            Event.dispatch('explode', {x = self.player.x, y = self.player.y, size = 20})
            Timer.after(1, function()
                self.player:dies()
            end)
        end
        for j, bullet in pairs(self.player.bullets) do
            if bullet:collides(asteroid) then
                table.remove(self.player.bullets, j)
                self.player.score = self.player.score + asteroid.size * 100
                if asteroid.size > 1 then
                    Event.dispatch('split-asteroid', asteroid)
                end
                table.remove(self.asteroids, k)
                Event.dispatch('explode', {x = asteroid.x + asteroid.size / 2, y = asteroid.y + asteroid.size / 2, size = asteroid.size * 10})
                if #self.asteroids == 0 then
                    Timer.after(1, function()
                        Event.dispatch('next_level', {level = self.levelNum + 1})
                    end)
                end
            end
        end
    end

    Timer.update(dt)
end

function Level:render()
    for k, asteroid in pairs(self.asteroids) do
        asteroid:render()
    end
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(tostring(self.levelNum), 0, 5, VIRTUAL_WIDTH, "center")
end

function Level:getLevelNum()
    return (self.levelNum)
end