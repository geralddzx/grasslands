Equipment = Class{__includes = Entity}

function Equipment:init(x, y, def)
    self.x = x
    self.y = y
    self.texture = def.texture
    self.attack = def.attack
    self.defense = def.defense
    self.range = def.range
    self.type = def.type
    self.direction = def.direction
end

function Equipment:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.direction][24], 
        Cartesian(self.x - 4, self.y - 2.5))
end
