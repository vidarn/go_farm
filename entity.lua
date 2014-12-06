function set_sprite(id,name,frames_x,frames_y,speed,direction,tile_w, tile_h, offset_x, offset_y)
    local sprite = load_resource(name,"sprite")
    local grid = anim8.newGrid(tile_w,tile_h,sprite:getWidth(),sprite:getHeight())
    local anim = anim8.newAnimation(grid(frames_x,frames_y),speed)
    if direction==-1 then
        anim:flipH()
    end
    game.sprites[id] = {anim = anim, sprite = sprite, direction=direction, offset_x=offset_x, offset_y=offset_y, active=true}
    game.direction[id] = direction
end

function add_camera(player_id)
    game.cameras[player_id] = {
        x = 0.0, y=0.0,
        shake_amplitude = 0.0, shake_frequency = 0.0,
        offset_x = 0.0, offset_y = 0.0,
        last_chunk_x = 0, last_chunk_y = 0
    }
end


function add_player(x,y)
    --NOTE will probably have to add some other type of table to link players with controllers.
    local id = new_entity()
    --local x = 8
    --local y = 8
    local w = 0.5
    local h = 0.5
    local center_x = 0.5
    local center_y = 1.0
    local sprite_w = 20
    local sprite_h = 20
    local t_w, t_h = to_canvas_coord(w,h)
    local offset_x = (-sprite_w)*center_x
    local offset_y = (-sprite_h)*center_y
    set_sprite(id,"human_regular_hair.png","3-5",2,0.2,1,sprite_w,sprite_h,offset_x, offset_y)
    game.dynamic[id] = true

    game.player_count = game.player_count + 1
    game.player_ids[game.player_count] = id

    game.chunks_to_draw[id] = {}

    -- SET UP DEFAULT PLAYER!
    game.players[id] = {
        inventory_slots = 1,
        active_inventory_slot = 1,
        inventory = {}
    }



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

function add_interactable(x,y,interactable_type)
    local id = new_entity()

    game.interactables[id] = {}
    game.interactables[id].functions = game.interactable_functions[interactable_type]
    game.interactables[id].active = true --setting to false will make the interact command ignore this object
    if game.interactables[id].functions then
        game.pos[id] = {x=x,y=y,vx=0,vy=0}

            -- execute object specific code, which is defined in interactables.lua
        game.interactables[id].functions.create(id)
    else
        print("Error creating interactable \""..interactable_type.."\", interactable type not recognized")
    end
end

