--Library called Classic which makes us able to create objects which lua doesn't support.
--require is javas import statement
Object = require 'libraries/classic/classic'
--Library called Tserial which makes us able to save tables to lua scripts.
--https://love2d.org/wiki/Tserial
require 'libraries/tserial/TSerial'

require 'Snake'
require 'Star'
require 'BackgroundStar'
require 'BlackHole'
require 'Highscore'
require 'HighscoreMenu'
require 'MainMenu'
require 'InGame'
require 'HelpMenu'
require 'GameOverScreen'
require 'ParticleText'
require 'SOUNDS'
require 'TEXTURES'
require 'Powerup'
require 'CreditsMenu'

--Wihout this line, images get blurry when we enlarge them :(
love.graphics.setDefaultFilter("nearest","nearest")

--Set font for drawable text
mainFont = love.graphics.newFont("res/font/fff-forward.regular.ttf", 20)
love.graphics.setFont(mainFont)

gameState = {
  [1] = MainMenu,
  [2] = InGame,
  [3] = HighscoreMenu,
  [4] = GameOverScreen,
  [5] = HelpMenu,
  [6] = CreditsMenu,
}

--Our current game state. See gameState for possible game states.
state = 1
--If the game is paused or not (only while InGame)
PAUSED = false
--List of all background stars (stars you can't interact with)
backgroundStars = {}
time = 0

DEBUG_MODE = true

--Called on startup by LOVE
function love.load()
  love.graphics.setBackgroundColor(0, 0, 15/255) -- RGB where each value is 0-1.
  --Generate background stars
  generateBackground(200)
  --Load the highscore file, if it exists.
  loadHighscore()
end

--Called every frame
--Updates stuff
function love.update(dt)
  if PAUSED == false then --Too lazy to look up how to do !PAUSED
    --This calls the class name and then the update() method for that class. The state is a field that stores what game state we are in.
    gameState[state].update(dt)
  end
end

--Called every frame.
--Draws stuff
function love.draw()
  --Draw background
  for i = 1, table.getn(backgroundStars), 1 do
    backgroundStars[i]:draw()
  end

  --Calls the draw function for the game state we are in.
  gameState[state].draw()

end

function love.quit()
  saveHighscore()
end

function love.keypressed( key )
  gameState[state].pressedKey(key)
end

--Generate background stars
function generateBackground(amount)
  for i = 0, 200, 1 do
    local randX = love.math.random(0, love.graphics.getWidth())
    local randY = love.math.random(0, love.graphics.getHeight())
    table.insert(backgroundStars, BackgroundStar(randX, randY))
  end
end
