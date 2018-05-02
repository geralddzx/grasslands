Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/Util'
require 'src/Animation'

require 'src/monster_defs'
require 'src/constants'

require 'src/Ground'
require 'src/Water'
require 'src/Air'

require 'src/Tree'

require 'src/Entity'
require 'src/Player'
require 'src/Monster'

require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerMoveState'
require 'src/states/monster/MonsterIdleState'

gTextures = {
    ['grassland_tiles'] = love.graphics.newImage('graphics/map/grassland_tiles.png'),
    ['clothes'] = love.graphics.newImage('graphics/player/clothes.png'),
    ['male_head1'] = love.graphics.newImage('graphics/player/male_head1.png'),
    ['dagger'] = love.graphics.newImage('graphics/player/dagger.png'),
    -- monsters
    ['antlion'] = love.graphics.newImage('graphics/monsters/antlion.png'),
    ['fire_ant'] = love.graphics.newImage('graphics/monsters/fire_ant.png'),
    ['ice_ant'] = love.graphics.newImage('graphics/monsters/ice_ant.png'),
    ['orc_elite'] = love.graphics.newImage('graphics/monsters/orc_elite.png'),
    ['orc_heavy'] = love.graphics.newImage('graphics/monsters/orc_heavy.png'),
    ['orc_regular'] = love.graphics.newImage('graphics/monsters/orc_regular.png'),
    ['spider'] = love.graphics.newImage('graphics/monsters/spider.png'),
    ['spider_giant'] = love.graphics.newImage('graphics/monsters/spider_giant.png'),
    ['spider_large'] = love.graphics.newImage('graphics/monsters/spider_large.png'),
    ['wyvern'] = love.graphics.newImage('graphics/monsters/wyvern.png'),
    ['wyvern_air'] = love.graphics.newImage('graphics/monsters/wyvern_air.png'),
    ['wyvern_fire'] = love.graphics.newImage('graphics/monsters/wyvern_fire.png'),
    ['wyvern_water'] = love.graphics.newImage('graphics/monsters/wyvern_water.png'),
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
    -- monsters
    ['antlion'] = Generate2DQuads(gTextures['antlion'], 128, 128),
    ['fire_ant'] = Generate2DQuads(gTextures['fire_ant'], 128, 128),
    ['ice_ant'] = Generate2DQuads(gTextures['ice_ant'], 128, 128),
    ['orc_elite'] = Generate2DQuads(gTextures['orc_elite'], 128, 128),
    ['orc_heavy'] = Generate2DQuads(gTextures['orc_heavy'], 128, 128),
    ['orc_regular'] = Generate2DQuads(gTextures['orc_regular'], 128, 128),
    ['spider'] = Generate2DQuads(gTextures['spider'], 128, 128),
    ['spider_giant'] = Generate2DQuads(gTextures['spider_giant'], 128, 128),
    ['spider_large'] = Generate2DQuads(gTextures['spider_large'], 128, 128),
    ['wyvern'] = Generate2DQuads(gTextures['wyvern'], 256, 256),
    ['wyvern_air'] = Generate2DQuads(gTextures['wyvern_air'], 256, 256),
    ['wyvern_fire'] = Generate2DQuads(gTextures['wyvern_fire'], 256, 256),
    ['wyvern_water'] = Generate2DQuads(gTextures['wyvern_water'], 256, 256),
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/grassy_world.mp3'),
}