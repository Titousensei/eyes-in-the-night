require "credits"
require "instructions"
require "game"

menu = {}

local menu_img
local buttons = {}
local eyes = {}

local function add_button(label, x0, y0, x1, y1)
  buttons[label] = {
    x0 = x0,
    y0 = y0,
    x1 = x1,
    y1 = y1
  }
end

local function find_button(x, y)
  for k, v in pairs(buttons) do
    if  v.x0<=x and x<=v.x1
    and v.y0<=y and y<=v.y1
    then
      return k
    end
  end
end

function menu.load()
  love.graphics.setBackgroundColor(0,0,0)

  menu_img = love.graphics.newImage("assets/menu1.png")

  table.insert(eyes, new_eye(.2, 50, 350, "purple"))
  table.insert(eyes, new_eye(.3, 550, 60, "green"))
  table.insert(eyes, new_eye(.15, 450, 550, "brown"))

  add_button("play", 192, 228, 414, 272)
  add_button("survival", 152, 287, 453, 333)
  add_button("instructions", 178, 347, 428, 386)
  add_button("credits", 231, 407, 375, 446)
end

function menu.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(menu_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  for k, v in pairs(eyes) do
    v:draw(mx,my)
  end

  --[[
  mb = find_button(mx,my)
  if mb then
    local box = buttons[mb]
    love.graphics.rectangle("line", box.x0, box.y0, box.x1-box.x0, box.y1-box.y0 )
  end
  --]]
end

function menu.update(dt)
end

function menu.mousereleased(x,y,b)
  mp = find_button(mousex, mousey)
  mr = find_button(x, y)

  if mp ~= mr then
    return
  elseif mr == "play" then
    change_state(game)
  elseif mr == "survival" then
    --change_state(survival)
  elseif mr == "instructions" then
    change_state(instructions)
  elseif mr == "credits" then
    change_state(credits)
  end
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

