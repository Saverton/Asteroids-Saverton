GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.start = Button(VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 20, 100, 20, 'RESTART')
    self.exit = Button(VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 + 10, 100, 20, 'EXIT')
end

function GameOverState:update(dt)
    if self.start:isPressed() then
        GlobalStateMachine:change('play')
    end

    if self.exit:isPressed() or love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('GAME OVER', 0, 60, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('SCORE: ' .. tostring(self.score), 0, 85, VIRTUAL_WIDTH, 'center')
    self.start:render()
    self.exit:render()
end