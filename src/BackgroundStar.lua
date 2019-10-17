BackgroundStar = Object:extend()

--TODO: Animate background stars

--Constructor
function BackgroundStar:new(x, y)
  self.x = x
  self.y = y
  self.size = 1

  --Random value for deciding which texture this object will have
  local rand = love.math.random(1,10)

  if rand >= 1 and rand <= 8 then
    self.texture = TEX_BACKG_STAR2
  elseif rand == 9 then
    self.texture = TEX_BACKG_STAR1
  else
    self.texture = TEX_BACKG_STAR3
  end

end

--Updates this star
function BackgroundStar:update(dt)

end

--Draws this star
function BackgroundStar:draw()
  love.graphics.draw(self.texture, self.x, self.y, 0, self.size)
end
