Asteroid = Class{}

function Asteroid:init(def)
    self.size = def.size
    self.x = def.x or 0
    self.y = def.y or 0
    self.dx = def.dx or math.random(2) == 1 and -math.random(5, 50) or math.random(5, 50)
    self.dy = def.dy or math.random(2) == 1 and -math.random(5, 50) or math.random(5, 50)
    self.width = def.size * 16
    self.height = def.size * 16
    self.sides = 8
    self:genShape()
    
    --[[ readjust size for hitbox purposes
    local max = self.points[1]
    local min = self.points[1]
    for i = 3, 15, 2 do
        max = math.max(max, self.points[i])
        min = math.min(min, self.points[i])
    end
    self.x = self.x + min
    self.width = max - min

    max = self.points[2]
    min = self.points[2]
    for i = 4, 16, 2 do
        max = math.max(max, self.points[i])
        min = math.min(min, self.points[i])
    end
    self.y = self.y + min
    self.height = max - min
    ]]
end

function Asteroid:genShape()
    self.points = {}
    for i = 1, 8, 1 do
        local x, y
        if i == 1 or i == 7 or i == 8 then
            x = math.random(math.floor(self.width / 3))
        elseif i == 2 or i == 6 then
            x = math.random(math.floor(self.width / 3) + 1, math.floor((2 * self.width) / 3))
        else
            x = math.random(math.floor((2 * self.width) / 3), math.floor((3 * self.width) / 3))
        end

        if i <= 3 then
            y = math.random(math.floor(self.height / 3))
        elseif i == 4 or i == 8 then
            y = math.random(math.floor(self.height / 3) + 1, math.floor((2 * self.height) / 3))
        else
            y = math.random(math.floor((2 * self.height) / 3), math.floor((3 * self.height) / 3))
        end

        table.insert(self.points, (i - 1) * 2 + 1, x)
        table.insert(self.points, i * 2, y)
    end
end

function Asteroid:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x < -self.width then
        self.x = VIRTUAL_WIDTH
    elseif self.x > VIRTUAL_WIDTH then
        self.x = -self.width
    end

    if self.y < -self.height then
        self.y = VIRTUAL_HEIGHT
    elseif self.y > VIRTUAL_HEIGHT then
        self.y = -self.height
    end
end

function Asteroid:render()
    local drawnPoints = {}
    for i in pairs(self.points) do
        if i % 2 == 0 then
            table.insert(drawnPoints, self.points[i] + self.y)
        else
            table.insert(drawnPoints, self.points[i] + self.x)
        end
    end
    love.graphics.polygon("line", drawnPoints)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.width)
end