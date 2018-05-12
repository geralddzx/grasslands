PlayerDeathState = Class{__includes = BaseState}

function PlayerDeathState:init(player, air)
    self.player = player
    self.air = air

    player.animation = Animation({19, 20, 21, 22, 23, 24}, 0.25, false)
    gSounds['player']['death']:play()

    -- make sure monster doesn't hurt the player if this is set to true
    self.player.dead = true
end

function PlayerDeathState:update(dt)
    if self.player.animation.timesPlayed > 0 then
        gStateMachine:change('play')
    end
end