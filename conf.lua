--[[
xlarge screens are at least 960dp x 720dp
large screens are at least 640dp x 480dp
normal screens are at least 470dp x 320dp
small screens are at least 426dp x 320dp

320dp: a typical phone screen (240x320 ldpi, 320x480 mdpi, 480x800 hdpi, etc).
480dp: a tweener tablet like the Streak (480x800 mdpi).
600dp: a 7” tablet (600x1024 mdpi).
720dp: a 10” tablet (720x1280 mdpi, 800x1280 mdpi, etc).

Transformer Pad Infinity - 1920×1200
Nexus 7 - 1280x800
HP Elitebook - 1280×800
Kindle Fire[2] - 1024×600
Most common: 480×800

Archos 101 - 1024 x 600 pixels
Motorola 480x854
1280x720
320×480
240×320

most common aspect ratio 5:3

 480 x 320 normal   1.5
 800 x 480 large    1.6666666666666667
1024 x 600          1.7066666666666668
1280 x 800 xlarge   1.6
--]]

function love.conf(t)
  t.title = "Eyes in the night"
  t.identity = "eyes_in_the_night"
  --t.version = "0.8.0"
  t.screen.width = 600
  t.screen.height = 600
  t.modules.audio = true
  t.modules.sound = true
  t.modules.physics = false
  t.modules.joystick = false
end
