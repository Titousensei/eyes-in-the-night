--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
the author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

credits = {}

local credits_img

function credits.load()
  credits_img = newPaddedImage("assets/credits_bg.png")
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

  --love.graphics.print("http://www.rti-zone.org/eyes-in-the-night", 10, 580,0,.7,.7)
end

function credits.update(dt)
end

function credits.mousereleased(x,y,b)
  change_state(menu)
end

function credits.keypressed(key)
  change_state(menu)
end

