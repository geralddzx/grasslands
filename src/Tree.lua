Tree = Class{}

function Tree:init(x, y)
    local frame = gFrames['trees'][math.random(#gFrames['trees'])]
    self.frame = frame.quad
    self.width = 0.5
    self.height = 0.5
    self.offsetX = frame.offsetX
    self.offsetY = frame.offsetY
    self.x = x
    self.y = y
    self.mass = math.huge
    self.radius = 0.25
end

function Tree:graphics()
    return {{gTextures['grassland_tiles'], self.frame}}
end

function Tree:update(dt)
end