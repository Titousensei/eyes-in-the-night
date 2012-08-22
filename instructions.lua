instructions = {}

local instructions_img
local eyes = {}

function instructions.load()
  love.graphics.setBackgroundColor(0,0,0)

  instructions_img = love.graphics.newImage("assets/instructions_bg.png")

  table.insert(eyes, new_eye(.2, 100, 380, "brown"))
  table.insert(eyes, new_eye(.2, 100, 460, "green"))
  table.insert(eyes, new_eye(.2, 100, 540, "purple"))
end

function instructions.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(instructions_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  love.graphics.printf("Repel all the purple eyes to win the level. "
    .. "Get an extra ball every 3 levels, with a maximum of 3 in reserve.",
      50, 210, 500, "left")

  love.graphics.print("dies on the first hit\nand gives 1 point.", 150, 350)
  love.graphics.print("can take 2 hits\nand gives 3 points.", 150, 430)
  love.graphics.print("can take 3 hits\nand gives 10 points.", 150, 510)

  local mx = love.mouse.getX()
  local my = love.mouse.getY()
  for k, v in pairs(eyes) do
    v:draw(mx,my)
  end
end

function instructions.update(dt)
end

function instructions.mousereleased(x,y,b)
  change_state(menu)
end

function instructions.keypressed(key)
  change_state(menu)
end

