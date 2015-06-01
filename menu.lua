--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
the author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

require "credits"
require "instructions"
require "chapter"
require "game"
require "game_mode"

menu = {}
local menu_img
local buttons = {}
local button_labels = {}
local eyes = {}
local selected = 0
score = 0

local function survival_init_map() end
local function survival_end_condition() return false end

local function add_button(label, x0, y0, x1, y1)
  buttons[label] = {
    x0 = x0,
    y0 = y0,
    x1 = x1,
    y1 = y1
  }
  table.insert(button_labels, label)
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
  menu_img = newPaddedImage("assets/menu1.png")
  cont_img = newPaddedImage("assets/menu_cont.png")
  surv_img = newPaddedImage("assets/menu_surv.png")

  table.insert(eyes, new_eye(.2, 50, 410, "purple"))
  table.insert(eyes, new_eye(.3, 550, 60, "green"))
  table.insert(eyes, new_eye(.15, 480, 460, "brown"))

  add_button("continue", 83, 216, 531, 267)
  add_button("new", 140, 278, 475, 327)
  add_button("survival", 102, 335, 513, 390)
  add_button("instructions", 158, 395, 436, 442)
  add_button("credits", 230, 456, 380, 506)

  love.audio.stop()
  music_current = nil
end

function menu.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(menu_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()

  if selected>0 then
    mb = button_labels[selected]
    mx = (buttons[mb].x0 + buttons[mb].x1) / 2
    my = (buttons[mb].y0 + buttons[mb].y1) / 2
  else
    mb = find_button(mx,my)
  end

  for k, v in pairs(eyes) do
    v:draw(mx,my)
  end

  if userdata.level > 1 and userdata.level < 34 then
    love.graphics.draw(cont_img, 88, 221, 0.0, 1.0, 1.0, 0, 0)
    love.graphics.setColor(255, 255, 255, 105)
    love.graphics.printf("Lvl\n"..userdata.level, 525, 221, 80, "center")
    love.graphics.setColor(255, 255, 255, 255)
  end

  if userdata.survival then
    love.graphics.draw(surv_img, 107, 340, 0.0, 1.0, 1.0, 0, 0)
    love.graphics.setColor(255, 255, 255, 160)
    love.graphics.printf("Best Survival\n"..userdata.best.." points", 310, 540, 300, "center")
    love.graphics.setColor(255, 255, 255, 255)
  end

  if userdata.adventure>=0 then
    love.graphics.setColor(255, 255, 255, 160)
    love.graphics.printf("Best Adventure\n"..userdata.adventure.." continues", 10, 540, 300, "center")
    love.graphics.setColor(255, 255, 255, 255)
  end

  if mb then
    local box = buttons[mb]
    love.graphics.setColor(255, 255, 0, 180)
    love.graphics.rectangle("line", box.x0, box.y0, box.x1-box.x0, box.y1-box.y0 )
    love.graphics.setColor(255, 255, 255, 255)
  end
end

function menu.update(dt) end

local function do_continue()
  game_mode = new_adventure_mode()
  set_level(userdata.level)
  game_mode.num_ball = userdata.balls
  score = userdata.score
  userdata.continue = userdata.continue + 1
  save_userdata()
  change_state(chapter)
end

local function do_newgame()
  game_mode = new_adventure_mode()
  set_level(1)
  score = 0
  change_state(chapter)
end

local function do_survival()
  game_mode = new_survival_mode()
  score = 0
  change_state(game)
end

function menu.mousemoved(x, y, dx, dy)
  selected = 0
end

local function executeSelected(mr)
  if mr == "continue" and userdata.level > 1 and userdata.level < 34 then
      do_continue()
  elseif mr == "new" then
    do_newgame()
  elseif userdata.survival and mr == "survival" then
    do_survival()
  elseif mr == "instructions" then
    change_state(instructions)
  elseif mr == "credits" then
    change_state(credits)
  end
end

function menu.mousereleased(x,y,b)
  mp = find_button(mousex, mousey)
  mr = find_button(x, y)

  if mp ~= mr then
    return
  end
  executeSelected(mr)
end

function menu.keypressed(key)
  if key == "p" or key == "P"
  or key == "g" or key == "G"
  then
    executeSelected("continue")
  elseif key == "return" or key == " " then
    if selected == 0 then
      executeSelected("continue")
    else
      executeSelected(button_labels[selected])
    end
  elseif key == "n" or key == "N" then
    executeSelected("new")
  elseif userdata.survival and (key == "s" or key == "S") then
    executeSelected("survival")
  elseif key == "i" or key == "I" then
    executeSelected("instructions")
  elseif key == "c" or key == "C" then
    executeSelected("credits")

  elseif key == "up" then
    if selected>1 then
      selected = selected - 1
    else
      selected = 1
    end
    if selected == 1 and not (userdata.level > 1 and userdata.level < 34) then
      selected = 2
    end
    if selected == 3 and not userdata.survival then
      selected = 2
    end
  elseif key == "down" then
    if selected<5 then
      selected = selected + 1
    else
      selected = 5
    end
    if selected == 1 and not (userdata.level > 1 and userdata.level < 34) then
      selected = 2
    end
    if selected == 3 and not userdata.survival then
      selected = 4
    end
  end
end
