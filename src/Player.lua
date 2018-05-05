Player = Class{__includes = Entity}

function Player:init(x, y)
    self.x = x
    self.y = y

    self.health = 100

    self.direction = 1

    self.width = 1
    self.height = 1

    self.mass = 1
    self.radius = 0.25

    self.body = 'clothes'
    self.head = 'male_head1'
    self.weapon = 'dagger'

    self.offsetX = -4
    self.offsetY = -2

    self.attackSpeed = 0.5
    self.inventory = {}
end

function Player:graphics()
    return {
        {
            gTextures[self.body], 
            gFrames[self.body][self.direction][self.animation:getCurrentFrame()]
        }, {
            gTextures[self.head],
            gFrames[self.head][self.direction][self.animation:getCurrentFrame()]
        }, {
            gTextures[self.weapon],
            gFrames[self.weapon][self.direction][self.animation:getCurrentFrame()]
        }
    }
end