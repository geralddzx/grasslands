StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    if love.mouse.keysReleased[1] or love.mouse.keysReleased[2] then
        gStateMachine:change('play')
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['huge'])
    love.graphics.printf('Grasslands', 0, VIRTUAL_HEIGHT * 0.2, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['large'])
    love.graphics.print('Left Click to Run', VIRTUAL_WIDTH * 0.2, VIRTUAL_HEIGHT * 0.4)
    love.graphics.print('Right Click to Attack', VIRTUAL_WIDTH * 0.2, VIRTUAL_HEIGHT * 0.5)
    love.graphics.print('Right Click to Pickup Nearby Item', VIRTUAL_WIDTH * 0.2, VIRTUAL_HEIGHT * 0.6)
    love.graphics.print('Press 1 to 10 to Use Items', VIRTUAL_WIDTH * 0.2, VIRTUAL_HEIGHT * 0.7)
    love.graphics.print('Click Anywhere to Play!', VIRTUAL_WIDTH * 0.2, VIRTUAL_HEIGHT * 0.8)
end