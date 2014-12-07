-- A file containing the functions to call when an object is being interacted with.

function drop_item(player_id)
    local player = game.players[player_id]
    local inv_id = get_current_inv_id(player_id)

    --move shovel item in worlds and unhide it.
    local x = game.pos[player_id].x 
    local y = game.pos[player_id].y

    game.pos[inv_id].x = x
    game.pos[inv_id].y = y

    game.sprites[inv_id].active = true
    game.interactables[inv_id].active = true

    --remove from inventory
    player.inventory[player.active_inventory_slot] = nil
end

return {
    ball = {
        create = function(id,player_id)
            set_sprite(id,"objects.png",1,1,0.2,1,32,32,-16,-24)
        end,
        
        interact = function(id,player_id)
            print("ball interact!" .. id)
            set_sprite(id,"objects.png",2,1,0.2,1,32,32,-16,-24)
            return true
        end
    },

    tree = {
        create = function(id)
            set_sprite(id,"tree.png",1,1,0.2,1,162,162,-162/2,-162+20)
        end,
    },

    sunflower = {
        create = function(id)
            set_sprite(id,"plants.png",1,1,0.8,1,32,64,-16,-64+8)
            game.plants[id] = {species="sunflower", growth=0.0, state=0}
        end,
    },

    sunflower_seed = {
        create = function(id)
            game.item_properties[id] = {
                uses_left = 10
            }
            set_sprite(id,"objects.png",1,3,0.2,1,32,32,-16,-24)

            print("Sunflower seed CREATE")
        end,

        interact = function(id,player_id)
            print("Sunflower SEED!" .. id)
            --check if player has room in inventory
            local player = game.players[player_id]

            local free_slot_found = false
            local inventory_id = 1
            while (not free_slot_found and inventory_id <= player.inventory_slots) do
                if player.inventory[inventory_id] == nil then
                    free_slot_found = true
                else
                    inventory_id = inventory_id + 1 
                end
            end

            if free_slot_found then
                    -- set the interactable world object to be unactive
                    game.sprites[id].active = false
                    game.interactables[id].active = false
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = id
            else 
                print("INGA SLOTS LEDIGA, sorry grabbar!")
            end
            return true
        end,

        drop = function(player_id)
            print("DROP sunflower seed!")
            drop_item(player_id)
        end,
        use = function(player_id)
            print("USE SUNFLOWERSEED!")

            local layer = game.map.layers['ground']
            local tile, tileset = get_tile_and_tileset(game.pos[player_id].x, game.pos[player_id].y, layer)
            print(tile)
            if tile ~= nil then
                local props = tileset.properties[tile]
                if props ~= nil then
                    for key,val in pairs(props) do
                        local px = game.pos[player_id].x
                        local py = game.pos[player_id].y
                        if key == 'plantable' and val == 'true' then
                            set_tile(px, py, layer, 63)
                            add_interactable(math.floor(px),math.floor(py),'sunflower')
                        end
                    end
                end
            end
        end,
    },
    shovel_dev = {
        create = function(id,player_id)
            game.item_properties[id] = {
                uses_left = 10 --example
            }
            set_sprite(id,"objects.png",1,2,0.2,1,32,32,-16,-24)

            print("SHOVEL CREATE")
        end,
        
        interact = function(id,player_id)
            print("SHOVEL interact!" .. id)
            --check if player has room in inventory
            local player = game.players[player_id]

            local free_slot_found = false
            local inventory_id = 1
            while (not free_slot_found and inventory_id <= player.inventory_slots) do
                if player.inventory[inventory_id] == nil then
                    free_slot_found = true
                else
                    inventory_id = inventory_id + 1 
                end
            end

            if free_slot_found then
                    -- set the interactable world object to be unactive
                    game.sprites[id].active = false
                    game.interactables[id].active = false
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = id
            else 
                print("INGA SLOTS LEDIGA")
            end
            return true
        end,

        use = function(player_id)
            print("USE SHOVEL!")

            local layer = game.map.layers['ground']
            local tile, tileset = get_tile_and_tileset(game.pos[player_id].x, game.pos[player_id].y, layer)
            print(tile)
            if tile ~= nil then
                local props = tileset.properties[tile]
                if props ~= nil then
                    for key,val in pairs(props) do
                        local px = game.pos[player_id].x
                        local py = game.pos[player_id].y
                        if key == 'digable' and val == 'true' then
                            set_tile(px, py, layer, 64)
                        end
                        if key == 'hoeable' and val == 'true' then
                            set_tile(px, py, layer, 62)
                        end
                        if key == 'plantable' and val == 'true' then
                            set_tile(px, py, layer, 63)
                            add_interactable(math.floor(px),math.floor(py),'sunflower')
                        end
                    end
                end
            end
        end,


        drop = function(player_id)
            print("DROP SHOVeL!")
            drop_item(player_id)
        end,

    },

    shovel_iron = {
        create = function(id,player_id)
            game.item_properties[id] = {
                uses_left = 10 --example
            }
            set_sprite(id,"objects.png",2,2,0.2,1,32,32,-16,-24)

            print("SHOVEL CREATE")
        end,
        
        interact = function(id,player_id)
            print("SHOVEL interact!" .. id)
            --check if player has room in inventory
            local player = game.players[player_id]

            local free_slot_found = false
            local inventory_id = 1
            while (not free_slot_found and inventory_id <= player.inventory_slots) do
                if player.inventory[inventory_id] == nil then
                    free_slot_found = true
                else
                    inventory_id = inventory_id + 1 
                end
            end

            if free_slot_found then
                    -- set the interactable world object to be unactive
                    game.sprites[id].active = false
                    game.interactables[id].active = false
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = id
            else 
                --no slots
            end
            return true
        end,

        use = function(player_id)
            print("USE SHOVEL!")

            local layer = game.map.layers['ground']
            local tile, tileset = get_tile_and_tileset(game.pos[player_id].x, game.pos[player_id].y, layer)
            print(tile)
            if tile ~= nil then
                local props = tileset.properties[tile]
                if props ~= nil then
                    for key,val in pairs(props) do
                        local px = game.pos[player_id].x
                        local py = game.pos[player_id].y
                        if key == 'digable' and val == 'true' then
                            set_tile(px, py, layer, 64)
                        end
                    end
                end
            end
        end,

        drop = function(player_id)
            print("DROP SHOVeL!")
            drop_item(player_id)
        end,
    },

    hoe_iron = {
        create = function(id,player_id)
            game.item_properties[id] = {
                uses_left = 10 --example
            }
            set_sprite(id,"objects.png",3,2,0.2,1,32,32,-16,-24)

            print("HOE CREATE")
        end,
        
        interact = function(id,player_id)
            print("HOE interact!" .. id)
            --check if player has room in inventory
            local player = game.players[player_id]

            local free_slot_found = false
            local inventory_id = 1
            while (not free_slot_found and inventory_id <= player.inventory_slots) do
                if player.inventory[inventory_id] == nil then
                    free_slot_found = true
                else
                    inventory_id = inventory_id + 1 
                end
            end

            if free_slot_found then
                    -- set the interactable world object to be unactive
                    game.sprites[id].active = false
                    game.interactables[id].active = false
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = id
            else 
                --no slots
            end
            return true
        end,

        use = function(player_id)
            print("USE HOE!")

            local layer = game.map.layers['ground']
            local tile, tileset = get_tile_and_tileset(game.pos[player_id].x, game.pos[player_id].y, layer)
            print(tile)
            if tile ~= nil then
                local props = tileset.properties[tile]
                if props ~= nil then
                    for key,val in pairs(props) do
                        local px = game.pos[player_id].x
                        local py = game.pos[player_id].y
                        if key == 'hoeable' and val == 'true' then
                            set_tile(px, py, layer, 62)
                        end
                    end
                end
            end
        end,

        drop = function(player_id)
            print("DROP HOE!")
            drop_item(player_id)
        end,

    },

    shop = {
        create = function(id,player_id)
            set_sprite(id,"vending_machine.png",1,1,0.2,1,32,64,-16,-64+8)
        end,
        
        interact = function(id,player_id)
            set_sprite(id,"vending_machine.png","2-4",1,0.2,1,32,64,-16,-64+8)
            local gui = {
                update = function(dt,player_id)
                end,
                keyreleased = function(key,player_id)
                    if key == game.keys[player_id].down then
                        game.players[player_id].gui = nil
                        set_sprite(id,"vending_machine.png",1,1,0.2,1,32,64,-16,-64+8)
                    end
                    if key == game.keys[player_id].up then
                        local gui = game.players[player_id].gui
                        add_interactable(game.pos[id].x+1.5,game.pos[id].y,gui.inventory[gui.active_slot].name)
                    end
                    if key == game.keys[player_id].left then
                        local gui = game.players[player_id].gui
                        gui.active_slot = gui.active_slot - 1
                        if gui.active_slot < 1 then
                            gui.active_slot = #gui.inventory
                        end
                    end
                    if key == game.keys[player_id].right then
                        local gui = game.players[player_id].gui
                        gui.active_slot = gui.active_slot + 1
                        if gui.active_slot > #gui.inventory then
                            gui.active_slot = 1
                        end
                    end
                end,
                draw = function(player_id)
                    print(game.players[player_id].gui.active_slot)
                    local active_item = game.players[player_id].gui.inventory[game.players[player_id].gui.active_slot]
                    local x,y = to_canvas_coord(game.pos[id].x,game.pos[id].y)
                    local bkg = load_resource("shop_gui.png","sprite")
                    local icon   = load_resource("shop_icons.png","sprite")
                    print(icon)
                    local grid = anim8.newGrid(32,32,icon:getWidth(),icon:getHeight())
                    local anim = anim8.newAnimation(grid(active_item.sprite.x,active_item.sprite.y),0.2)
                    love.graphics.push()
                    love.graphics.translate(x-48,y-110)
                    love.graphics.draw(bkg)
                    anim:draw(icon,10,10)
                    love.graphics.pop()
                end,
                active_slot = 1,
                inventory = {
                },
            }
            table.insert(gui.inventory, {
                        price = 130,
                        sprite = {x=1,y=1},
                        name = "sunflower_seed",
                    })
            table.insert(gui.inventory, {
                        price = 200,
                        sprite = {x=2,y=1},
                        name = "shovel_iron",
                    })
            table.insert(gui.inventory, {
                        price = 200,
                        sprite = {x=3,y=1},
                        name = "hoe_iron",
                    })
            game.players[player_id].gui = gui
            return true
        end
    }
}
