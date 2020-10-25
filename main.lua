push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20
PADDLE_SPEED = 200
PADDLE_STARTING_HEIGHT = (VIRTUAL_HEIGHT / 2) - (PADDLE_HEIGHT / 2)

SCORE_Y = 50
P1_SCORE_X = VIRTUAL_WIDTH / 2 - 50
P2_SCORE_X = VIRTUAL_WIDTH / 2 + 30

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Game state
    p1Score = 1
    p2Score = 0

    p1Y = PADDLE_STARTING_HEIGHT
    p2Y = PADDLE_STARTING_HEIGHT
end

function love.update(dt)
    -- Player 1 controls
    if love.keyboard.isDown('w') then
        p1Y = p1Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        p1Y = p1Y + (PADDLE_SPEED * dt)
    end

     -- Player 2 controls
     if love.keyboard.isDown('up') then
        p2Y = p2Y + (-PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        p2Y = p2Y + (PADDLE_SPEED * dt)
    end
end
 

function love.draw()
    push:apply('start')

    -- Draw background
    love.graphics.clear(40, 45, 52, 0)

    -- Draw title
    love.graphics.setFont(smallFont)
    love.graphics.printf('Pong', 0, 20, VIRTUAL_WIDTH, 'center')

    -- Draw scoreboard
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(p1Score), P1_SCORE_X, SCORE_Y)
    love.graphics.print(tostring(p2Score), P2_SCORE_X, SCORE_Y)

    -- Draw paddles and ball
    love.graphics.rectangle('fill', 10, p1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, p2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
