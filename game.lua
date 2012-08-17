require "eyes"

local update_fn
local aim_speed = 1.5
local ball_speed = 500
local friction = 0.99

play_h = love.graphics.getHeight()
play_w = love.graphics.getWidth()
local play_h0 = play_h - 50
local play_h1 = play_h0 - 15
local play_w0 = play_w - 15

local start_x = play_w / 2
local start_y = play_h - 15

local bg_img

local eyes
local ball = {}
local grow = {}
local aim
local score

local pause = false

--=== Forward Declarations ===---

local do_wait
local do_shoot
local do_grow
local do_gameover

--=== Init Functions ===---

local function reset()
  eyes = {}
  aim = {
    angle = 0,
    direction = aim_speed
  }

  score = 0

  print "Game started"

  do_wait()
end


--=== Update Functions ===---

local function update_wait(dt)
  aim.angle = aim.angle + dt * aim.direction
  if aim.angle > 1.45 then
    aim.angle = 2.9 - aim.angle
    aim.direction = -aim_speed
  end
  if aim.angle < -1.45 then
    aim.angle = -2.9 - aim.angle
    aim.direction = aim_speed
  end
end

local function update_shoot(dt)

  --if ball.dx == 0 and ball.dy == 0 then return end

  ball.x = ball.x + ball.dx * dt
  ball.y = ball.y - ball.dy * dt
  ball.dx = ball.dx * friction
  ball.dy = ball.dy * friction

  --print (ball.x,ball.y,ball.dx,ball.dy)

  if ball.x > play_w0 then
    print "Bounce right wall"
    ball.x = play_w0 * 2 - ball.x
    ball.dx = - ball.dx
  elseif ball.x < 15 then
    print "Bounce left wall"
    ball.x = 30 - ball.x
    ball.dx = - ball.dx
  end

  if ball.y < 15 then
    print "Bounce top wall"
    ball.y = 30 - ball.y
    ball.dy = - ball.dy
  elseif ball.y > play_h1 and ball.dy < 0 then
    do_gameover()
  end

  -- bounce on eyes
  for k, v in pairs(eyes) do
    local b = v:bounce(ball, dt)

    if b == 1 then
      print ("Bounce eye number:", k)
    elseif b == -1 then
      eyes[k] = nil
      score = score + 1
      print ("Delete eye:",k)
    end
  end

  ball.speed = ball.speed * friction

  if ball.speed < 5.0 then
    print ("Stopped at speed:", ball.speed)
    do_grow()
  end
end

local function update_grow(dt)
  grow.size = grow.size + 0.02

  if grow.size >= grow.max_size then
    --local e = new_eye(grow.max_size, ball.x, ball.y, "green")
    local e = new_eye(grow.max_size, ball.x, ball.y)
    table.insert(eyes, e)
    do_wait()
  end
end

local function update_gameover(dt)
end

--=== Switch functions ===---

do_wait = function()
  --print"do_wait"
  update_fn = update_wait

  grow.size = 0

  ball.x = start_x
  ball.y = start_y
  ball.dx = 0
  ball.dy = 0
  ball.speed = 0
end

do_shoot = function()
  --print"do_shoot"
  update_fn = update_shoot

  print ("Shooting angle:", aim.angle)

  ball.speed = ball_speed
  ball.dx = ball_speed * math.sin(aim.angle)
  ball.dy = ball_speed * math.cos(aim.angle)
end

do_grow = function()
  --print"do_grow"
  update_fn = update_grow

  local r = math.min(ball.x, play_w - ball.x , ball.y, play_h0 - ball.y)

  for k, v in pairs(eyes) do
    local dx = ball.x - v.x
    local dy = ball.y - v.y
    local dr = math.sqrt(dx*dx+dy*dy) - v.radius
    r = math.min(r, dr)
  end

  print ("Grow to:", r)

  ball.speed = 0
  ball.dx = 0
  ball.dy = 0

  grow.size = 0.1
  grow.max_size = r/160
end

do_gameover = function()
  print ("Lost:",score)
  update_fn = update_gameover
end

--=== CALLBACKS ===---

game = {}

function game.load()
  love.graphics.setBackgroundColor(0,0,0)

  bg_img = love.graphics.newImage("assets/background.png")
  gameover_img = love.graphics.newImage("assets/gameover.png")
  pause_img = love.graphics.newImage("assets/pause.png")

  grow.img = love.graphics.newImage("assets/ball1.png")
  ball.img = love.graphics.newImage("assets/ball.png")

  print "Assets Loaded"
  reset()
end

function game.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.print( score, 20, 565, 0, 1, 1)

  love.graphics.setColor(255, 255, 255, 255)

  if pause then
    love.graphics.draw(pause_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  else
    for k, v in pairs(eyes) do
      v:draw(ball.x, ball.y)
    end

    if update_fn == update_gameover then
      love.graphics.draw(gameover_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
    else
      love.graphics.setColor(255, 128, 0, 180)
      love.graphics.setLineWidth(3)

      local x2 = start_x + 50 * math.sin(aim.angle)
      local y2 = start_y - 50 * math.cos(aim.angle)
      love.graphics.line(start_x, start_y, x2, y2)

      if grow.size>0 then
        local alpha = math.sqrt(grow.size) * 400
        if alpha>255 then alpha = 255 end
        love.graphics.setColor(255, 255, 255, alpha)
        love.graphics.draw(grow.img, ball.x, ball.y, 0.0, grow.size, grow.size, 160, 160)
      end

      love.graphics.setColor(255, 255, 255, 255)
      love.graphics.draw(ball.img, ball.x, ball.y, 0.0, 0.25, 0.25, 60, 60)
    end
  end
end

function game.update(dt)
  if pause then return end
  update_fn(dt)
end

function game.mousereleased(x,y,b)
  if update_fn == update_gameover then
    change_state(menu)
  elseif (b == "r") then
    pause = not pause
  elseif update_fn == update_wait then
    do_shoot()
  end
end

function game.keypressed(key)
  if update_fn == update_gameover then
    change_state(menu)
  elseif (key == "p") then
    pause = not pause
  elseif update_fn == update_wait then
    do_shoot()
  end
end

