-- this layer contains all higher up objects 
-- that need to collide and render after the ground
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
    self:generateIndex()
end

function Air:update(dt)
    for k, object in pairs(self.objects) do
        object:update(dt)
    end
end

function Air:render()
    for k, object in pairs(self.deadObjects) do
        renderObject(object)
    end

    for k, drop in pairs(self.drops) do
        drop:render()
    end

    -- sort standing objects by depth, the objects higher in both x and y
    -- get rendered last because they are closest to perspective
    local depths = {}
    for i = self.startX + self.startY, self.endX + self.endY do
        depths[i] = {}
    end
    
    -- put object in depth index
    -- then sort objects in the same index
    -- this prevents every object having to compare to every other object
    for k, object in pairs(self.objects) do
        table.insert(depths[math.floor(object.x + object.y)], object)
    end

    for i = self.startX + self.startY, self.endX + self.endY do
        -- sort objects by how far they are, render the farther objects first
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
        -- convert isometric coords back to cartesian so love can draw it properly
        love.graphics.draw(graphic[1], graphic[2],
            Cartesian(object.x + object.offsetX, object.y + object.offsetY))
    end
end

function Air:generatePlayer()
    -- player stands on the first tile that get generated
    self.player = Player(0.5, 0.5, self)
    table.insert(self.objects, self.player)

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player, self) end,
        ['move'] = function() return PlayerMoveState(self.player, self) end,
        ['attack'] = function() return PlayerAttackState(self.player, self) end,
        ['hurt'] = function() return PlayerHurtState(self.player, self) end,
        ['death'] = function() return PlayerDeathState(self.player, self) end,
    }
    self.player:changeState('idle')
end

function Air:generateTrees()
    for y = self.startY, self.endY do
        for x = self.startX, self.endX do
            -- generate trees on grass
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
            -- generate monsters only on grass
            if IsGrassTile(self.ground.tiles[y][x].id) then
                local def = MONSTER_DEFS[math.random(#MONSTER_DEFS)]
                if (math.random() < 0.05 / def.level ^ 1) then
                    -- all objects are track by its center, so tile 1's center
                    -- is 1 - 0.5 = 0.5
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

function Air:generateIndex()
    -- index for tracking all objects that touch each tile,
    -- this makes it easy because all objects that could collide
    -- in a certain area is scoped to a few tiles
    self.tiles = {}
    for y = self.startY, self.endY do
        self.tiles[y] = {}
        for x = self.startX, self.endX do
            self.tiles[y][x] = {}
        end
    end

    for k, object in pairs(self.objects) do
        self:addIndex(object)
    end
end

function Air:removeIndex(target)
    -- remove object from collision tracking index
    for x = math.floor(target.x - target.radius) + 1, math.floor(target.x + target.radius) + 1 do
        for y = math.floor(target.y - target.radius) + 1, math.floor(target.y + target.radius) + 1 do
            for i, object in pairs(self.tiles[y][x]) do
                if object == target then
                    table.remove(self.tiles[y][x], i)
                end
            end
        end
    end
end

function Air:addIndex(target)
    -- add object back to collision tracking index
    for x = math.floor(target.x - target.radius) + 1, math.floor(target.x + target.radius) + 1 do
        for y = math.floor(target.y - target.radius) + 1, math.floor(target.y + target.radius) + 1 do
            table.insert(self.tiles[y][x], target)
        end
    end
end

function Air:processCollisions(object)
    local collided = false
    -- check all tiles the object spans
    for x = math.floor(object.x - object.radius) + 1, math.floor(object.x + object.radius) + 1 do
        for y = math.floor(object.y - object.radius) + 1, math.floor(object.y + object.radius) + 1 do
            -- go through each object in each of the spanning tiles
            for k, target in pairs(self.tiles[y][x]) do
                if self:processCollision(object, target) then
                    collided = true
                end
            end
            -- check if the object also collides with a tile that can't be stepped on
            if self:processTileCollision(object, x, y) then
                collided = true
            end
        end
    end
    return collided
end

function Air:processCollision(object, target)
    -- if two objects are exactly in the same place, move 
    -- the object slightly out of the way
    if object.x == target.x and object.y == target.y then
        object.x = object.x + math.random() * 0.2 - 0.1
        object.y = object.y + math.random() * 0.2 - 0.1
    end
  
    -- get distance between center of objects
    local x, y = object.x - target.x, object.y - target.y
    local touchDistance = object.radius + target.radius
    local distance = Magnitude(x, y)
  
    -- if objects are touching
    if distance < touchDistance then
        -- calculate how much the object should be pushed further in the same direction
        local pushDistance = touchDistance - distance
        local pushScale = pushDistance / distance
        local dx, dy = pushScale * x, pushScale * y

        object.x, object.y = object.x + dx, object.y + dy
        return true
    end
end

function Air:processTileCollision(object, x, y)
    -- set object out of non steppable tile based on angle to the tile
    if not self.ground.tiles[y][x].grass then
        local x, y = x - 0.5, y - 0.5
        local angle = Angle(object.x - x, object.y - y)
        if angle > 3 * math.pi / 4 or angle < -3 * math.pi / 4 then
            object.x = x - 0.5 - object.radius
        elseif angle > math.pi / 4 then
            object.y = y - 0.5 - object.radius
        elseif angle > -math.pi / 4 then
            object.x = x + 0.5 + object.radius
        else
            object.y = y + 0.5 + object.radius
        end
        return true         
    end
end
