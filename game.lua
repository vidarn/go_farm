bump      = require "lib.bump.bump"
anim8     = require "lib.anim8.anim8"
timer     = require "lib.hump.timer"
require "common"
game = {}

game.camera = {
    x = 0.0, y=0.0,
    shake_amplitude = 0.0, shake_frequency = 0.0,
    offset_x = 0.0, offset_y = 0.0,
}

game.chunksize = 6
game.num_chunks = {w=0,h=0}


game.shake_time = 0.0

game.tile_size = {
    w=32,h=16,
}

game.alive = {}

game.components = {
    "sprites",
    "pos",
    "direction",
    "players",
    "dynamic",
    "coins",
    "tiles",
}

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

function handle_collision(id, other, cols)
    if game.players[id] then
        if game.coins[other] then
            kill_entity(other)
        end
    end
end

function prerun_physics(steps)
    game.prerun = true
    local dt = 0.01
    for step = 1,steps do
        for id,val in pairs(game.dynamic) do 
            if game.alive[id] and val==true then
                update_physics(dt,id)
            end
        end
    end
    game.prerun = false
end

function spawn_from_map(map,layername,hide_layer)
    local layer = map.layers[layername]
    if layer then 
        for x = 1, layer.width do
            for y = 1, layer.height do
                local tile = layer.data[x+(y-1)*layer.width] - 1
                if tile ~= nil then
                    local tileset = nil
                    for _,ts in pairs(map.tilesets) do
                        if(tile < ts.lastgid) then
                            tileset = ts
                            break
                        end
                    end
                    if tile > -1 then
                        local properties = tileset.properties[tile]
                        if properties then
                            local px = x*map.tilewidth
                            local py = y*map.tilewidth
                            for key,val in pairs(properties) do
                                if key == "spawn" then
                                    if val == "coin" then
                                        add_coin(px,py)
                                    end
                                    if val == "player" then
                                        game.pos[game.player].x = px
                                        game.pos[game.player].y = py
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        if hide_layer then
            layer.visible = false
        end
    else
        print("Error in spawn_from_map: layer\""..layername.."\" does not exist")
    end
end

function to_tile_coord(x,y,truncate)
    if truncate == nil then truncate = true end
    local ret_x = x/game.map.tilewidth + y/game.map.tileheight
    local ret_y = -x/game.map.tilewidth + y/game.map.tileheight
    if truncate then
        return math.floor(ret_x),math.floor(ret_y)
    else
        return ret_x,ret_y
    end
end

function to_canvas_coord(x,y)
    local ret_x = (x-y)*game.tile_size.w*0.5
    local ret_y = (x+y)*game.tile_size.h*0.5
    return ret_x,ret_y
end

function get_current_chunk()
    --local player_tile_x, player_tile_y = to_tile_coord(game.pos[game.player].x, game.pos[game.player].y)
    local player_tile_x, player_tile_y = game.pos[game.player].x, game.pos[game.player].y
    local x = math.floor((player_tile_x-1)/game.chunksize)
    local y = math.floor((player_tile_y-1)/game.chunksize)
    return x,y
end

function set_sprite(id,name,frames_x,frames_y,speed,direction,tile_w, tile_h, offset_x, offset_y)
    local sprite = load_resource(name,"sprite")
    local grid = anim8.newGrid(tile_w,tile_h,sprite:getWidth(),sprite:getHeight())
    local anim = anim8.newAnimation(grid(frames_x,frames_y),speed)
    if direction==-1 then
        anim:flipH()
    end
    game.sprites[id] = {anim = anim, sprite = sprite, direction=direction, offset_x=offset_x, offset_y=offset_y}
    game.direction[id] = direction
end

function add_player()
    local id = new_entity()
    local x = 8
    local y = 8
    local w = 0.5
    local h = 0.5
    local center_x = 0.5
    local center_y = 1.1
    local sprite_w = 20
    local sprite_h = 20
    local t_w, t_h = to_canvas_coord(w,h)
    local offset_x = (-sprite_w)*center_x
    local offset_y = (-sprite_h)*center_y
    set_sprite(id,"human_regular_hair.png","3-5",2,0.2,1,sprite_w,sprite_h,offset_x, offset_y)
    game.dynamic[id] = true

    game.pos[id] = {x=x,y=y,vx=0,vy=0}
    game.world:add(id, game.pos[id].x,game.pos[id].y, w, h)
    return id
end

function add_coin(x,y)
    local id = new_entity()
    local w = 16
    local h = 16
    local center_x = 0.5
    local center_y = 1.0
    local tile_w = 16
    local tile_h = 16
    local offset_x = (w-tile_w)*center_x
    local offset_y = (h-tile_h)*center_y
    set_sprite(id,"puhzil_0.png",2,7,0.2,1,tile_w,tile_h,offset_x,offset_y)
    --game.dynamic[id] = true
    game.coins[id] = true

    game.pos[id] = {x=x,y=y,vx=0,vy=0}
    game.world:add(id, game.pos[id].x,game.pos[id].y, w, h)
    return id
end

function add_tile(x,y,w,h)
    local id = new_entity()
    game.tiles[id] = "sand"

    game.pos[id] = {x=x,y=y,vx=0,vy=0}
    game.world:add(id, game.pos[id].x,game.pos[id].y, w, h)
    return id
end


function game:init()
    create_component_managers()
    game.canvas = love.graphics.newCanvas(g_screenres.w, g_screenres.h)
    game.canvas:setFilter('nearest','nearest')
    game.world = bump.newWorld(game.tile_size.w)
    game.player = add_player()

    -- load map
    game.map = load_resource("data/levels/test.lua","map")
    for _,layer in pairs(game.map.layers) do
        for _,col in pairs(layer.colliders) do 
            add_tile(col.x,col.y,col.w,col.h)
        end
    end
    spawn_from_map(game.map,"objects",true)
    game.num_chunks = {w=game.map.width/game.chunksize, h=game.map.height/game.chunksize}

    prerun_physics(100)
end

function game:keyreleased(key, code)
    if key == 'escape' then
        gamestate.switch(g_menu)
    end
    if key == 'f1' then
        debug.debug()
    end
end

function update_player(dt,id)
    local accel = 600.0
    if(love.keyboard.isDown('left') or love.keyboard.isDown("a")) then
        game.pos[id].vx = game.pos[id].vx - accel*dt
        game.pos[id].vy = game.pos[id].vy + accel*dt
        game.direction[id] = -1
    end
    if(love.keyboard.isDown('right') or love.keyboard.isDown("d")) then
        game.pos[id].vx = game.pos[id].vx + accel*dt
        game.pos[id].vy = game.pos[id].vy - accel*dt
        game.direction[id] = 1
    end
    if(love.keyboard.isDown('up') or love.keyboard.isDown("w")) then
        game.pos[id].vx = game.pos[id].vx - accel*dt
        game.pos[id].vy = game.pos[id].vy - accel*dt
    end
    if(love.keyboard.isDown('down') or love.keyboard.isDown("s")) then
        game.pos[id].vx = game.pos[id].vx + accel*dt
        game.pos[id].vy = game.pos[id].vy + accel*dt
    end
end

function update_physics(dt,id)
    local max_speed = 0.3
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
    update_player(dt,game.player)
    -- Update camera
    local camera_offset = 7
    game.camera.offset_x = game.camera.offset_x + (game.direction[game.player]*camera_offset - game.camera.offset_x)*0.3
    local player_chunk_x, player_chunk_y = get_current_chunk()
    local offset_x, offset_y = to_canvas_coord(player_chunk_x*game.chunksize, player_chunk_y*game.chunksize)
    game.camera.x = offset_x
    game.camera.y = game.map.tileheight*3 + offset_y
    game.camera.x = game.camera.x + game.camera.shake_amplitude*love.math.noise(12345.2 + game.shake_time*game.camera.shake_frequency)
    game.camera.y = game.camera.y + game.camera.shake_amplitude*love.math.noise(31.5232 + game.shake_time*game.camera.shake_frequency)

    game.shake_time = (game.shake_time + dt)%1.0
end

function game:draw()
    love.graphics.setCanvas(game.canvas)

    love.graphics.setBackgroundColor(89,125,206)
    love.graphics.clear()

    love.graphics.push()
    local bkg_parallax = 0.4
    love.graphics.translate(math.floor(-game.camera.x*bkg_parallax), math.floor(-game.camera.y*bkg_parallax))
    love.graphics.pop()

    love.graphics.push()
    love.graphics.translate(math.floor(-game.camera.x + g_screenres.w*0.5), math.floor(-game.camera.y + g_screenres.h*0.5))

    love.graphics.setColor(255,255,255)
    -- draw map
    for _,layer in pairs(game.map.layers) do
        if layer.name ~= "game" and layer.visible ~= false then
            local chunk_x, chunk_y = get_current_chunk()
            for x = chunk_x*game.chunksize+1, (chunk_x+1)*game.chunksize do
                for y = chunk_y*game.chunksize+1, (chunk_y+1)*game.chunksize do
                    if x >= 1 and x < game.map.width and y >=1 and y < game.map.height then
                        local tile = layer.data[x+(y-1)*layer.width]
                        if tile ~= nil then
                            tile = tile - 1
                            local tileset = nil
                            for _,ts in pairs(game.map.tilesets) do
                                if(tile < ts.lastgid) then
                                    tileset = ts
                                    break
                                end
                            end
                            if(tileset ~= nil) then
                                local localgid = tile + 1 - tileset.firstgid
                                local tx = localgid % tileset.tiles_x
                                local ty = math.floor(localgid / tileset.tiles_x)
                                local tw = tileset.tilewidth
                                local th = tileset.tileheight
                                local quad = love.graphics.newQuad(tx*tw, ty*th,tw,th,tileset.imagewidth, tileset.imageheight)
                                local draw_x = (x-y-1)*game.map.tilewidth*0.5
                                local draw_y = (x+y-1)*game.map.tileheight*0.5
                                love.graphics.draw(tileset.loaded_image, quad, draw_x, draw_y)
                            end
                        end
                    end
                end
            end
        end
    end

    for id,sprite in pairs(game.sprites) do
        if game.alive[id] == true then
            if game.direction[id] ~= sprite.direction then
                sprite.direction = game.direction[id]
                sprite.anim:flipH()
            end
            local x,y = to_canvas_coord(game.pos[id].x, game.pos[id].y)
            x = math.floor(x)
            y = math.floor(y)
            sprite.anim:draw(sprite.sprite,x+sprite.offset_x,y+sprite.offset_y)
        end
    end

    -- Draw scaled canvas to screen
    love.graphics.pop()
    love.graphics.setBackgroundColor(0,0,0,0)
    love.graphics.setColor(255,255,255)
    love.graphics.setCanvas()
    love.graphics.clear()
    local h = love.graphics.getHeight()
    local w = love.graphics.getWidth()
    local aspect = g_screenres.w/g_screenres.h
    if aspect < w/h then
        local w = love.graphics.getWidth()
        local quad = love.graphics.newQuad(0,0,h*aspect,h,h*aspect,h)
        love.graphics.draw(game.canvas, quad, (w-h*aspect)*0.5, 0)
    else
        aspect = 1/aspect
        local quad = love.graphics.newQuad(0,0,w,w*aspect,w,w*aspect)
        love.graphics.draw(game.canvas, quad, 0, (h-w*aspect)*0.5)
    end
end

