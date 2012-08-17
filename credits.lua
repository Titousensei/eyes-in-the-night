--require "menu"

credits = {}

local credits_img

function credits.load()
  love.graphics.setBackgroundColor(0,0,0)

  credits_img = love.graphics.newImage("assets/credits_bg.png")
end

function credits.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(credits_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)

  love.graphics.print("Design, Graphics, Code:", 130, 250)
  love.graphics.print("Eric Gaudet", 150, 280)
  love.graphics.print("Music:", 130, 330)
  love.graphics.print("Kevin MacLeod", 150, 360)
  love.graphics.print("Original Concept:", 130, 410)
  love.graphics.print("Wouter Visser", 150, 440)
end

function credits.update(dt)
end

function credits.mousereleased(x,y,b)
  change_state(menu)
end

function credits.keypressed(key)
  change_state(menu)
end

