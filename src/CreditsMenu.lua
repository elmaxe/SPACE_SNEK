CreditsMenu = {}
require 'CreditsText'

local ystart = 1000
local titleY = ystart - 100
local creditsY = ystart + 100
local programmingY = ystart + 300
local musicY = ystart + 600
local audioY =  ystart + 850
local artY = ystart + 1150
local snakePhysicsY = ystart + 1450

local text = {}

function CreditsMenu.update(dt)
  for i = 1, #text, 1 do
    text[i]:update(dt)
  end
end

function CreditsMenu.enter()
  state = 6
  MUSIC_CREDITS:setLooping(true)
  love.audio.play(MUSIC_CREDITS)
  text = {
    CreditsText("SPACE SNEK", love.graphics.getWidth()/2 - 330, titleY - 100, 4),
    CreditsText("A Space Adventure", love.graphics.getWidth()/2 - 185, titleY + 50, 1.5),
    CreditsText("CREDITS", love.graphics.getWidth()/2 - 100, creditsY, 2),

    CreditsText("PROGRAMMING", love.graphics.getWidth()/2 - 140, programmingY, 1.5),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, programmingY + 100, 1),
    CreditsText("Axel Elmarsson", love.graphics.getWidth()/2 - 90, programmingY + 150, 1),

    CreditsText("MUSIC", love.graphics.getWidth()/2 - 60, musicY, 1.5),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, musicY + 100, 1),

    CreditsText("AUDIO", love.graphics.getWidth()/2 - 50, audioY, 1.5),
    CreditsText("Axel Elmarsson", love.graphics.getWidth()/2 - 90, audioY + 100, 1),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, audioY + 150, 1),

    CreditsText("ART", love.graphics.getWidth()/2 - 25, artY, 1.5),
    CreditsText("Axel Elmarsson", love.graphics.getWidth()/2 - 90, artY + 100, 1),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, artY + 150, 1),

    CreditsText("SNAKE PHYSICS", love.graphics.getWidth()/2 - 150, snakePhysicsY, 1.5),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, snakePhysicsY + 100, 1),

    CreditsText("MESSY BLACK HOLES", love.graphics.getWidth()/2 - 200, snakePhysicsY + 250, 1.5),
    CreditsText("Axel Elmarsson", love.graphics.getWidth()/2 - 80, snakePhysicsY + 350, 1),

    CreditsText("BEST AT GAME", love.graphics.getWidth()/2 - 130, snakePhysicsY + 500, 1.5),
    CreditsText("Lara Sheik", love.graphics.getWidth()/2 - 60, snakePhysicsY + 600, 1),

    CreditsText("SECOND BEST AT GAME", love.graphics.getWidth()/2 - 210, snakePhysicsY + 750, 1.5),
    CreditsText("Axel Elmarsson", love.graphics.getWidth()/2 - 80, snakePhysicsY + 850, 1),

    CreditsText("WORST AT GAME", love.graphics.getWidth()/2 - 150, snakePhysicsY + 1000, 1.5),
    CreditsText("Marcus Dicander <3", love.graphics.getWidth()/2 - 100, snakePhysicsY + 1100, 1),

    CreditsText("Programmed in Lua with the LOVE engine", love.graphics.getWidth()/2 - 240, snakePhysicsY + 1250, 1),
    CreditsText("Created in spring 2018 for the KTH course DD1349", love.graphics.getWidth()/2 - 300, snakePhysicsY + 1300, 1),
    CreditsText("Inspired by the original Snake game", love.graphics.getWidth()/2 - 220, snakePhysicsY + 1350, 1),

    CreditsText("No sneks were hurt during the production of this game", love.graphics.getWidth()/2 - 340, snakePhysicsY + 1500, 1),
    CreditsText("snek snek snke snken skensken snkensk copyright something 2018", love.graphics.getWidth()/2 - 430, snakePhysicsY + 1650, 1),
  }
end

local key = love.keyboard
local g = love.graphics

function CreditsMenu.pressedKey(key)
  if key == "escape" then
    love.audio.stop(MUSIC_CREDITS)
    love.audio.play(SOUND_NAV_MOVE)
    state = 1
  end
end

function CreditsMenu.draw()
  for i = 1, #text, 1 do
    text[i]:draw()
  end
end
