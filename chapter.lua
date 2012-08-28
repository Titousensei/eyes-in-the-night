--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
then author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

local bg_img

local level = 1
local alpha = 0
local alpha_dt = 0

function next_level()
  if level == 1 then
    userdata.continue = 0
  end
  level = level + 1
end
function set_level(val) level = val end
function get_level() return level end

--=== Init Functions ===---

--Ch1 shore -- L1 L2 L3
local function init_map1()
  map_eye(.3, 300, 200, "purple")
end

local function init_map2()
  map_eye(.2, 300, 100, "purple")
  map_eye(.3, 300, 200, "brown")
end

local function init_map3()
  map_eye(.2, 300, 100, "purple")
  map_eye(.4, 300, 250, "brown")
end

--Ch2 broken tree -- L4 L5 L6
local function init_map4()
  map_eye(.2, 300, 100, "purple")
  map_eye(.3, 200, 250, "brown")
  map_eye(.3, 400, 250, "brown")
end

local function init_map5()
  map_eye(.2, 300, 100, "purple")
  map_eye(.2, 300, 250, "green")
end

local function init_map6()
  map_eye(.2, 300, 100, "purple")
  map_eye(.3, 150, 150, "brown")
  map_eye(.3, 450, 150, "brown")
  map_eye(.2, 300, 250, "green")
end

--Ch3 to the forest -- L7 L8 L9
local function init_map7()
  map_eye(.3, 200, 150, "purple")
  map_eye(.3, 400, 150, "purple")
end

local function init_map8()
  map_eye(.3, 150, 150, "purple")
  map_eye(.3, 450, 150, "purple")
  map_eye(.2, 300, 250, "brown")
end

local function init_map9()
  map_eye(.2, 300, 100, "brown")
  map_eye(.3, 150, 150, "purple")
  map_eye(.3, 450, 150, "purple")
  map_eye(.2, 300, 250, "green")
end

--Ch4 forest -- L10 L11 L12
local function init_map10()
  map_eye(.2, 150, 150, "purple")
  map_eye(.3, 150, 250, "brown")
  map_eye(.2, 450, 150, "purple")
  map_eye(.3, 450, 250, "brown")
end

local function init_map11()
  map_eye(.2, 150, 150, "purple")
  map_eye(.2, 450, 150, "purple")
  map_eye(.3, 150, 250, "brown")
  map_eye(.3, 450, 250, "brown")
  map_eye(.2, 300, 250, "green")
end

local function init_map12()
  map_eye(.3,  150, 150, "purple")
  map_eye(.3,  450, 150, "purple")
  map_eye(.2,  250, 300, "brown")
  map_eye(.2,  350, 300, "brown")
  map_eye(.15, 100, 400, "green")
  map_eye(.15, 500, 400, "green")
end

--Ch5 path -- L13 L14 L15
local function init_map13()
  map_eye(.3, 120, 200, "purple")
  map_eye(.3, 480, 200, "purple")
  map_eye(.3, 300, 150, "purple")
  map_eye(.3, 160, 300, "brown")
  map_eye(.3, 440, 300, "brown")
end

local function init_map14()
  map_eye(.3, 150, 150, "purple")
  map_eye(.3, 450, 150, "purple")
  map_eye(.4, 300, 250, "purple")
  map_eye(.2, 150, 300, "green")
end

local function init_map15()
  map_eye(.2, 180, 150, "purple")
  map_eye(.2, 480, 150, "purple")
  map_eye(.1, 330, 250, "purple")
end

--Ch6 bridge -- L16 L17 L18
local function init_map16()
  map_eye(.4, 150, 150, "purple")
  map_eye(.4, 450, 150, "purple")
end

local function init_map17()
  map_eye(.5, 150, 150, "purple")
  map_eye(.5, 450, 200, "purple")
  map_eye(.2, 200, 350, "brown")
  map_eye(.2, 400, 350, "brown")
end

local function init_map18()
  map_eye(.5, 150, 150, "purple")
  map_eye(.4, 450, 200, "purple")
  map_eye(.2, 160, 420, "brown")
  map_eye(.2, 440, 420, "brown")
  map_eye(.1, 300, 350, "brown")
end

--Ch7 to the cliff -- L19 L20 L21
local function init_map19()
  map_eye(.6, 250, 150, "purple")
  map_eye(.2, 150, 250, "brown")
  map_eye(.4, 350, 300, "brown")
end

local function init_map20()
  map_eye(.9, 250, 150, "purple")
  map_eye(.3, 110, 290, "brown")
  map_eye(.5, 350, 350, "green")
end

local function init_map21()
  map_eye(.4, 250, 150, "purple")
  map_eye(.6, 350, 350, "green")
  map_eye(.4, 150, 250, "brown")
  map_eye(.4, 450, 220, "brown")
end

--Ch8 cliff -- L22 L23 L24
local function init_map22()
  map_eye(.3,  50, 150, "purple")
  map_eye(.3,  50, 250, "brown")
  map_eye(.3, 550, 150, "green")
  map_eye(.3, 550, 250, "brown")
end

local function init_map23()
  map_eye(.3,  50, 150, "purple")
  map_eye(.3,  150, 250, "brown")
  map_eye(.3, 450, 150, "purple")
  map_eye(.3, 550, 250, "brown")
end

local function init_map24()
  map_eye(.3,  50, 120, "purple")
  map_eye(.4,  70, 250, "green")
  map_eye(.3, 480, 250, "purple")
  map_eye(.4, 530, 380, "green")
end

--Ch9 stairs -- L25 L26
local function init_map25()
  map_eye(.2,  300, 400, "purple")
  map_eye(.3,  150, 300, "brown")
  map_eye(.3,  450, 300, "brown")
end

local function init_map26()
  map_eye(.2,  200, 450, "purple")
  map_eye(.2,  400, 450, "purple")
  map_eye(.3,  300, 300, "brown")
  map_eye(.2,  250, 210, "brown")
  map_eye(.1,  200, 150, "brown")
end

--Ch10 castle -- L27
local function init_map27()
  map_eye(.3, 315, 200, "purple")
  map_eye(.3, 410, 200, "purple")
  map_eye(.2, 140, 300, "green")
  map_eye(.2, 205, 300, "green")
end

--Ch11 wall -- L28
local function init_map28()
  map_eye(.3,  200, 250, "purple")
  map_eye(.2,  300, 250, "green")
  map_eye(.2,  270, 320, "green")
  map_eye(.2,  200, 350, "green")
end

--Ch12 catacombs -- L29 L30
local function init_map29()
  map_eye(.1,  100,  50, "green")
  map_eye(.1,  200,  50, "purple")
  map_eye(.1,  300,  50, "green")
  map_eye(.1,  400,  50, "green")
  map_eye(.1,  150, 150, "brown")
  map_eye(.1,  250, 150, "brown")
  map_eye(.1,  350, 150, "brown")
end

local function init_map30()
  map_eye(.1,  100,  50, "green")
  map_eye(.1,  200,  50, "purple")
  map_eye(.1,  300,  50, "green")
  map_eye(.1,  400,  50, "purple")
  map_eye(.1,  500,  50, "green")
  map_eye(.1,  150, 150, "brown")
  map_eye(.1,  250, 150, "brown")
  map_eye(.1,  350, 150, "brown")
  map_eye(.1,  450, 150, "brown")
  map_eye(.1,  220, 250, "brown")
  map_eye(.1,  380, 250, "brown")
end

--Ch13 inside -- L31 L32
local function init_map31()
  map_eye(.25, 165, 220, "brown")
  map_eye(.25, 335, 220, "brown")
  map_eye(.2,  250, 240, "purple")
  map_eye(.25, 200, 310, "brown")
  map_eye(.25, 300, 310, "brown")
  map_eye(.25, 250, 150, "brown")
  map_eye(.15, 395, 265, "brown")
  map_eye(.15, 448, 280, "brown")
  map_eye(.15, 490, 250, "brown")
  map_eye(.3,  510, 180, "green")
end

local function init_map32()
  map_eye(.2,  150, 180, "green")
  map_eye(.15, 150, 260, "purple")
  map_eye(.2,  100, 320, "brown")
  map_eye(.2,  200, 320, "brown")

  map_eye(.2,  450, 100, "brown")
  map_eye(.15, 450, 180, "purple")
  map_eye(.2,  400, 240, "green")
  map_eye(.2,  500, 240, "green")
end

--Ch14 finale -- L33
local function init_map33()
  map_eye(.1,  200, 100, "purple")
  map_eye(.1,  400, 100, "purple")
  map_eye(.6,  300, 200, "purple")
  map_eye(.3,  150, 220, "purple")
  map_eye(.3,  450, 220, "purple")
  map_eye(.2,  220, 320, "purple")
  map_eye(.2,  380, 320, "purple")
end

local map = {
  init_map1,  init_map2,  init_map3,
  init_map4,  init_map5,  init_map6,
  init_map7,  init_map8,  init_map9,
  init_map10, init_map11, init_map12,
  init_map13, init_map14, init_map15,
  init_map16, init_map17, init_map18,
  init_map19, init_map20, init_map21,
  init_map22, init_map23, init_map24,
  init_map25, init_map26, init_map27,
  init_map28, init_map29, init_map30,
  init_map31, init_map32, init_map33
}

local texts = {
  -- L1 L2 L3
  "Chapter 1\n\nIn my quest to find the demon that destroyed my village "
  .. "10 years ago, I found this desolated place. Villagers up north "
  .. "have many stories about frightening noises coming from this forsaken island.\n\n"
  .. "Hopefully I will find him and have my revenge soon ...", nil, nil,
  -- L4 L5 L6
  "Chapter 2\n\nThe stories are true, there are many monsters on this island. "
  .. "They only appear at night. The noises of the fight attract more of them. "
  .. "I need to be very careful and target their leader first.", nil, nil,
  -- L7 L8 L9
  "Chapter 3\n\nThere's more monster tracks toward the forest. They use my own "
  .. "weapons to attack me. Some of these beasts seem more intelligent than "
  .. "the others.\n\nI'm following their tracks in the hope to find more ...", nil, nil,
  -- L10 L11 L12
  "Chapter 4\n\nThe forest is infested with these creatures. I need to find "
  .. "their nest or the place they gather. But I must hurry because the forest "
  .. " is getting denser and the monsters more aggressive.", nil, nil,
  -- L13 L14 L15
  "Chapter 5\n\nI found a path, I must be on the right track! This island is not as "
  .. "abandoned as it seemed at first. The master of these beasts must hide "
  .. "nearby, I can feel it.", nil, nil,
  -- L16 L17 L18
  "Chapter 6\n\nThis bridge reminds me of the villagers story \"bridge to the haunted castle\". "
  .. "I will follow it and explore further. My food reserve is almost exhausted. "
  .. "If I don't find the monsters' lair soon I will have to give up.", nil, nil,
  -- L19 L20 L21
  "Chapter 7\n\nI walked for hours and I didn't find anything. If only I could "
  .. "find a way to the top of this cliff, I could see the entire island and "
  .. "surely discover where this demon hides.", nil, nil,
  -- L22 L23 L24
  "Chapter 8\n\nI have no more food, but at last I find a way through. "
  .. "There's monsters hiding under every rock. I must keep fighting "
  .. "if I want the get revenge.", nil, nil,
  -- L25 L26
  "Chapter 9\n\nStairs going up the cliff ... the castle must be very close now. "
  .. "I have to be careful and preserve my strength for the final battle.", nil,
  -- L27
  "Chapter 10\n\nHere it is! The lair of the demon. I should look around for a backdoor "
  .. "and surprise the beast.",
  -- L28
  "Chapter 11\n\n If I enter by the catacombs, I will be able to sneak inside "
  .. "and kill my enemy. Your end is near, monster!",
  -- L29 L30
  "Chapter 12\n\nThese catacombs are a real maze. I must get inside the castle "
  .. "before I loose all my energy fighting these monstrosities.", nil,
  -- L31 L32
  "Chapter 13\n\nI'm inside the castle! My whole body is shaking, "
  .. "not from fear, but from rage. I'm so close to get my revenge.", nil,
  -- L33
  "Chapter 14\n\n^Who are you to disturb the Master of the Beasts^ said a demoniacal voice\n\n"
  .. "The monster is right in front of me. He's big. He's strong."
  .. "\n\nThis is the moment of truth, the final battle.",
  -- L34
  "Chapter 15\n\nI have killed the Master of the Beasts, the demon who destroyed "
  .. "my village and devoured my family so long ago. But my revenge leaves bittersweet "
  .. "taste in my mouth. I have nothing to live for anymore ...\n"
  .. "I hope I can find some peace in the fact that families "
  .. "are now safe from this horrible monster."
}

local backgrounds = {
  -- L1 L2 L3
  "assets/adventure_01.png", "assets/adventure_01.png", "assets/adventure_01.png",
  -- L4 L5 L6
  "assets/adventure_02.png", "assets/adventure_02.png", "assets/adventure_02.png",
  -- L7 L8 L9
  "assets/adventure_03.png", "assets/adventure_03.png", "assets/adventure_03.png",
  -- L10 L11 L12
  "assets/adventure_04.png", "assets/adventure_04.png", "assets/adventure_04.png",
  -- L13 L14 L15
  "assets/adventure_05.png", "assets/adventure_05.png", "assets/adventure_05.png",
  -- L16 L17 L18
  "assets/adventure_06.png", "assets/adventure_06.png", "assets/adventure_06.png",
  -- L19 L20 L21
  "assets/adventure_07.png", "assets/adventure_07.png", "assets/adventure_07.png",
  -- L22 L23 L24
  "assets/adventure_08.png", "assets/adventure_08.png", "assets/adventure_08.png",
  -- L25 L26
  "assets/adventure_09.png", "assets/adventure_09.png",
  -- L27
  "assets/adventure_10.png",
  -- L28
  "assets/adventure_11.png",
  -- L29 L30
  "assets/adventure_12.png", "assets/adventure_12.png",
  -- L31 L32
  "assets/adventure_13.png", "assets/adventure_13.png",
  -- L33
  "assets/adventure_14.png",
  -- L34
  "assets/theend.png"
}

local music = {
  -- L1 L2 L3
  "music/Land of Phantoms.mp3", "music/Land of Phantoms.mp3", "music/Land of Phantoms.mp3",
  -- L4 L5 L6
  "music/Dopplerette.mp3", "music/Dopplerette.mp3", "music/Dopplerette.mp3",
  -- L7 L8 L9
  "music/Oppressive Gloom.mp3", "music/Oppressive Gloom.mp3", "music/Oppressive Gloom.mp3",
  -- L10 L11 L12
  "music/Halls of the Undead.mp3", "music/Halls of the Undead.mp3", "music/Halls of the Undead.mp3",
  -- L13 L14 L15
  "music/Return of Lazarus.mp3", "music/Return of Lazarus.mp3", "music/Return of Lazarus.mp3",
  -- L16 L17 L18
  "music/The Path of the Goblin King.mp3", "music/The Path of the Goblin King.mp3", "music/The Path of the Goblin King.mp3",
  -- L19 L20 L21
  "music/Private Reflection.mp3", "music/Private Reflection.mp3", "music/Private Reflection.mp3",
  -- L22 L23 L24
  "music/Thunder Dreams.mp3", "music/Thunder Dreams.mp3", "music/Thunder Dreams.mp3",
  -- L25 L26
  "music/The Chamber.mp3", "music/The Chamber.mp3",
  -- L27
  "music/Unnatural Situation.mp3",
  -- L28
  "music/Bump in the Night.mp3",
  -- L29 L30
  "music/The Hive.mp3", "music/The Hive.mp3",
  -- L31 L32
  "music/Dance of Deception.mp3", "music/Dance of Deception.mp3",
  -- L33
  "music/Darkness is Coming.mp3",
  -- L34
  "music/Quinns Song-The Dance Begins.mp3"
}

--=== CALLBACKS ===---

chapter = {}

music_current = nil

function chapter.load()
  print ("=== Level:",level)
  game_mode.bg_img = love.graphics.newImage(backgrounds[level])
  game_mode.init_map = map[level]

  if level==1 or music_current ~= music[level] then
    love.audio.stop()
    music_current = music[level]
    local src = love.audio.newSource(music_current, "stream")
    src:setVolume(0.5)
    src:setLooping(true)
    love.audio.play(src)
  end
  if level>=20 then
    game_mode.new_eye = adventure_new_eye3
  elseif level>=10 then
    game_mode.new_eye = adventure_new_eye2
  end

  if level == 34 then
    alpha = 400
    userdata.level = 1
    if userdata.adventure > userdata.continue then
      userdata.adventure = userdata.continue
    end
  elseif level > 6 then
    game_mode.caption = "Level "..level.."\nRepel all the Purple Eyes"
  elseif level == 6 then
    userdata.survival = true
    game_mode.caption = "Level "..level.."\nRepel the Purple Eye\n\nSurvival challenge unlocked"
  else
    game_mode.caption = "Level "..level.."\nRepel the Purple Eye"
  end

  if level>1 then
    userdata.level = level
    userdata.balls = game_mode.num_ball
    userdata.score = score
    save_userdata()
  end

  if not texts[level] then change_state(game) end
end

function chapter.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(game_mode.bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  --love.graphics.print(alpha, 10, 10)
  if level == 34 then
    love.graphics.printf("\n\nI have killed the Master of the Beasts"
        .. "\n\n\n\n\n\n\nI hope I can find some peace", 50, 100, 500, "left")
    love.graphics.setColor(255, 255, 255, math.min(alpha,255))
    love.graphics.print("THE END", 400, 550)
  end
  love.graphics.printf(texts[level], 50, 100, 500, "left")
end

function chapter.update(dt)
  if alpha>6 then
    alpha_dt = alpha_dt + dt
    while alpha_dt > 0.01 do
      alpha = alpha*.999
      alpha_dt = alpha_dt - 0.01
    end
  else
    alpha = 0
  end
end

local function any_key()
  if level==1 and first_time == 1 then
    first_time = 2
    change_state(instructions)
  elseif level < 34 then
    change_state(game)
  elseif alpha<500 then
    level = 1
    change_state(menu)
  end
end

function chapter.mousereleased(x,y,b) any_key() end
function chapter.keypressed(key) any_key() end

