Ground = Class{}

function Ground:init()
    self.tiles = {}

    for y = 1, MAP_SIZE do
        table.insert(self.tiles, {})
        for x = 1, MAP_SIZE do
            local tile = {id = MAP_EMPTY, soil = 0}
            table.insert(self.tiles[y], tile)

            if x == 5 and y == 5 then
                tile.id = SHORE_TOP_LEFT
            elseif x == MAP_SIZE - 5 and y == 5 then
                tile.id = SHORE_TOP_RIGHT[1]
            elseif x == MAP_SIZE - 4 and y == 6 then
                tile.id = SHORE_TOP_RIGHT[2]
            elseif x == MAP_SIZE - 5 and y == MAP_SIZE - 5 then
                tile.id = SHORE_BOTTOM_RIGHT[1]
            elseif x == MAP_SIZE - 4 and y == MAP_SIZE - 4 then
                tile.id = SHORE_BOTTOM_RIGHT[2]
            elseif x == 5 and y == MAP_SIZE - 5 then
                tile.id = SHORE_BOTTOM_LEFT[1]
            elseif x == 6 and y == MAP_SIZE - 4 then
                tile.id = SHORE_BOTTOM_LEFT[2]

            elseif y == 5 and x > 5 and x < MAP_SIZE - 5 then
                tile.id = SHORE_TOP[math.random(#SHORE_TOP)]
                
            elseif x == MAP_SIZE - 5 and y > 5 and y < MAP_SIZE - 5 then
                tile.id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][1]
            elseif x == MAP_SIZE - 4 and y > 6 and y <= MAP_SIZE - 5 then
                tile.id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][2]
            
            elseif y == MAP_SIZE - 5 and x > 5 and x < MAP_SIZE - 5 then
                tile.id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][1]
            elseif y == MAP_SIZE - 4 and x > 6 and x <= MAP_SIZE - 5 then
                tile.id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][2]
            
            elseif x == 5 and y > 5 and y < MAP_SIZE - 5 then
                tile.id = SHORE_LEFT[math.random(#SHORE_LEFT)]

            elseif x > 5 and y > 5 and x < MAP_SIZE - 5 and y < MAP_SIZE - 5 then
                tile.id = GRASS[math.random(#GRASS)]
                
                if math.random() < 0.1 then
                    tile.bush = gFrames['bushes'][math.ceil(math.random() ^ 0.2 * #gFrames['bushes'])]
                elseif math.random() < 0.15 then
                    tile.bush = self.tiles[y][x - 1].bush
                elseif math.random() < 0.2 then
                    tile.bush = self.tiles[y - 1][x].bush
                end
            end
        end
    end
end

function Ground:render()
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            love.graphics.draw(gTextures['grassland_tiles'], 
                gFrames['grassland_tiles'][self.tiles[y][x].id], 
                Cartesian(x - 1, y - 1))
            if self.tiles[y][x].bush then
                love.graphics.draw(gTextures['grassland_tiles'], 
                    self.tiles[y][x].bush, Cartesian(x - 2, y - 2))
            end
        end
    end
end