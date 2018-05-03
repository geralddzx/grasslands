MonsterIdleState = Class{__includes = BaseState}

function MonsterIdleState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['idle'], monster.rate)
end

function MonsterIdleState:damage()
    self.monster.health = self.monster.health - 10
    self.monster:changeState('hurt')
end

function MonsterIdleState:update(dt)
end