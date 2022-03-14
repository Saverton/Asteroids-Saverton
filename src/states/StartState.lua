StartState = Class{__includes = BaseState}

function StartState:enter()
    self.start = Button(VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 20, 100, 20, 'START')
    self.exit = Button(VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 + 10, 100, 20, 'EXIT')
end

function StartState:update(dt)
    if self.start:isPressed() then
        GlobalStateMachine:change('play')
    end

    if self.exit:isPressed() or love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('ASTEROIDS', 0, 60, VIRTUAL_WIDTH, 'center')
    self.start:render()
    self.exit:render()
end

function StartState:exit() end