Class = require 'library/class'
push = require 'library/push'
Timer = require 'library/knife.timer'
Event = require 'library/knife.event'

require 'src/StateMachine'
require 'src/Util'
require 'src/constants'
require 'src/Button'
require 'src/Asteroid'
require 'src/Level'
require 'src/Spaceship'
require 'src/Projectile'
require 'src/Ufo'

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
    ['particle'] = love.graphics.newImage('graphics/particle.png'),
    ['ufo'] = love.graphics.newImage('graphics/ufo.png')
}

gSounds = {
    ['shoot'] = love.audio.newSource('sounds/ship_shoots.wav', 'static'),
    ['asteroid_explode'] = love.audio.newSource('sounds/asteroid_explodes.wav', 'static'),
    ['ship_explode'] = love.audio.newSource('sounds/ship_explodes.wav', 'static'),
    ['ufo_flies'] = love.audio.newSource('sounds/ufo_flies.wav', 'static'),
    ['music'] = love.audio.newSource('sounds/Free_Floating.mp3', 'static')
}

gFonts = {
    ['large'] = love.graphics.newFont('font.ttf', 32),
    ['medium'] = love.graphics.newFont('font.ttf', 16),
    ['small'] = love.graphics.newFont('font.ttf', 8)
}