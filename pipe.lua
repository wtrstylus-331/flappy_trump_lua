require "love"

Pipe = {}
PipeMeta = {__index = Pipe}

function Pipe.new()
    local instance = {}
    setmetatable(instance, PipeMeta)

    instance.xVelocity = -100

    instance.topX = 800
    instance.topY = 0

    instance.bottomX = 800
    instance.bottomY = 500

    instance.width = 94
    instance.height = 363

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
    plr = player

    local topCollision = 
        player.x < self.topX + self.width and
        player.x + player.width > self.topX and
        player.y + 2 < self.topY + self.height

    local bottomCollision = 
        player.x < self.bottomX + self.width and
        player.x + player.width > self.bottomX and
        player.y + player.height > self.bottomY

    return topCollision or bottomCollision
end

return Pipe