playerClass = require("player")
pipeClass = require("pipe")

function love.load()
    plr = playerClass.new()
    plr:Center()

    score = 0
    highscore = 0
    running = true
    action = false
end

function love.update(dt)
    if running == true then
        plr:Update(dt)

        if action then
            plr:SetYVelocity(-150)  -- Apply upward velocity when the mouse is clicked
            action = false   -- Reset the click state to avoid continuous jumping
        end
    end
end

function love.draw()
    love.graphics.draw(plr:GetSprite(), plr.x, plr.y, 0, 0.075, 0.075)
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then  -- Left mouse button (button 1 is usually the left button)
        action = true
    end
end