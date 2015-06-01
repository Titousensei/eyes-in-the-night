--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
the author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

require "menu"
require "eyes"
require "libuserdata"

local file_userdata = "userdata.tsv"

userdata = nil
first_time = 0

local default_userdata = {
  -- survival
  best = 0,
  survival = false,
  -- adventure
  level = 0,
  balls = 0,
  score = 0,
  continue = 0,
  adventure = -1
}

local state = nil

function change_state(s)
  state = s
  --print ("State:",s)
  state.load()
end

function save_userdata()
  libuserdata.save(file_userdata, userdata)
end

function newPaddedImage(filename)
  if love._version==72 or not love._os then  -- Android?
    local source = love.image.newImageData(filename)
    local w, h = source:getWidth(), source:getHeight()

    -- Find closest power-of-two.
    local wp = math.pow(2, math.ceil(math.log(w)/math.log(2)))
    local hp = math.pow(2, math.ceil(math.log(h)/math.log(2)))

    -- Only pad if needed:
    if wp ~= w or hp ~= h then
        local padded = love.image.newImageData(wp, hp)
        padded:paste(source, 0, 0)
        return love.graphics.newImage(padded)
    end

    return love.graphics.newImage(source)
  else
    return love.graphics.newImage(filename)
  end
end

function init_joysticks()
  local joysticks = love.joystick.getJoysticks()
  for i, joystick in ipairs(joysticks) do
    if joystick:getName() == "OUYA Game Controller" then
      local guid = joystick:getGUID()
      love.joystick.setGamepadMapping(guid, "a", "button", 1)
      love.joystick.setGamepadMapping(guid, "b", "button", 2)
      love.joystick.setGamepadMapping(guid, "x", "button", 3)
      love.joystick.setGamepadMapping(guid, "y", "button", 4)
      love.joystick.setGamepadMapping(guid, "dpup", "button", 12)
      love.joystick.setGamepadMapping(guid, "dpdown", "button", 13)
      love.joystick.setGamepadMapping(guid, "dpleft", "button", 14)
      love.joystick.setGamepadMapping(guid, "dpright", "button", 15)
      love.joystick.setGamepadMapping(guid, "back", "button", 10)
      love.joystick.setGamepadMapping(guid, "start", "button", 11)

-- D-Pad Up    1
-- D-Pad Down    2
-- D-Pad Left    3
-- D-Pad Right   4
-- O       6
-- U       9
-- Y       10
-- A       7
-- LB        12
-- LT        14
-- LS        16
-- RB        13
-- RT        15
-- RS        17
-- System      5 or 8 (?) (doesn't report)
    end
  end
end

function love.load()
  print("Love version:", love._version, love._os)
  print("Start memory:",gcinfo())
  local scale = love.window.getPixelScale( )
  print("Pixel scale:", scale)

  love.graphics.setBackgroundColor(0,0,0)

  local img_font = newPaddedImage("assets/font.png")
  local default_font = love.graphics.newImageFont(img_font,
    " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,!?/=+-()*^'&")
  love.graphics.setFont(default_font)

  sound_no = love.audio.newSource("assets/no.ogg", "static")
  sound_no_long = love.audio.newSource("assets/no_long.ogg", "static")
  sound_lost = love.audio.newSource("assets/lost1.ogg", "static")
  sound_lost_all = love.audio.newSource("assets/lost_all.ogg", "static")

  userdata = libuserdata.load(file_userdata)
  if not userdata then
    print "Using default userdata"
    userdata = default_userdata
    first_time = 1
  end

  init_eyes()
  change_state(menu)
  print("End Memory:",gcinfo())
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
  if state.mousepressed then
    state.mousepressed(x,y,b)
  end
end

function love.mousereleased(x,y,b)
  state.mousereleased(x,y,b)
end

function love.mousemoved(x, y, dx, dy)
  if state.mousemoved then
    state.mousemoved(x, y, dx, dy)
  end
end


function love.keypressed(key)
  if key == "escape" then
    if state==menu then
      if love.event.quit then
        love.event.quit() -- 0.8
      else
        love.event.push("q") -- 0.7
      end
    else
      change_state(menu)
    end
  else
    state.keypressed(key)
  end
end

