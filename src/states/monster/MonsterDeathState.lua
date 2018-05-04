MonsterDeathState = Class{__includes = BaseState}

function MonsterDeathState:init(monster, air)
    self.monster = monster
    self.air = air
    self.monster.dead = true

    monster.animation = Animation(monster.states['death']['frames'], 
        monster.states['death']['rate'], false) 
end

function MonsterDeathState:update(dt)
    if self.monster.animation.timesPlayed > 0 then
        for i, object in pairs(self.air.objects) do
            if object == self.monster then
                table.remove(self.air.objects, i)
            end
        end
        table.insert(self.air.deadObjects, self.monster)
    end
end