menu = {}

function menu:init()
    print("INIT!")
    menu.active_player = 1
    menu.ask_switch_player = false
    menu.active_key_num = 1
    menu.active_key = g_key_codes[menu.active_key_num]
    menu.canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    menu.tmp_canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    menu.canvas:setFilter('nearest','nearest')
    menu.block = load_resource('menu.png','sprite')
    menu.block_time =  0
end

function menu:update(dt)
    menu.block_time = menu.block_time + dt
end

function menu:resize(w,h)
    g_screenres = {
        w=math.floor(love.graphics.getWidth()/2),
        h=math.floor(love.graphics.getHeight()/2)
    }
    menu.canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    menu.tmp_canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    menu.canvas:setFilter('nearest','nearest')
end

function menu:draw()
    love.graphics.setCanvas(menu.canvas)

    love.graphics.setBackgroundColor(99,155,255)
    love.graphics.clear()

    love.graphics.draw(menu.block,(g_screenres.w-menu.block:getWidth())*0.5,(g_screenres.h-menu.block:getHeight())*0.5+math.floor(4*math.sin(menu.block_time*0.8)+30))


    love.graphics.setColor(255,255,255)
    local t_w = 300
    if menu.ask_switch_player == true then
        love.graphics.printf('PRESS \n"'..g_key_names.up..'" TO GO FARM WITH A FRIEND\n AND \n"'..g_key_names.down..'" TO GO FARM ALONE'
            ,(g_screenres.w-t_w)*0.5,g_screenres.h*0.5-100,t_w,'center')
    else
        love.graphics.printf("PLAYER "..menu.active_player..'\n\nPRESS THE BUTTON YOU WISH TO USE TO\n"'..g_key_names[menu.active_key]..'"'
            ,(g_screenres.w-t_w)*0.5,g_screenres.h*0.5-100,t_w,'center')
    end


    love.graphics.setBackgroundColor(99,155,255)
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()
    love.graphics.clear()
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    local s_w = g_screenres.w*2
    local s_h = g_screenres.h*2
    local quad = love.graphics.newQuad(0,0,s_w,s_h,s_w,s_h)
    local x = math.floor((w-s_w)*0.5)
    local y = math.floor((h-s_h)*0.5)
    love.graphics.draw(menu.canvas, quad, x, y)
end

function menu:keyreleased(key, code)
    play_sound('blip')
    if menu.ask_switch_player == true then
        if key == g_keys[menu.active_player].up then
            menu.active_player = 2
            menu.ask_switch_player = false
            menu.active_key_num = 1
            menu.active_key = g_key_codes[menu.active_key_num]
        elseif key == g_keys[menu.active_player].down then
            gamestate.switch(game)
        end
    else
        g_keys[menu.active_player][menu.active_key] = key
        menu.active_key_num = menu.active_key_num + 1
        if menu.active_key_num > #g_key_codes then
            if menu.active_player == 1 then
                menu.ask_switch_player = true
            else
                g_num_players = 2
                gamestate.switch(game)
            end
        else
            menu.active_key = g_key_codes[menu.active_key_num]
        end
    end
end
