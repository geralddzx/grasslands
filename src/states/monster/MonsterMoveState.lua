MonsterMoveState = Class{__includes = BaseState}

function MonsterMoveState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['move']['frames'], 
        monster.states['move']['rate'], true)
end

function MonsterMoveState:update(dt)
    local playerX, playerY = self.air.player.x - self.monster.x, 
        self.air.player.y - self.monster.y

    -- if player is close enough
    if Magnitude(playerX, playerY) <= 5 then
        -- face the player
        self.monster:changeDirection(Direction(playerX, playerY))
    end

    -- if player is in hit range
    if Magnitude(playerX, playerY) < (self.monster.radius + self.air.player.radius) + 0.25 then
        if self.monster:attack() then
            -- return when monster enters attack state
            return
        else
            self.monster:changeState('idle')
        end
    end

    -- remove itself from collision tracking index
    self.air:removeIndex(self.monster)

    -- move based on current direction
    local dx, dy = Vector(self.monster.direction)
    self.monster.x = self.monster.x + dt * dx * 0.2 / self.monster.states['move']['rate']
    self.monster.y = self.monster.y + dt * dy * 0.2 / self.monster.states['move']['rate']

    -- make sure monster does not collided into any thing
    if self.air:processCollisions(self.monster) then -- if collided
        -- if far from player
        if Magnitude(playerX, playerY) > 5 then
            -- change to new direction
            self.monster:changeDirection(math.random(8))
        end
    elseif Magnitude(playerX, playerY) > 5 then -- if didnt collide and is far from far from player
        if math.random() < dt / 5 then
            -- still have a chance to change direction
            self.monster:changeDirection(math.random(8))
        elseif math.random() < dt / 5 then
            -- still have a chance to rest
            self.monster:changeState('idle')
        end
    end

    -- add its new position to the collision tracking index
    self.air:addIndex(self.monster)
end