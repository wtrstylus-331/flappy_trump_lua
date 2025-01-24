require "love"

Player = {}
PlayerMeta = {__index = Player}

function Player.new()
    local instance = {}
    setmetatable(instance, PlayerMeta)

    instance.x = 0
    instance.y = 0
    instance.yVelocity = 0
    instance.rotation = 0
    instance.width = 64
    instance.height = 64
    instance.gravity = 10
    instance.downwardForce = 40
    instance.sprite = love.graphics.newImage("assets/player.png")

    return instance
end

function Player:GetSprite()
    return self.sprite
end

function Player:SetGravityForce(force)
    self.gravity = force
end

function Player:SetDownwardForce(force)
    self.downwardForce = force
end

function Player:Center()
    self.rotation = 0
    self.x = (love.graphics.getPixelWidth() / 2) - (self.width / 2)
    self.y = (love.graphics.getPixelHeight() / 2) - (self.height / 2)
end

function Player:Update(dt)
    self.yVelocity = self.yVelocity + self.downwardForce * self.gravity * dt

    if self.yVelocity > 500 then
        self.yVelocity = 500
    end

    if self.rotation < 0.8 then
        self.rotation = self.rotation + 0.4 * 1.05 * dt
        self.x = self.x + 15 * dt
    end

    self.y = self.y + self.yVelocity * dt
end

function Player:SetYVelocity(velocity)
    self.yVelocity = velocity
    self.rotation = -0.15
    self.x = (love.graphics.getPixelWidth() / 2) - (self.width / 2)
end

return Player