playerClass = require("player")
pipeClass = require("pipe")

play = {}
playTxt = {}

function love.load()
    plr = playerClass.new()
    plr:Center()

    titleSequence = love.audio.newSource("assets/title_sequence.mp3", "stream")
    titleSequence:setLooping(true)
    love.audio.play(titleSequence)

    gameSequence = love.audio.newSource("assets/game_sequence.mp3", "stream")
    gameSequence:setLooping(true)

    titleBg = love.graphics.newImage("assets/bg.png")
    titleBg:setFilter("nearest", "nearest")

    play.width = 175
    play.height = 80
    play.x = (love.graphics.getPixelWidth() / 2) - (175 / 2)
    play.y = 350

    playTxt.text = love.graphics.newText(love.graphics.newFont(50), "PLAY")
    playTxt.x = play.x + 30
    playTxt.y = play.y + 10

    score = 0
    highscore = 0
    running = false
    title = true
    paused = false
    action = false
end

function love.update(dt)
    if running == true then
        plr:Update(dt)

        if action then
            plr:SetYVelocity(-150)
            action = false
        end
    end
end

function love.draw()
    if title == true then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(titleBg, 0, 0, 0, 0.7, 0.9)

        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(10)
        love.graphics.rectangle("line", play.x, play.y, play.width, play.height)

        if love.mouse.getX() >= play.x and love.mouse.getX() <= play.x + play.width and love.mouse.getY() >= play.y and love.mouse.getY() <= play.y + play.height then
            love.graphics.setColor(110/255, 110/255, 110/255)
        else
            love.graphics.setColor(200/255, 200/255, 200/255)
        end

        love.graphics.rectangle("fill", play.x, play.y, play.width, play.height)  

        love.graphics.setColor(0,0,0)
        love.graphics.draw(playTxt.text, playTxt.x, playTxt.y)
    end

    if running == true then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(plr:GetSprite(), plr.x, plr.y, plr.rotation, 0.075, 0.075)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if running then
            action = true
        end

        if title then
            if x >= play.x and x <= play.x + play.width and y >= play.y and y <= play.y + play.height then
                running = true
                title = false
                love.audio.stop(titleSequence)
                love.audio.play(gameSequence)
            end
        end
    end
end