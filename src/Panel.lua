Panel = Class{__includes = Entity}

function Panel:init(player)
    self.player = player
end

function Panel:render()
    self:renderInventory()

    love.graphics.draw(gTextures['panel'], 
        0, VIRTUAL_HEIGHT - gTextures['panel']:getHeight() / 2, 0, 0.5)
    love.graphics.draw(gTextures['panel'], 
        gTextures['panel']:getHeight() / 2, 
        VIRTUAL_HEIGHT - gTextures['panel']:getHeight() / 2, 0, 0.5)

    love.graphics.draw(gTextures['empty_bar'], 10, VIRTUAL_HEIGHT - 50, 0, 0.5)
    local healthTexture = gTextures['red_bar']
    local healthQuad = love.graphics.newQuad(0, 0,
        healthTexture:getWidth() * self.player.health / self.player.maxHealth, 
        healthTexture:getHeight(), healthTexture:getWidth(), healthTexture:getHeight())
    love.graphics.draw(gTextures['red_bar'], healthQuad, 10, VIRTUAL_HEIGHT - 50, 0, 0.5)

    love.graphics.draw(gTextures['empty_bar'], 10, VIRTUAL_HEIGHT - 20, 0, 0.5)
    local expTexture = gTextures['green_bar']
    local expQuad = love.graphics.newQuad(0, 0,
        expTexture:getWidth() * self.player.exp / self.player.maxExp, 
        expTexture:getHeight(), expTexture:getWidth(), expTexture:getHeight())
    love.graphics.draw(gTextures['green_bar'], expQuad, 10, VIRTUAL_HEIGHT - 20, 0, 0.5)
end

function Panel:renderInventory()
    local x, y = VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT - 32
    
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