HighscoreMenu = {}

function HighscoreMenu.update()

end

function HighscoreMenu.enter()
  state = 3
end

local key = love.keyboard
local g = love.graphics

function HighscoreMenu.pressedKey(key)
  if key == "escape" then
    love.audio.play(SOUND_NAV_MOVE)
    state = 1
  end
end

function HighscoreMenu.draw()
  g.print("HIGHSCORE", 380, 100, 0, 2)
  --g.print("WIP :)", 500, 300, 0, 1)
  g.print("Press ESCAPE to return", 370, 30, 0, 1)
  g.print("No working highscore system for you, scrub!", 370, 500, 0, 1)
  for i = 1, table.getn(highscores), 1 do
    g.print(highscores[i][1], 400, 150 + (i*50), 0, 1)
    g.print(highscores[i][2], 630, 150 + (i*50), 0, 1)
  end
end
