MonsterAttackState = Class{__includes = BaseState}

function MonsterAttackState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['attack']['frames'], 
        monster.states['attack']['rate'], false)

    local sounds = gSounds[monster.sounds]['attack']
    sounds[math.random(#sounds)]:play()

    -- hurt the player
    self.air.player:hurt(monster.level ^ 0.5 * math.random(100))
end

function MonsterAttackState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    -- try to face the player when attacking
    self.monster.direction = Direction(dx, dy)

    if self.monster.animation.timesPlayed > 0 then
        self.monster.lastAttack = os.time()
        -- go back to moving when finished attacking
        self.monster:changeState('idle')
    end
end
