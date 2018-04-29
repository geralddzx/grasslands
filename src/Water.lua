Water = Class{}

function Water:init()
    self.tiles = {}

    for y = 1, MAP_SIZE do
        table.insert(self.tiles, {})
        for x = 1, MAP_SIZE do
            if x <= 5 or x > MAP_SIZE - 5 or y <= 5 or y > MAP_SIZE - 5 then
                self.tiles[y][x] = WATER[math.random(#WATER)]
            else
                self.tiles[y][x] = MAP_EMPTY
            end
        end
    end
end

function Water:render(renderTile)
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            renderTile(gTextures['grassland_tiles'], 
                gFrames['grassland_tiles'][self.tiles[y][x]], 
                x - 1, y - 1)
        end
    end
end