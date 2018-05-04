MonsterIdleState = Class{__includes = BaseState}

function MonsterIdleState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['idle']['frames'], 
        monster.states['idle']['rate'])
end

function MonsterIdleState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    if Magnitude(dx, dy) < 5 then
        self.monster:changeDirection(Direction(dx, dy))
    end

    if Magnitude(dx, dy) < (self.monster.radius + self.air.player.radius) * 2 then
        self.monster:attack()
    elseif Magnitude(dx, dy) < 5 or math.random() < dt / 5 then
        self.monster:changeState('move')
    elseif self.monster.bumped then
        self.monster.bumped = false
        self.monster:changeDirection(math.random(8))
    elseif math.random() < dt / 5 then
        self.monster:changeDirection(math.random(8))
    end
end