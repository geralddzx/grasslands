MonsterIdleState = Class{__includes = BaseState}

function MonsterIdleState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['idle']['frames'], 
        monster.states['idle']['rate'], true)

    -- track how long monster has been in idle state
    self.time = os.time()
end

function MonsterIdleState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    -- if close enough to player, face the player direction
    if Magnitude(dx, dy) < 5 then
        self.monster:changeDirection(Direction(dx, dy))
    end

    -- if stayed in idle state for at least 0.5 seconds
    if os.time() - self.time > 0.5 then
        -- if player is in hit range
        if Magnitude(dx, dy) < (self.monster.radius + self.air.player.radius) + 0.25 then
            self.monster:attack()
        elseif Magnitude(dx, dy) < 5 then
            -- if player is close but not in hit range then chase the player
            self.monster:changeState('move')
        elseif math.random() < dt / 5 then
            -- if player is far then have a random chance the move once in a while
            self.monster:changeState('move')
        elseif math.random() < dt / 5 then
            -- if player is far then have a random chance to change direction in a while
            self.monster:changeDirection(math.random(8))
        end
    end
end