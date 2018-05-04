MonsterIdleState = Class{__includes = BaseState}

function MonsterIdleState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['idle']['frames'], 
        monster.states['idle']['rate'])
end

function MonsterIdleState:damage()
    self.monster.health = self.monster.health - 10
    self.monster:changeState('hurt')
end

function MonsterIdleState:update(dt)
    -- random chance to move every 5 seconds
    if math.random() < dt / 5 then
        self.monster:changeState('move')
    end
end