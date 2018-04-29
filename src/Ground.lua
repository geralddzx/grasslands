Ground = Class{}

function Ground:init()
    self.tiles = {}

    for y = 1, MAP_SIZE do
        table.insert(self.tiles, {})
        for x = 1, MAP_SIZE do
            local id = MAP_EMPTY

            if x == 5 and y == 5 then
                id = SHORE_TOP_LEFT
            elseif x == MAP_SIZE - 5 and y == 5 then
                id = SHORE_TOP_RIGHT[1]
            elseif x == MAP_SIZE - 4 and y == 6 then
                id = SHORE_TOP_RIGHT[2]
            elseif x == MAP_SIZE - 5 and y == MAP_SIZE - 5 then
                id = SHORE_BOTTOM_RIGHT[1]
            elseif x == MAP_SIZE - 4 and y == MAP_SIZE - 4 then
                id = SHORE_BOTTOM_RIGHT[2]
            elseif x == 5 and y == MAP_SIZE - 5 then
                id = SHORE_BOTTOM_LEFT[1]
            elseif x == 6 and y == MAP_SIZE - 4 then
                id = SHORE_BOTTOM_LEFT[2]

            elseif y == 5 and x > 5 and x < MAP_SIZE - 5 then
                id = SHORE_TOP[math.random(#SHORE_TOP)]
                
            elseif x == MAP_SIZE - 5 and y > 5 and y < MAP_SIZE - 5 then
                id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][1]
            elseif x == MAP_SIZE - 4 and y > 6 and y <= MAP_SIZE - 5 then
                id = SHORE_RIGHT[math.random(#SHORE_RIGHT)][2]
            
            elseif y == MAP_SIZE - 5 and x > 5 and x < MAP_SIZE - 5 then
                id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][1]
            elseif y == MAP_SIZE - 4 and x > 6 and x <= MAP_SIZE - 5 then
                id = SHORE_BOTTOM[math.random(#SHORE_BOTTOM)][2]
            
            elseif x == 5 and y > 5 and y < MAP_SIZE - 5 then
                id = SHORE_LEFT[math.random(#SHORE_LEFT)]

            elseif x > 5 and y > 5 and x < MAP_SIZE - 5 and y < MAP_SIZE - 5 then
                id = GRASS[math.random(#GRASS)]
            end

            self.tiles[y][x] = id
        end
    end
end

function Ground:render(renderTile)
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            renderTile(gTextures['grassland_tiles'], 
                gFrames['grassland_tiles'][self.tiles[y][x]], 
                x - 1, y - 1)
        end
    end
end