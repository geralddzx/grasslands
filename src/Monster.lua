Monster = Class{__includes = Entity}

function Monster:init(x, y)
    self.x = x
    self.y = y

    local def = MONSTER_DEFS[math.random(#MONSTER_DEFS)]
    self.states = def.states
    
    self.texture = def.texture

    self.radius = def.radius

    self.offsetX = def.offsetX
    self.offsetY = def.offsetY

    self.mass = 10

    self.direction = math.random(8)
end

function Monster:graphics()
    return {{
        gTextures[self.texture],
        gFrames[self.texture][self.direction][self.animation:getCurrentFrame()]
    }}
end