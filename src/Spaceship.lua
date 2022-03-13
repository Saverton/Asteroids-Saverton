Spaceship = Class{}

function Spaceship:init()
    local originX = VIRTUAL_WIDTH / 2
    local originY = VIRTUAL_HEIGHT / 2
    self.speed = 0
    self.x = originX
    self.y = originY
    self.width = PLAYER_WIDTH
    self.height = PLAYER_HEIGHT
    self.dir = math.rad(90)
    self.points = {originX + math.cos(self.dir) * 8, 
        originY + math.sin(self.dir) * 8, 
        originX + math.cos(self.dir + (2 * math.pi / 3)) * 4,
        originY + math.sin(self.dir + (2 * math.pi / 3)) * 4,
        originX + math.cos(self.dir + (4 * math.pi / 3)) * 4,
        originY + math.sin(self.dir + (4 * math.pi / 3)) * 4,
    }
    self.dr = 0
    self.bullets = {}
    self.canShoot = true
    self.dead = false
end

function Spaceship:update(dt)
    local updatePos = false

    if love.keyboard.isDown('left') then
        self.dr = math.min(self.dr + PLAYER_DIR_ACCELERATION * dt, PLAYER_DIR_SPEED)
    elseif love.keyboard.isDown('right') then
        self.dr = math.max(self.dr - PLAYER_DIR_ACCELERATION * dt, -PLAYER_DIR_SPEED)
    elseif self.dr > 0 then
        self.dr = math.max(self.dr - PLAYER_DIR_ACCELERATION * dt, 0)
    elseif self.dr < 0 then
        self.dr = math.min(self.dr + PLAYER_DIR_ACCELERATION * dt, 0)
    end

    if self.dr ~= 0 then
        self.dir = (self.dir - self.dr * dt) % math.rad(360)
        updatePos = true
    end

    if love.keyboard.isDown('up') then
        self.speed = math.min(self.speed + PLAYER_ACCELERATION * dt, PLAYER_SPEED)
    elseif love.keyboard.isDown('down') then
        self.speed = math.max(self.speed - PLAYER_ACCELERATION * dt, -PLAYER_SPEED)
    elseif self.speed > 0 then
        self.speed = math.max(self.speed - PLAYER_ACCELERATION / 2 * dt, 0)
    elseif self.speed < 0 then
        self.speed = math.min(self.speed + PLAYER_ACCELERATION / 2 * dt, 0)
    end

    if self.speed ~= 0 then
        self.x = self.x + math.floor(math.cos(self.dir) * self.speed) * dt
        self.y = self.y + math.floor(math.sin(self.dir) * self.speed) * dt
        --player loops edges
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
        updatePos = true
    end

    if self.canShoot and love.keyboard.wasPressed('space') then
        self:shoot()
        self.canShoot = false
        Timer.after(0.25, function() self.canShoot = true end)
    end

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end

    if updatePos then
        self:updatePosition()
    end
end

function Spaceship:updatePosition()
    self.points = {self.x + math.cos(self.dir) * 8, 
        self.y + math.sin(self.dir) * 8, 
        self.x + math.cos(self.dir + (2 * math.pi / 3)) * 4,
        self.y + math.sin(self.dir + (2 * math.pi / 3)) * 4,
        self.x + math.cos(self.dir + (4 * math.pi / 3)) * 4,
        self.y + math.sin(self.dir + (4 * math.pi / 3)) * 4,
    }
end

function Spaceship:shoot()
    table.insert(self.bullets, Projectile(self.x, self.y, self.dir))
end

function Spaceship:collides(target)
    local x = self.x - self.width / 2
    local y = self.y - self.height / 2
    return not (x + self.width < target.x or x > target.x + target.width or
                y + self.height < target.y or y > target.y + target.height)
end

function Spaceship:render()
    if not self.dead then
        love.graphics.polygon('line', self.points)
    end
    --love.graphics.rectangle('line', self.x - self.width / 2, self.y - self.height / 2, self.width, self.height)
    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end
end