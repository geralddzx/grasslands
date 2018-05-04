MonsterMoveState = Class{__includes = BaseState}

function MonsterMoveState:init(monster, air)
    self.monster = monster
    self.air = air

    self.bumped = false

    monster.animation = Animation(monster.states['move']['frames'], 
        monster.states['move']['rate'])
end

function MonsterMoveState:damage()
    self.monster.health = self.monster.health - 10
    self.monster:changeState('hurt')
end

function MonsterMoveState:update(dt)
    if self.monster.bumped then
        self.monster.bumped = false
        self.monster.direction = math.random(8)
    end

    -- stop moving after 10 seconds on average
    if math.random() < dt / 10 then
        self.monster:changeState('idle')
    end

    -- change direction after 5 seconds on average
    if math.random() < dt / 5 then
        self.direction = math.random(8)
    end

    local dx, dy = VectorFromDirection(self.monster.direction)
    self.monster.x = self.monster.x + dt * dx * 0.2 / self.monster.states['move']['rate']
    self.monster.y = self.monster.y + dt * dy * 0.2 / self.monster.states['move']['rate']
end