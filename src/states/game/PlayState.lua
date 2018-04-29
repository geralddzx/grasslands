PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.ground = Ground()
    self.water = Water()
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()

    -- love.graphics.translate(-MAP_SIZE * 32, -MAP_SIZE * 16)


    local tiles = {}

    for i = 1, 2 * MAP_SIZE do
        tiles[i] = {}
    end

    local renderTile = function(texture, frame, x , y)
        print(x, y)
        table.insert(tiles[math.floor(x + y) + 1], {
            texture = texture,
            frame = frame, 
            x = x, 
            y = y
        })
    end
    
    self.water:render(renderTile)
    self.ground:render(renderTile)
    

    for k, tileRow in pairs(tiles) do
        for k, tile in pairs(tileRow) do
            love.graphics.draw(tile.texture, tile.frame, Cartesian(tile.x, tile.y))
        end
    end

    love.graphics.pop()
end
