Button = Class{}

function Button:init(x, y, w, h, text)
    self.x = x
    self.y = y
    self.width = w
    self.height = h

    self.text = text or ''
end

function Button:isPressed()
    if self:containsMouse() and MouseInput.b == 1 then
        return true
    end
    return false
end

function Button:containsMouse()
    return CursorCollides(self.x, self.y, self.width, self.height)
end

function Button:render()
    if self:containsMouse() then
        love.graphics.setColor(1, 0, 0, 1)
    end
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf(self.text, 0, self.y + math.max(self.height - 16, 2), VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1, 1, 1, 1)
end

function Button:setText(text)
    self.text = text
end