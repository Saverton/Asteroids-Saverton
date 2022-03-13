Level = Class{}

function Level:init(def)
    self.levelNum = def.levelNum or 1
    self.player = def.player
    self:spawnAsteroids()
end

function Level:spawnAsteroids()
    local num_of_asteroids = 1--math.random(math.floor(5 + self.levelNum / 3), math.floor(9 + self.levelNum / 3))
    self.asteroids = {}
    for i = 1, num_of_asteroids, 1 do
        table.insert(self.asteroids, Asteroid({
            size = ASTEROID_BIG}))
    end
end

function Level:update(dt)
    for k, asteroid in pairs(self.asteroids) do
        asteroid:update(dt)
        if self.player:collides(asteroid) then
            -- player dies
            self.player.dead = true
            GlobalStateMachine:change('play')
        end
        for j, bullet in pairs(self.player.bullets) do
            if bullet:collides(asteroid) then
                table.remove(self.player.bullets, j)
                if asteroid.size > 1 then
                    Event.dispatch('split-asteroid', asteroid)
                end
                table.remove(self.asteroids, k)
            end
        end
    end

    -- check collision
end

function Level:render()
    for k, asteroid in pairs(self.asteroids) do
        asteroid:render()
    end
end