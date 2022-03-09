Spaceship = Class{}

function Spaceship:init()
    self.texture = 'spaceship'
    self.speed = PLAYER_SPEED
    self.x = VIRTUAL_WIDTH / 2
    self.y = VIRTUAL_HEIGHT / 2
    self.size = PLAYER_SIZE
    self.dir = math.rad(90)
    self.dr = PLAYER_DIR_SPEED
    self.bullets = {}
    self.canShoot = true
    self.dead = false
end

function Spaceship:update(dt)
    if love.keyboard.isDown('left') then
        self.dir = (self.dir + self.dr * dt) % math.rad(360)
    elseif love.keyboard.isDown('right') then
        self.dir = (self.dir - self.dr * dt) % math.rad(360)
    end

    if love.keyboard.isDown('up') then
        self.x = self.x + math.floor(math.cos(self.dir) * self.speed) * dt
        self.y = self.y + math.floor(math.sin(self.dir) * self.speed) * dt
    elseif love.keyboard.isDown('down') then
        self.x = self.x - math.floor(math.cos(self.dir) * self.speed) * dt
        self.y = self.y - math.floor(math.sin(self.dir) * self.speed) * dt
    end

    if self.canShoot and love.keyboard.wasPressed('space') then
        self:shoot()
        self.canShoot = false
        Timer.after(0.5, function() self.canShoot = true end)
    end

    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end

    Timer.update(dt)
end

function Spaceship:shoot()
    table.insert(self.bullets, Projectile(self.x, self.y, self.dir))
end

function Spaceship:collides(target)
    local x = self.x - self.size / 2
    local y = self.y - self.size / 2
    return not (x + self.size < target.x or x > target.x + target.width or
                y + self.size < target.y or y > target.x + target.height)
end

function Spaceship:render()
    if not self.dead then
        love.graphics.draw(gTextures['spaceship'], self.x, self.y, (self.dir + math.rad(90)) % math.rad(360), 1, 1, self.size / 2, self.size / 2)
    end
    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end
end