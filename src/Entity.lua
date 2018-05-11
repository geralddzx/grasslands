Entity = Class{}

function Entity:init(def)

    -- in top-down games, there are four directions instead of two
    self.direction = 'down'

    -- dimensions
    self.x = def.x
    self.y = def.y
    self.width = def.width
    self.height = def.height

    self.tiles = def.tiles

    self.walkSpeed = def.walkSpeed

    self.health = def.health

    self.dead = false
end

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:update(dt)
    self.animation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:origin()
    return self.x - self.width / 2, self.y - self.height / 2
end

function Entity:attack()
    self.lastAttack = self.lastAttack or 0
    if os.time() - self.lastAttack > self.attackSpeed then
        self:changeState('attack')
        self.lastAttack = os.time()
        return true
    end
end

function Entity:hurt(damage)
    if not self.dead then
        self:changeState('hurt', damage)
    end
end

-- function processCollision(object)
--   if self.x == object.x and self.y == object.y then
--       self.x = self.x + math.random() - 0.5
--       self.y = self.y + math.random() - 0.5
--   end

--   local x, y = self.x - object.x, self.y - object.y
--   local touchDistance = self.radius + object.radius
--   local distance = Magnitude(x, y)

--   if distance < touchDistance then
--       local pushDistance = touchDistance - distance
--       local pushScale = pushDistance / distance
--       local dx, dy = pushScale * x, pushScale * y

--       self.x, self.y = self.x + dx, self.y + dy
--   end
-- end

-- function Entity:createAnimations(animations)
--     local animationsReturned = {}

--     for k, animationDef in pairs(animations) do
--         animationsReturned[k] = Animation {
--             texture = animationDef.texture or 'entities',
--             frames = animationDef.frames,
--             interval = animationDef.interval
--         }
--     end

--     return animationsReturned
-- end

-- --[[
--     AABB with some slight shrinkage of the box on the top side for perspective.
-- ]]
-- function Entity:collides(target)
--     return not (self.x + self.width < target.x or self.x > target.x + target.width or
--                 self.y + self.height < target.y or self.y > target.y + target.height)
-- end

-- function Entity:damage(dmg)
--     self.health = self.health - dmg
-- end

-- function Entity:goInvulnerable(duration)
--     self.invulnerable = true
--     self.invulnerableDuration = duration
-- end

-- function Entity:changeState(name, params)
--     self.stateMachine:change(name, params)
-- end

-- function Entity:changeAnimation(name)
--     self.currentAnimation = self.animations[name]
-- end



-- function Entity:processAI(params, dt)
--     self.stateMachine:processAI(params, dt)
-- end

-- function Entity:render(adjacentOffsetX, adjacentOffsetY)
--     -- draw sprite slightly transparent if invulnerable every 0.04 seconds
--     if self.invulnerable and self.flashTimer > 0.06 then
--         self.flashTimer = 0
--         love.graphics.setColor(255, 255, 255, 64)
--     end

--     self.x, self.y = self.x + (adjacentOffsetX or 0), self.y + (adjacentOffsetY or 0)
--     self.stateMachine:render()
--     love.graphics.setColor(255, 255, 255, 255)
--     self.x, self.y = self.x - (adjacentOffsetX or 0), self.y - (adjacentOffsetY or 0)
-- end