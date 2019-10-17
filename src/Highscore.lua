  --https://love2d.org/wiki/Tserial

highscores = { }

function testHighscoreAdd()
  for i = 1, 10 do
    table.insert(highscores, {"hej" .. i, "10" .. i})
  end
end

--Loads file from:
--Windows: C:\Users\USERNAME\AppData\Roaming\LOVE\src
--OSX: ??
function loadHighscore()
  --Basically: if highscores exist, see the outcommented code below:
  if love.filesystem.getInfo("highscores.txt") then
    local data = love.filesystem.read("highscores.txt")
    local file = TSerial.unpack(data)
    for i = 1, 10 do
      highscores[i] = file[i]
    end
  end
  --[[
  if love.filesystem.exists("highscores") then
    local data = love.filesystem.read("highscores")
    local file = TSerial.unpack(data)
    for i = 1, 10 do
      highscores[i] = file[i]
    end
  end--]]
end

--Saves file to:
--Windows: C:\Users\USERNAME\AppData\Roaming\LOVE\src
--OSX: ??
function saveHighscore()
  local data = TSerial.pack(highscores, true)
  love.filesystem.write("highscores.txt", data)
end

function insertHighscore(score)
  local min = highscores[1]
  local index = 1
  for i = 1, table.getn(highscores), 1 do
    if highscores[i] < min then
      min = highscores[i]
      index = i
    end
  end

  if score > min then
    --shift every score below our score down by one
  end
end

--https://en.wikipedia.org/wiki/Insertion_sort#Algorithm_for_insertion_sort
function insertionSort()
  i = 2
  while i < table.getn(highscores) + 1 do
    j = i
    while j > 1 and  highscores[j-1][2] > highscores[j][2] do
      local temp = highscores[j]
      highscores[j] = highscores[j-1]
      highscores[j-1] = temp
      j = j - 1
    end
    i  = i + 1
  end
  return highscores
end
