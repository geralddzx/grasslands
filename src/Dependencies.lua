Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/Util'

require 'src/constants'

require 'src/Ground'
require 'src/Water'

require 'src/states/BaseState'

require 'src/states/game/PlayState'

gTextures = {
    ['grassland_tiles'] = love.graphics.newImage('graphics/map/grassland_tiles.png'),
}

gCursors = {
    ['open'] = love.graphics.newImage('graphics/cursors/glove1.png'),
    ['close'] = love.graphics.newImage('graphics/cursors/glove2.png'),
    ['point'] = love.graphics.newImage('graphics/cursors/glove3.png'),
}

gFrames = {
    ['grassland_tiles'] = GenerateQuads(gTextures['grassland_tiles'], 64, 32),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/grassy_world.mp3'),
}