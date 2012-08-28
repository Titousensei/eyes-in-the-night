--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
then author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

local eye_data = {}
local blink_img = {}
local wound_img = {}

eye_colors = {}

local function load(color, maxwound, points)
  local bg = love.graphics.newImage("assets/"..color.."0.png")
  local fg = love.graphics.newImage("assets/"..color.."1.png")
  eye_data[color] = {
    bg = bg,
    fg = fg,
    maxwound = maxwound,
    points = points
  }

  table.insert(eye_colors, color)
end

function init_eyes()
  blink_img[1] = love.graphics.newImage("assets/blink1.png")
  blink_img[2] = love.graphics.newImage("assets/blink2.png")
  blink_img[3] = love.graphics.newImage("assets/blink3.png")
  blink_img[4] = love.graphics.newImage("assets/blink4.png")

  wound_img[1] = love.graphics.newImage("assets/wound1.png")
  wound_img[2] = love.graphics.newImage("assets/wound2.png")
  wound_img[3] = love.graphics.newImage("assets/wound3.png")

  load("brown",  0, 1)
  load("green",  2, 3)
  load("purple", 3, 10)
end

local function bounce(v, ball)
  local dx = (v.x - ball.x)
  local dy = (v.y - ball.y)

  local dr2 = dx*dx + dy*dy
  if dr2 < v.collision2 then
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
end

-- returns -1: nothing, 0: wound, >0: score, eye dead
local function update(v, dt)
  local ret = -1

  if v.dblink ~= 0 then
    v.blink = v.blink + v.dblink * dt
    if v.blink > 3.5 then
      v.dblink = - v.dblink
      v.blink  = 3.5
      if v.wound >= eye_data[v.color].maxwound then
        ret = eye_data[v.color].points
      else
        v.wound = v.wound + 1
        ret = 0
      end
    elseif v.blink < 0 then
      v.blink  = 0
      v.dblink = 0
    end
  end

  return ret
end

local function draw(v, bx, by)
  love.graphics.draw(eye_data[v.color].bg, v.x, v.y, 0.0, v.size, v.size, 160, 160)
  if v.wound>0 then
    love.graphics.draw(wound_img[v.wound], v.x, v.y, 0.0, v.size, v.size, 160, 160)
  end

  local lx = v.x - bx
  local ly = v.y - by
  local lz = math.sqrt(lx*lx+ly*ly)

  if lz <= v.size * 60 then
    lx = v.x - bx
    ly = v.y - by
  else
    lx = 60 * v.size * lx / lz
    ly = 60 * v.size * ly / lz
  end
  love.graphics.draw(eye_data[v.color].fg, v.x - lx, v.y - ly, 0.0, v.size, v.size, 65, 65)

  if v.blink>0 then
    love.graphics.draw(blink_img[math.ceil(v.blink)], v.x, v.y, 0.0, v.size, v.size, 160, 160)
  end
end

function new_eye(sz, x0, y0, col)
  -- ball radius = 60
  local r = sz * 160 + 60 * 0.25
  local r2 = r*r

  col = col or eye_colors[math.random(#eye_colors)]

  print ("New eye:", col, x0, y0, r)

  local e = {
    color = col,
    x = x0,
    y = y0,
    size = sz,
    radius = sz*160,
    collision2 = r2,
    wound = 0,
    blink = 0,
    dblink = 0,
    draw = draw,
    bounce = bounce,
    update = update
  }

  return e
end

