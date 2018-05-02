Monster = Class{__includes = Entity}

function Monster:init(x, y, def)
    self.x = x
    self.y = y

    self.states = def.states
    
    self.texture = def.texture

    self.radius = def.radius

    self.rate = def.rate

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