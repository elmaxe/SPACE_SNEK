MainMenu = {}

local buttons = {
  [1] = "Play",
  [2] = "Help",
  [3] = "Highscore",
  [4] = "Credits",
  [5] = "Quit",
}

--You can apparently do this :D
local key = love.keyboard
local g = love.graphics

--Called when you enter the main menu
function MainMenu.enter()
  state = 1
  navigator = 1
  love.graphics.setBackgroundColor(0, 0, 15/255)
end

navigator = 1
--To help with drawing and changing stuff fast
local x = 450
local y = 300
local space = 70

--The draw function for our main menu
function MainMenu.draw()

  --g.print(love.window.getTitle(), 100, 100, 0, 2)
  g.print("SPACE SNEK", 250, 100, 0, 3)
  g.print("A Space Adventure", 380, 200, 0, 1)

  g.print("2018: Lara Sheik, Axel Elmarsson", 10, 740, 0, 0.8)

  for i = 1, 5 do
    --Draw left selector
    if i == navigator then
      g.print(">", x - 30, y + (i*space), 0, 1.5)
    end

    g.print(buttons[i], x, y + (i*space), 0, 1.5)
  end
end

function MainMenu.update(dt)

end

function MainMenu.pressedKey(key)
  if key == "up" then
    love.audio.play(SOUND_NAV_MOVE)
    if navigator == 1 then
      navigator = 5
    else
      navigator = navigator - 1
    end
  elseif key == "down" then
    love.audio.play(SOUND_NAV_MOVE)
    if navigator == 5 then
      navigator = 1
    else
      navigator = navigator + 1
    end
  elseif key == "return" or key == "space" then
    love.audio.play(SOUND_NAV_CLICK)
    if navigator == 1 then
      --Start game
      --state = 2
      InGame.newGame()
    elseif navigator == 2 then
      --Show help screen
      state = 5
    elseif navigator == 3 then
      --Show high score screen
      --state = 3
      HighscoreMenu.enter()
      -- Credits
      -- state = 4
    elseif navigator == 4 then
      CreditsMenu.enter()
      --Quit
    elseif navigator == 5 then
      love.event.quit()
    
    end
  end
end
