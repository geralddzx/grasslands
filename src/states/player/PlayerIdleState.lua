PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player)
    self.player = player

    player.animation = Animation({1,2,3,4,3,2,1}, 0.25)
end

function PlayerIdleState:update(dt)
    if love.mouse.isDown(1) then
        self.player:changeState('run')
    end
end