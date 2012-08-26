instructions = {}

local instructions_img
local eyes = {}

function instructions.load()
  love.graphics.setBackgroundColor(0,0,0)

  instructions_img = love.graphics.newImage("assets/instructions_bg.png")
end

function instructions.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(instructions_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
end

function instructions.update(dt) end

local function any_key()
  if first_time == 2 then
    first_time = 0
    change_state(game)
  else
    change_state(menu)
  end
end

function instructions.mousereleased(x,y,b) any_key() end
function instructions.keypressed(key) any_key() end

