Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/Util'
require 'src/Animation'

require 'src/constants'

require 'src/Ground'
require 'src/Water'
require 'src/Tree'

require 'src/Entity'
require 'src/Player'

require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerRunState'

gTextures = {
    ['grassland_tiles'] = love.graphics.newImage('graphics/map/grassland_tiles.png'),
    ['clothes'] = love.graphics.newImage('graphics/player/clothes.png'),
    ['male_head1'] = love.graphics.newImage('graphics/player/male_head1.png'),
    ['dagger'] = love.graphics.newImage('graphics/player/dagger.png'),
}

gCursors = {
    ['open'] = love.graphics.newImage('graphics/cursors/glove1.png'),
    ['close'] = love.graphics.newImage('graphics/cursors/glove2.png'),
    ['point'] = love.graphics.newImage('graphics/cursors/glove3.png'),
}

gFrames = {
    ['grassland_tiles'] = GenerateQuads(gTextures['grassland_tiles'], 64, 32),
    ['bushes'] = Slice(GenerateQuads(gTextures['grassland_tiles'], 64, 64), 81, 96),
    ['trees'] = GenerateTreeQuads(gTextures['grassland_tiles']),
    ['clothes'] = Generate2DQuads(gTextures['clothes'], 128, 128),
    ['male_head1'] = Generate2DQuads(gTextures['male_head1'], 128, 128),
    ['dagger'] = Generate2DQuads(gTextures['dagger'], 128, 128),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/grassy_world.mp3'),
}