push = require 'push'
Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_STARTING_HEIGHT = (VIRTUAL_HEIGHT / 2) - (PADDLE_HEIGHT / 2)

SCORE_Y = 30
P1_SCORE_X = VIRTUAL_WIDTH / 2 - 100
P2_SCORE_X = VIRTUAL_WIDTH / 2 + 70

function love.load()
    -- General setup
    math.randomseed(os.time())

    -- fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Screen setup
    love.window.setTitle('Pong')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    -- Game state
    player1 = Paddle(10, PADDLE_STARTING_HEIGHT)
    player2 = Paddle(VIRTUAL_WIDTH - 15, PADDLE_STARTING_HEIGHT)

    player1Score = 1
    player2Score = 0

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gamePhase = 'start'
end

function love.update(dt)
    -- Ball movement
    if gamePhase == 'play' then
        if ball:collides(player1) then
            -- Reverse and slightly increase ball horizontal direction
            ball.dx = -ball.dx * 1.03

            -- keep vertical direction, but randomize it
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        if ball:collides(player2) then
            -- Reverse and slightly increase ball horizontal direction
            ball.dx = -ball.dx * 1.03

            -- keep vertical direction, but randomize it
            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        -- reverse vertical direction on top screen edge collision
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        -- reverse vertical direction on bottom screen edge collision
        if ball.y >= VIRTUAL_HEIGHT - BALL_SIZE then
            ball.y = VIRTUAL_HEIGHT - BALL_SIZE
            ball.dy = -ball.dy
        end
    end

    -- Player 1 controls
    if love.keyboard.isDown('w') then
        player1:move('up')
    elseif love.keyboard.isDown('s') then
        player1:move('down')
    else
        player1:stop()
    end

     -- Player 2 controls
     if love.keyboard.isDown('up') then
        player2:move('up')
    elseif love.keyboard.isDown('down') then
        player2:move('down')
    else
        player2:stop()
    end

    if gamePhase == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
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
    love.graphics.print(tostring(player1Score), P1_SCORE_X, SCORE_Y)
    love.graphics.print(tostring(player2Score), P2_SCORE_X, SCORE_Y)

    -- Draw paddles and ball
    player1:render()
    player2:render()
    ball:render()

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' then
        if gamePhase == 'start' then
            gamePhase = 'play'
        else
            gamePhase = 'start'
            ball:reset()
        end
    end
end
