require 'src/Dependencies'

-- all assets obtained from opengameart.org

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
    }
    gStateMachine:change('play')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
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
