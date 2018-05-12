PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player, air)
    self.player = player
    
    player.animation = Animation({13, 14, 15, 16}, 0.1, false)

    gSounds['player']['attack'][math.random(#gSounds['player']['attack'])]:play()

    -- attack in direction of mouse
    self.player.direction = love.mousedirection()

    -- get current hit angle in isometric coordinates
    local hitAngle = Angle(Vector(player.direction))
    local hitRange = self.player.weapon.range

    -- go through all the tiles this can potentially hit,
    -- check collision with all objects on all those possible tiles
    -- track hits to not count the same object twice since an object
    -- can be tracked in multiple tiles
    local hits = {}
    -- check tiles that the player can hit
    for x = math.floor(player.x - hitRange) + 1, math.floor(player.x + hitRange) + 1 do
        for y = math.floor(player.y - hitRange) + 1, math.floor(player.y + hitRange) + 1 do
            -- go through all objects in those tiles
            for k, object in pairs(air.tiles[y][x]) do
                if not hits[object] and object.stateMachine and object ~= self.player then
                    -- if did not count this object and this object has a state (monsters)
                    -- get monster angle and distance to player
                    local monsterX, monsterY = object.x - self.player.x, object.y - self.player.y
                    local monsterDistance = Magnitude(monsterX, monsterY)
                    local monsterAngle = Angle(monsterX, monsterY)
                    local angleDiff = math.min((monsterAngle - hitAngle) % (math.pi * 2),
                        (hitAngle - monsterAngle) % (math.pi * 2))
                    -- only if the monster is within 45% in the direction of the attack
                    -- and is within attack range based on the weapon
                    if angleDiff < math.pi / 4 and monsterDistance < hitRange then
                        hits[object] = true
                        -- damage monster based on player attack
                        -- essentially this behaves like a fan collision area
                        object:hurt(player:totalAttack())
                    end
                end
            end
        end
    end
end

function PlayerAttackState:update(dt)
    if self.player.animation.timesPlayed > 0 then
        -- go back to idle when finished attacking
        self.player:changeState('idle')
    end
end