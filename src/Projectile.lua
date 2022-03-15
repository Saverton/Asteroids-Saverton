Projectile = Class{}

function Projectile:init(def)
    self.x = def.x
    self.y = def.y
    self.dir = def.dir
    self.speed = BULLET_SPEED
    self.size = BULLET_SIZE
    self.lifetime = 0
    self.looping = def.looping
end

function Projectile:update(dt)
    self.x = self.x + (math.cos(self.dir) * self.speed) * dt
    self.y = self.y + (math.sin(self.dir) * self.speed) * dt
    self.lifetime = self.lifetime + dt

    if self.looping then
        if self.x < 0 then
            self.x = VIRTUAL_WIDTH
        elseif self.x > VIRTUAL_WIDTH then
            self.x = 0
        elseif self.y < 0 then
            self.y = VIRTUAL_HEIGHT
        elseif self.y > VIRTUAL_HEIGHT then
            self.y = 0
        end
    end
end

function Projectile:isDead()
    return self.lifetime > BULLET_LIFETIME
end

function Projectile:collides(target)
    return not (self.x < target.x or self.x > target.x + target.width or
                self.y < target.y or self.y > target.y + target.height)
end

function Projectile:render()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end