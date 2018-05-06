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

function Slice(t, from, to)
    local result = {}
    for k = from, to do
        table.insert(result, t[k])
    end
    return result
end

function GenerateTreeQuads(atlas)
    local frames = {}
    local x, y = 0, 992
    for i = 1, 4 do
        table.insert(frames, {
            quad = love.graphics.newQuad(x, y, 128, 128, atlas:getDimensions()),
            offsetX = -4.5,
            offsetY = -2.5
        })
        x = x + 128
    end

    y = y + 160
    x = 0

    for i = 1, 4 do
        table.insert(frames, {
            quad = love.graphics.newQuad(x, y, 128, 192, atlas:getDimensions()),
            offsetX = -6.5,
            offsetY = -4.5
        })
        x = x + 128
    end

    y = y + 32

    for i = 1, 4 do
        table.insert(frames, {
            quad = love.graphics.newQuad(x, y, 128, 160, atlas:getDimensions()),
            offsetX = -5.5,
            offsetY = -3.5
        })
        x = x + 128
    end

    return frames
end

function GenerateWallQuads(atlas)
    local quads = {}
    local x, y = 0, 480
    for i = 1, 2 do
        for j = 1, 16 do
            table.insert(quads, love.graphics.newQuad(x, y, 64, 64, atlas:getDimensions()))
            x = x + 64
        end
        y = y + 64
        x = 0
    end
    return quads
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
    local angle = Angle(x, y)
    local scaledAngle = angle / (2 * math.pi) * 8
    local nearestDirection = math.floor(scaledAngle + 0.5)
    return (-nearestDirection - 3) % 8 + 1
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

function Angle(x, y)
    return math.atan2(-y, x)
end

-- function Distance(x1, y1, x2, y2)
--     return math.sqrt(x2 - x1)^2 + (y2 - y1)^2)
-- end

function Magnitude(x, y)
    return math.sqrt(x^2 + y^2)
end

function Hypotenuse(angle)
    return math.min(1 / math.abs(math.cos(angle)), 1 / math.abs(math.sin(angle)))
end

--[[
    Recursive table printing function.
    https://coronalabs.com/blog/2014/09/02/tutorial-printing-table-contents/
]]
function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end