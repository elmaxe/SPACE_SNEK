CreditsText = Object:extend()

function CreditsText:new(text, x, y, size)
  self.text = text
  self.x = x
  self.y = y
  self.speed = 50--30
  self.size = size
end

function CreditsText:update(dt)
  self.y = self.y - self.speed*dt
end

function CreditsText:draw()
  love.graphics.print(self.text, self.x, self.y, 0, self.size)
end
