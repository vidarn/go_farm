bump      = require "lib.bump.bump"
anim8     = require "lib.anim8.anim8"
timer     = require "lib.hump.timer"
require "common"
require "entity"
require "game_control"

game = {}
game.interactable_functions = require "interactables"
game.inventory_item_functions = require "inventory_items"

game.cameras = {
}

game.chunksize = 6
game.num_chunks = {w=0,h=0}
game.chunks_to_draw = {}
game.debug = false
game.player_ids = {}
game.money = 40000
game.harvest_tip_shown = false
game.message = ""

game.tile_size = {
    w=32,h=16,
}

game.alive = {}

game.keys = {
}


game.components = {
    "sprites",
    "pos",
    "direction",
    "players",
    "dynamic",
    "coins",
    "tiles",
    "plants",
    "interactables",
    "inventory",
    "item_properties"
}

game.player_count = 0

function create_component_managers()
    for _,component in pairs(game.components) do
        game[component] = {}
    end
end

function kill_entity(id)
    game.alive[id] = false
    for _,component in pairs(game.components) do
        game[component][id] = nil
    end
end

function new_entity()
    for key,val in pairs(game.alive) do
        if(val == false) then
            game.alive[key] = true
            return key
        end
    end
    table.insert(game.alive,true)
    return table.getn(game.alive)
end

function game:resize(w,h)
    g_screenres = {
        w=math.floor(love.graphics.getWidth()/2),
        h=math.floor(love.graphics.getHeight()/2)
    }
    game.canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    game.tmp_canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    game.canvas:setFilter('nearest','nearest')
end

function game:enter()
    game.keys[game.player_ids[1]] = g_keys[1]
    if g_num_players == 2 then
        game.keys[game.player_ids[2]] = g_keys[2]
    end
end

function game:init()
    create_component_managers()
    game.canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    game.tmp_canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    game.canvas:setFilter('nearest','nearest')
    game.world = bump.newWorld(game.tile_size.w)
    game.bkg = load_resource('clouds.png','sprite')
    game.bkg_offset = 0
    add_player(14,15)
    add_camera(game.player_ids[1])

    if g_num_players == 2 then
        add_player(10,26)
        add_camera(game.player_ids[2])
    end

    -- load map
    game.map = load_resource("data/levels/test.lua","map")
    for _,layer in pairs(game.map.layers) do
        for _,col in pairs(layer.colliders) do 
            add_tile(col.x,col.y,col.w,col.h)
        end
    end
    spawn_from_map(game.map,"objects",true)
    game.num_chunks = {w=game.map.width/game.chunksize, h=game.map.height/game.chunksize}
end

function game:keyreleased(key, code)
    if key == 'f1' then
        game.debug = true
    end
    for _,player_id in pairs(game.player_ids) do
        if game.players[player_id].gui == nil then
            if key == game.keys[player_id].interact then
                interact(player_id) --keyboard is treated as player one
            end
            if key == game.keys[player_id].drop then
                local interactable = game.interactables[get_current_inv_id(player_id)]
                if interactable ~= nil then
                    if interactable.functions ~= nil then
                        if interactable.functions.drop ~= nil then
                          interactable.functions.drop(player_id)
                        end
                    end
                end
            end
            if key == game.keys[player_id].cycle then
                next_inventory_item(player_id)
            end
        else
            game.players[player_id].gui.keyreleased(key,player_id)
        end
    end
end

function update_physics(dt,id)
    local max_speed = 0.4
    -- Update physics
    local sx = sign(game.pos[id].vx)
    local sy = sign(game.pos[id].vy)
    local speed = math.sqrt(sx*sx+sy*sy)
    game.pos[id].vx = game.pos[id].vx*math.min(speed,max_speed)/speed
    game.pos[id].vy = game.pos[id].vy*math.min(speed,max_speed)/speed


    local damping_x = -game.pos[id].vx*0.3
    local damping_y = -game.pos[id].vy*0.3
    game.pos[id].vx = game.pos[id].vx + damping_x
    game.pos[id].vy = game.pos[id].vy + damping_y

    -- Scale y velocity to make things feel a bit better
    local vx,vy = to_canvas_coord(game.pos[id].vx, game.pos[id].vy)
    vy = vy * 1.2
    game.pos[id].vx, game.pos[id].vy = to_tile_coord(vx,vy,false)

    local dy = dt*(game.pos[id].vy)
    local dx = dt*(game.pos[id].vx) 
    local new_x = game.pos[id].x + dx
    local new_y = game.pos[id].y + dy
    local x = math.floor(game.pos[id].x/game.tile_size.w)
    -- collisions
    local colliders = {}

    -- check y
    local collisions, len = game.world:check(id, game.pos[id].x, new_y)
    local moved = false -- Make sure we move to the first (closest) intersected tile
    if len >= 1 then
        for _,col in pairs(collisions) do
            local tl, tt, nx, ny = col:getTouch()
            local other = col.other
            if game.tiles[other] then
                if not moved then
                    new_y = tt
                    moved = true
                end
            end
            if colliders[other] == nil then
                colliders[other] = {}
            end
            table.insert(colliders[other],{col=col, dir='y'})
        end
    end

    -- check x
    collisions, len = game.world:check(id, new_x, new_y)
    moved = false
    if len >= 1 then
        for _,col in pairs(collisions) do
            local tl, tt, nx, ny = col:getTouch()
            local other = col.other
            if game.tiles[other] then
                if not moved then
                    new_x = tl
                    moved = true
                end
            end
            if colliders[other] == nil then
                colliders[other] = {}
            end
            table.insert(colliders[other],{col=col, dir='x'})
        end
    end
    if not game.prerun then
        for other,cols in pairs(colliders) do 
            handle_collision(id,other,cols)
        end
    end
    game.pos[id].x = new_x
    game.pos[id].y = new_y
    game.world:move(id, new_x, new_y)
end

function game:update(dt)
    timer.update(dt)
    for id,sprite in pairs(game.sprites) do 
        if game.alive[id] then
            sprite.anim:update(dt)
        end
    end
    for id,val in pairs(game.dynamic) do 
        if game.alive[id] and val==true then
            update_physics(dt,id)
        end
    end
    update_plants(dt)

    local active_chunks = {}
    for a,player_id in pairs(game.player_ids) do
        local curr_x, curr_y = get_current_chunk(player_id)
        active_chunks[curr_x + curr_y*game.num_chunks.w] = 1
    end
    local num_active_chunks = 0
    for _,__ in pairs(active_chunks) do
        num_active_chunks = num_active_chunks + 1
    end

    for a,player_id in pairs(game.player_ids) do
        update_player(dt,player_id)
        for _,chunk in pairs(game.chunks_to_draw[player_id]) do
            local curr_x, curr_y = get_current_chunk(player_id)
            chunk.active = chunk.active or (chunk.x == curr_x and chunk.y == curr_y)
        end
        -- update camera

        local player_chunk_x, player_chunk_y = get_current_chunk(player_id)

        local camera = game.cameras[player_id]

        if player_chunk_x ~= camera.last_chunk_x or player_chunk_y ~= camera.last_chunk_y or camera.last_num_active_chunks ~= num_active_chunks then
            local offset_x, offset_y = to_canvas_coord(player_chunk_x*game.chunksize, player_chunk_y*game.chunksize)
            if num_active_chunks == 2 then
                if a == 1 then
                    offset_x = offset_x - game.chunksize*game.map.tilewidth*0.5 - 3
                else
                    offset_x = offset_x + game.chunksize*game.map.tilewidth*0.5 + 3
                end
            else
            end

            timer.tween(0.2,camera,{x =offset_x, y = game.map.tileheight*0 + offset_y},'in-out-expo')
            game.chunks_to_draw[player_id][player_chunk_x+player_chunk_y*game.num_chunks.w] = {x=player_chunk_x, y=player_chunk_y, alpha=0.0, active=true}

            camera.last_chunk_x = player_chunk_x
            camera.last_chunk_y = player_chunk_y

        end
        camera.last_num_active_chunks = num_active_chunks
        -- update chunks
        for _,chunk in pairs(game.chunks_to_draw[player_id]) do
            if chunk.active == true and (num_active_chunks == 2 or a ==1 )then
                chunk.alpha = chunk.alpha + dt*8
                chunk.alpha = math.min(chunk.alpha, 1)
            else
                chunk.alpha = chunk.alpha - dt*8
                if chunk.alpha < 0 then
                    game.chunks_to_draw[player_id][chunk.x + chunk.y*game.num_chunks.w] = nil
                end
            end
            chunk.active = false
        end
        camera.shake_time = (camera.shake_time + dt*camera.shake_frequency)%1.0
    end
    game.bkg_offset = game.bkg_offset + dt*4
    while game.bkg_offset > game.bkg:getWidth() do
        game.bkg_offset = game.bkg_offset - game.bkg:getWidth()
    end
end

function draw_map_tile(x,y,layer)
    if layer.visible ~= false then
        local tile,tileset = get_tile_and_tileset(x,y,layer)
        if tile ~= nil then
            local localgid = tile + 1 - tileset.firstgid
            local tx = localgid % tileset.tiles_x
            local ty = math.floor(localgid / tileset.tiles_x)
            local tw = tileset.tilewidth
            local th = tileset.tileheight
            local quad = love.graphics.newQuad(tx*tw, ty*th,tw,th,tileset.imagewidth, tileset.imageheight)
            local draw_x = (x-y-1)*game.map.tilewidth*0.5
            local draw_y = (x+y+3)*game.map.tileheight*0.5-th
            love.graphics.draw(tileset.loaded_image, quad, draw_x, draw_y)
        end
    end
end

function game:draw()
    love.graphics.setCanvas(game.canvas)

    love.graphics.setBackgroundColor(99,155,255)
    love.graphics.clear()

    love.graphics.draw(game.bkg, math.floor(game.bkg_offset))
    love.graphics.draw(game.bkg, math.floor(game.bkg_offset-game.bkg:getWidth()))

    love.graphics.push()
    for a,player_id in pairs(game.player_ids) do
        local camera = game.cameras[player_id]

        love.graphics.pop()
        love.graphics.push()
        -- Camera shake
        --camera.x = camera.x + camera.shake_amplitude*love.math.noise(12345.2 + game.shake_time*camera.shake_frequency)
        local offset_y = camera.shake_amplitude*math.sin(camera.shake_time*2*math.pi + 1234.322*a)
        love.graphics.translate(math.floor(-camera.x + g_screenres.w*0.5), math.floor(-camera.y + g_screenres.h*0.5 + offset_y))

        love.graphics.setColor(255,255,255)
        for chunk_x = 0, game.num_chunks.w do
            for chunk_y = 0, game.num_chunks.h do
                local chunk = game.chunks_to_draw[player_id][chunk_x + game.num_chunks.w*chunk_y]
                if chunk ~= nil then
                    love.graphics.setCanvas(game.tmp_canvas)
                    love.graphics.setColor(255,255,255)
                    love.graphics.setBackgroundColor(0,0,0,0)
                    love.graphics.clear()
                    -- draw the ground, should always be behind the player
                    for x = chunk_x*game.chunksize+1, (chunk_x+1)*game.chunksize do
                        for y = chunk_y*game.chunksize+1, (chunk_y+1)*game.chunksize do
                            if x >= 1 and x < game.map.width and y >=1 and y < game.map.height then
                                draw_map_tile(x,y,game.map.layers['ground'])
                            end
                        end
                    end


                    -- Fix drawing of hilight squares when players are on the same chunk
                    local players =game.player_ids
                    if camera.last_num_active_chunks == 2 then
                        players = {player_id}
                    end
                    for b,p_id in pairs(players) do
                        -- draw interaction hilight, between ground and objects
                        if game.players[p_id].available_interactable ~= nil then
                            local id = game.players[p_id].available_interactable
                            local interactable = game.interactables[id]
                            local x,y = to_canvas_coord(game.pos[id].x,game.pos[id].y)
                            game.players[p_id].hl_anim:draw(game.players[p_id].hl_sprite,x-21,y-22)
                        end
                    end

                    -- draw all objects and decoration in the correct order
                    for x = chunk_x*game.chunksize+1, (chunk_x+1)*game.chunksize do
                        for y = chunk_y*game.chunksize+1, (chunk_y+1)*game.chunksize do
                            if x >= 1 and x < game.map.width and y >=1 and y < game.map.height then
                                for layername,layer in pairs(game.map.layers) do
                                    if layername ~= 'ground' then
                                        draw_map_tile(x,y,layer)
                                    end
                                end
                                local to_draw = {}
                                --draw sprites
                                for id,sprite in pairs(game.sprites) do
                                    if game.alive[id] == true and sprite.active then
                                        if math.floor(game.pos[id].x) == x and math.floor(game.pos[id].y) == y then
                                            table.insert(to_draw,id)
                                        end
                                    end
                                end
                                table.sort(to_draw, function(a,b) return (game.pos[a].x+game.pos[a].y) < (game.pos[b].x+game.pos[b].y) end)
                                for i=1 , #to_draw do
                                    local id = to_draw[i]
                                    local sprite = game.sprites[id]
                                    if game.direction[id] ~= sprite.direction then
                                        sprite.direction = game.direction[id]
                                        sprite.anim:flipH()
                                    end
                                    local x,y = to_canvas_coord(game.pos[id].x, game.pos[id].y)
                                    x = math.floor(x)
                                    y = math.floor(y)
                                    sprite.anim:draw(sprite.sprite,x+sprite.offset_x,y+sprite.offset_y)
                                    --for debugging, draw center
                                    if game.debug then
                                        local cx, cy = to_canvas_coord(game.pos[id].x, game.pos[id].y)
                                        love.graphics.rectangle("fill", cx, cy, 2,2)
                                    end
                                end
                            end
                        end
                    end
                    love.graphics.push()
                    love.graphics.origin()
                    love.graphics.setColor(255,255,255,255*chunk.alpha)
                    love.graphics.setCanvas(game.canvas)
                    love.graphics.draw(game.tmp_canvas)
                    love.graphics.pop()
                end
            end
        end
        -- floating guis
        if game.players[player_id].gui ~= nil then
            game.players[player_id].gui.draw(player_id)
        end
    end

    love.graphics.pop()



    --hud stuff
    for player_number = 1, 2, 1 do 
        if game.player_ids[player_number] ~= nil then
            local player = game.players[game.player_ids[player_number]]

            -- draw frames
            love.graphics.setColor(150,150,150)
            local framesize = 32
            local margin = 40
            for frame = 1, player.inventory_slots, 1 do 
                local x
                if player_number == 1 then
                    x = g_screenres.w-margin - framesize*(frame-1)
                else
                    x = 10 + framesize*(frame-1)
                end
                local y = g_screenres.h-margin
                love.graphics.rectangle("fill",x,y,framesize,framesize)
            end

            -- draw items
            love.graphics.setColor(255, 255, 255, 255)
            for key,item_id in pairs(player.inventory) do
                local sprite = game.sprites[item_id]
                local x
                if player_number == 1 then
                    x = g_screenres.w-margin - framesize*(key-1)
                else
                    x = 10 + framesize*(key-1)
                end
                local y = g_screenres.h-margin

                if sprite ~= nil and item_id ~= nil and key ~= nil then
                    sprite.anim:draw(sprite.sprite,x,y)
                end
                -- draw amount if it exists
                if game.item_properties[item_id] ~= nil and game.item_properties[item_id].amount ~= nil then
                    love.graphics.print(game.item_properties[item_id].amount, x, y)
                end
            end
            
            -- highlight active slot
            if player_number == 1 then 
                love.graphics.setColor(63,63,116)
            else
                love.graphics.setColor(172,50,50)
            end
            local x
            if player_number == 1 then
                x = g_screenres.w-margin - framesize*(player.active_inventory_slot-1)
            else
                x = 10 + framesize*(player.active_inventory_slot-1)
            end
            local y = g_screenres.h-margin
            love.graphics.rectangle("line",x,y,framesize,framesize)
        end
    end

    love.graphics.setColor(255,255,255)
    love.graphics.print("$"..game.money,10,10)
    local t_w = 300
    love.graphics.printf(game.message,(g_screenres.w-t_w)*0.5,g_screenres.h-20,t_w,'center')


    -- Draw scaled canvas to screen
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
    love.graphics.draw(game.canvas, quad, x, y)
    -- draw inventory HUD
end

