Projectile = Class{}

function Projectile:init(x, y, dir)
    self.x = x
    self.y = y
    self.dir = dir
    self.speed = BULLET_SPEED
    self.size = BULLET_SIZE
end

function Projectile:update(dt)
    self.x = self.x + (math.cos(self.dir) * self.speed) * dt
    self.y = self.y + (math.sin(self.dir) * self.speed) * dt
end

function Projectile:isOffScreen()
    return self.x < 0 or self.y < 0 or self.x > VIRTUAL_WIDTH or self.y > VIRTUAL_HEIGHT
end

function Projectile:collides(target)
    return not (self.x < target.x or self.x > target.x + target.width or
                self.y < target.y or self.y > target.x + target.height)
end

function Projectile:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end