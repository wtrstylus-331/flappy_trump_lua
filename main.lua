playerClass = require("player")
pipeClass = require("pipe")

function rng()
    math.randomseed(os.time())

    for i = 1, 5 do
        math.random()
    end
end

function love.load()
    rng()

    play = {}
    replay = {}
    playTxt = {}
    replayTxt = {}
    gamePipes = {}

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
    deadLabel = createImage("dead_label.png")

    play.width = 175
    play.height = 80
    play.x = (love.graphics.getPixelWidth() / 2) - (175 / 2)
    play.y = 350

    playTxt.text = love.graphics.newText(love.graphics.newFont(50), "PLAY")
    playTxt.x = play.x + 30
    playTxt.y = play.y + 10

    replay.width = 200
    replay.height = 70
    replay.x = (love.graphics.getPixelWidth() / 2) - (175 / 2)
    replay.y = 470

    replayTxt.text = love.graphics.newText(love.graphics.newFont(40), "RESTART")
    replayTxt.x = replay.x + 12
    replayTxt.y = replay.y + 10

    score = 0
    highscore = 0
    counter = 0
    running = false
    title = true
    paused = false
    action = false
    dead = false
end

function love.update(dt)
    if running == true then
        if paused == false then
            counter = counter + 1
            
            if counter >= 810 then
                p = pipeClass.new()
                p:SetYPos(math.random(-250, 0))
                table.insert(gamePipes, p)
                counter = 0
            end

            for i, p in ipairs(gamePipes) do
                p:Update(dt)

                if p:DetectCollision(plr) == true then
                    die()
                end
            end

            for i = #gamePipes, 1, -1 do
                if gamePipes[i].topX < -90 then
                    table.remove(gamePipes, i)
                end
            end

            plr:Update(dt)
            
            if action then
                plr:SetYVelocity(-150)
                action = false
            end

            if plr.y >= (600 - plr.height) then
                die()
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
        love.graphics.setColor(1,1,1)
        love.graphics.draw(icon, 520, 15, 0.2, 0.2, 0.2)

        -- title text
        love.graphics.setColor(1,1,1)
        love.graphics.draw(titleTxt, 125, 50, 0, 0.9, 0.9)

        -- btn border
        love.graphics.setColor(0,0,0)
        love.graphics.setLineWidth(10)
        love.graphics.rectangle("line", play.x, play.y, play.width, play.height)

        -- btn highlight + fill
        if love.mouse.getX() >= play.x and love.mouse.getX() <= play.x + play.width and love.mouse.getY() >= play.y and love.mouse.getY() <= play.y + play.height then
            love.graphics.setColor(110/255, 110/255, 110/255)
        else
            love.graphics.setColor(220/255, 220/255, 220/255)
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

        for i, pipe in ipairs(gamePipes) do
            love.graphics.setColor(1,1,1)
            love.graphics.draw(pipe:GetSprite("top"), pipe.topX, pipe.topY, 0, 0.4, 0.4)
            love.graphics.draw(pipe:GetSprite("bottom"), pipe.bottomX, pipe.bottomY, 0, 0.4, 0.4)
        end
    end

    if paused == true then
        if dead then
            love.graphics.setColor(1,1,1)
            love.graphics.draw(deadLabel, 235, 330, 0, 0.9, 0.9)
            
            -- btn border
            love.graphics.setColor(0,0,0)
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line", replay.x, replay.y, replay.width, replay.height)
    
            -- btn highlight + fill
            if love.mouse.getX() >= replay.x and love.mouse.getX() <= replay.x + replay.width and love.mouse.getY() >= replay.y and love.mouse.getY() <= replay.y + replay.height then
                love.graphics.setColor(110/255, 110/255, 110/255)
            else
                love.graphics.setColor(220/255, 220/255, 220/255)
            end
            love.graphics.rectangle("fill", replay.x, replay.y, replay.width, replay.height)  
    
            -- btn text
            love.graphics.setColor(0,0,0)
            love.graphics.draw(replayTxt.text, replayTxt.x, replayTxt.y)
        else 
            love.graphics.setColor(1,1,1)
            love.graphics.draw(label, 210, 330, 0, 0.9, 0.9)
        end
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        if running then
            action = true

            if dead == false then
                paused = false
            end

            if paused == true then
                if dead == true then
                    if x >= replay.x and x <= replay.x + replay.width and y >= replay.y and y <= replay.y + replay.height then
                        paused = true
                        dead = false
                        clearPipes()
                        plr:Center()
                    end
                end
            end
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

function clearPipes()
    for i = #gamePipes, 1, -1 do
        table.remove(gamePipes, i)
    end
end

function die()
    dead = true
    paused = true
end

function restart()
    dead = false
    paused = false
end