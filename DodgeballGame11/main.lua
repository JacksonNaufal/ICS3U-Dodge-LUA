function love.load()
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.ball = love.graphics.newImage('sprites/dodgeball.png')
    sprites.lightingbolt = love.graphics.newImage('sprites/lightingbolt.png')
    sprites.bomb = love.graphics.newImage('sprites/bomb.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getWidth() / 2
    player.movement = 180
    tempRotation = 0

    myFont = love.graphics.newFont(30)

    balls = {}
    bolts = {}
    bombs = {}
    gameState = 1
    score = 0
    maxTime = 2
    timer = maxTime

    ballHit = {
        ['ball_hit'] = love.audio.newSource('ball_hit.wav', 'static')
    }
    introMusic = {
        ['load_screen_music'] = love.audio.newSource('load_screen_music.wav', 'static')
    }
    gameMusic = {
        ['game_music'] = love.audio.newSource('game_music.wav', 'static')
    }
    boltHit = {
        ['bolt_hit'] = love.audio.newSource('bolt_hit.wav', 'static')
    }
    bombHit = {
        ['bomb_hit'] = love.audio.newSource('bomb_hit.wav', 'static')
    }
end 

function love.update(dt)
    if gameState == 2 then
        if love.keyboard.isDown("right") and player.x < love.graphics.getWidth() then 
            player.x = player.x + player.movement*dt 
        elseif love.keyboard.isDown("left") and player.x > 0 then 
                player.x = player.x - player.movement*dt
        elseif love.keyboard.isDown("up") and player.y > 0  then 
            player.y = player.y - player.movement*dt
        elseif love.keyboard.isDown("down") and player.y < love.graphics.getHeight()then 
                player.y = player.y + player.movement*dt
        end
    end

    for i,z in ipairs(balls) do 
        z.x = z.x + math.random(0, 10)
        z.y = z.y  

        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(balls) do
                balls[i] = nil
                gameState = 1
                score = score + 1
                player.x = love.graphics.getWidth() / 2 
                player.y = love.graphics.getHeight() / 2
                ballHit['ball_hit']:play()
            end
        end
    end
    for i,z in ipairs(bolts) do
        z.x = z.x + math.random(0, 10)
        z.y = z.y  
        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(bolts) do
                bolts[i] = nil
                player.movement = player.movement + 25
                bombHit['bolt_hit']:play()
            end
        end
    end
    for i,z in ipairs(bombs) do
        z.x = z.x + math.random(0, 10)
        z.y = z.y  
        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(bombs) do
                bombs[i] = nil
                player.movement = player.movement - 50
                boltHit['bomb_hit']:play()
            end
        end
    end

        if gameState == 2 then
            timer = timer - dt
            if timer <= 0 then 
                spawnball()
                spawnBolt()
                spawnBomb()
                maxTime = 0.95 * maxTime
                timer = maxTime * 0.95
            end
        end
    
    tempRotation = tempRotation + 0.01
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)

    if gameState == 1 then
        love.graphics.setFont(myFont)
        love.graphics.printf("Click your RMB to begin!", 0, 50, love.graphics.getWidth(), "center")
        love.graphics.printf("Score: ".. score, 0 ,love.graphics.getHeight() - 100, love.graphics.getWidth(), "center")
        love.graphics.printf("NOTE: PRESS SPACE TO INITIATE DODGEBALLS!", 0, 150, love.graphics.getWidth(), "center")
        introMusic['load_screen_music']:play()
        gameMusic['game_music']:stop()
    end
    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)

    for i,z in ipairs(balls) do
        love.graphics.draw(sprites.ball, z.x, z.y,  ballPlayerAngle(z), nil, nil, sprites.ball:getWidth()/2, sprites.ball:getHeight()/2)
    end
    for i,z in ipairs(bolts) do
        love.graphics.draw(sprites.lightingbolt, z.x, z.y, nil, nil, nil, sprites.lightingbolt:getWidth()/2, sprites.lightingbolt:getHeight()/2 )
    end
    for i,z in ipairs(bombs) do
        love.graphics.draw(sprites.bomb, z.x, z.y, nil, nil, nil, sprites.bomb:getWidth()/2, sprites.bomb:getHeight()/2 )
    end
end

function love.keypressed( key )
    if gameState == 2 and key == 'space' then
        spawnball()
    end
    if gameState == 2 and key == 'space' then
        spawnBolt()
    end
    if gameState == 2 and key == 'space' then
        spawnBomb()
    end
end

function love.mousepressed( x, y, button)
    if button == 1 and gameState == 1 then
        gameState = 2
        maxTime = 2
        timer = maxTime
        score = 0
        gameMusic['game_music']:play()
        introMusic['load_screen_music']:stop()
    end
end

function playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function ballPlayerAngle(enemy)
    return math.atan2(player.y - enemy.y, player.x - enemy.x)
 end


function spawnball()
    local ball = {}
    ball.x = 0
    ball.y = math.random(0, 700)
    ball.speed = 100
    table.insert(balls, ball)   
end

function spawnBolt()
    if math.random(1,4) == 4 then
        local bolt = {}
        bolt.x = 0
        bolt.y = math.random(0, 700)
        bolt.speed = 100
        table.insert(bolts, bolt)
    end
end

function spawnBomb()
    if math.random(1,8) == 4 then
        local bomb = {}
        bomb.x = 300
        bomb.y = 500
        bomb.speed = 100
        table.insert(bombs, bomb)
    end
end
function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end