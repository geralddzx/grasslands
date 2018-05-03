PlayerAttackState = Class{__includes = BaseState}

function PlayerAttackState:init(player, air)
    self.player = player
    
    player.animation = Animation({13, 14, 15, 16}, 0.1, false)

    gSounds['swing'][math.random(#gSounds['swing'])]:play()

    local hitX, hitY = Vector(player.direction)
    hitX, hitY = player.x + hitX / 2, player.y + hitY / 2
    local hitRadius = 0.5

    local hits = {}
    for x = math.floor(hitX - hitRadius) + 1, math.floor(hitX + hitRadius) + 1 do
        for y = math.floor(hitY - hitRadius) + 1, math.floor(hitY + hitRadius) + 1 do
            for k, object in pairs(air.tiles[y][x]) do
                if not hits[object] and object.stateMachine and object ~= self.player and
                        Magnitude(object.x - hitX, object.y - hitY) <
                        object.radius + hitRadius then
                    hits[object] = true
                    object.stateMachine.current:damage(1)
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