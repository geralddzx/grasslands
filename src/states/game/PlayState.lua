PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.ground = Ground()
    self.water = Water()
    self.air = Air(self.ground)
    self.player = self.air.player
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.air:update(dt)
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()

    local playerX, playerY = Cartesian(self.player.x, self.player.y)

    love.graphics.translate(math.floor(VIRTUAL_WIDTH / 2 - playerX - 32), 
        math.floor(VIRTUAL_HEIGHT / 2 - playerY))
    
    self.water:render()
    self.ground:render()
    self.air:render()
    love.graphics.pop()
end