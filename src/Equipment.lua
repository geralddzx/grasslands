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
    self.sound = def.sound
    self.icon = def.icon
    self.offsetX = def.offsetX
    self.offsetY = def.offsetY
end

function Equipment:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.direction][24], 
        Cartesian(self.x + self.offsetX, self.y + self.offsetY))
    -- love.graphics.setColor(255, 255, 255)
    -- local x, y = Cartesian(self.x, self.y)
    -- love.graphics.circle("line", x, y, 16) 
end
