--CONFIG FILE
--Replaces the love.conf function upon startup according to the wiki: https://love2d.org/wiki/Config_Files
function love.conf(t)
    t.window.title = "Space Snek - A Space Adventure"
    t.version = "11.1"
    t.window.width = 1024
    t.window.height = 768
    t.window.resizable = false
    --FIX ICON
    t.window.icon = "res/img/snake_head.png"
end
