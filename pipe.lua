require "love"

Pipe = {}
PipeMeta = {__index = Pipe}

function Pipe.new()
    local instance = {}
    setmetatable(instance, PipeMeta)

    instance.passed = false

    instance.xVelocity = -100

    instance.topX = 800
    instance.topY = 0

    instance.bottomX = 800
    instance.bottomY = 500

    instance.width = 94
    instance.height = 360

    instance.topSprite = love.graphics.newImage("assets/pipe_top.png")
    instance.bottomSprite = love.graphics.newImage("assets/pipe_bottom.png")

    return instance
end

-- debug
function Pipe:DrawTop()
    return love.graphics.rectangle("fill", self.topX, self.topY, self.width, self.height)
end

-- debug
function Pipe:DrawBottom()
    return love.graphics.rectangle("fill", self.bottomX, self.bottomY, self.width, self.height)
end

function Pipe:SetYPos(n)
    self.topY = self.topY + n
    self.bottomY = self.bottomY + n
end

function Pipe:GetSprite(input)
    if input == "top" then
        return self.topSprite
    elseif input == "bottom" then
        return self.bottomSprite
    end
end

function Pipe:Update(dt)
    self.topX = self.topX + self.xVelocity * dt
    self.bottomX = self.bottomX + self.xVelocity * dt
end

function Pipe:DetectCollision(player)
    local topCollision = 
        player.x - 2 < self.topX + self.width and
        (player.x + player.width) - 2 > self.topX and
        player.y + 2 < self.topY + self.height

    local bottomCollision = 
        player.x - 2 < self.bottomX + self.width and
        (player.x + player.width) - 2 > self.bottomX and
        (player.y + player.height) - 2 > self.bottomY

    return topCollision or bottomCollision
end

function Pipe:Passed(player)
    if not self.passed and player.x > self.topX + self.width then
        self.passed = true
        return true
    end
    return false
end

return Pipe