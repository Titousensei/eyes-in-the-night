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

local ball = {}
local grow = {}

local eyes
local aim
local caption_alpha
local caption_text

local pause = false
local lost = false
local lost_x = 0

--=== Forward Declarations ===---

local do_wait
local do_shoot
local do_grow
local do_gameover
local do_lost

--=== Init Functions ===---

local function reset()
  eyes = {}
  aim = {
    angle = 0,
    direction = aim_speed
  }

  game_mode.init_map()

  print "Game started"
  do_wait()
end

function map_eye(sz, x, y, color)
  table.insert(eyes, game_mode.new_eye(sz, x, y, color))
end

function new_caption(txt)
  caption_alpha = 330
  caption_text  = txt
end

--=== Update Functions ===---

local function update_eyes(dt)
  for k, v in pairs(eyes) do
    local b = v:update(dt)

    if b == 0 then
      print ("Bounce eye number:", k)
      love.audio.play(sound_no)
    elseif b > 0  then
      game_mode.delete_eye(eyes[k].color)
      eyes[k] = nil
      local coef = 30
      if score > 120 then
        coef = 50
      end
      local next_ball = math.ceil((score+1)/coef)*coef
      score = score + b
      if score >= next_ball and game_mode.num_ball < 3 then
        game_mode.num_ball = game_mode.num_ball + 1
        new_caption("* 1UP at "..next_ball.." *")
      end
      print ("Delete eye:",k, "points", b)
      love.audio.play(sound_no_long)
    end
  end
end

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
  update_eyes(dt)
end

local function update_shoot(dt)
  ball.x = ball.x + ball.dx * dt
  ball.y = ball.y - ball.dy * dt
  ball.dx = ball.dx * friction
  ball.dy = ball.dy * friction

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
    return
  end

  -- bounce on eyes
  for k, v in pairs(eyes) do
    v:bounce(ball)
  end
  update_eyes(dt)

  ball.speed = ball.speed * friction

  if ball.speed < 5.0 then
    print ("Stopped at speed:", ball.speed)
    do_grow()
    return
  end
end

local function update_grow(dt)
  grow.size = grow.size + dt

  if grow.size >= .5 then
    map_eye(grow.max_size, ball.x, ball.y)
    if lost then
      do_lost()
    else
      do_wait()
    end
  end
end

local function update_gameover(dt) end
local function update_victory(dt) end

local function update_lost(dt)
  ball.x = ball.x - 120 *dt
  local dy = ball.x - lost_x
  local dx = start_x - lost_x
  ball.y = start_y - 30*(1-dy*dy/(dx*dx))
  if ball.x <= start_x then
    ball.x = start_x
    do_wait()
  end
end

--=== Switch functions ===---

do_wait = function()
  print "... do_wait"
  if game_mode.end_condition() then
    do_victory()
    return
  end

  update_fn = update_wait

  grow.size = 0

  ball.x = start_x
  ball.y = start_y
  ball.dx = 0
  ball.dy = 0
  ball.speed = 0
end

do_shoot = function()
  print "... do_shoot"
  update_fn = update_shoot

  print ("Shooting angle:", aim.angle)

  ball.speed = ball_speed
  ball.dx = ball_speed * math.sin(aim.angle)
  ball.dy = ball_speed * math.cos(aim.angle)
end

do_grow = function()
  print "... do_grow"
  update_fn = update_grow

  local r = math.min(ball.x, play_w - ball.x, ball.y, play_h0 - ball.y)

  for _, v in pairs(eyes) do
    local dx = ball.x - v.x
    local dy = ball.y - v.y
    local dr = math.sqrt(dx*dx+dy*dy) - v.radius
    r = math.min(r, dr)
  end

  if ball.y>play_h1 then
    print "Won't grow in safe zone"
    if lost then
      do_lost()
    else
      do_wait()
    end
  else
    print ("Grow to:", r)

    ball.speed = 0
    ball.dx = 0
    ball.dy = 0

    grow.size = 0.1
    grow.max_size = r/160
  end
end

do_gameover = function()
  print ("... do_gameover", game_mode.num_ball)
  if game_mode.num_ball >= 1 then
    game_mode.num_ball = game_mode.num_ball - 1
    love.audio.play(sound_lost)
    lost = true
    do_grow()
  else
    print ("Lost:",score)
    love.audio.stop()
    love.audio.play(sound_lost_all)
    update_fn = update_gameover
    game_mode.gameover()
  end
end

do_victory = function()
  print ("Victory:",score)
  update_fn = update_victory
end

do_lost = function()
  ball.x = start_x+13+game_mode.num_ball*45+45
  ball.y = start_y
  lost_x = (ball.x + start_x)/2
  update_fn = update_lost
end

--=== CALLBACKS ===---

game = {}

function game.load()
  gameover_img = love.graphics.newImage("assets/gameover.png")
  victory_img = love.graphics.newImage("assets/victory.png")
  pause_img = love.graphics.newImage("assets/pause.png")

  grow.img = love.graphics.newImage("assets/ball1.png")
  ball.img = love.graphics.newImage("assets/ball.png")

  print "Assets Loaded"
  reset()
  new_caption(game_mode.caption)
end

function game.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(game_mode.bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  love.graphics.print(score, 20, 565, 0, 1, 1)

  if pause then
    love.graphics.draw(pause_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  else
    for _, v in pairs(eyes) do
      v:draw(ball.x, ball.y)
    end

    if update_fn == update_gameover then
      love.graphics.draw(gameover_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
    elseif update_fn == update_victory then
      love.graphics.draw(victory_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
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

      if game_mode.num_ball>0 then
        for i = 1,game_mode.num_ball do
          love.graphics.draw(ball.img, start_x+13+i*45, start_y, 0.0, 0.25, 0.25, 60, 60)
        end
      end

      if caption_alpha>0 then
        love.graphics.setColor(255, 255, 255, math.min(caption_alpha,255))
        love.graphics.printf(caption_text, 50, 200+caption_alpha/3, 500, "center")
      end
    end
  end
end

function game.update(dt)
  if pause then return end
  if caption_alpha>0 then
    caption_alpha = caption_alpha - 110*dt
  end
  update_fn(dt)
end

function game.mousereleased(x,y,b)
  if update_fn == update_gameover then
    change_state(menu)
  elseif update_fn == update_victory then
    next_level()
    change_state(chapter)
  elseif (b == "r") then
    pause = not pause
  elseif update_fn == update_wait then
    do_shoot()
  end
end

function game.keypressed(key)
  if update_fn == update_gameover then
    change_state(menu)
  elseif update_fn == update_victory then
    next_level()
    change_state(chapter)
  elseif (key == "p") then
    pause = not pause
  elseif update_fn == update_wait then
    do_shoot()
  end
end

