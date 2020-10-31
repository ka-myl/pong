BALL_SIZE = 4

Ball = Class{}

function Ball:init(x, y)
    -- position
    self.x = x
    self.y = y

    -- velocity
    self.dx = math.random(2) == 1 and -200 or 200
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = math.random(2) == 1 and -200 or 200
    self.dy = math.random(-50, 50)
end

function Ball:collides(paddle)
    -- check left / right
    if self.x > paddle.x + PADDLE_WIDTH or paddle.x > self.x + BALL_SIZE then
        return false
    end

    -- check top / bottom
    if self.y > paddle.y + PADDLE_HEIGHT or paddle.y > self.y + BALL_SIZE then
        return false
    end 

    return true
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, BALL_SIZE, BALL_SIZE)
end
