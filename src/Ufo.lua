Ufo = Class{}

function Ufo:init(def)
    self.texture = 'ufo'
    self.target = def.target
    local xLoc = {0, VIRTUAL_WIDTH}
    self.x = xLoc[math.random(2)]
    self.y = math.random(VIRTUAL_HEIGHT)
    self.width = 16
    self.height = 16
    local dir_table = {-1, 1}
    self.dx = dir_table[math.random(1, 2)] * math.random(25, 50)
    self.dy = dir_table[math.random(1, 2)] * (50 - math.abs(self.dx))
    self.bullets = {}
    self.dead = def.dead or false

    self.shootTimer = {}
    Timer.every(UFO_SHOOT_EVERY, function()
        if not self.dead then
            local direction = math.atan((self.target.y - self.y) / (self.target.x - self.x))
            if self.x > self.target.x then
                direction = direction + math.rad(180)
            end
            table.insert(self.bullets, Projectile({x = self.x + self.width / 2, y = self.y + self.height / 2, dir = direction, looping = false, spd = UFO_BULLET_SPEED}))
            gSounds['shoot']:stop()
            gSounds['shoot']:play()
        end
    end):group(self.shootTimer)

    gSounds['ufo_flies']:setLooping(true)
    gSounds['ufo_flies']:play()
end

function Ufo:update(dt)
    for k, bullet in pairs(self.bullets) do
        bullet:update(dt)
        if bullet:collides({x = self.target.x - self.target.width / 2,
                            y = self.target.y - self.target.height / 2,
                            width = self.target.width,
                            height = self.target.height}) then
            Event.dispatch('player_dies')
            table.remove(self.bullets, k)
        end
        if bullet.x < 0 or bullet.x > VIRTUAL_WIDTH or bullet.y < 0 or bullet.y > VIRTUAL_HEIGHT then
            table.remove(self.bullets, k)
        end
    end

    if not self.dead then
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
end

function Ufo:render()
    if not self.dead then
        love.graphics.draw(gTextures[self.texture], math.floor(self.x), math.floor(self.y))
    end

    for k, bullet in pairs(self.bullets) do
        bullet:render()
    end
end

function Ufo:dies()
    self.dead = true
    self.x = -100
    self.y = -100
    Timer.clear(self.shootTimer)
    self.bullets = {}
    gSounds['ufo_flies']:stop()
    gSounds['ship_explode']:stop()
    gSounds['ship_explode']:play()
    Event.dispatch('explode', {x = self.x + self.width / 2, y = self.y + self.height / 2, size = 20})
end