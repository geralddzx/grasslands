-- this layer contains all higher up objects that need to collide and render after the ground
Air = Class{}

function Air:init(ground)
    self.ground = ground
    self.startX, self.startY, self.endX, self.endY =
        ground.startX, ground.startY, ground.endX, ground.endY
    self.objects = {}
    self.deadObjects = {}
    self.drops = {}

    self:generatePlayer()
    self:generateTrees()
    self:generateMonsters()
end

function Air:update(dt)
    self:updateIndex()
    for k, object in pairs(self.objects) do
        object:update(dt)
    end
    self:processCollisions()
end

function Air:render()
    for k, object in pairs(self.deadObjects) do
        renderObject(object)
    end

    for k, drop in pairs(self.drops) do
        drop:render()
    end

    local depths = {}
    for i = self.startX + self.startY, self.endX + self.endY do
        depths[i] = {}
    end
    
    for k, object in pairs(self.objects) do
        table.insert(depths[math.floor(object.x + object.y)], object)
    end

    for i = self.startX + self.startY, self.endX + self.endY do
        local depth = depths[i]
        table.sort(depth, function(farther, closer)
            if farther.x + farther.y < closer.x + closer.y then
                return true
            elseif farther.x + farther.y == closer.x + closer.y then
                return farther.x < closer.x
            else
                return false
            end
        end)

        for k, object in pairs(depth) do
            renderObject(object)
        end
    end
end

function renderObject(object)
    for k, graphic in pairs(object:graphics()) do
        love.graphics.draw(graphic[1], graphic[2],
            Cartesian(object.x + object.offsetX, object.y + object.offsetY))
        -- love.graphics.setColor(255, 255, 255)
        -- local x, y = Cartesian(object.x, object.y)
        -- love.graphics.circle("fill", x, y, object.radius * 32) 
    end
end

function Air:generatePlayer()
    self.player = Player(1, 1)
    table.insert(self.objects, self.player)

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player, self) end,
        ['move'] = function() return PlayerMoveState(self.player, self) end,
        ['attack'] = function() return PlayerAttackState(self.player, self) end,
        ['hurt'] = function() return PlayerHurtState(self.player, self) end,
    }
    self.player:changeState('idle')
end

function Air:generateTrees()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if IsGrassTile(self.ground.tiles[y][x].id) then
                if math.random() < 0.05 then
                    table.insert(self.objects, Tree(x - 0.5, y - 0.5))
                end
            end
        end
    end
end

function Air:generateMonsters()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            if IsGrassTile(self.ground.tiles[y][x].id) then
                local def = MONSTER_DEFS[math.random(#MONSTER_DEFS)]
                if (math.random() < 0.05 / def.level ^ 1) then
                    local monster = Monster(x - 0.5, y - 0.5, def)
                    table.insert(self.objects, monster)

                    monster.stateMachine = StateMachine {
                        ['idle'] = function() return MonsterIdleState(monster, self) end,
                        ['move'] = function() return MonsterMoveState(monster, self) end,
                        ['hurt'] = function() return MonsterHurtState(monster, self) end,
                        ['attack'] = function() return MonsterAttackState(monster, self) end,
                        ['death'] = function() return MonsterDeathState(monster, self) end,
                    }
                    monster:changeState('idle')
                end
            end
        end
    end
end

function Air:updateIndex()
    self.tiles = {}
    for y = self.startY, self.endY do
        self.tiles[y] = {}
        for x = self.startX, self.endX do
            self.tiles[y][x] = {}
        end
    end

    for k, object in pairs(self.objects) do
        for x = math.floor(object.x - object.radius) + 1, math.floor(object.x + object.radius) + 1 do
            for y = math.floor(object.y - object.radius) + 1, math.floor(object.y + object.radius) + 1 do
                table.insert(self.tiles[y][x], object)
            end
        end
    end
end

-- function Air:processTiles()
--     for y = 1, MAP_SIZE do
--         for x = 1, MAP_SIZE do
--             for k, object in pairs(self.objects) do
--                 for x = math.floor(object.x - object.radius) + 1, math.floor(object.x + object.radius) + 1 do
--                     if not GRASS[self.ground.tiles[y][x].id] then
--                         local dx, dy = object.x - (x - 0.5), object.y - (y - 0.5)
--                         local angle = Angle(x, y)
--                         local hypotenuse = 0.5 * Hypotenuse(angle)
--                         local distance = Magnitude(dx, dy)
--                         local gap = distance - object.radius
                        
--                         if gap < hypotenuse then
--                             local scaleFactor = (hypotenuse - gap) / distance
--                             object.x = object.x + scaleFactor * dx
--                             object.y = object.y + scaleFactor * dy
--                             object.bumped = true
--                             -- print(self.player.x, self.player.y)
--                         end
--                     end
--                 end
--             end
--         end
--     end
-- end

function Air:processCollisions()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            local objects = self.tiles[y][x]
            for i = 1, #objects do
                for j = i + 1, #objects do
                    processCollision(objects[i], objects[j])
                end
                if not IsGrassTile(self.ground.tiles[y][x].id) then
                    processCollision(objects[i], self.ground.tiles[y][x])
                end
            end
        end
    end
end

function processCollision(a, b)
    if a.x == b.x and a.y == b.y then
        a.x = a.x + math.random() * 0.1 * (-1) ^ math.random(2)
        a.y = a.y + math.random() * 0.1 * (-1) ^ math.random(2)
    end

    local x, y = b.x - a.x, b.y - a.y
    local touchDistance = a.radius + b.radius
    local distance = Magnitude(x, y)

    if distance < touchDistance then
        a.bumped = true
        b.bumped = true

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

        a.x, a.y = a.x - dx * aPush, a.y - dy * aPush
        b.x, b.y = b.x + dx * bPush, b.y + dy * bPush

        -- if b.mass > a.mass then
        --     a.x, a.y = a.x - dx, a.y - dy
        -- elseif a.mass == b.mass then
        --     a.x, a.y = a.x - dx * 0.5, a.y - dy * 0.5
        --     b.x, b.y = b.x + dx * 0.5, b.y + dy * 0.5
        -- else
        --     b.x, b.y = b.x + dx, b.y + dy
        -- end
    end
end