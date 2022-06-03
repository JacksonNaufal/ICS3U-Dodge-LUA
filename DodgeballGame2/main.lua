function love.load()
    sprites = {}
    sprites.background = love.graphics.newImage('sprites/background.png')
    sprites.player = love.graphics.newImage('sprites/player.png')
    sprites.targer = love.graphics.newImage('sprites/target.png')

    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getWidth() / 2
    player.movement = 180
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
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(sprites.player, player.x, player.y )
end