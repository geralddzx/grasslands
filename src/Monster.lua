Monster = Class{__includes = Entity}

function Monster:init(x, y, def)
    self.attackSpeed = 1

    self.x = x
    self.y = y
    self.sounds = def.sounds
    self.health = 30

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

function Monster:changeDirection(direction)
    self.lastRedirect = self.lastRedirect or 0
    if os.time() - self.lastRedirect > 0.05 then
        self.direction = direction
        self.lastRedirect = os.time()
    end
end

-- function Monster:changeState(name, params)
--     self.lastChange = self.lastChange or 0

--     if os.time() - self.lastChange > 0.05 then
--         self.stateMachine:change(name, params)
--         self.lastChange = os.time()
--     end
-- end