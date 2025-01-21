player = require("player")
running = false

function love.load()
    plr = player.new()
    plr:Center()
end

function love.update(dt)
    if running == true then
        plr.y = plr.y + 0.5
    end
end

function love.draw()
    love.graphics.draw(plr:GetSprite(), plr.x, plr.y, 0, 0.075, 0.075)
end