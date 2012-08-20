local bg_img

local ch = 1

function next_chapter() ch = ch + 1 end

--=== Init Functions ===---

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

local map = {
  init_map1, init_map2, init_map3,
  init_map4, init_map5, init_map6
}

local texts = {
  "Chapter 1\n\nIn my quest to find the monsters that destroyed my village "
  .. "3 years ago, I found this desolated place. Villagers up north "
  .. "have many stories about frightening noises coming from this forsaken island.\n\n"
  .. "Hopefully I will find these demons and have my revenge soon ...", nil, nil,
  "Chapter 2\n\nThe stories are true, there are many monsters on this island. "
  .. "They only appear at night. The noises of the fight attract more of them. "
  .. "I need to be very careful and target their leader first.", nil, nil,
  "Chapter 3\n\nThere's more tracks toward the forest. They use my own "
  .. "weapons to attack me. Some of these beasts seem more intelligent than "
  .. "the others.\n\nI'm following their tracks in the hope to find more ...", nil, nil,
  "Chapter 4\n\nThe forest is infested with these creatures. I need to find "
  .. "their nest or the place they gather.", nil, nil
}

local backgrounds = {
  "assets/adventure_01.png", "assets/adventure_01.png", "assets/adventure_01.png",
  "assets/adventure_02.png", "assets/adventure_02.png", "assets/adventure_02.png",
  "assets/adventure_03.png", "assets/adventure_03.png", "assets/adventure_03.png",
  "assets/adventure_04.png", "assets/adventure_04.png", "assets/adventure_04.png",
  "assets/adventure_05.png", "assets/adventure_05.png", "assets/adventure_05.png",
  "assets/adventure_06.png", "assets/adventure_06.png", "assets/adventure_06.png",
  "assets/adventure_07.png", "assets/adventure_07.png", "assets/adventure_07.png",
  "assets/adventure_08.png", "assets/adventure_08.png", "assets/adventure_08.png",
  "assets/adventure_09.png", "assets/adventure_09.png", "assets/adventure_09.png"
}

local music = {
  "music/Dopplerette.mp3",      "music/Dopplerette.mp3",      "music/Dopplerette.mp3",
  "music/Land of Phantoms.mp3", "music/Land of Phantoms.mp3", "music/Land of Phantoms.mp3",
  "music/Oppressive Gloom.mp3", "music/Oppressive Gloom.mp3", "music/Oppressive Gloom.mp3"
}

--=== CALLBACKS ===---

chapter = {}

music_current = nil

function chapter.load()
  print ("=== Level:",ch)
  game_mode.bg_img = love.graphics.newImage(backgrounds[ch])
  game_mode.init_map = map[ch]
  if ch>6 then
    game_mode.new_eye = adventure_new_eye2
  end
  if not texts[ch] then change_state(game) end
  if ch==1 or music_current ~= music[ch] then
    love.audio.stop()
    music_current = music[ch]
    local src = love.audio.newSource(music_current, "stream")
    src:setVolume(0.5)
    src:setLooping(true)
    love.audio.play(src)
  end
end

function chapter.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(game_mode.bg_img, 0, 0, 0.0, 1.0, 1.0, 0, 0)
  love.graphics.printf(texts[ch], 50, 100, 500, "left")
end

function chapter.update(dt) end
function chapter.mousereleased(x,y,b) change_state(game) end
function chapter.keypressed(key) change_state(game) end

