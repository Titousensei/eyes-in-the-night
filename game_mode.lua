local num_purple

game_mode = nil

local survival_eye_colors = {
  "brown", "brown", "brown", "green", "green", "purple"
}

local function init_survival()
  love.audio.stop()
  local src = love.audio.newSource("music/Thunder Dreams.mp3", "stream")
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

local function adventure_delete_eye(color)
  print("Repel:",color, num_purple)
  if color == "purple" then
    num_purple = num_purple - 1
    print("Num purple:",num_purple)
  end
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
  local img = love.graphics.newImage("assets/background.png")
  return {
    num_ball = 0,
    init_map = init_survival,
    end_condition = function() return false end,
    new_eye = survival_new_eye,
    delete_eye = function() end,
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
    caption = "Repel the Purple Eye",
    gameover = function() end
  }
end

