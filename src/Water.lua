Water = Class{}

function Water:init()
    self.tiles = {}

    for y = 1, MAP_SIZE do
        table.insert(self.tiles, {})
        for x = 1, MAP_SIZE do
            self.tiles[y][x] = WATER[math.random(#WATER)]
        end
    end
end

function Water:render()
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            love.graphics.draw(gTextures['grassland_tiles'], 
                gFrames['grassland_tiles'][self.tiles[y][x]], 
                Cartesian(x - 1, y - 1))
        end
    end
end