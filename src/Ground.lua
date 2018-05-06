Ground = Class{}

function Ground:init()
    self.tiles = {}
    self.startX, self.startY, self.endX, self.endY = 1, 1, 1, 1
    self.tileCount = 0
    self:generateGrassTile(1, 1, 1)
    self.startX = self.startX - 10
    self.startY = self.startY - 10
    self.endX = self.endX + 10
    self.endY = self.endY + 10
    self:generateWaterTiles()
    self:removePool()
    self.walls = {}
    self:generateWalls()
    -- self:generateCorners()

    -- for y = 1, MAP_SIZE do
    --     table.insert(self.tiles, {})
    --     for x = 1, MAP_SIZE do
    --         local tile = {
    --             id = MAP_EMPTY, 
    --             soil = 0, 
    --             x = x - 0.5, 
    --             y = y - 0.5, 
    --             radius = 0.5, 
    --             mass = math.huge
    --         }
    --         table.insert(self.tiles[y], tile)

    --         if x == 5 and y == 5 then
    --             tile.id = SHORE_TOP_LEFT
    --         elseif x == MAP_SIZE - 5 and y == 5 then
    --             tile.id = SHORE_TOP_RIGHT[1]
    --         elseif x == MAP_SIZE - 4 and y == 6 then
    --             tile.id = SHORE_TOP_RIGHT[2]
    --         elseif x == MAP_SIZE - 5 and y == MAP_SIZE - 5 then
    --             tile.id = SHORE_BOTTOM_RIGHT[1]
    --         elseif x == MAP_SIZE - 4 and y == MAP_SIZE - 4 then
    --             tile.id = SHORE_BOTTOM_RIGHT[2]
    --         elseif x == 5 and y == MAP_SIZE - 5 then
    --             tile.id = SHORE_BOTTOM_LEFT[1]
    --         elseif x == 6 and y == MAP_SIZE - 4 then
    --             tile.id = SHORE_BOTTOM_LEFT[2]

    --         elseif y == 5 and x > 5 and x < MAP_SIZE - 5 then
    --             tile.id = SHORE_TOP[math.random(#SHORE_TOP)]
                
    --         elseif x == MAP_SIZE - 5 and y > 5 and y < MAP_SIZE - 5 then
    --             tile.id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][1]
    --         elseif x == MAP_SIZE - 4 and y > 6 and y <= MAP_SIZE - 5 then
    --             tile.id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][2]
            
    --         elseif y == MAP_SIZE - 5 and x > 5 and x < MAP_SIZE - 5 then
    --             tile.id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][1]
    --         elseif y == MAP_SIZE - 4 and x > 6 and x <= MAP_SIZE - 5 then
    --             tile.id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][2]
            
    --         elseif x == 5 and y > 5 and y < MAP_SIZE - 5 then
    --             tile.id = SHORE_LEFT[math.random(#SHORE_LEFT)]

    --         elseif x > 5 and y > 5 and x < MAP_SIZE - 5 and y < MAP_SIZE - 5 then
    --             tile.id = GRASS[math.random(#GRASS)]
                
    --             if math.random() < 0.1 then
    --                 tile.bush = gFrames['bushes'][math.ceil(math.random() ^ 0.2 * #gFrames['bushes'])]
    --             elseif math.random() < 0.15 then
    --                 tile.bush = self.tiles[y][x - 1].bush
    --             elseif math.random() < 0.2 then
    --                 tile.bush = self.tiles[y - 1][x].bush
    --             end
    --         end
    --     end
    -- end
end

function Ground:render()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if IsWaterTile(self.tiles[y][x].id) then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    gFrames['grassland_tiles'][self.tiles[y][x].id], 
                    Cartesian(x - 1, y - 1))
            end
        end
    end

    -- for y = self.startY, self.endY do
    --     for x = self.startX, self.endX do
    --         -- table.sort(self.walls[y][x], function(farther, closer)
    --         --     return farther.z < closer.z
    --         -- end)

    --         for k, wall in pairs(self.walls[y][x]) do
    --             -- if not wall.corner and not wall.point then
    --                 love.graphics.draw(gTextures['grassland_tiles'], 
    --                     gFrames['grassland_tiles'][wall.id],
    --                     Cartesian(x - 1, y - 1))
    --             -- end
    --         end
    --     end
    -- end

    -- for y = self.startY, self.endY do
    --     for x = self.startX, self.endX do
    --         for k, wall in pairs(self.walls[y][x]) do
    --             if wall.corner then
    --                 love.graphics.draw(gTextures['grassland_tiles'], 
    --                     gFrames['grassland_tiles'][wall.id],
    --                     Cartesian(x - 1, y - 1))
    --             end
    --         end
    --     end
    -- end

    -- for y = self.startY, self.endY do
    --     for x = self.startX, self.endX do
    --         for k, wall in pairs(self.walls[y][x]) do
    --             if wall.point then
    --                 love.graphics.draw(gTextures['grassland_tiles'], 
    --                     gFrames['grassland_tiles'][wall.id],
    --                     Cartesian(x - 1, y - 1))
    --             end
    --         end
    --     end
    -- end

    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if self.tiles[y][x].grass then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    gFrames['grassland_tiles'][self.tiles[y][x].id], 
                    Cartesian(x - 1, y - 1))
            end

            if self.walls[y][x] then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    gFrames['walls'][self.walls[y][x]], 
                    Cartesian(x - 1, y - 1))
            end
        end
    end
end

function Ground:generateGrassTile(x, y, p)
    self.tiles[y] = self.tiles[y] or {}
    self.tiles[y][x] = {
        id = GRASS[math.random(#GRASS)], 
        x = x - 0.5, 
        y = y - 0.5, 
        radius = 0.5, 
        mass = math.huge,
        grass = true,
    }

    self.tileCount = self.tileCount + 1

    self.startX = math.min(self.startX, x)
    self.startY = math.min(self.startY, y)
    self.endX = math.max(self.endX, x)
    self.endY = math.max(self.endY, y)

    for i = -1, 1 do
        for j = -1, 1 do
            if math.abs(i + j) == 1 then
                if not self.tiles[y + i] or not self.tiles[y + i][x + j] then
                    if self.tileCount < 9600 and math.random() < p then
                        self:generateGrassTile(x + j, y + i, p * 0.99)
                    end
                end
            end
        end
    end
end

function Ground:generatePool(x, y, p)
    self.tiles[y][x] = {
        id = WATER[math.random(#WATER)], 
        x = x - 0.5, 
        y = y - 0.5, 
        radius = 0.5, 
        mass = math.huge,
    }

    for i = -1, 1 do
        for j = -1, 1 do
            if math.abs(i + j) == 1 then
                if math.random() < p then
                    self:generatePool(x + j, y + i, p^3)
                end
            end
        end
    end
end

function Ground:generateWaterTiles()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            self.tiles[y] = self.tiles[y] or {}

            if not self.tiles[y][x] then
                self.tiles[y][x] = {
                    id = WATER[math.random(#WATER)], 
                    x = x - 0.5, 
                    y = y - 0.5, 
                    radius = 0.5, 
                    mass = math.huge
                }
            end
        end
    end

    -- for y = self.startY + 20, self.endY - 20 do
    --     for x = self.startX + 20, self.endX - 20 do
    --         if math.random() < 0.02 then
    --             self:generatePool(x, y, 0.9)
    --         end
    --     end
    -- end
end

function Ground:removePool()
    local tilesRemoved = 0
    for y = self.startY + 5, self.endY - 5 do
        for x = self.startX + 5, self.endX - 5 do
            if not self.tiles[y][x].grass then
                if self.tiles[y + 1][x].grass and self.tiles[y - 1][x].grass or
                    self.tiles[y][x + 1].grass and self.tiles[y][x - 1].grass or
                    self.tiles[y + 1][x + 1].grass and self.tiles[y - 1][x - 1].grass or
                    self.tiles[y - 1][x + 1].grass and self.tiles[y + 1][x - 1].grass then
                    self.tiles[y][x].id = GRASS[math.random(#GRASS)]
                    self.tiles[y][x].grass = true
                    tilesRemoved = tilesRemoved + 1
                end
            end
            -- if not self.tiles[y][x].grass then
            --     local count = 0
            --     for i = -1, 1 do
            --         for j = -1, 1 do
            --             -- if math.abs(i + j) == 1 then
            --             if self.tiles[y + i][x + j].grass then
            --                 count = count + 1
            --             end
            --             -- end
            --         end
            --     end
            --     if count > 2 then
            --         -- local cornerCount = 0
            --         -- for i = -1, 1 do
            --         --     for j = -1, 1 do
            --         --         if self.tiles[y + i][x + j].corner then
            --         --             cornerCount = cornerCount + 1
            --         --         end
            --         --     end
            --         -- end
            --         -- if cornerCount > 0 then
            --         self.tiles[y][x].id = GRASS[math.random(#GRASS)]
            --         self.tiles[y][x].grass = true
            --         tilesRemoved = tilesRemoved + 1
            --         -- else
            --         --     self.tiles[y][x].corner = true
            --         -- end
            --     end
            -- end
        end
    end

    if tilesRemoved > 0 then
        self:removePool()
    end
end

function Ground:generateWalls()
    for y = self.startY, self.endY do
        self.walls[y] = {}
    end

    for y = self.startY + 5, self.endY - 5 do
        for x = self.startX + 5, self.endX - 5 do
            if self.tiles[y][x].grass then
                if not self.tiles[y + 1][x].grass then
                    self.walls[y + 1][x] = BOTTOM_WALL
                end

                if not self.tiles[y][x - 1].grass then
                    self.walls[y][x - 1] = LEFT_WALL
                end

                if not self.tiles[y - 1][x].grass then
                    self.walls[y - 1][x] = TOP_WALL
                end

                if not self.tiles[y][x + 1].grass then
                    self.walls[y][x + 1] = RIGHT_WALL
                end

                if not self.tiles[y - 1][x].grass and not self.tiles[y][x + 1].grass then
                    self.walls[y - 1][x + 1] = TOP_RIGHT_WALL
                end

                if not self.tiles[y + 1][x].grass and not self.tiles[y][x + 1].grass then
                    self.walls[y + 1][x + 1] = BOTTOM_RIGHT_WALL
                end

                if not self.tiles[y + 1][x].grass and not self.tiles[y][x - 1].grass then
                    self.walls[y + 1][x - 1] = BOTTOM_LEFT_WALL
                end

                if not self.tiles[y - 1][x].grass and not self.tiles[y][x - 1].grass then
                    self.walls[y - 1][x - 1] = TOP_LEFT_WALL
                end


                -- for k, def in pairs(TILE_DEFS) do
                --     if self:needsWall(x, y, def) then
                --         local wallX, wallY = x + def.x, y + def.y
                --         for i, frame in pairs(def.frames) do
                --             self.walls[wallY] = self.walls[wallY] or {}
                --             self.walls[wallY][wallX] = self.walls[wallY][wallX] or {}
                --             table.insert(self.walls[wallY][wallX], {
                --                 x = wallX,
                --                 y = wallY,
                --                 id = frame,
                --                 point = def.point,
                --                 z = def.z
                --             })
                --             -- frames go down in both x and y isometric direction
                --             wallX = wallX + 1
                --             wallY = wallY + 1
                --         end
                --     end
                -- end

            end
        end
    end

    for y = self.startY + 5, self.endY - 5 do
        for x = self.startX + 5, self.endX - 5 do
            if not self.tiles[y][x].grass then
                if self.tiles[y - 1][x].grass and self.tiles[y][x + 1].grass then
                    self.walls[y][x] = BOTTOM_LEFT_CLIFF
                end

                if self.tiles[y + 1][x].grass and self.tiles[y][x + 1].grass then
                    self.walls[y][x] = TOP_LEFT_CLIFF
                end

                if self.tiles[y + 1][x].grass and self.tiles[y][x - 1].grass then
                    self.walls[y][x] = TOP_RIGHT_CLIFF
                end

                if self.tiles[y - 1][x].grass and self.tiles[y][x - 1].grass then
                    self.walls[y][x] = BOTTOM_RIGHT_CLIFF
                end


                -- for k, def in pairs(TILE_DEFS) do
                --     if self:needsWall(x, y, def) then
                --         local wallX, wallY = x + def.x, y + def.y
                --         for i, frame in pairs(def.frames) do
                --             self.walls[wallY] = self.walls[wallY] or {}
                --             self.walls[wallY][wallX] = self.walls[wallY][wallX] or {}
                --             table.insert(self.walls[wallY][wallX], {
                --                 x = wallX,
                --                 y = wallY,
                --                 id = frame,
                --                 point = def.point,
                --                 z = def.z
                --             })
                --             -- frames go down in both x and y isometric direction
                --             wallX = wallX + 1
                --             wallY = wallY + 1
                --         end
                --     end
                -- end

            end
        end
    end
end

-- function Ground:generateCorners()
--     for y = self.startY, self.endY do
--         for x = self.startX, self.endX do
--             if not IsGrassTile(self.tiles[y][x].id) then
--                 for k, def in pairs(CORNERS) do
--                     if self:needsCorner(x, y, def) then
--                         self.walls[y][x] = {{
--                             x = x,
--                             y = y,
--                             id = def.frames[1],
--                             corner = true,
--                             z = def.z
--                         }}

--                         if def.frames[2] then
--                             if def.override then
--                                 self.walls[y + 1][x + 1] = {{
--                                     x = x + 1,
--                                     y = y + 1,
--                                     id = def.frames[2],
--                                     corner = true,
--                                     z = def.z
--                                 }}
--                             else
--                                 table.insert(self.walls[y + 1][x + 1], {
--                                     x = x + 1,
--                                     y = y + 1,
--                                     id = def.frames[2],
--                                     corner = true,
--                                     z = def.z
--                                 })
--                             end
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end

-- function Ground:needsWall(x, y, wall)
--     if wall.x == 0 or wall.y == 0 then
--         return not IsGrassTile(self.tiles[y + wall.y][x + wall.x].id)
--     else
--         return not IsGrassTile(self.tiles[y + wall.y][x].id) and
--             not IsGrassTile(self.tiles[y][x + wall.x].id)
--     end
-- end

-- function Ground:needsCorner(x, y, corner)
--     -- if corner.x == 0 or corner.y == 0 then
--     --     return IsGrassTile(self.tiles[y + corner.y][x + corner.x].id)
--     -- else
--     --     return IsGrassTile(self.tiles[y + corner.y][x].id) and
--     --         IsGrassTile(self.tiles[y][x + corner.x].id)
--     -- end
--     for k, edge in pairs(corner.edges) do
--         if y + edge.y > self.endY or y + edge.y < self.startY or
--             x + edge.x > self.endX or x + edge.x < self.startX then
--                 return false
--         end
        
--         if not IsGrassTile(self.tiles[y + edge.y][x + edge.x].id) then
--             return false
--         end
--     end
--     return true
-- end