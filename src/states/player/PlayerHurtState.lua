PlayerHurtState = Class{__includes = BaseState}

function PlayerHurtState:init(player, air)
    self.player = player
    self.air = air

    player.animation = Animation({17, 18}, 0.2, false)
    self.player.health = self.player.health - 10

    local sounds = gSounds['player']['hurt']
    sounds[math.random(#sounds)]:play()
end

function PlayerHurtState:update(dt)
    if self.player.animation.timesPlayed > 0 then
        self.player:changeState('idle')
    end
end
