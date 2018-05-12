PlayState = Class{__includes = BaseState}

function PlayState:init()
    -- ground refers to the tiles layer
    self.ground = Ground()

    -- air refers to the objects layer (including the player, monsters and trees)
    self.air = Air(self.ground)
    self.player = self.air.player

    -- the panel that displays stats and inventory
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
        -- remove item from inventory after pressing number key
        if love.keyboard.wasPressed(tostring(i % 10)) then
            local item = table.remove(self.player.inventory, i)
            if item then
                -- get the current equipment that the player is equiped
                local currentEquipment = self.player[item.type]
                if currentEquipment then
                    -- add the current equipment to the inventory
                    self.player:pickup(currentEquipment)
                end
                -- equip the new item
                self.player[item.type] = item
            end
        end
    end
end

function PlayState:render()
    love.graphics.push()

    -- convert player coordinates from isometric coordinates to cartesian coordinates
    local playerX, playerY = Cartesian(self.player.x, self.player.y)

    -- translate camera to have player in the middle of screen
    love.graphics.translate(math.floor(VIRTUAL_WIDTH / 2 - playerX - 32), 
        math.floor(VIRTUAL_HEIGHT / 2 - playerY))
    
    -- render ground
    self.ground:render()

    -- render objects in air
    self.air:render()

    love.graphics.pop()

    -- render stats panel
    self.panel:render()
end