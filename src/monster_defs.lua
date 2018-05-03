MONSTER_DEFS = {
    {
        texture = 'antlion',
        offsetX = -4,
        offsetY = -2,
        radius = 0.5,
        level = 2,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['bleed'] = {25, 26, 27, 28, 29, 30, 31, 32}
        },
    }, {
        texture = 'fire_ant',
        offsetX = -4,
        offsetY = -2,
        level = 20,
        radius = 0.5,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['bleed'] = {25, 26, 27, 28, 29, 30, 31, 32}
        }
    }, {
        texture = 'ice_ant',
        offsetX = -4,
        offsetY = -2,
        level = 19,
        radius = 0.5,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['bleed'] = {25, 26, 27, 28, 29, 30, 31, 32}
        }
    }, {
        texture = 'orc_elite',
        offsetX = -4,
        offsetY = -2,
        level = 20,
        radius = 0.25,
        rate = 0.2,
        sounds = 'ogre',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['hit'] = {25, 26, 27, 28},
            ['shoot'] = {25, 26, 27, 28}
        }
    }, {
        texture = 'orc_heavy',
        offsetX = -4,
        offsetY = -2,
        level = 15,
        radius = 0.25,
        rate = 0.2,
        sounds = 'ogre',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['hit'] = {25, 26, 27, 28},
            ['shoot'] = {25, 26, 27, 28}
        }
    }, {
        texture = 'orc_regular',
        offsetX = -4,
        offsetY = -2,
        level = 5,
        radius = 0.25,
        rate = 0.2,
        sounds = 'ogre',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['block'] = {17, 18},
            ['death'] = {19, 20, 21, 22, 23, 24},
            ['hit'] = {25, 26, 27, 28},
            ['shoot'] = {25, 26, 27, 28}
        }
    }, {
        texture = 'spider',
        offsetX = -4,
        offsetY = -2,
        level = 1,
        radius = 0.5,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['death'] = {17, 18, 19, 20, 21, 22, 23, 24},
            ['block'] = {29, 30, 32},
        }
    }, {
        texture = 'spider_giant',
        offsetX = -4,
        offsetY = -2,
        level = 5,
        radius = 0.75,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['death'] = {17, 18, 19, 20, 21, 22, 23, 24},
            ['hit'] = {25, 26, 27, 28},
            ['block'] = {29, 30, 32},
        }
    }, {
        texture = 'spider_large',
        offsetX = -4,
        offsetY = -2,
        level = 10,
        radius = 0.5,
        rate = 0.2,
        sounds = 'beetle',
        states = {
            ['idle'] = {1, 2, 3, 4, 3, 2},
            ['walking'] = {5, 6, 7, 8, 9, 10, 11, 12},
            ['attack'] = {13, 14, 15, 16},
            ['death'] = {17, 18, 19, 20, 21, 22, 23, 24},
            ['hit'] = {25, 26, 27, 28},
            ['jump'] = {29, 30, 31, 32},
            ['block'] = {29, 30, 32},
        }
    }, {
        texture = 'wyvern',
        offsetX = -7.5,
        offsetY = -3.5,
        level = 25,
        radius = 0.5,
        rate = 0.1,
        sounds = 'beast',
        states = {
            ['idle'] = {1, 2, 3, 4, 5, 6, 7, 8},
            ['move'] = {9, 10, 11, 12, 13, 14, 15, 16},
            ['attack'] = {17, 18, 19, 20, 21, 22, 23, 24},
            ['block'] = {41, 42, 43, 44, 45, 46, 47, 48},
            ['death'] = {49, 50, 51, 52, 53, 54, 55, 56},
        }
    }, 
}

-- {
--     texture = 'wyvern_air',
--     offsetX = -7.5,
--     offsetY = -3.5,
--     level = 31,
--     radius = 0.5,
--     rate = 0.1,
--     sounds = 'beast',
--     states = {
--         ['idle'] = {1, 2, 3, 4, 5, 6, 7, 8},
--         ['move'] = {9, 10, 11, 12, 13, 14, 15, 16},
--         ['attack'] = {17, 18, 19, 20, 21, 22, 23, 24},
--         ['block'] = {41, 42, 43, 44, 45, 46, 47, 48},
--         ['death'] = {49, 50, 51, 52, 53, 54, 55, 56},
--     }
-- }, {
--     texture = 'wyvern_fire',
--     offsetX = -7.5,
--     offsetY = -3.5,
--     level = 32,
--     radius = 0.5,
--     rate = 0.1,
--     sounds = 'beast',
--     states = {
--         ['idle'] = {1, 2, 3, 4, 5, 6, 7, 8},
--         ['move'] = {9, 10, 11, 12, 13, 14, 15, 16},
--         ['attack'] = {17, 18, 19, 20, 21, 22, 23, 24},
--         ['block'] = {41, 42, 43, 44, 45, 46, 47, 48},
--         ['death'] = {49, 50, 51, 52, 53, 54, 55, 56},
--     }
-- }, {
--     texture = 'wyvern_water',
--     offsetX = -7.5,
--     offsetY = -3.5,
--     level = 31,
--     radius = 0.5,
--     rate = 0.1,
--     sounds = 'beast',
--     states = {
--         ['idle'] = {1, 2, 3, 4, 5, 6, 7, 8},
--         ['move'] = {9, 10, 11, 12, 13, 14, 15, 16},
--         ['attack'] = {17, 18, 19, 20, 21, 22, 23, 24},
--         ['block'] = {41, 42, 43, 44, 45, 46, 47, 48},
--         ['death'] = {49, 50, 51, 52, 53, 54, 55, 56},
--     }
-- }