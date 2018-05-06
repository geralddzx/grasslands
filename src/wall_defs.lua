TOP_WALL = 4
RIGHT_WALL = 1
LEFT_WALL = 3
BOTTOM_WALL = 2

TOP_LEFT_WALL = 19
BOTTOM_LEFT_WALL = 18
BOTTOM_RIGHT_WALL = 17
TOP_RIGHT_WALL = 20

BOTTOM_RIGHT_CLIFF = 9
TOP_LEFT_CLIFF = 11
TOP_RIGHT_CLIFF = 12
BOTTOM_LEFT_CLIFF = 10


WALL_DEFS = {
    {
        x = -1,
        y = -1,
        frames = {275},
        z = 0,
        point = true,
    }, {
        x = 0,
        y = -1,
        frames = {244},
        z = 0,
    }, {
        x = 1,
        y = -1,
        frames = {276, 292},
        z = 1,
        point = true,
    }, {
        x = 1,
        y = 0,
        frames = {241, 257},
        z = 0,
    }, {
        x = 1,
        y = 1,
        frames = {273, 289},
        z = 0,
        point = true,
    }, {
        x = 0,
        y = 1,
        frames = {242, 258},
        z = 0,
    }, {
        x = -1,
        y = 1,
        frames = {274, 290},
        z = 0,
        point = true,
    }, {
        x = -1,
        y = 0,
        frames = {243},
        z = 0,
    },
}

CORNERS = {
    {
        edges = {
            {x = 1, y = 0},
            {x = 0, y = 1},
        },
        frames = {251},
        z = 0,
    }, {
        edges = {
            {x = -1, y = 0},
            {x = 0, y = -1},
        },
        frames = {249, 265},
        z = 0,
        override = true
    }, {
        edges = {
            {x = -1, y = 0},
            {x = 0, y = 1},
        },
        frames = {256, 272},
        z = 0,
    }, {
        edges = {
            {x = 1, y = 0},
            {x = 0, y = -1},
        },
        frames = {254, 270},
        z = 0,
    }
    
}