-- this layer contains all higher up objects that need to collide and render after the ground
Air = Class{}

function Air:init(ground)
    self.ground = ground
    self.objects = {}

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
    local depths = {}
    for i = 1, 2 * MAP_SIZE do
        depths[i] = {}
    end
    
    for k, object in pairs(self.objects) do
        table.insert(depths[math.floor(object.x + object.y) + 1], object)
    end

    for k, depth in pairs(depths) do
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
            for k, graphic in pairs(object:graphics()) do
                love.graphics.draw(graphic[1], graphic[2],
                    Cartesian(object.x + object.offsetX, object.y + object.offsetY))
                love.graphics.setColor(255, 255, 255)
                local x, y = Cartesian(object.x, object.y)
                love.graphics.circle("fill", x, y, object.radius * 32) 
            end
        end
    end
end

function Air:generatePlayer()
    self.player = Player(MAP_SIZE / 2, MAP_SIZE / 2)
    table.insert(self.objects, self.player)

    self.player.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self.player, self) end,
        ['move'] = function() return PlayerMoveState(self.player, self) end,
    }
    self.player:changeState('idle')
end

function Air:generateTrees()
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            if GRASS[self.ground.tiles[y][x].id] then
                if math.random() < 0.05 then
                    table.insert(self.objects, Tree(x - 0.5, y - 0.5))
                end
            end
        end
    end
end

function Air:generateMonsters()
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            if GRASS[self.ground.tiles[y][x].id] then
                if math.random() < 0.01 then
                    local monster = Monster(x - 0.5, y - 0.5)
                    table.insert(self.objects, monster)

                    monster.stateMachine = StateMachine {
                        ['idle'] = function() return MonsterIdleState(monster, self) end,
                        ['move'] = function() return MonsterMoveState(monster, self) end,
                    }
                    monster:changeState('idle')
                end
            end
        end
    end
end

function Air:updateIndex()
    self.tiles = {}
    for y = 1, MAP_SIZE do
        table.insert(self.tiles, {})
        for x = 1, MAP_SIZE do
            table.insert(self.tiles[y], {})
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

function Air:processCollisions()
    for y = 1, MAP_SIZE do
        for x = 1, MAP_SIZE do
            local objects = self.tiles[y][x]
            for i = 1, #objects do
                for j = i + 1, #objects do
                    if objects[i] == objects[j] then
                        print(123)
                    end
                    processCollision(objects[i], objects[j])
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