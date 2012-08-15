--require "menu"

instructions = {}

local instructions_img

function instructions.load()
  love.graphics.setBackgroundColor(0,0,0)

  instructions_img = love.graphics.newImage("assets/instructions_bg.png")
end

function instructions.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(instructions_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  love.graphics.printf("Repel all the purple eyes to win the level and get 1 extra ball. "
    .. "You can have a maximum of 3 balls in reserve.\n"
    .. "Purple eyes are repelled after 4 hits, earning 10 points per hit. "
    .. "Green eyes are repelled after 3 hits, earning 3 points per hit. "
    .. "Brown eyes are repelled after 1 hit, earning 1 point.",
      50, 220, 500, "left")
end

function instructions.update(dt)
end

function instructions.keypressed(key)
  change_state(menu)
end

