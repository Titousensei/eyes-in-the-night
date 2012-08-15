require "credits"
require "instructions"
require "game"

menu = {}

local menu_img

function menu.load()
  love.graphics.setBackgroundColor(0,0,0)

  menu_img = love.graphics.newImage("assets/menu1.png")
end

function menu.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(menu_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  --love.graphics.print("This is some text 0123456789", 50, 50)
end

function menu.update(dt)
end

function menu.keypressed(key)
  if key == "return"
  or key == "p" or key == "P"
  or key == "g" or key == "G"
  then
    change_state(game)
  elseif key == "s" or key == "S" then
    --change_state(survival)
  elseif key == "i" or key == "I" then
    change_state(instructions)
  elseif key == "c" or key == "C" then
    change_state(credits)
  end
end

