PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.ground = Ground()
    self.water = Water()
    self.player = Player()
    self.entities = {self.player}
end

function PlayState:enter(params)
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    self.player:update(dt)

    self:checkCollisions()
end

function PlayState:render()
    -- render dungeon and all entities separate from hearts GUI
    love.graphics.push()

    local playerX, playerY = Cartesian(self.player.x, self.player.y)

    love.graphics.translate(math.floor(VIRTUAL_WIDTH / 2 - playerX - 32), 
        math.floor(VIRTUAL_HEIGHT / 2 - playerY))

    local tiles = {}

    for i = 1, 2 * MAP_SIZE do
        tiles[i] = {}
    end

    local renderTile = function(texture, frame, x, y)
        table.insert(tiles[math.floor(x + y) + 1], {
            texture = texture,
            frame = frame, 
            x = x, 
            y = y
        })
    end
    
    self.water:render(renderTile)

    for k, tileRow in pairs(tiles) do
        for k, tile in pairs(tileRow) do
            love.graphics.draw(tile.texture, tile.frame, Cartesian(tile.x, tile.y))
        end
    end

    tiles = {}

    for i = 1, 2 * MAP_SIZE do
        tiles[i] = {}
    end

    self.ground:render(renderTile)

    for k, tileRow in pairs(tiles) do
        for k, tile in pairs(tileRow) do
            love.graphics.draw(tile.texture, tile.frame, Cartesian(tile.x, tile.y))
        end
    end

    local bodies = {}

    for i = 1, 2 * MAP_SIZE do
        bodies[i] = {}
    end

    local renderBody = function(texture, frame, x, y, offsetX, offsetY)
        table.insert(bodies[math.floor(x + y) + 1], {
            texture = texture,
            frame = frame, 
            x = x, 
            y = y,
            offsetX = offsetX,
            offsetY = offsetY,
        })
    end

    self.ground:renderBushes(renderBody)

    for k, bodyGroup in pairs(bodies) do
        table.sort(bodyGroup, function(farther, closer)
            if farther.x + farther.y < closer.x + closer.y then
                return true
            elseif farther.x + farther.y == closer.x + closer.y then
                return farther.x % 2 < closer.x % 2
            else
                return false
            end
        end)

        for k, body in pairs(bodyGroup) do
            love.graphics.draw(body.texture, body.frame, 
                Cartesian(body.x + body.offsetX, body.y + body.offsetY))
        end
    end

    bodies = {}

    for i = 1, 2 * MAP_SIZE do
        bodies[i] = {}
    end

    self.ground:renderTrees(renderBody)
    self.player:render(renderBody)
    
    for k, bodyGroup in pairs(bodies) do
        table.sort(bodyGroup, function(farther, closer)
            if farther.x + farther.y < closer.x + closer.y then
                return true
            elseif farther.x + farther.y == closer.x + closer.y then
                return farther.x % 2 < closer.x % 2
            else
                return false
            end
        end)

        -- for k, body in pairs(bodyGroup) do
        --     love.graphics.setColor(255, 255, 255)
        --     x, y = Cartesian(body.x, body.y)
        --     love.graphics.circle("fill", x, y , 5, 5)
        -- end

        for k, body in pairs(bodyGroup) do
            love.graphics.draw(body.texture, body.frame, 
                Cartesian(body.x + body.offsetX, body.y + body.offsetY))
        end
    end

    love.graphics.pop()
end

function PlayState:checkCollisions()
    local tiles = {}

    for i = 1, MAP_SIZE do
        table.insert(tiles, {})
    end

    for k, entity in pairs(self.entities) do
        local x, y = entity:origin()
        for i = math.floor(y) + 1, math.floor(y + entity.height) + 1 do
            for j = math.floor(x) + 1, math.floor(x + entity.width) + 1 do
                tiles[i][j] = tiles[i][j] or {}
                table.insert(tiles[i][j], entity)
            end
        end
    end

    for i = 1, MAP_SIZE do
        for j = 1, MAP_SIZE do
            if not GRASS[self.ground.tiles[i][j].id] and tiles[i][j] then
                for k, entity in pairs(tiles[i][j]) do
                    local dx, dy = entity.x - j + 0.5, entity.y - i + 0.5
                    local distance = Magnitude(dx, dy)
                    if distance < 1 then
                        local scaling = 1 / distance - 1
                        entity.x = entity.x + scaling * dx
                        entity.y = entity.y + scaling * dy
                    end
                end
            end

            if self.ground.tiles[i][j].tree then
                if tiles[i][j] then
                    for k, entity in pairs(tiles[i][j]) do
                        self:processCollision(entity, self.ground.tiles[i][j].tree)
                    end
                end
            end
        end
    end
end

function PlayState:processCollision(a, b)
    local x, y = b.x - a.x, b.y - a.y
    local touchDistance = a.radius + b.radius
    local distance = Magnitude(x, y)

    if distance < touchDistance then
        local pushDistance = touchDistance - distance
        local pushScale = pushDistance / distance
        local dx, dy = pushScale * x, pushScale * y

        local totalMass = a.mass + b.mass
        local aPush = b.mass / totalMass
        local bPush = a.mass / totalMass

        if aPush ~= aPush then
            aPush = 1
        end

        if bPush ~= bPush then
            bPush = 1
        end

        b.x, b.y = b.x + bPush * dx, b.y + bPush * dy
        a.x, a.y = a.x - aPush * dx, a.y - aPush * dy
    end
end