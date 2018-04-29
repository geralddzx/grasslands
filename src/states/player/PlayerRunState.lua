PlayerRunState = Class{__includes = BaseState}

function PlayerRunState:init(player)
    self.player = player

    player.animation = Animation({5,6,7,8,9,10,11,12}, 0.1)
end

function PlayerRunState:update(dt)
    if love.mouse.isDown(1) then
        local x, y = VirtualPosition(love.mouse.getPosition())
        self.player.direction = Direction(x - VIRTUAL_WIDTH / 2, y - VIRTUAL_HEIGHT / 2)
    else
        self.player:changeState('idle')
    end

    local dx, dy = Vector(self.player.direction)
    self.player.x = self.player.x + PLAYER_RUN_SPEED * dt * dx
    self.player.y = self.player.y + PLAYER_RUN_SPEED * dt * dy
end