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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['bleed'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28, 29, 30, 31, 32}
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['bleed'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28, 29, 30, 31, 32}
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['bleed'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28, 29, 30, 31, 32}
            },
        }
    }, {
        texture = 'orc_elite',
        offsetX = -4,
        offsetY = -2,
        level = 20,
        radius = 0.25,
        rate = 0.25,
        sounds = 'ogre',
        states = {
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.1, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['hit'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28},
            },
            ['shoot'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28}
            },
        }
    }, {
        texture = 'orc_heavy',
        offsetX = -4,
        offsetY = -2,
        level = 15,
        radius = 0.25,
        rate = 0.25,
        sounds = 'ogre',
        states = {
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.1, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['hit'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28},
            },
            ['shoot'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28}
            },
        }
    }, {
        texture = 'orc_regular',
        offsetX = -4,
        offsetY = -2,
        level = 5,
        radius = 0.25,
        rate = 0.25,
        sounds = 'ogre',
        states = {
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.1, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {17, 18},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {19, 20, 21, 22, 23, 24},
            },
            ['hit'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28},
            },
            ['shoot'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28}
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {17, 18, 19, 20, 21, 22, 23, 24},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {29, 30, 32},
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {17, 18, 19, 20, 21, 22, 23, 24},
            },
            ['hit'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {29, 30, 32},
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 3, 2},
            },
            ['move'] = {
                rate = 0.18, 
                frames = {5, 6, 7, 8, 9, 10, 11, 12},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {13, 14, 15, 16},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {17, 18, 19, 20, 21, 22, 23, 24},
            },
            ['hit'] = {
                rate = 0.2, 
                frames = {25, 26, 27, 28},
            },
            ['jump'] = {
                rate = 0.2, 
                frames = {29, 30, 31, 32},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {29, 30, 32},
            },
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
            ['idle'] = {
                rate = 0.2, 
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
            },
            ['move'] = {
                rate = 0.05, 
                frames = {9, 10, 11, 12, 13, 14, 15, 16},
            },
            ['attack'] = {
                rate = 0.2, 
                frames = {17, 18, 19, 20, 21, 22, 23, 24},
            },
            ['hurt'] = {
                rate = 0.2, 
                frames = {41, 42, 43, 44, 45, 46, 47, 48},
            },
            ['death'] = {
                rate = 0.2, 
                frames = {49, 50, 51, 52, 53, 54, 55, 56},
            },
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
--         ['hurt'] = {41, 42, 43, 44, 45, 46, 47, 48},
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
--         ['hurt'] = {41, 42, 43, 44, 45, 46, 47, 48},
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