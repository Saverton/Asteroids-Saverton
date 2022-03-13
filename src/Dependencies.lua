Class = require 'library/class'
push = require 'library/push'
Timer = require 'library/knife.timer'
Event = require 'library/knife.Event'

require 'src/StateMachine'
require 'src/Util'
require 'src/constants'
require 'src/Button'
require 'src/Asteroid'
require 'src/Level'
require 'src/Spaceship'
require 'src/Projectile'

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'
require 'src/states/GameOverState'

GlobalStateMachine = StateMachine({
    ['play'] = function() return PlayState() end,
    ['start'] = function() return StartState() end,
    ['game-over'] = function() return GameOverState() end
})

gTextures = {
    ['particle'] = love.graphics.newImage('graphics/particle.png')
}

gSounds = {
}

gFonts = {
    ['large'] = love.graphics.newFont('font.ttf', 32),
    ['medium'] = love.graphics.newFont('font.ttf', 16),
    ['small'] = love.graphics.newFont('font.ttf', 8)
}