Player = Class{__includes = Entity}

function Player:init(x, y)
    self.x = x
    self.y = y

    self.level = 1
    self.health = 100
    self.maxHealth = 100

    self.exp = 0
    self.maxExp = 100

    self.direction = 1

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

function Player:stats()
    return {
        level = self.level,
        attack = 100,
        defense = 100,
    }
end

function Player:pickup(item)
    table.insert(self.inventory, item)
    gSounds['equipment'][item.sound]:play()
end
