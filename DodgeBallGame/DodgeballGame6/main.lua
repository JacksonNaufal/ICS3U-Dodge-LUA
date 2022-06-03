function love.load()
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.zombie = love.graphics.newImage('sprites/dodgeball.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getWidth() / 2
    player.movement = 180
    tempRotation = 0

    zombies = {}
    gameState = 2
    maxTime = 6
    timer = maxTime
end 

function love.update(dt)
    if love.keyboard.isDown("right") then 
        player.x = player.x + player.movement*dt 
    elseif love.keyboard.isDown("left") then 
            player.x = player.x - player.movement*dt
    elseif love.keyboard.isDown("up") then 
        player.y = player.y - player.movement*dt
    elseif love.keyboard.isDown("down") then 
            player.y = player.y + player.movement*dt
    end

    for i,z in ipairs(zombies) do 
        z.x = z.x + math.random(0, 10)
        z.y = z.y  

        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(zombies) do
                zombies[i] = ni
            end
        end

        if gameState == 2 then
            timer = timer - dt
            if timer <= 0 then 
                spawnZombie()

                timer = maxTime
            end
        end
    end
    
    tempRotation = tempRotation + 0.01
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)

    for i,z in ipairs(zombies) do
        love.graphics.draw(sprites.zombie, z.x, z.y,  zombiePlayerAngle(z), nil, nil, sprites.zombie:getWidth()/2, sprites.zombie:getHeight()/2)
    end
end

function love.keypressed( key )
    if key == 'space' then
        spawnZombie()
    end
end

function playerMouseAngle()
   return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

function zombiePlayerAngle(enemy)
    return math.atan2(player.y - enemy.y, player.x - enemy.x)
 end

function spawnZombie()
    local zombie = {}
    zombie.x = 0
    zombie.y = math.random(0, 700)
    zombie.speed = 100
    table.insert(zombies, zombie)
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end