MonsterHurtState = Class{__includes = BaseState}

function MonsterHurtState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['hurt']['frames'], 
        monster.states['hurt']['rate'], false)

    local sounds = gSounds[monster.sounds]['hurt']
    sounds[math.random(#sounds)]:play()
end

function MonsterHurtState:update(dt)
    if self.monster.animation.timesPlayed > 0 then
        self.monster:changeState('idle')
    end
end

function MonsterHurtState:damage(dt)
end