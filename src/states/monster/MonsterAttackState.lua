MonsterAttackState = Class{__includes = BaseState}

function MonsterAttackState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['attack']['frames'], 
        monster.states['attack']['rate'], false)

    local sounds = gSounds[monster.sounds]['attack']
    sounds[math.random(#sounds)]:play()

    self.air.player:hurt(monster.level ^ 0.5 * math.random(200))
end

function MonsterAttackState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    -- self.monster:changeDirection(Direction(dx, dy))
    self.monster.direction = Direction(dx, dy)

    if self.monster.animation.timesPlayed > 0 then
        self.monster.lastAttack = os.time()
        self.monster:changeState('move')
    end
end
