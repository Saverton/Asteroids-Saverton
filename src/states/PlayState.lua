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
            dx = -parent_asteroid.dy,
            dy = parent_asteroid.dx,
            size = parent_asteroid.size - 1
        }))
        table.insert(self.level.asteroids, Asteroid({
            x = parent_asteroid.x,
            y = parent_asteroid.y,
            dx = parent_asteroid.dy,
            dy = -parent_asteroid.dx,
            size = parent_asteroid.size - 1
        }))
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
end

function PlayState:render()
    self.player:render()
    self.level:render()
end