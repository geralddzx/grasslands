MonsterMoveState = Class{__includes = BaseState}

function MonsterMoveState:init(monster, air)
    self.monster = monster
    self.air = air

    self.bumped = false

    monster.animation = Animation(monster.states['move']['frames'], 
        monster.states['move']['rate'])
end

function MonsterMoveState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    -- local dx, dy = self.monster.x - playerX, self.monster.y - playerY
    -- local direction = Direction(dx, dy)
    -- local focusX, focusY = Vector(direction)
    -- local focusX, focusY = self.air.player.x + focusX * self.air.player.radius,
    --     self.air.player.y + focusY * self.air.player.radius
    -- local dx, dy = focusX - self.monster.x, focusY - self.monster.y

    if Magnitude(dx, dy) < 5 then
        self.monster:changeDirection(Direction(dx, dy))
    end

    if Magnitude(dx, dy) < (self.monster.radius + self.air.player.radius) * 2 then
        if not self.monster:attack() then
            self.monster:changeState('idle')
        end
    elseif self.monster.bumped then
        self.monster.bumped = false
        self.monster:changeDirection(math.random(8))
    elseif math.random() < dt / 5 then
        self.monster:changeDirection(math.random(8))
    end

    -- stop moving after 10 seconds on average
    if math.random() < dt / 10 then
        self.monster:changeState('idle')
    end

    local dx, dy = Vector(self.monster.direction)
    self.monster.x = self.monster.x + dt * dx * 0.2 / self.monster.states['move']['rate']
    self.monster.y = self.monster.y + dt * dy * 0.2 / self.monster.states['move']['rate']
end