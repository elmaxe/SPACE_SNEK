Powerup = Object:extend()

--Constructor
function Powerup:new(x, y)
	-- what number isntead of 32?
	self.x = x
  self.y = y

 	self.dx = 0                         -- Set x-velocity to 0
  	self.dy = love.math.random(1, 3)  -- Randomise y-velocity of star


	self.timer = 0
	self.timeMax = 600
  self.size = 1
  self.middlePoint = {self.x + 32*self.size, self.y + 32*self.size}

		local rand = love.math.random(1,100)

  	--self.powertype = 1

  	if rand >= 1 and rand < 70 then
  		self.sprite = TEX_POWERUP_SPEED -- Speed powerup
			self.powertype = 1
  	elseif rand >= 70 and rand < 80 then
  		self.sprite = TEX_POWERUP_NO_BLACKHOLE -- No black holes powerup
			self.powertype = 2
  	elseif rand >= 80 and rand <= 100 then
  		self.sprite = TEX_POWERUP_STARS -- More stars powerup
			self.powertype = 3
  	end

end


function Powerup:update(dt)
	self.middlePoint = {self.x + (32*self.size)/2, self.y + (32*self.size)/2}
	self:move()

	if self.timer < self.timeMax then
		self.timer = self.timer + 1
	else
		player:changeSpeed(SNAKE_NORMAL_SPEED)
		love.audio.stop(MUSIC_POWERUP)
		love.audio.play(MUSIC_THEME)
	end
end


function Powerup:move(targetX, targetY)
	--dir = normalise(direction(targetX, targetY, self.x, self.y)) -- Get the direction vector

  	--self.x = self.x + (dir[1]*self.speed)
  	--self.y = self.y + (dir[2]*self.speed)
  	self.x = self.x + self.dx
  	self.y = self.y + self.dy
end

-- Activate powerup
function Powerup:activate()

	if self.powertype == 1 then
		self:speed()
		MUSIC_POWERUP:setLooping(true)
		love.audio.stop(MUSIC_THEME)
		love.audio.play(MUSIC_POWERUP)
	elseif self.powertype == 2 then
		self:noBlackHole()
	elseif self.powertype == 3 then
		self:moreStars()
	end

	--love.audio.stop(MUSIC_POWERUP)
	--love.audio.play(MUSIC_THEME)
end


-- Speed powerup
function Powerup:speed()
	player:changeSpeed(SNAKE_NORMAL_SPEED + 5)
end

-- No blackholes
function Powerup:noBlackHole()
	InGame.removeBlackHoles()
end

-- More stars
function Powerup:moreStars()
	for i = 1, 10, 1 do
		InGame.spawnStars(4)
	end
end

function Powerup:eatPowerup()
	-- Change names!!!
	-- determine SOI
	-- determine starDiffX etc (and change names)
	--local SOI = 200
	local powerupDiffX = math.abs(player:getX() - self.middlePoint[1])
    local powerupDiffY = math.abs(player:getY() - self.middlePoint[2])

    for i = 1, table.getn(powerups), 1 do
	    if powerupDiffX < (self.size * 32) / 2 and powerupDiffY < (self.size * 32) / 2 then
	      --Remove star (crashes the game :( )
	      self:activate()
	      table.remove(powerups, i)
	      break -- without this break the game crashes. It works with the break, so don't remove it
	    end
	end
end

function Powerup:getSize()
  return self.size
end

function Powerup:draw()
    love.graphics.draw(self.sprite, self.x, self.y, 0, self.size)
end

function Powerup:getX()
  return self.x
end

function Powerup:getY()
  return self.y
end

function Powerup:isOutOfBounds()
  return self.y > love.graphics.getHeight() + 10
end
