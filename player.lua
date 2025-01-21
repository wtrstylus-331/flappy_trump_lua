require "love"

Player = {}
PlayerMeta = {__index = Player}

function Player.new()
    local instance = {}
    setmetatable(instance, PlayerMeta)

    instance.x = 0
    instance.y = 0
    instance.yVelocity = 0
    instance.width = 64
    instance.height = 64
    instance.sprite = love.graphics.newImage("assets/player.png")
    --instance.sprite:setFilter("nearest", "nearest")

    return instance
end

function Player:GetSprite()
    return self.sprite
end

function Player:Center()
    self.x = (love.graphics.getPixelWidth() / 2) - (self.width / 2)
    self.y = (love.graphics.getPixelHeight() / 2) - (self.height / 2)
end

function Player:Update(dt)
    self.yVelocity = self.yVelocity + 40 * 5 * dt

    if self.yVelocity > 500 then
        self.yVelocity = 500
    end

    self.y = self.y + self.yVelocity * dt
end

function Player:SetYVelocity(velocity)
    self.yVelocity = velocity
end

return Player