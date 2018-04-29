Animation = Class{}

function Animation:init(frames, interval)
    self.frames = frames
    self.interval = interval

    self.currentFrame = 1

    self.timer = 0
end

function Animation:update(dt)
    self.timer = self.timer + dt

    if self.timer > self.interval then
        self.timer = self.timer % self.interval

        self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end