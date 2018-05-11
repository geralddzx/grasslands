PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.ground = Ground()
    self.air = Air(self.ground)
    self.player = self.air.player
    self.panel = Panel(self.player)
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.air:update(dt)

    for i = 10, 1, -1 do
        if love.keyboard.wasPressed(tostring(i % 10)) then
            local item = self.player.inventory[i]
            if item then
                local currentEquipment = self.player[item.type]
                if currentEquipment then
                    self.player:pickup(currentEquipment)
                end
                table.remove(self.player.inventory, i)
                self.player[item.type] = item
            end
        end
    end
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()

    local playerX, playerY = Cartesian(self.player.x, self.player.y)

    love.graphics.translate(math.floor(VIRTUAL_WIDTH / 2 - playerX - 32), 
        math.floor(VIRTUAL_HEIGHT / 2 - playerY))
    
    self.ground:render()
    self.air:render()
    love.graphics.pop()

    self.panel:render()
end