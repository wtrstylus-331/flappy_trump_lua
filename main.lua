player = require("player")

function love.load()
    plr = player.new()
end

function love.update(dt)

end

function love.draw()
    love.graphics.setColor(200/255, 0, 0)
    love.graphics.rectangle("fill", 10, 10, 100, 50)
end