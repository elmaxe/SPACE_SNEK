InGame = {}

--List of all foreground stars (stars you can eat etc.)
stars = {}
--List of all black holes
blackHoles = {}
--List of all powerups
powerups = {}
--Player object
player = Snake(love.graphics.getWidth()/2-32, love.graphics.getHeight()/2, 3)

score = 0

particleText = {}

function InGame.newGame()
  state = 2
  love.graphics.setBackgroundColor(0, 0, 15/255)
  time = 0
  player = Snake(love.graphics.getWidth()/2-32, love.graphics.getHeight()/2, 3)
  stars = {}
  particleText = {}
  powerups = {}
  blackHoles = {--[[BlackHole(0, 0, 1)]]}
  score = 0

  --Start music
  love.audio.setVolume( 1 )
  MUSIC_THEME:setLooping(true)
  love.audio.stop(MUSIC_DEATH)
  love.audio.play(MUSIC_THEME)
end

function InGame.pressedKey(key)
  --Pause the game
  if key == "escape" then
    if PAUSED == false then
      PAUSED = true
    else PAUSED = false end
  --If pressed enter when paused (exit to main menu)
  elseif PAUSED and key == "return" then
    love.audio.play(SOUND_NAV_CLICK)
    love.audio.stop(MUSIC_THEME)
    state = 1
    PAUSED = false
    MainMenu.enter()
  --Debug extension of player
elseif key == "w" and DEBUG_MODE then
    player:extend()
    --Debug game over
  elseif key == "p" and DEBUG_MODE then
    --game over
    GameOverScreen.enter()
  end
end

function InGame.update(dt)
  --Spawn eatable stars
  time = time + 1
  if (time % 100 == 0) then
    InGame.spawnStars(--[[3]]3)
    -- Spawn powerups
  end

  if (time % 600 == 0) then
  	InGame.spawnPowerups(1)
  end

  if score >= 100 and #blackHoles < 1 then
    table.insert(blackHoles, BlackHole(-200, 100, 1))
  end

  --Mouse interaction
  if love.mouse.isDown(1) then
      mouse_x = love.mouse.getX()
      mouse_y = love.mouse.getY()
      player:move(mouse_x, mouse_y)
      --score = score + 1
  end

  --Update stars
  for i = 1, table.getn(stars), 1 do
    stars[i]:update(0)
    if stars[i]:isOutOfBounds() then
      table.remove(stars, i)
      break
    end
    --Player collision
    if  player:getX() + player:getSize()*player:getTextureSize()/2 >= stars[i]:getX()
    and player:getX() + player:getSize()*player:getTextureSize()/2 <= stars[i]:getX() + stars[i]:getTextureSize()*stars[i]:getSize()
    and player:getY() + player:getSize()*(player:getTextureSize()/2)/2 >= stars[i]:getY()
    and player:getY() + player:getSize()*(player:getTextureSize()/2)/2  <= stars[i]:getY() + stars[i]:getTextureSize()*stars[i]:getSize()
    then
      score = score + math.floor(50/stars[i]:getSize())
      local newscore = "+" .. math.floor(50/stars[i]:getSize())
      table.insert(particleText, ParticleText(newscore, stars[i]:getX(), stars[i]:getY()))
      table.remove(stars, i)
      player:eat()
      break
    end

  end

  for i = 1, table.getn(blackHoles), 1 do
    blackHoles[i]:update()
  end

  --player:inertia()
  if mouse_x ~= nil and mouse_y ~= nil then
    player:inertia(mouse_x, mouse_y)
  end


  if player:isSuckedByHole() == false then
    player:gravity()
  end
  player:update()

  -- Update stars
  for i = 1, table.getn(stars), 1 do
    stars[i]:update(0)
  end

  -- Update powerups
  for i = 1, table.getn(powerups), 1 do
  	powerups[i]:update(dt)

  	if powerups[i]:isOutOfBounds() then
  		table.remove(powerups, i)
  		break
  	end

  	if player:getX() >= powerups[i]:getX() and player:getX() < powerups[i]:getX() + 50 and player:getY() >= powerups[i]:getY() and player:getY() < powerups[i]:getY() + 50  then
  		powerups[i]:activate()
  		table.insert(particleText, ParticleText('POWERUP!!!', powerups[i]:getX(), powerups[i]:getY()))
  		table.remove(powerups, i)
  		love.audio.play(SOUND_EFFECT_POWERUP)
      	player:eat()
      	break
  	end
  end


  for i = 1, #particleText, 1 do
    particleText[i]:update(dt)
    if particleText[i]:isDone() then
      table.remove(particleText, i)
      break
    end
  end
end


function InGame.draw()
  --Draw food (stars)
  for i = 1, table.getn(stars), 1 do
    stars[i]:draw()
  end

  -- Draw player
  player:draw()

  -- Draw black holes
  for i = 1, table.getn(blackHoles), 1 do
    blackHoles[i]:draw()
  end

  -- Draw powerups
  for i = 1, table.getn(powerups), 1 do
  	powerups[i]:draw()
  end

  if PAUSED then
    love.graphics.setBackgroundColor(15/255, 15/255, 15/255)
    love.graphics.print("PAUSED", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 - 50, 0, 2)
    love.graphics.print("Press ESCAPE to UNPAUSE", love.graphics.getWidth()/2 - 100, love.graphics.getHeight()/2 + 20, 0, 0.6)
    love.graphics.print("Press ENTER to EXIT to MAIN MENU", love.graphics.getWidth()/2 - 130, love.graphics.getHeight()/2 + 180, 0, 0.6)
    love.graphics.print("All progress will be lost", love.graphics.getWidth()/2 - 85, love.graphics.getHeight()/2 + 210, 0, 0.6)
  else
    love.graphics.setBackgroundColor(0, 0, 15/255)
  end

  for i = 1, #particleText, 1 do
    particleText[i]:draw()
  end

  --Draw text
  --Appends the score to the string
  local scoreString = "Score: " .. score
  local bodyPartString = "Body Parts: " .. player:getLength()
  love.graphics.print(scoreString, 15, love.graphics.getHeight() - love.graphics.getHeight()/20)
  love.graphics.print(bodyPartString, 15, love.graphics.getHeight() - love.graphics.getHeight()/20 - 40)

  if DEBUG_MODE then
    local starsString = "Stars: " .. #stars
    local holesString = "Black Holes: " .. #blackHoles
    love.graphics.print("Debug mode", 15, 10)
    love.graphics.print(starsString, 15, 50)
    love.graphics.print(holesString, 15, 90)
  end
end

function InGame.spawnStars(amount)
  for i = 0, amount, 1 do
    local randX = love.math.random(0, love.graphics.getWidth())
    local randY = love.math.random(-100, 0)
    table.insert(stars, Star(randX, randY))
  end
end

function InGame.spawnPowerups(amount)
	for i = 0, amount, 1 do
		local randX = love.math.random(0,love.graphics.getWidth())
		local randY = love.math.random(-100, -50)
    	table.insert(powerups, Powerup(randX, randY))
    end
end

function InGame.removeBlackHoles()
  for i = 1, #blackHoles, 1 do
    for k = 1, #blackHoles[i]:getEatenObjects(), 1 do
      table.insert(stars, blackHoles[i]:getEatenObjects()[k])
    end
      table.remove(blackHoles, i)
      break
  end
end
