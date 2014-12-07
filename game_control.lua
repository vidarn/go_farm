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
    for id, interactable in pairs(game.interactables) do
        --check that object is close
        local dx = game.pos[id].x-game.pos[player_id].x
        local dy = game.pos[id].y-game.pos[player_id].y
        dx, dy = to_canvas_coord(dx,dy)
        local distance = math.pow(dx,2) + math.pow(dy,2)
        print("interact distance"..distance)
        print("id",id,"active:",interactable.active)
        if interactable.active and (  distance < use_range ) then
            -- run function for interactable
            if interactable.functions.interact ~= nil then
                if interactable.functions.interact(id,player_id) == true then
                    interacted = true
                end
            end
        end 
    end
    if not interacted then
        local inv = game.players[player_id].inventory[game.players[player_id].active_inventory_slot]
        if inv ~= nil then
            local interactable = game.interactables[inv]
            if interactable.functions.use ~= nil then
                interactable.functions.use(player_id)
            end
        end
    end
end

function update_player(dt,id)
    local accel = 600.0

    if love.keyboard.isDown(game.keys[id].left) then
        game.pos[id].vx = game.pos[id].vx - accel*dt
        game.pos[id].vy = game.pos[id].vy + accel*dt
        game.direction[id] = -1
    end
    if love.keyboard.isDown(game.keys[id].right) then
        game.pos[id].vx = game.pos[id].vx + accel*dt
        game.pos[id].vy = game.pos[id].vy - accel*dt
        game.direction[id] = 1
    end
    if love.keyboard.isDown(game.keys[id].up) then
        game.pos[id].vx = game.pos[id].vx - accel*dt
        game.pos[id].vy = game.pos[id].vy - accel*dt
    end
    if love.keyboard.isDown(game.keys[id].down) then
        game.pos[id].vx = game.pos[id].vx + accel*dt
        game.pos[id].vy = game.pos[id].vy + accel*dt
    end
end

function update_plants(dt)
    for id,plant in pairs(game.plants) do
        if plant.species == 'sunflower' then
            plant.growth = plant.growth + dt
            if plant.growth > 3.0 and plant.state < 1 then
                set_sprite(id,"plants.png",2,1,0.8,1,32,64,-16,-64+8)
                plant.state = 1
            end
            if plant.growth > 7.0 and plant.state < 2 then
                set_sprite(id,"plants.png",3,1,0.8,1,32,64,-16,-64+8)
                plant.state = 2
            end
            if plant.growth > 12.0 and plant.state < 3 then
                set_sprite(id,"plants.png",4,1,0.8,1,32,64,-16,-64+8)
                plant.state = 3
            end
        end
    end
end

