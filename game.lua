local update_fn
local blink_img = {}
local wound_img = {}
local aim_speed = 1.5
local ball_speed = 500
local friction = 0.99

local play_h = love.graphics.getHeight()
local play_w = play_h
local play_h0 = play_h - 50
local play_h1 = play_h0 - 15
local play_w0 = play_w - 15

local start_x = play_w / 2
local start_y = play_h - 15

local bg_img
local eye1_img1
local eye1_img2

local eyes
local ball = {}
local grow = {}
local aim
local score

local paused = false

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

local function add_eye(sz)
  local r = sz * 160 + 60 * 0.25
  local r2 = r*r

  print ("New eye:", ball.x, ball.y, r)

  -- ball radius = 60
  local e = {
    img1 = eye1_img1,
    img2 = eye1_img2,
    x = ball.x,
    y = ball.y,
    size = sz,
    radius = sz*160,
    collision2 = r2,
    wound = 0,
    blink = 0,
    dblink = 0
  }

  table.insert(eyes, e)
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
    local dx = (v.x - ball.x)
    local dy = (v.y - ball.y)

    if ball.dx == 0 and ball.dy == 0 then return end

    local dr2 = dx*dx + dy*dy
    if dr2 < v.collision2 then
      print ("Bounce eye number:", k)

      local distance  = math.sqrt(dr2);
      local collision = v.radius + 15;
      local motion    = math.sqrt(ball.dx*ball.dx + ball.dy*ball.dy)

      -- rewind time to exact instant of collision
      local dt0 = (collision - distance)/motion --+ 0.001  -- surcompensate precision loss
      ball.x = ball.x - ball.dx * dt0
      ball.y = ball.y + ball.dy * dt0

      dx = (v.x - ball.x)
      dy = (v.y - ball.y)
      dr = math.sqrt(dx*dx+dy*dy)

      -- Unit vector in the direction of the collision
      local ax = dx/dr
      local ay = -dy/dr

      -- Projection of the velocities on the collision axis
      local va =  ball.dx*ax + ball.dy*ay
      local vb = -ball.dx*ay + ball.dy*ax

      -- Rebound
      va = -va
      --vb = vb

      -- new dx,dy for ball after collision
      ball.dx = va*ax - vb*ay;
      ball.dy = va*ay + vb*ax;

      -- move ball in the new direction to current time
      ball.x = ball.x + ball.dx*dt0;
      ball.y = ball.y - ball.dy*dt0;

      v.dblink = 30
    end

    if v.dblink ~= 0 then
      v.blink = v.blink + v.dblink * dt
      if v.blink > 3.5 then
        v.dblink = - v.dblink
        v.blink  = 3.5
        if v.wound >= 3 then
          eyes[k] = nil
          score = score + 1
          print ("Delete eye:",k)
        else
          v.wound = v.wound + 1
        end
      elseif v.blink < 0 then
        v.blink  = 0
        v.dblink = 0
      end
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
    add_eye(grow.max_size)
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

  blink_img[1] = love.graphics.newImage("assets/blink1.png")
  blink_img[2] = love.graphics.newImage("assets/blink2.png")
  blink_img[3] = love.graphics.newImage("assets/blink3.png")
  blink_img[4] = love.graphics.newImage("assets/blink4.png")

  wound_img[1] = love.graphics.newImage("assets/wound1.png")
  wound_img[2] = love.graphics.newImage("assets/wound2.png")
  wound_img[3] = love.graphics.newImage("assets/wound3.png")

  eye1_img1 = love.graphics.newImage("assets/green0.png")
  eye1_img2 = love.graphics.newImage("assets/green1.png")

  grow.img = love.graphics.newImage("assets/ball1.png")
  ball.img = love.graphics.newImage("assets/ball.png")

  print "Assets Loaded"
  reset()
end

function game.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  love.graphics.setColor(255, 255, 0, 255)
  love.graphics.print( score, 700, 100, 0, 2, 2)

  love.graphics.setColor(255, 255, 255, 255)

  for k, v in pairs(eyes) do
    love.graphics.draw(v.img1, v.x, v.y, 0.0, v.size, v.size, 160, 160)
    if v.wound>0 then
      love.graphics.draw(wound_img[v.wound], v.x, v.y, 0.0, v.size, v.size, 160, 160)
    end

    local lx = (v.x - ball.x) * v.size / play_w * 80
    local ly = (v.y - ball.y) * v.size / play_h * 80
    love.graphics.draw(v.img2, v.x - lx, v.y - ly, 0.0, v.size, v.size, 65, 65)

    if v.blink>0 then
      love.graphics.draw(blink_img[math.ceil(v.blink)], v.x, v.y, 0.0, v.size, v.size, 160, 160)
    end
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

function game.update(dt)
  if paused then return end
  update_fn(dt)
end

function game.keypressed(key)
  if (key == "p") then
    paused = not paused
  elseif update_fn == update_gameover then
    reset()
  elseif update_fn == update_wait then
    do_shoot()
  end
end

