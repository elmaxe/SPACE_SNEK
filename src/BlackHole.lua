BlackHole = Object:extend()

--size, speed, gravity, SOI, food to next level
local levelData = {
  [1] = {2, 1, 1, 100,  10},
  [2] = {3, 0.8, 2, 125, 20},
  [3] = {4, 0.6, 3, 200, 30},
  [4] = {5, 0.45, 4, 250, 75},
  [5] = {6, 0.3, 5, 400,  140},
  [6] = {7, 0.1, 7, 650,  140}
}

--Constructor
function BlackHole:new(x, y, level)
  self.x = x
  self.y = y
  if level > #levelData then
    self.level = 1
  else
    self.level = level
  end
  self.size = levelData[self.level][1]
  --Prob not correct. I measured the size of a black hole to 200 pixels (size 5), 5*32 is 160, not 200
  self.middlePoint = {self.x + 32*self.size, self.y + 32*self.size}
  self.speed = levelData[self.level][2]
  self.targetX = player:getX()
  self.targetY = player:getY()

  self.food = 0
  self.SOI = levelData[self.level][4]
  self.gravity = levelData[self.level][3]

  self.eatenObjects = {}

  self.texture = TEX_BLACK_HOLE
end

--Called every game update
function BlackHole:update(dt)
  self.middlePoint = {self.x + (32*self.size)/2, self.y + (32*self.size)/2}
  self:move()
  for i = 1, table.getn(stars), 1 do
    --How big the SOI (Sphere of influence) of the black hole is (amount of pixels from the center)
    --https://en.wikipedia.org/wiki/Sphere_of_influence_(astrodynamics)
    --Distance from the black hole center to the star (TODO: Fix so that it is from the center of the star and not upper left corner)
    local starDiffX = math.abs(stars[i]:getX() - self.middlePoint[1])
    local starDiffY = math.abs(stars[i]:getY() - self.middlePoint[2])



    --If the star is insude the horizon, suck it
    if  starDiffX < self.SOI and starDiffY < self.SOI then
      stars[i]:suction(self.middlePoint[1], self.middlePoint[2], self.gravity)
    end

    --If star is inside the black hole horizon, remove it.
    if starDiffX < (self.size * 32) / 2 and starDiffY < (self.size * 32) / 2 then
      --Remove star (crashes the game :( )
      table.insert(self.eatenObjects, stars[i])
      table.remove(stars, i)
      self.food = self.food + 1
      break -- without this break the game crashes. It works with the break, so don't remove it
    end

    for k = 1, player:getLength(), 1 do
      local playerDiffX = math.abs(player:getBodyParts()[k][1] - self.middlePoint[1])
      local playerDiffY = math.abs(player:getBodyParts()[k][2] - self.middlePoint[2])

      if  playerDiffX < self.SOI and playerDiffY < self.SOI then
        player:suction(self.middlePoint[1], self.middlePoint[2], k, 0.3)
        player:setSuckedByHole(true)
      else player:setSuckedByHole(false) end

      if playerDiffX < (self.size * 32) / 2 and playerDiffY < (self.size * 32) / 2 then
        player:removeBodyPart(k)
        self.food = self.food + 2
        break -- without this break the game crashes. It works with the break, so don't remove it
      end
    end

    local playerDiffX = math.abs(player:getX() + (player:getSize()*player:getTextureSize()/2) - self.middlePoint[1])
    local playerDiffY = math.abs(player:getY() + (player:getSize()*player:getTextureSize()/2) - self.middlePoint[2])

    if playerDiffX < (self.size * 32) / 2 and playerDiffY < (self.size * 32) / 2 then
      GameOverScreen.enter()
    end
  end

  if self.food >= levelData[self.level][5] and self.level < #levelData then
    self.level = self.level + 1
    self.size = levelData[self.level][1]
    self.speed = levelData[self.level][2]
    self.gravity = levelData[self.level][3]
    self.SOI = levelData[self.level][4]
  end

end

--Draws this objects texture at its position
function BlackHole:draw()
  love.graphics.draw(self.texture, self.x, self.y, 0, self.size)
end

function BlackHole:getMiddle()
  return self.middlePoint
end

function BlackHole:getEatenObjects()
  return self.eatenObjects
end

function BlackHole:move()
  self.targetX = player:getX()
  self.targetY = player:getY()
  dir = direction(self.targetX, self.targetY, self.x, self.y) -- Get the direction vector
  mag = magnitude(dir) -- Get magnitude of direction vector
  dir = normalise(dir) -- Normalise direction vector

  self.x = self.x + (dir[1]*self.speed)
  self.y = self.y + (dir[2]*self.speed)
end
