PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player, air)
    self.player = player
    self.air = air
    player.animation = Animation({1,2,3,4,3,2,1}, 0.25, true)
end

function PlayerIdleState:update(dt)
    if love.mouse.isDown(1) then
        -- left click moves
        self.player:changeState('move')
    elseif love.mouse.keysReleased[2] and not self:processPickup() then
        -- right click attacks if not items nearby
        self.player:attack()
    end
end

function PlayerIdleState:processPickup()
    for i, drop in pairs(self.air.drops) do
        -- pick item if standing close to the item
        if Magnitude(drop.x - self.player.x, drop.y - self.player.y) < 0.5 then
            table.remove(self.air.drops, i)
            self.player:pickup(drop)
            return true
        end
    end
end