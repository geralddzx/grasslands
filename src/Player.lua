Player = Class{__includes = Entity}

function Player:init(x, y, air)
    self.x = x
    self.y = y

    self.air = air

    self.level = 1

    self.baseAttack = math.random(100)
    self.baseDefense = math.random(100)
    self.maxHealth = math.random(100) + 50
    self.health = self.maxHealth

    self.exp = 0
    self.maxExp = 100

    self.direction = math.random(8)

    self.width = 1
    self.height = 1

    self.mass = 1
    self.radius = 0.25

    self.armor = Equipment(self.x, self.y, EQUIPMENT_DEFS[1])
    self.head = Equipment(self.x, self.y, EQUIPMENT_DEFS[2])
    self.weapon = Equipment(self.x, self.y, EQUIPMENT_DEFS[3])

    self.offsetX = -4
    self.offsetY = -2

    self.attackSpeed = 0.5
    self.inventory = {}
end

function Player:graphics()
    local graphics = {{
        gTextures[self.armor.texture], 
        gFrames[self.armor.texture][self.direction][self.animation:getCurrentFrame()]
    }, {
        gTextures[self.head.texture],
        gFrames[self.head.texture][self.direction][self.animation:getCurrentFrame()]
    }, {
        gTextures[self.weapon.texture],
        gFrames[self.weapon.texture][self.direction][self.animation:getCurrentFrame()]
    }}

    if self.shield then
        table.insert(graphics, {
            gTextures[self.shield.texture],
            gFrames[self.shield.texture][self.direction][self.animation:getCurrentFrame()]
        })
    end
    return graphics
end

function Player:totalAttack()
    return self.baseAttack + self.weapon.attack
end

function Player:totalDefense()
    return self.baseDefense + self.armor.defense + (self.shield and self.shield.defense or 0)
end


function Player:gainExp(exp)
    self.exp = self.exp + exp
    if self.exp > self.maxExp then
        self.level = self.level + 1
        self.exp = self.exp - self.maxExp
        self.maxExp = self.maxExp * 1.2
        self.baseAttack = self.baseAttack + math.random(10)
        self.baseDefense = self.baseDefense + math.random(10)
        self.maxHealth = self.maxHealth + math.random(20)
        self.health = self.maxHealth
    end
end

function Player:pickup(item)
    if #self.inventory == 10 then
        local firstItem = table.remove(self.inventory, 1)
        firstItem.x, firstItem.y = self.x, self.y
        table.insert(self.air.drops, firstItem)
        gSounds['equipment'][item.sound]:play()
    end
    table.insert(self.inventory, item)
    gSounds['equipment'][item.sound]:play()
end
