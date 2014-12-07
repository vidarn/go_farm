gamestate = require "lib.hump.gamestate"
sti       = require "lib.sti"
require "resource_loader"
require "game"
require "menu"

g_screenres = {
    w=math.floor(love.graphics.getWidth()/2),
    h=math.floor(love.graphics.getHeight()/2)
}

g_num_players = 1

g_key_codes = {
    'left',
    'right',
    'up',
    'down',
    'interact',
    'drop',
    'cycle',
}

g_key_names = {
    up = 'WALK UP', 
    down = 'WALK DOWN', 
    left = 'WALK LEFT', 
    right = 'WALK RIGHT', 
    interact = 'USE/PICK UP ITEMS',
    drop = 'DROP ITEMS',
    cycle = 'TOGGLE INVENTORY SLOT',
}

g_keys = {
    {up = 'up', 
        down = 'down', 
        left = 'left', 
        right = 'right', 
        interact = 'return',
        drop = ' ',
        cycle = 'backspace',
    },
    {
        up = 'w', 
        down = 's', 
        left = 'a', 
        right = 'd', 
        interact = 'e',
        drop = 'q',
        cycle = 'tab',
    }
}


g_font = love.graphics.newImageFont(load_resource('8pxfont.png','font'),[[!"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_'abcdefghijlkmnopqrstuvwxyz{|}~ ]])

function love.load()
    love.graphics.setFont(g_font)
    gamestate.registerEvents()
    -- TODO(Vidar) change to menu for release
    gamestate.switch(game)
    --gamestate.switch(menu)
end



