ParticleText = Object:extend()

function ParticleText:new(text, x, y)
  self.text = text
  self.x = x
  self.y = y
  self.duration = 50
  self.lifetime = 0
end

function ParticleText:update(dt)
  self.lifetime = self.lifetime + 1
end

function ParticleText:draw()
  love.graphics.print(self.text, self.x, self.y, 0, 0.8)
end

function ParticleText:isDone()
  return self.lifetime >= self.duration
end
