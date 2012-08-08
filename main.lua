require"game"

local state = nil

function change_state(s)
  state = s
  state.load()
end

function love.load()
  math.randomseed(os.time())

  change_state(game)
end

function love.draw()
  state.draw()
end

function love.update(dt)
  state.update(dt)
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
