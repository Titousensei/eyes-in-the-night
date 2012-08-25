local bg_img

local level = 1

function next_level()
  if level == 1 then
    userdata.continue = 0
  end
  level = level + 1
end
function set_level(val) level = val end

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
  map_eye(.2, 150, 150, "purple")
  map_eye(.2, 450, 150, "purple")
  map_eye(.1, 300, 250, "purple")
end

local function init_map14()
  map_eye(.3, 150, 150, "purple")
  map_eye(.3, 450, 150, "purple")
  map_eye(.4, 300, 250, "purple")
  map_eye(.2, 150, 300, "green")
end

local function init_map15()
  map_eye(.3, 120, 200, "purple")
  map_eye(.3, 480, 200, "purple")
  map_eye(.3, 300, 150, "purple")
  map_eye(.3, 160, 300, "brown")
  map_eye(.3, 440, 300, "brown")
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
  map_eye(.5, 250, 150, "purple")
  map_eye(.4, 350, 260, "brown")
end

local function init_map20()
  map_eye(.5, 250, 150, "purple")
  map_eye(.5, 350, 300, "green")
end

local function init_map21()
  map_eye(.4, 250, 150, "purple")
  map_eye(.6, 350, 350, "green")
  map_eye(.2, 150, 250, "brown")
  map_eye(.2, 450, 220, "brown")
end

--Ch8 cliff -- L22 L23 L24
--Ch9 stairs -- L25 L26
--Ch10 castle -- L27
--Ch11 wall -- L28
--Ch12 catacombs -- L29 L30
--Ch13 inside -- L31 L32
--Ch14 finale -- L33

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
  init_map31, init_map31, init_map33
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
  "Chapter 14\n\n\"Who are you to disturb the Master of the Beasts\" said a demoniacal voice\n\n"
  .. "The monster is right in front of me. He's big. He's strong. His minions are surrounding me."
  .. "\n\nThis is the final battle, the moment of truth.",
  -- L34
  "Chapter 15\n\nI have killed the Master of the Beasts, the demon who destroyed "
  .. "my village and devoured my family so long ago. But my revenge leaves bittersweet"
  .. "taste in my mouth: I am now an old man, wounded and alone.\n\nAnd I have "
  .. "nothing to live for anymore ...\n\n      ... I think I can find some peace "
  .. "in the fact that families are safe from this horrible monster."
  .. "\n\n\n            THE END"
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
  "music/Pop Goes the Weasel.mp3", "music/Pop Goes the Weasel.mp3", "music/Pop Goes the Weasel.mp3",
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
  if not texts[level] then change_state(game) end
  if level==1 or music_current ~= music[level] then
    love.audio.stop()
    music_current = music[level]
    local src = love.audio.newSource(music_current, "stream")
    src:setVolume(0.5)
    src:setLooping(true)
    love.audio.play(src)
  end
  if level>10 then
    game_mode.new_eye = adventure_new_eye2
  end

  if level > 6 then
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
end

function chapter.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(game_mode.bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  love.graphics.printf(texts[level], 50, 100, 500, "left")
end

function chapter.update(dt) end

function chapter.mousereleased(x,y,b)
  if level < 34 then
    change_state(game)
  else
    change_state(menu)
  end
end

function chapter.keypressed(key)
  if level==1 and first_time == 1 then
    first_time = 2
    change_state(instructions)
  elseif level < 34 then
    change_state(game)
  else
    change_state(menu)
  end
end

