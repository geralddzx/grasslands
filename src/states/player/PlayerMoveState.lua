PlayerMoveState = Class{__includes = BaseState}

function PlayerMoveState:init(player, air)
    self.player = player
    self.air = air
    player.animation = Animation({5,6,7,8,9,10,11,12}, 0.1, true)
end

function PlayerMoveState:update(dt)
    if love.mouse.isDown(1) then
        -- change direction based on mouse position
        self.player.direction = love.mousedirection()
    elseif love.mouse.isDown(2) then
        self.player:attack()
    else
        self.player:changeState('idle')
    end

    -- remove itself from collision tracking index
    self.air:removeIndex(self.player)
    
    -- change position
    local dx, dy = Vector(self.player.direction)
    self.player.x = self.player.x + PLAYER_RUN_SPEED * dt * dx
    self.player.y = self.player.y + PLAYER_RUN_SPEED * dt * dy

    -- prevent player from colliding into other objects
    self.air:processCollisions(self.player)
    -- add player back to index so other objects can check collision on player
    self.air:addIndex(self.player)
end