require 'src/Dependencies'

-- all assets obtained from opengameart.org and www.dafont.com
-- special thanks to CC-BY for the graphics from opengameart
-- especially for the isometric hero sprites
-- https://opengameart.org/content/isometric-hero-and-heroine
-- and for the grassland tiles
-- https://opengameart.org/content/grassland-tileset
-- also thanks to multiple authors from opengameart for
-- sound effects, music, monsters etc.

function love.load()
    -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
    love.mouse.setVisible(false)
    -- love.mouse.setGrabbed(true)

    math.randomseed(os.time())
    love.window.setTitle('Grassland')
    love.graphics.setDefaultFilter('linear', 'linear')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['start'] = function() return StartState() end,
    }
    gStateMachine:change('start')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    Timer.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
end

function love.draw()
    push:start()

    gStateMachine:render()
    
    push:finish()

    -- http://nova-fusion.com/2012/09/20/custom-cursors-in-love2d/
    love.graphics.draw(gCursors['point'], 
        love.mouse.getX() - gCursors['point']:getWidth() / 2, 
        love.mouse.getY() - gCursors['point']:getHeight() / 2)
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = {
        x / love.graphics.getWidth() * VIRTUAL_WIDTH, 
        y / love.graphics.getHeight() * VIRTUAL_HEIGHT
    }
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.mousedirection()
    local x, y = love.mouse.getPosition()
    x, y = x - love.graphics.getWidth() / 2,
        y - love.graphics.getHeight() / 2
    return (Direction(x, y) - 2) % 8 + 1
end