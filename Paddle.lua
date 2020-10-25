PADDLE_WIDTH = 5
PADDLE_HEIGHT = 20

Paddle = Class{}

function Paddle:init(x, y)
    self.x = x
    self.y = y
    self.dy = 0
end

function Paddle:update(dt)
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - PADDLE_HEIGHT, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, PADDLE_WIDTH, PADDLE_HEIGHT)
end
