function handle_collision(id, other, cols)
    if game.players[id] then
        if game.coins[other] then
            kill_entity(other)
        end
    end
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
                            for key,val in pairs(properties) do
                                if key == "interactable_type" then
                                    add_interactable(x,y,val)
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

function interact(player_id)
    local use_range= math.pow(18,2)
    local interacted = false
    if game.players[player_id].available_interactable then
        local id = game.players[player_id].available_interactable
        local interactable = game.interactables[id]
        if not interacted then
            interactable.functions.interact(id,player_id)
        end
        interacted = true
    end
    if not interacted then
        local inv = game.players[player_id].inventory[game.players[player_id].active_inventory_slot]
        if inv ~= nil then
            local interactable = game.interactables[inv]
            if interactable ~= nil and interactable.functions ~= nil and interactable.functions.use ~= nil then
                interactable.functions.use(player_id)
            end
        end
    end
end

function update_player(dt,id)
    local accel = 600.0
    local walking = false
    local player_num = 1
    if game.player_ids[2] == id then player_num=2 end

    if game.players[id].gui == nil then

        if love.keyboard.isDown(game.keys[id].left) then
            game.pos[id].vx = game.pos[id].vx - accel*dt
            game.pos[id].vy = game.pos[id].vy + accel*dt
            game.direction[id] = -1
            walking = true
        end
        if love.keyboard.isDown(game.keys[id].right) then
            game.pos[id].vx = game.pos[id].vx + accel*dt
            game.pos[id].vy = game.pos[id].vy - accel*dt
            game.direction[id] = 1
            walking = true
        end
        if love.keyboard.isDown(game.keys[id].up) then
            game.pos[id].vx = game.pos[id].vx - accel*dt
            game.pos[id].vy = game.pos[id].vy - accel*dt
            walking = true
        end
        if love.keyboard.isDown(game.keys[id].down) then
            game.pos[id].vx = game.pos[id].vx + accel*dt
            game.pos[id].vy = game.pos[id].vy + accel*dt
            walking = true
        end
    else
        game.players[id].gui.update(dt,id)
    end

    if walking ~= game.players[id].walking then
        local w = 0.5
        local h = 0.5
        local center_x = 0.5
        local center_y = 1.0
        local sprite_w = 32
        local sprite_h = 64
        local t_w, t_h = to_canvas_coord(w,h)
        local offset_x = (-sprite_w)*center_x
        local offset_y = (-sprite_h)*center_y
        if walking == true then
            set_sprite(id,"player_walk.png","1-10",player_num,0.1,1,sprite_w,sprite_h,offset_x, offset_y)
        else
            set_sprite(id,"player.png",1,player_num,0.2,game.direction[id],sprite_w,sprite_h,offset_x, offset_y)
        end
        game.players[id].walking = walking
    end

    -- check interactables within range
    local closest = nil
    local closest_dist = math.pow(18,2)
    for i_id, interactable in pairs(game.interactables) do
        --check that the object is on the same chunk as the player
        local chunk_player_x, chunk_player_y = get_current_chunk(id)
        local chunk_this_x, chunk_this_y = get_current_chunk(i_id)
        if chunk_player_x == chunk_this_x and chunk_player_y == chunk_this_y then
            --check that object is close
            local dx = game.pos[i_id].x-game.pos[id].x
            local dy = game.pos[i_id].y-game.pos[id].y
            dx, dy = to_canvas_coord(dx,dy)
            local distance = math.pow(dx,2) + math.pow(dy,2)
            if interactable.active and (  distance < closest_dist ) then
                if interactable.functions.interact ~= nil and interactable.functions.check_interact ~= nil then
                    if interactable.functions.check_interact(i_id,id) == true then
                        closest = i_id
                        closest_dist = distance
                    end
                end
            end 
        end
    end

    if game.players[id].available_interactable ~= closest then
        local hl_sprite = load_resource("hilight_interactable.png","sprite")
        game.players[id].hl_sprite = hl_sprite
        local hl_grid = anim8.newGrid(42,32,hl_sprite:getWidth(),hl_sprite:getHeight())
        game.players[id].hl_grid = hl_grid
        game.players[id].hl_anim = anim8.newAnimation(hl_grid("4-1",player_num),0.05,'pauseAtEnd')
    end

    game.players[id].available_interactable = closest

    if game.players[id].available_interactable ~= nil then
        game.players[id].hl_anim:update(dt)
    end
end

function update_plants(dt)
    --growth is set so that
    -- diffrent growing stages between 0 and 1
    -- at 1 the plant is fully grown.
    -- at 2 it is decomposing
    for id,plant in pairs(game.plants) do
        if plant.species == 'sunflower' then
            local growth_rate = 0.5 --percent per second
            if plant.growth > 0.3 and plant.state < 0.7 then
                set_sprite(id,"plants.png",2,1,0.8,1,32,64,-16,-64+8)
                plant.state = 1
            end
            if plant.growth > 0.7 and plant.state <= 1.0 then
                set_sprite(id,"plants.png",3,1,0.8,1,32,64,-16,-64+8)
                plant.state = 2
            end
            if plant.growth > 1.0 and plant.state <= 2 then
                set_sprite(id,"plants.png",4,1,0.8,1,32,64,-16,-64+8)
                plant.state = 3
            end
            plant.growth = plant.growth + dt*growth_rate
        end
        if plant.species == 'maize' then
            local growth_rate = 0.5 --percent per second
            if plant.growth > 0.3 and plant.state < 0.7 then
                set_sprite(id,"plants.png",6,1,0.8,1,32,64,-16,-64+8)
                plant.state = 1
            end
            if plant.growth > 0.7 and plant.state <= 1.0 then
                set_sprite(id,"plants.png",7,1,0.8,1,32,64,-16,-64+8)
                plant.state = 2
            end
            if plant.growth > 1.0 and plant.state <= 2 then
                set_sprite(id,"plants.png",8,1,0.8,1,32,64,-16,-64+8)
                plant.state = 3
            end
            plant.growth = plant.growth + dt*growth_rate
        end
        if plant.species == 'berry_bush' then
            local growth_rate = 0.2 --percent per second
            if plant.growth > 0.3 and plant.state < 0.7 then
                set_sprite(id,"plants.png",2,3,0.8,1,32,32,-16,-32+8)
                plant.state = 1
            end
            if plant.growth > 0.7 and plant.state < 1.0 then
                set_sprite(id,"plants.png",3,3,0.8,1,32,32,-16,-32+8)
                plant.state = 2
            end
            if plant.growth > 1.0 and plant.state < 2 then
                set_sprite(id,"plants.png",4,3,0.8,1,32,32,-16,-32+8)
                plant.state = 3
            end
            plant.growth = plant.growth + dt*growth_rate
        end
        if plant.species == 'carrot' then
            local growth_rate = 0.2 --percent per second
            if plant.growth > 0.3 and plant.state < 0.7 then
                set_sprite(id,"plants.png",6,3,0.8,1,32,32,-16,-32+8)
                plant.state = 1
            end
            if plant.growth > 0.7 and plant.state < 1.0 then
                set_sprite(id,"plants.png",7,3,0.8,1,32,32,-16,-32+8)
                plant.state = 2
            end
            if plant.growth > 1.0 and plant.state < 2 then
                set_sprite(id,"plants.png",8,3,0.8,1,32,32,-16,-32+8)
                plant.state = 3
            end
            plant.growth = plant.growth + dt*growth_rate
        end
    end
end
