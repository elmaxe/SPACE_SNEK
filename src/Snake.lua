Snake = Object:extend()
require 'Math'
require 'TEXTURES'

local head = TEX_SNAKE_HEAD
local body = TEX_SNAKE_BODY

SNAKE_NORMAL_SPEED = 8

--Constructor
function Snake:new(x, y, length)
  self.x = x -- Start x-position
  self.y = y -- Start y-position
  self.width = 50
  self.food = 10
  self.bodyParts = {} -- List of position of body parts
  self.speed = 8
  self.inertiaSpeed = 2
  self.gravityC = 3
  self.rotation = 0
  self.size = 2

  self.SUCTION = false

  self.textureSize = head:getPixelWidth()

  if length > 0 then
    self.length = length
  else
    self.length = 3
  end

  --Add specified amount of body parts
  for i = 1, self.length, 1 do
    table.insert(self.bodyParts, {self.x, self.y+(self.width*(i-1))} )
  end

end

-- Snake update function
function Snake:update(dt)
  --Update the x and y so that it actually stores the position of snake
  self.x = self.bodyParts[1][1]
  self.y = self.bodyParts[1][2]

  if self.bodyParts[1][2] > love.graphics.getHeight() + 50 then
    --game over you suk, scrub
    GameOverScreen.enter()
  end

  --remove bodyparts that are out of the screen
  for i = 1, #self.bodyParts, 1 do
    if self.bodyParts[i][2] > love.graphics.getHeight() then
      if i ~= 1 then
        table.remove(self.bodyParts, i)
        break
      end
    end
  end
end

function Snake:getTextureSize()
  return self.textureSize
end

function Snake:isSuckedByHole()
  return self.SUCTION
end

function Snake:setSuckedByHole(condition)
  self.SUCTION = condition
end

function Snake:getSize()
  return self.size
end

function Snake:getSpeed()
  return self.speed
end

function Snake:changeSpeed(speed)
  self.speed = speed
end

-- Draw snake
function Snake:draw()

  for i = table.getn(self.bodyParts), 1, -1 do
    if i == 1 then
      --texture, x-pos, y-pos, rotation, shear, shear, something, something
      love.graphics.draw(head, self.bodyParts[i][1], self.bodyParts[i][2], 0, self.size, self.size, 0, 0)
    else
      love.graphics.draw(body, self.bodyParts[i][1], self.bodyParts[i][2], 0, self.size, self.size)
    end
  end

end

function Snake:eat()
  love.audio.play(SOUND_EFFECT_EAT)
  self:extend()
end

function Snake:extend()
  local last = table.getn(self.bodyParts)
  table.insert(self.bodyParts, {self.bodyParts[last][1], self.bodyParts[last][2]})
end

function Snake:suction(targetX, targetY, index, speed)
  dir = direction(targetX, targetY, self.bodyParts[index][1], self.bodyParts[index][2]) -- Get the direction vector
  mag = magnitude(dir) -- Get magnitude of direction vector
  dir = normalise(dir) -- Normalise direction vector

  self.bodyParts[index][1] = self.bodyParts[index][1] + dir[1]*speed
  self.bodyParts[index][2]= self.bodyParts[index][2] + dir[2]*speed
end

function Snake:removeBodyPart(i)
  if i ~= 1 then
    local minus = -3
    score = score + minus
    table.insert(particleText, ParticleText(minus, self.bodyParts[i][1], self.bodyParts[i][2]))
    table.remove(self.bodyParts, i)
  end
end

function Snake:getBodyParts()
  return self.bodyParts
end

function Snake:getLength()
  --return table.getn(self.bodyParts)
  return #self.bodyParts
end

function Snake:getX()
  return self.x
end

function Snake:getY()
  return self.y
end

-- Makes the snake move downwards (or the camera move up???)
function Snake:gravity()
  for i = 1, table.getn(self.bodyParts), 1 do
    self.bodyParts[i][2] = self.bodyParts[i][2] + self.gravityC
  end
end

function Snake:move(x, y)
  if math.floor(self.bodyParts[1][1]) >= x - 1 and math.floor(self.bodyParts[1][1]) <= x + 1
 and math.floor(self.bodyParts[1][2]) >= y - 1 and math.floor(self.bodyParts[1][1]) <= x + 1 then

   self.bodyParts[1][1] = self.bodyParts[1][1]
   self.bodyParts[1][2] = self.bodyParts[1][2]
    return
  end
  --print("bodyparts: ", math.floor(self.bodyParts[1][1]), "MouseX: ", x)
  dir = direction(x, y, self.bodyParts[1][1], self.bodyParts[1][2]) -- Get the direction vector
  mag = magnitude(dir) -- Get magnitude of direction vector
  dir = normalise(dir) -- Normalise direction vector

    -- Save initial position of head
    local lastBodyPart = self.bodyParts[1]

    -- Move the snake head towards cursor
    self.bodyParts[1][1] = self.bodyParts[1][1] + (dir[1]*self.speed)
    self.bodyParts[1][2] = self.bodyParts[1][2] + (dir[2]*self.speed)

    -- Rotate the head
    -- By calculating the angle between the base y-vector and the mouse direciton
    local a = angle(-1, dir[1])
    self.rotation = a

  for i = 2, table.getn(self.bodyParts), 1 do
    local lastBodyPart = self.bodyParts[i] -- Save last moved body part

    -- Get direction & magnitude of direction vector
    dir = direction(self.bodyParts[i-1][1], self.bodyParts[i-1][2], self.bodyParts[i][1], self.bodyParts[i][2])
    mag = magnitude(dir)
    dir = normalise(dir)

    if mag > self.width then
      -- Move body if magnitude of direction vector is larger that self.width
      self.bodyParts[i][1] = self.bodyParts[i][1] + (dir[1]*self.speed)
      self.bodyParts[i][2] = self.bodyParts[i][2] + (dir[2]*self.speed)
    else
      -- Else, do nothing
      self.bodyParts[i] = lastBodyPart
    end
  end
end

-- Make the snake continuously move towards x and y
function Snake:inertia(x, y)
  if x >= 0 and y >= 0 then
    dir = direction(x, y, self.bodyParts[1][1], self.bodyParts[1][2])
    dir = normalise(dir)
    for i = 1, table.getn(self.bodyParts), 1 do
      self.bodyParts[i][1] = self.bodyParts[i][1] + dir[1]*self.inertiaSpeed
      self.bodyParts[i][2] = self.bodyParts[i][2] + dir[2]*self.inertiaSpeed
    end
  end
end
