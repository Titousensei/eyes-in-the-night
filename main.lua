require "menu"
require "eyes"
require "libuserdata"

local file_userdata = "userdata.tsv"

userdata = nil

local default_userdata = {
  -- survival
  best = 0,
  survival = false,
  -- adventure
  chapter = 0,
  balls = 0,
  score = 0
}

local state = nil

function change_state(s)
  state = s
  print ("State:",s)
  state.load()
end

function save_userdata()
  libuserdata.save(file_userdata, userdata)
end

function love.load()
  love.graphics.setBackgroundColor(0,0,0)

  default_font = love.graphics.newImageFont("assets/font.png",
    " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,!?/=+-()*^'&")
  love.graphics.setFont(default_font)

  sound_no = love.audio.newSource("assets/no.mp3", "static")
  sound_no_long = love.audio.newSource("assets/no_long.mp3", "static")
  sound_lost = love.audio.newSource("assets/lost1.mp3", "static")
  sound_lost_all = love.audio.newSource("assets/lost_all.mp3", "static")

  userdata = libuserdata.load(file_userdata)
  if not userdata then
    print "Using default userdata"
    userdata = default_userdata
  end

  init_eyes()
  change_state(menu)
end

function love.draw()
  state.draw()
end

function love.update(dt)
  state.update(dt)
end

function love.focus(f)
  paused = not f
end

mousex = -1
mousey = -1
mouseb = -1

function love.mousepressed(x,y,b)
  mousex = x
  mousey = y
  mouseb = b
end

function love.mousereleased(x,y,b)
  state.mousereleased(x,y,b)
end

function love.keypressed(key)
  if key == "escape" then
    if love.event.quit then
      love.event.quit() -- 0.8
    else
      love.event.push("q") -- 0.7
    end
  elseif key == "q" or key == "Q" then
    change_state(menu)
  else
    state.keypressed(key)
  end
end

