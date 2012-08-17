require "menu"

local state = nil

function change_state(s)
  state = s
  state.load()
end

function love.load()
  math.randomseed(os.time())

  default_font = love.graphics.newImageFont("assets/font.png",
    " 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,!?/=+-()*^'&")
  love.graphics.setFont(default_font)

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
  if (key == "escape") then
    if (love.event.quit) then
      love.event.quit() -- 0.8
    else
      love.event.push("q") -- 0.7
    end
  else
    state.keypressed(key)
  end
end

--[[
 480 x 320 normal   1.5
 800 x 480 large    1.6666666666666667
1024 x 600          1.7066666666666668
1280 x 800 xlarge   1.6
]]

