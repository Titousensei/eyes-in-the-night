--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
the author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

local num_purple

game_mode = nil
local new_high_score = false

local survival_eye_colors = {
  "brown", "brown", "brown", "green", "green", "purple"
}

local function init_survival()
  love.audio.stop()
  local src = love.audio.newSource("music/Thunder Dreams.ogg", "stream")
  src:setVolume(0.5)
  src:setLooping(true)
  love.audio.play(src)
end

local function gameover_survival()
  userdata.best = score
  save_userdata()
end

--=== end_condition Functions ===---

local function adventure_victory()
  return (num_purple==0)
end

--=== delete_eye Functions ===---

local function adventure_delete_eye(color, score, add_score)
  print("Repel:",color, num_purple)
  if color == "purple" then
    num_purple = num_purple - 1
    print("Num purple:",num_purple)
  end

  local coef = 30
  if score > 120 then
    coef = 50
  end
  local next_ball = math.ceil((score+1)/coef)*coef
  score = score + add_score
  if score >= next_ball and game_mode.num_ball < 3 then
    game_mode.num_ball = game_mode.num_ball + 1
    print ("1UP at",next_ball,game_mode.num_ball)
    new_caption("* 1UP at "..next_ball.." *")
  end

  return score
end

local function survival_delete_eye(color, score, add_score)
  if userdata.best < score and new_high_score then
    new_caption("* New High Score *")
    new_high_score = false
  end

  return score + add_score
end

--=== new_eye Functions ===---

function adventure_new_eye1(sz, x, y, col)
  col = col or eye_colors[1]
  if col == "purple" then
    num_purple = num_purple + 1
  end
  return new_eye(sz, x, y, col)
end

function adventure_new_eye2(sz, x, y, col)
  if col then
    if col == "purple" then
      num_purple = num_purple + 1
    end
  else
    local r = math.random(3)
    if r == 1 then
      col = "green"
    else
      col = "brown"
    end
  end
  return new_eye(sz, x, y, col)
end

function adventure_new_eye3(sz, x, y, col)
  col = col or eye_colors[math.random(2)]
  if col == "purple" then
    num_purple = num_purple + 1
  end
  return new_eye(sz, x, y, col)
end

local function survival_new_eye(sz, x, y, col)
  col = survival_eye_colors[math.random(#survival_eye_colors)]
  return new_eye(sz, x, y, col)
end

--=== Modes ===---

function new_survival_mode()
  local img = newPaddedImage("assets/background.png")
  new_high_score = true
  return {
    num_ball = 0,
    init_map = init_survival,
    end_condition = function() return false end,
    new_eye = survival_new_eye,
    delete_eye = survival_delete_eye,
    bg_img = img,
    caption = "Survive as long as possible,\nscore as much as possible",
    gameover = gameover_survival
  }
end

function new_adventure_mode()
  num_purple = 0
  return {
    num_ball = 1,
    init_map = nil,
    end_condition = adventure_victory,
    new_eye = adventure_new_eye1,
    delete_eye = adventure_delete_eye,
    bg_img = nil,
    caption = "Repel the Purple Eyes",
    gameover = function() end
  }
end

