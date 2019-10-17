Star = Object:extend()

function Star:new(x, y)
  self.x = x
  self.y = y

  local earth = love.math.random(1,1000)
  if earth == 145 then
    --Earth texture
    self.sprite = TEX_EARTH
    self.size = love.math.random(1,3)
  else
    local rand = love.math.random(1,2)
    if rand == 1 then
          self.sprite = TEX_STAR
          self.size = love.math.random(2,6)   -- Randomise size of star
    else
      self.sprite = TEX_STAR_2
      self.size = love.math.random(4,6)
    end

  end

  --how big the texture is in pixels. Used for hitbox collision
  self.textureSize = self.sprite:getPixelWidth()

  self.dx = 0                         -- Set x-velocity to 0
  self.dy = love.math.random(1, 3)  -- Randomise y-velocity of star
end

function Star:update(dt)
  -- Update star position
  self.x = self.x + self.dx
  self.y = self.y + self.dy

-- Set star to middle of screen if it hits bottom (DEBUG)
  --[[if self:isOutOfBounds() then
    self.x = 500
    self.y = 500
    self.dy = 0
  end--]]
end

function Star:suction(targetX, targetY, speed)
  dir = direction(targetX, targetY, self.x, self.y) -- Get the direction vector
  mag = magnitude(dir) -- Get magnitude of direction vector
  dir = normalise(dir) -- Normalise direction vector

  speed = speed/(self.size*10)
  self.dx = self.dx + dir[1]*speed
  self.dy = self.dy + dir[2]*speed
  --self.x = self.x + self.dx
  --self.y = self.y + self.dy
end

function Star:getSize()
  return self.size
end

function Star:getTextureSize()
  return self.textureSize
end

function Star:draw()
    --love.graphics.draw(self.sprite, self.x, self.y)
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.size)
end

function Star:getX()
  return self.x
end

function Star:getY()
  return self.y
end

function Star:isOutOfBounds()
  return self.y > love.graphics.getHeight() + 10
end
