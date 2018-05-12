MonsterDeathState = Class{__includes = BaseState}

function MonsterDeathState:init(monster, air)
    self.monster = monster
    self.air = air
    self.monster.dead = true

    monster.animation = Animation(monster.states['death']['frames'], 
        monster.states['death']['rate'], false)

    -- give player experience
    self.air.player:gainExp(50 * (self.monster.level / self.air.player.level)^0.5)
end

function MonsterDeathState:update(dt)
    if self.monster.animation.timesPlayed > 0 then
        -- remove itself from collision tracking index
        self.air:removeIndex(self.monster)

        for i, object in pairs(self.air.objects) do
            if object == self.monster then
                -- remove from object list
                table.remove(self.air.objects, i)
            end
        end

        table.insert(self.air.deadObjects, self.monster)
        for k, equipmentDef in pairs(EQUIPMENT_DEFS) do
            -- drop equipment if player level high enough, 
            -- less likely when higher level equipment
            if equipmentDef.level <= self.air.player.level
                and math.random() < 0.2 / equipmentDef.level then
                -- insert equipment in objects layer
                table.insert(self.air.drops,
                    Equipment(self.monster.x + math.random() - 0.5, 
                        self.monster.y + math.random() - 0.5, equipmentDef))
            end
        end
    end
end