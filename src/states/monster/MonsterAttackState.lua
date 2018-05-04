MonsterAttackState = Class{__includes = BaseState}

function MonsterAttackState:init(monster, air)
    self.monster = monster
    self.air = air

    monster.animation = Animation(monster.states['attack']['frames'], 
        monster.states['attack']['rate'], false)

    local sounds = gSounds[monster.sounds]['attack']
    sounds[math.random(#sounds)]:play()

    self.air.player:changeState('hurt')
end

function MonsterAttackState:update(dt)
    local playerX, playerY = self.air.player.x, self.air.player.y
    local dx, dy = playerX - self.monster.x, playerY - self.monster.y

    self.monster.direction = Direction(dx, dy)

    if self.monster.animation.timesPlayed > 0 then
        self.monster.lastAttack = os.time()
        self.monster:changeState('move')
    end
end

function MonsterAttackState:damage(dt)
    self.monster.health = self.monster.health - 10
    self.monster:changeState('hurt')
end