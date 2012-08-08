local update_fn
local eyes = {}
local ball = {}
local grow = {}
local aim = {}
local aim_speed = 2
local ball_speed = 600
local friction = 0.99

local play_h = love.graphics.getHeight()
local play_w = play_h

local start_x = 400
local start_y = 585

--=== Forward Declarations ===---

local do_wait
local do_shoot
local do_grow

--=== Update Functions ===---

local function update_wait(dt)
  aim.angle = aim.angle + dt * aim.direction
  if aim.angle > 1.4 then
    aim.angle = 2.8 - aim.angle
    aim.direction = -aim_speed
  end
  if aim.angle < -1.4 then
    aim.angle = -2.8 - aim.angle
    aim.direction = aim_speed
  end
end

local function update_shoot(dt)
  ball.x = ball.x + ball.dx * dt
  ball.y = ball.y - ball.dy * dt
  ball.dx = ball.dx * friction
  ball.dy = ball.dy * friction

  if ball.x > play_w then
    ball.x = play_w * 2 - ball.x
    ball.dx = - ball.dx
  elseif ball.x < 15 then
    ball.x = 30 - ball.x
    ball.dx = - ball.dx
  end

  if ball.y < 15 then
    ball.y = 30 - ball.y
    ball.dy = - ball.dy
  end

  ball.speed = ball.speed * friction

  if ball.speed < 3.0 then
    do_grow()
  end
end

local function update_grow(dt)
  grow.size = grow.size + 0.01

  if grow.size > 1.0 then
    do_wait()
  end
end

--=== Switch functions ===---

do_wait = function()
  print"do_wait"

  update_fn = update_wait

  grow.size = 0

  ball.x = start_x
  ball.y = start_y
  ball.dx = 0
  ball.dy = 0
  ball.speed = 0
end

do_shoot = function()
  print"do_shoot"
  update_fn = update_shoot

  ball.speed = ball_speed
  ball.dx = ball_speed * math.sin(aim.angle)
  ball.dy = ball_speed * math.cos(aim.angle)
end

do_grow = function()
  print"do_grow"
  update_fn = update_grow

  ball.speed = 0
  ball.dx = 0
  ball.dy = 0

  grow.size = 0.1
end

--=== CALLBACKS ===---

game = {}

function game.load()
  love.graphics.setBackgroundColor(0,0,0)

  grow.img = love.graphics.newImage("assets/ball1.png")

  ball.img = love.graphics.newImage("assets/ball.png")

  aim.angle = 0
  aim.direction = aim_speed

  print"game started"

  do_wait()
end

function game.draw()
  love.graphics.setColor(255, 0, 0, 180)
  love.graphics.setLineWidth(3)

  x2 = start_x + 50 * math.sin(aim.angle)
  y2 = start_y - 50 * math.cos(aim.angle)
  love.graphics.line(start_x, start_y, x2, y2)

  love.graphics.setColor(255, 255, 255)

  if grow.size>0 then
    love.graphics.draw(grow.img, ball.x, ball.y, 0.0, grow.size, grow.size, 160, 160)
  else
    love.graphics.draw(ball.img, ball.x, ball.y, 0.0, 0.25, 0.25, 58, 58)
  end

  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.point( ball.x, ball.y )
  love.graphics.print(string.format("%1.1f %1.2f", ball.speed, grow.size), 10, 200)
end

function game.update(dt)
  update_fn(dt)
end

function game.keypressed(key)
  if update_fn == update_wait then
    do_shoot()
  end
end

