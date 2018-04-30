Player = Class{__includes = Entity}

function Player:init()
    self.x = MAP_SIZE / 2
    self.y = MAP_SIZE / 2

    self.direction = 1

    self.width = 1
    self.height = 1

    self.mass = 1
    self.radius = 0.25

    self.body = 'clothes'
    self.head = 'male_head1'

    self.stateMachine = StateMachine {
        ['idle'] = function() return PlayerIdleState(self) end,
        ['run'] = function() return PlayerRunState(self) end,
    }
    self:changeState('idle')
end

function Player:render(renderBody)
    renderBody(gTextures[self.body],
        gFrames[self.body][self.direction][self.animation:getCurrentFrame()], 
        self.x, self.y, -4, -2)

    renderBody(gTextures[self.head],
        gFrames[self.head][self.direction][self.animation:getCurrentFrame()], 
        self.x, self.y, -4, -2)
end