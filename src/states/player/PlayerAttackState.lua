PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player, air)
    self.player = player
    
    player.animation = Animation({13, 14, 15, 16}, 0.1, false)

    gSounds['player']['attack'][math.random(#gSounds['player']['attack'])]:play()

    self.player.direction = love.mousedirection()

    local hitAngle = Angle(Vector(player.direction))
    local hitRange = self.player.weapon.range

    -- local hitX, hitY = Vector(player.direction)


    -- hitX, hitY = hitX * self.player.weapon.range, hitY * self.player.weapon.range
    -- hitX1 = math.min(hitX, player.x) 
    -- local hitRadius = 1

    local hits = {}
    for x = math.floor(player.x - hitRange) + 1, math.floor(player.x + hitRange) + 1 do
        for y = math.floor(player.y - hitRange) + 1, math.floor(player.y + hitRange) + 1 do
            for k, object in pairs(air.tiles[y][x]) do
                if not hits[object] and object.stateMachine and object ~= self.player then
                    local monsterX, monsterY = object.x - self.player.x, object.y - self.player.y
                    local monsterDistance = Magnitude(monsterX, monsterY)
                    local monsterAngle = Angle(monsterX, monsterY)
                    local angleDiff = math.min((monsterAngle - hitAngle) % (math.pi * 2),
                        (hitAngle - monsterAngle) % (math.pi * 2))
                    if angleDiff < math.pi / 4 and monsterDistance < hitRange then
                        hits[object] = true
                        object:hurt(player:totalAttack())
                    end
                end
            end
        end
    end
end

function PlayerAttackState:update(dt)
    if self.player.animation.timesPlayed > 0 then
        self.player:changeState('idle')
    end
end