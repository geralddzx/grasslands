Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/Util'
require 'src/Animation'

require 'src/monster_defs'
require 'src/equipment_defs'
require 'src/wall_defs'
require 'src/constants'

require 'src/Ground'
require 'src/Air'
require 'src/Panel'

require 'src/Tree'
require 'src/Entity'
require 'src/Player'
require 'src/Monster'
require 'src/Equipment'

require 'src/states/BaseState'
require 'src/states/game/PlayState'
require 'src/states/game/StartState'

require 'src/states/player/PlayerIdleState'
require 'src/states/player/PlayerMoveState'
require 'src/states/player/PlayerAttackState'
require 'src/states/player/PlayerHurtState'
require 'src/states/player/PlayerDeathState'

require 'src/states/monster/MonsterIdleState'
require 'src/states/monster/MonsterMoveState'
require 'src/states/monster/MonsterHurtState'
require 'src/states/monster/MonsterAttackState'
require 'src/states/monster/MonsterDeathState'

gTextures = {
    ['grassland_tiles'] = love.graphics.newImage('graphics/map/grassland_tiles.png'),
    -- interface
    ['panel'] = love.graphics.newImage('graphics/interface/panel.tga'),
    ['tile'] = love.graphics.newImage('graphics/interface/tile.tga'),
    ['empty_bar'] = love.graphics.newImage('graphics/interface/empty_bar.png'),
    ['red_bar'] = love.graphics.newImage('graphics/interface/red_bar.png'),
    ['green_bar'] = love.graphics.newImage('graphics/interface/green_bar.png'),
    -- equipment
    ['clothes'] = love.graphics.newImage('graphics/player/clothes.png'),
    ['male_head1'] = love.graphics.newImage('graphics/player/male_head1.png'),
    ['dagger'] = love.graphics.newImage('graphics/player/dagger.png'),
    ['shield'] = love.graphics.newImage('graphics/player/shield.png'),
    ['greatsword'] = love.graphics.newImage('graphics/player/greatsword.png'),
    ['leather_armor'] = love.graphics.newImage('graphics/player/leather_armor.png'),
    ['longsword'] = love.graphics.newImage('graphics/player/longsword.png'),
    ['rod'] = love.graphics.newImage('graphics/player/rod.png'),
    ['shortsword'] = love.graphics.newImage('graphics/player/shortsword.png'),
    ['steel_armor'] = love.graphics.newImage('graphics/player/steel_armor.png'),
    ['buckler'] = love.graphics.newImage('graphics/player/buckler.png'),
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
    ['walls'] = GenerateWallQuads(gTextures['grassland_tiles']),
    ['bushes'] = Slice(GenerateQuads(gTextures['grassland_tiles'], 64, 64), 81, 96),
    ['trees'] = GenerateTreeQuads(gTextures['grassland_tiles']),
    -- equipment
    ['shield'] = Generate2DQuads(gTextures['shield'], 128, 128),
    ['greatsword'] = Generate2DQuads(gTextures['greatsword'], 128, 128),
    ['leather_armor'] = Generate2DQuads(gTextures['leather_armor'], 128, 128),
    ['longsword'] = Generate2DQuads(gTextures['longsword'], 128, 128),
    ['rod'] = Generate2DQuads(gTextures['rod'], 128, 128),
    ['shortsword'] = Generate2DQuads(gTextures['shortsword'], 128, 128),
    ['steel_armor'] = Generate2DQuads(gTextures['steel_armor'], 128, 128),
    ['clothes'] = Generate2DQuads(gTextures['clothes'], 128, 128),
    ['male_head1'] = Generate2DQuads(gTextures['male_head1'], 128, 128),
    ['dagger'] = Generate2DQuads(gTextures['dagger'], 128, 128),
    ['buckler'] = Generate2DQuads(gTextures['buckler'], 128, 128),
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
    ['equipment'] = {
        ['interface1'] = love.audio.newSource('sounds/equipment/interface1.wav'),
        ['armor-light'] = love.audio.newSource('sounds/equipment/armor-light.wav'),
        ['cloth-heavy'] = love.audio.newSource('sounds/equipment/cloth-heavy.wav'),
        ['cloth'] = love.audio.newSource('sounds/equipment/cloth.wav'),
        ['metal-small1'] = love.audio.newSource('sounds/equipment/metal-small1.wav'),
        ['metal-small2'] = love.audio.newSource('sounds/equipment/metal-small2.wav'),
        ['metal-small3'] = love.audio.newSource('sounds/equipment/metal-small3.wav'),
        ['sword-unsheathe'] = love.audio.newSource('sounds/equipment/sword-unsheathe.wav'),
        ['sword-unsheathe2'] = love.audio.newSource('sounds/equipment/sword-unsheathe2.wav'),
        ['sword-unsheathe3'] = love.audio.newSource('sounds/equipment/sword-unsheathe3.wav'),
        ['sword-unsheathe4'] = love.audio.newSource('sounds/equipment/sword-unsheathe4.wav'),
        ['sword-unsheathe5'] = love.audio.newSource('sounds/equipment/sword-unsheathe5.wav'),
    },
    ['player'] = {
        attack = {
            love.audio.newSource('sounds/battle/swing.wav'),
            love.audio.newSource('sounds/battle/swing2.wav'),
            love.audio.newSource('sounds/battle/swing3.wav'),
        },
        hurt = {
            love.audio.newSource('sounds/player/pain1.wav'),
            love.audio.newSource('sounds/player/pain2.wav'),
            love.audio.newSource('sounds/player/pain3.wav'),
            love.audio.newSource('sounds/player/pain4.wav'),
            love.audio.newSource('sounds/player/pain5.wav'),
            love.audio.newSource('sounds/player/pain6.wav'),
            love.audio.newSource('sounds/player/painh.wav'),
            love.audio.newSource('sounds/player/paino.wav'),
        },
        death = love.audio.newSource('sounds/player/deathh.wav')
    },
    ['beetle'] = {
        attack = {
            love.audio.newSource('sounds/beetle/bite-small2.wav'),
            love.audio.newSource('sounds/beetle/bite-small3.wav'),
        },
        hurt = {
            love.audio.newSource('sounds/beetle/bite-small.wav'),
        }
    },
    ['ogre'] = {
        attack = {
            love.audio.newSource('sounds/ogre/ogre1.wav'),
            love.audio.newSource('sounds/ogre/ogre2.wav'),
        },
        hurt = {
            love.audio.newSource('sounds/ogre/ogre3.wav'),
            love.audio.newSource('sounds/ogre/ogre4.wav'),
            love.audio.newSource('sounds/ogre/ogre5.wav'),
        }
    },
    ['beast'] = {
        attack = {
            love.audio.newSource('sounds/beast/mnstr1.wav'),
            love.audio.newSource('sounds/beast/mnstr2.wav'),
            love.audio.newSource('sounds/beast/mnstr3.wav'),
            love.audio.newSource('sounds/beast/mnstr4.wav'),
            love.audio.newSource('sounds/beast/mnstr5.wav'),
            love.audio.newSource('sounds/beast/mnstr6.wav'),
            love.audio.newSource('sounds/beast/mnstr7.wav'),
            love.audio.newSource('sounds/beast/mnstr8.wav'),
            love.audio.newSource('sounds/beast/mnstr9.wav'),
            love.audio.newSource('sounds/beast/mnstr10.wav'),
        },
        hurt = {
            love.audio.newSource('sounds/beast/mnstr11.wav'),
            love.audio.newSource('sounds/beast/mnstr12.wav'),
            love.audio.newSource('sounds/beast/mnstr13.wav'),
            love.audio.newSource('sounds/beast/mnstr14.wav'),
            love.audio.newSource('sounds/beast/mnstr15.wav'),
        }
    } 
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/knights-quest.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/knights-quest.ttf', 32),
    ['huge'] = love.graphics.newFont('fonts/knights-quest.ttf', 48)
}