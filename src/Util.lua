--[[
    GD50
    Super Mario Bros. Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Helper functions for writing Match-3.
]]

--[[
    Given an "atlas" (a texture with multiple sprites), as well as a
    width and a height for the tiles therein, split the texture into
    all of the quads by simply dividing it evenly.
]]
function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

function Cartesian(x, y)
    return (x - y) * 32, (x + y) * 16
end

function Generate2DQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        table.insert(spritesheet, {})
        
        for x = 0, sheetWidth - 1 do
            table.insert(spritesheet[#spritesheet],
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                    tileheight, atlas:getDimensions()))
        end
    end

    return spritesheet
end

function Direction(x, y)
    local angle = math.atan2(-y, x)
    local scaledAngle = angle / (2 * math.pi) * 8
    local nearestDirection = math.floor(scaledAngle + 0.5)
    return (-nearestDirection - 4) % 8 + 1
end

function Vector(direction)
    local angle = -direction * math.pi / 4 + math.pi * 3 / 2
    return math.cos(angle), -math.sin(angle)

    -- if direction == 1 then
    --     return -1, -1
    -- elseif direction == 2 then
    --     return -1, 0
    -- elseif direction == 2 then
    --     return -1, 1
    -- elseif direction == 2 then
    --     return -1, 0
    -- elseif direction == 2 then
    --     return -1, 0
end

function VirtualPosition(x, y)
    return x / love.graphics.getWidth() * VIRTUAL_WIDTH, 
        y / love.graphics.getHeight() * VIRTUAL_HEIGHT
end

-- function Distance(x1, y1, x2, y2)
--     return math.sqrt(x2 - x1)^2 + (y2 - y1)^2)
-- end

function Magnitude(x, y)
    return math.sqrt(x^2 + y^2)
end