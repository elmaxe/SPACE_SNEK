HelpMenu = {}

function HelpMenu.update()

end

local key = love.keyboard
local g = love.graphics

function HelpMenu.pressedKey(key)
  if key == "escape" then
    love.audio.play(SOUND_NAV_MOVE)
    state = 1
  end
end

function HelpMenu.draw()
  g.print("Press ESCAPE to return", 370, 30, 0, 1)
  g.print("HELP", love.graphics.getWidth()/2 - 55, 100, 0, 2)
  g.print("Move the snek around by HOLDING LEFT MOUSE BUTTON", 160, 250, 0, 1)
  g.print("Eat as many stars as you can.", 320, 300, 0, 1)
  g.print("Avoid the black holes.", 380, 350, 0, 1)
  g.print("Take powerups.", 410, 400, 0, 1)
  g.print("Press ESCAPE to pause the game", 300, 450, 0, 1)
  love.graphics.draw(TEX_STAR, 800, 290, 0, 4)
  love.graphics.draw(TEX_STAR_2, 840, 290, 0, 4)
  love.graphics.draw(TEX_BLACK_HOLE, 800, 340, 0, 1.5)
  love.graphics.draw(TEX_POWERUP_SPEED, 730, 375, 0, 1)
  love.graphics.draw(TEX_POWERUP_NO_BLACKHOLE, 780, 375, 0, 1)
  love.graphics.draw(TEX_POWERUP_STARS, 830, 375, 0, 1)
end
