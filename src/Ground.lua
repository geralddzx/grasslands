Ground = Class{}

function Ground:init()
    self.tiles = {}
    self.startX, self.startY, self.endX, self.endY = 1, 1, 1, 1
    self.tileCount = 0
    self:generateGrassTile(1, 1, 1)
    -- where the map starts depends on the grass tiles generated
    self.startX = self.startX - 10
    self.startY = self.startY - 10
    self.endX = self.endX + 10
    self.endY = self.endY + 10
    self:generateWaterTiles()
    self:removePool()
    self.walls = {}
    self:generateWalls()
    self:generateBushes()
end

function Ground:render()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            -- render water tiles first
            if IsWaterTile(self.tiles[y][x].id) then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    gFrames['grassland_tiles'][self.tiles[y][x].id], 
                    Cartesian(x - 1, y - 1))
            end
        end
    end

    -- render grass tiles and walls (grass water border shores)
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

    -- render bushes
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if self.tiles[y][x].bush then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    self.tiles[y][x].bush, 
                    Cartesian(x - 1, y - 1))
            end
        end
    end
end

function Ground:generateGrassTile(x, y, p)
    -- recursively span grass tiles in all 4 directions with probability p
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
                    if self.tileCount < 6400 and math.random() < p then
                        -- decrease probability of spreading further by 0.99 each time
                        -- so that it will spread more closer to the origin and less after
                        -- getting further away
                        self:generateGrassTile(x + j, y + i, p * 0.99)
                    end
                end
            end
        end
    end
end

-- generate bush based on locations of previous bushes
function Ground:generateBushes()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if self.tiles[y][x].grass then
                if math.random() < 0.1 then
                    self.tiles[y][x].bush = gFrames['bushes'][math.ceil(math.random() ^ 0.2 * #gFrames['bushes'])]
                elseif math.random() < 0.15 then
                    self.tiles[y][x].bush = self.tiles[y][x - 1].bush
                elseif math.random() < 0.2 then
                    self.tiles[y][x].bush = self.tiles[y - 1][x].bush
                end
            end
        end
    end
end

function Ground:generateWaterTiles()
    -- fill the rest of the map with water (tiles that are not grass)
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
end

-- remove small pools of water that can't be walled properly since it would
-- require multiple wall tiles in the same location, that is a pool with a single
-- tile would have a wall in each direction in a single location
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
        end
    end

    if tilesRemoved > 0 then
        -- remove until all small pools are erased
        self:removePool()
    end
end

function Ground:generateWalls()
    -- wall the grass tiles with appropriate wall tile to make
    -- a nice shoreline between water and grass
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
            end
        end
    end
end
