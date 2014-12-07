gamestate = require "lib.hump.gamestate"
sti       = require "lib.sti"
require "resource_loader"
require "game"

g_menu = {}

g_screenres = {
    w=math.floor(love.graphics.getWidth()/2),
    h=math.floor(love.graphics.getHeight()/2)
}

g_font = love.graphics.newImageFont(load_resource('8pxfont.png','font'),[[!"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_'abcdefghijlkmnopqrstuvwxyz{|}~]])

function love.load()
    love.graphics.setFont(g_font)
    gamestate.registerEvents()
    gamestate.switch(game)
end


function g_menu:keyreleased(key, code)
    if key == 'escape' then
        gamestate.switch(game)
    end
end

