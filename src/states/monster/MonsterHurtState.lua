MonsterHurtState = Class{__includes = BaseState}

function MonsterHurtState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['hurt']['frames'], 
        monster.states['hurt']['rate'], false)

    local sounds = gSounds[monster.sounds]['hurt']
    local sound = sounds[math.random(#sounds)]:play()
end

function MonsterHurtState:update(dt)
    if self.monster.animation.timesPlayed > 0 then
        if self.monster.health <= 0 then
            self.monster:changeState('death')
        else
            self.monster:changeState('idle')
        end
    end
end

function MonsterHurtState:enter(damage)
    self.monster.health = self.monster.health - damage
end