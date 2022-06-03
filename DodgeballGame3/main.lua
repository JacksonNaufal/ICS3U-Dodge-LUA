function love.load()
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.player = love.graphics.newImage('sprites/player.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getWidth() / 2
    player.movement = 180
    tempRotation = 0
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
    
    tempRotation = tempRotation + 0.01
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(sprites.player, player.x, player.y, tempRotation, nil, nil, sprites.player:getWidth()/2, sprites.player:getHeight()/2)
end