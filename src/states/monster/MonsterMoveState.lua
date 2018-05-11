MonsterMoveState = Class{__includes = BaseState}

function MonsterMoveState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['move']['frames'], 
        monster.states['move']['rate'], true)

    self.time = os.time()
end

function MonsterMoveState:update(dt)
    local playerX, playerY = self.air.player.x - self.monster.x, 
        self.air.player.y - self.monster.y

    -- local dx, dy = self.monster.x - playerX, self.monster.y - playerY
    -- local direction = Direction(dx, dy)
    -- local focusX, focusY = Vector(direction)
    -- local focusX, focusY = self.air.player.x + focusX * self.air.player.radius,
    --     self.air.player.y + focusY * self.air.player.radius
    -- local dx, dy = focusX - self.monster.x, focusY - self.monster.y

    if Magnitude(playerX, playerY) <= 5 then
        self.monster:changeDirection(Direction(playerX, playerY))
    end

    if Magnitude(playerX, playerY) < (self.monster.radius + self.air.player.radius) + 0.25 then
        if self.monster:attack() then
            return
        else
            self.monster:changeState('idle')
        end
    end

    self.air:removeIndex(self.monster)

    local dx, dy = Vector(self.monster.direction)
    self.monster.x = self.monster.x + dt * dx * 0.2 / self.monster.states['move']['rate']
    self.monster.y = self.monster.y + dt * dy * 0.2 / self.monster.states['move']['rate']

    if self.air:processCollisions(self.monster) then
        if Magnitude(playerX, playerY) > 5 then
            self.monster:changeState('idle')
        end
    elseif Magnitude(playerX, playerY) > 5 then
        if math.random() < dt / 5 then
            self.monster:changeDirection(math.random(8))
        elseif math.random() < dt / 5 then
            self.monster:changeState('idle')
        end
    end

    self.air:addIndex(self.monster)
end