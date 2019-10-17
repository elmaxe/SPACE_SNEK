GameOverScreen = {}

function GameOverScreen.update()
end

function GameOverScreen.enter()
  state = 4
  love.audio.stop(MUSIC_THEME)
  love.audio.stop(MUSIC_POWERUP)
  love.audio.play(MUSIC_DEATH)
end

local key = love.keyboard
local g = love.graphics

function GameOverScreen.pressedKey(key)
  if key == "return" then
    state = 2
    love.audio.play(SOUND_NAV_CLICK)
    InGame.newGame()
  elseif key == "escape" then
    state = 1
    MainMenu.enter()
  end
end

local scoreX = love.graphics.getWidth()/2 - 110
local scoreY = 250

function GameOverScreen.draw()
--  g.setColor(76/255, 0, 15/255, 100)
  love.graphics.setBackgroundColor(76/255, 0, 15/255)
  g.print("GAME OVER", love.graphics.getWidth()/2 - 155, 100, 0, 2)
  g.print("SCORE:", scoreX, scoreY, 0, 1.5)
  g.print(score, scoreX + 160, scoreY, 0, 1.5)

  --[[
  Pseudocode

  if new highscore
    print New Highscore!!!
    and add to highscore.txt
  else do not print
  ]]

  g.print("Press ENTER to restart", 370, scoreY + 300, 0, 1)
  g.print("Press ESCAPE to quit to MAIN MENU", 280, scoreY + 345, 0, 1)

end
