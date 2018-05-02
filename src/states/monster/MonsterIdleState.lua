MonsterIdleState = Class{__includes = BaseState}

function MonsterIdleState:init(monster, air)
    self.monster = Monster
    self.air = air

    monster.animation = Animation(monster.states['idle'], 0.25)
end

function MonsterIdleState:update(dt)
end