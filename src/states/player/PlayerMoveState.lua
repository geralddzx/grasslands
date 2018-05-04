PlayerMoveState = Class{__includes = BaseState}

function PlayerMoveState:init(player, air)
    self.player = player

    player.animation = Animation({5,6,7,8,9,10,11,12}, 0.1)
end

function PlayerMoveState:update(dt)
    if love.mouse.isDown(1) then
        self.player.direction = love.mousedirection()
    elseif love.mouse.isDown(2) then
        self.player:attack()
    else
        self.player:changeState('idle')
    end

    
    local dx, dy = Vector(self.player.direction)
    self.player.x = self.player.x + PLAYER_RUN_SPEED * dt * dx
    self.player.y = self.player.y + PLAYER_RUN_SPEED * dt * dy
end