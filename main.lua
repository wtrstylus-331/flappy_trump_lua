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
    gameSequence:setVolume(0.6)

    titleBg = createImage("bg.png")
    gameBg = createImage("game_bg.jpg")
    icon = createImage("player.png")
    titleTxt = createImage("title_text.png")
    label = createImage("fly_label.png")

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
        if paused == false then
            plr:Update(dt)
            
            if action then
                plr:SetYVelocity(-150)
                action = false
            end
        end
    end
end

function love.draw()
    if title == true then
        -- background
        love.graphics.setColor(1,1,1)
        love.graphics.draw(titleBg, 0, 0, 0, 0.7, 0.9)

        -- icon
        love.graphics.draw(icon, 520, 15, 0.2, 0.2, 0.2)

        -- title text
        love.graphics.draw(titleTxt, 125, 50, 0, 0.9, 0.9)

        -- btn border
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(10)
        love.graphics.rectangle("line", play.x, play.y, play.width, play.height)

        -- btn highlight + fill
        if love.mouse.getX() >= play.x and love.mouse.getX() <= play.x + play.width and love.mouse.getY() >= play.y and love.mouse.getY() <= play.y + play.height then
            love.graphics.setColor(110/255, 110/255, 110/255)
        else
            love.graphics.setColor(200/255, 200/255, 200/255)
        end
        love.graphics.rectangle("fill", play.x, play.y, play.width, play.height)  

        -- btn text
        love.graphics.setColor(0,0,0)
        love.graphics.draw(playTxt.text, playTxt.x, playTxt.y)
    end

    if running == true then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(gameBg, 0, 0, 0, 0.7, 0.7)

        love.graphics.draw(plr:GetSprite(), plr.x, plr.y, plr.rotation, 0.075, 0.075)
    end

    if paused == true then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(label, 210, 330, 0, 0.9, 0.9)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if running then
            action = true
            paused = false
        end

        if title then
            if x >= play.x and x <= play.x + play.width and y >= play.y and y <= play.y + play.height then
                running = true
                title = false
                paused = true
                gameSequence:setLooping(true)
                love.audio.stop(titleSequence)
                love.audio.play(gameSequence)
            end
        end
    end
end

function createImage(input)
    img = love.graphics.newImage("assets/" .. input)
    img:setFilter("nearest", "nearest")

    return img
end