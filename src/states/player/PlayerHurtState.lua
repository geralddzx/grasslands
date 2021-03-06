PlayerHurtState = Class{__includes = BaseState}

function PlayerHurtState:init(player, air)
    self.player = player
    self.air = air

    player.animation = Animation({17, 18}, 0.25, false)

    local sounds = gSounds['player']['hurt']
    sounds[math.random(#sounds)]:play()
end

function PlayerHurtState:update(dt)
    if self.player.animation.timesPlayed > 0 then
        if self.player.health > 0 then
            self.player:changeState('idle')
        else
            self.player:changeState('death')
        end
    end
end

function PlayerHurtState:enter(damage)
    -- damage player based on player defense
    self.player.health = self.player.health - 10 * damage / self.player:totalDefense()
end