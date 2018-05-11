MonsterDeathState = Class{__includes = BaseState}

function MonsterDeathState:init(monster, air)
    self.monster = monster
    self.air = air
    self.monster.dead = true

    monster.animation = Animation(monster.states['death']['frames'], 
        monster.states['death']['rate'], false) 
    self.air.player.exp = self.air.player.exp + 5 * self.monster.level / self.air.player.level
end

function MonsterDeathState:update(dt)
    if self.monster.animation.timesPlayed > 0 then
        self.air:removeIndex(self.monster)

        for i, object in pairs(self.air.objects) do
            if object == self.monster then
                table.remove(self.air.objects, i)
            end
        end

        table.insert(self.air.deadObjects, self.monster)
        for k, equipmentDef in pairs(EQUIPMENT_DEFS) do
            if equipmentDef.level > 0 and math.random() < 0.2 / equipmentDef.level then
                table.insert(self.air.drops,
                    Equipment(self.monster.x + math.random() - 0.5, 
                        self.monster.y + math.random() - 0.5, equipmentDef))
            end
        end
    end
end