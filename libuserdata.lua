--[[
This source code is provided for educational purposes only.
Copyright by Eric Gaudet.

If you like reading the source code of this game, please consider supporting
then author by buying the game at http://www.rti-zone.org/eyes-in-the-night/
]]

-- Inspired by SICK

libuserdata = {}

function libuserdata.load(filename)
  if not love.filesystem.exists(filename) then return false end
  local file = love.filesystem.newFile(filename)
  if not file:open("r") then return false end

  local data = {}
  for line in file:lines() do
    local i = line:find('\t', 1, true)
    local key = line:sub(1, i-1)
    local value = line:sub(i+1)
    if value == "false" then
      value = false
    elseif value == "true" then
      value = true
    else
      value = tonumber(value) or value
    end
    print ("Load:", key, value)
    data[key] = value
  end
  file:close()

  return data
end

function libuserdata.save(filename, data)
  local file = love.filesystem.newFile(filename)
  if not file:open("w") then return false end

  for k,v in pairs(data) do
    print ("Save:", k, v)
    file:write(k)
    file:write("\t")
    file:write(tostring(v))
    file:write("\n")
  end
  file:close()

  return true
end

