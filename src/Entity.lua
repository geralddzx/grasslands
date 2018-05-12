Entity = Class{}

function Entity:changeState(name, params)
    self.stateMachine:change(name, params)
end

function Entity:update(dt)
    self.animation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:origin()
    -- get entity center
    return self.x - self.width / 2, self.y - self.height / 2
end

function Entity:attack()
    -- don't allow entity to attack more frequent than its attack speed
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