Panel = Class{__includes = Entity}

function Panel:init(player)
    self.player = player
end

function Panel:render()
    self:renderInventory()
    self:renderStatus()
end

function Panel:renderStatus()
    local y = VIRTUAL_HEIGHT - 32

    for i = 1, VIRTUAL_WIDTH / 64 do
        love.graphics.draw(gTextures['panel'], 64 * (i - 1), y, 0, 0.25)
    end

    -- there is 6 pixels of shadow at the bottom of the bar, 22 / 2 / 2 == 5.5
    y = y + 16 - 5.5

    love.graphics.draw(gTextures['empty_bar'], 16, y, 0, 0.5)
    local healthTexture = gTextures['red_bar']
    local healthQuad = love.graphics.newQuad(0, 0,
        206 * self.player.health / self.player.maxHealth, 28, 206, 28)
    love.graphics.draw(gTextures['red_bar'], healthQuad, 16, y, 0, 0.5)

    love.graphics.draw(gTextures['empty_bar'], 103 + 32, y, 0, 0.5)
    local expTexture = gTextures['green_bar']
    local expQuad = love.graphics.newQuad(0, 0,
        206 * self.player.exp / self.player.maxExp, 28, 206, 28)
    love.graphics.draw(gTextures['green_bar'], expQuad, 103 + 32, y, 0, 0.5)

    y = VIRTUAL_HEIGHT - 16 - 8
    local x = 206 + 64
    local width = (VIRTUAL_WIDTH - x) / 3
    love.graphics.printf('Level: ' .. self.player.level, x - 32, y, width, 'right')
    x = x + width
    love.graphics.printf('Attack: ' .. self.player:totalAttack(), x - 32, y, width, 'right')
    x = x + width
    love.graphics.printf('Defense: ' .. self.player:totalDefense(), x - 32, y, width, 'right')
    x = x + width
    
end

function Panel:renderInventory()
    local x, y = VIRTUAL_WIDTH - 10 * 32, VIRTUAL_HEIGHT - 64
    
    love.graphics.setColor(255, 255, 255, 255)

    for i = 1, 10 do
        love.graphics.draw(gTextures['tile'], x, y, 0, 0.125)

        local item = self.player.inventory[i]
        if item then
            love.graphics.draw(gTextures[item.texture], item.icon, x + 4, y + 4)
        end

        love.graphics.printf(i, x, y + 16 - 8, 32, 'center')

        x = x + 32
    end
end