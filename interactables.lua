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

function get_free_slot(player_id)
    local free_slot_found = false
    local inventory_id = 1
    while (not free_slot_found and inventory_id <= game.players[player_id].inventory_slots) do
        if game.players[player_id].inventory[inventory_id] == nil then
            free_slot_found = true
        else
            inventory_id = inventory_id + 1 
        end
    end

    if free_slot_found then
        return inventory_id
    else
        return false
    end
end

function add_harvest_to_inventory(player_id, harvest_type_string)
    local harvest_type = game.harvest_types[harvest_type_string]

    local slot_found = false
    local item_id = nil
    local inventory_id = 1
    -- look for existing inventory item
    while (not slot_found and inventory_id <= game.players[player_id].inventory_slots) do
        print("checking for matching slot", inventory_id)
        item_id = game.players[player_id].inventory[inventory_id]
        local item_prop = game.item_properties[item_id]

        if item_prop and
            item_prop.harvest_type == harvest_type and
            item_prop.amount < item_prop.max_amount then
            --We have found a matching harvest item in the players inventory with room!

            slot_found = true

            -- increase amount!
            if item_prop.amount ~=nil then
                item_prop.amount = item_prop.amount + 1
            end
        else
            inventory_id = inventory_id + 1 
        end
    end

    -- If there is space, create a new one
    if slot_found == false then
        print("No MATCHING HARVEST SLOT FOUND")
        --find empty slot
        inventory_id = get_free_slot(player_id)
        print(inventory_id)
        if inventory_id then
            print("Empty slot FOUND")
            --create harvest item
            item_id = new_entity()
            game.item_properties[item_id] = {
                harvest_type = harvest_type,
                amount = 1,
                max_amount = harvest_type.max_amount --we might want to have diffrent amounts for diffrent crops
            }
            harvest_type.set_sprite(item_id) --set sprite to use in inventory.
            game.sprites[item_id].active = false

            slot_found = true
        end
    end

    if slot_found == true then
        print("SLOT found adding to inventory and removing entity!")
        --add to inventory
        game.players[player_id].inventory[inventory_id] = item_id
        --delete world entity
        return true
    else
        print("NO SLOT FOUND FOR HARVEST!")
        return false
    end
end

function consume_inventory_item(player_id)
    --used to count down usable inventory items, that will dissapear after a set number of uses.
    local item_id = get_current_inv_id(player_id)
    if item_id then
        game.item_properties[item_id].amount = game.item_properties[item_id].amount - 1

        if game.item_properties[item_id].amount <= 0 then
            -- remove from inventory and delete
            local slot = game.players[player_id].active_inventory_slot 
            game.players[player_id].inventory[slot] = nil
            kill_entity(item_id)
        end
    end
end

game.harvest_types = {
    sunflower_harvest = {
        set_sprite = function(id)
            set_sprite(id,"objects.png",2,3,0.2,1,32,32,-16,-24)
        end,
        max_amount = 10
    },
}

return {
    ball = {
        create = function(id,player_id)
            set_sprite(id,"objects.png",1,1,0.2,1,32,32,-16,-24)
        end,

        check_interact = function(id,player_id)
            return true
        end,
        
        interact = function(id,player_id)
            print("ball interact!" .. id)
            set_sprite(id,"objects.png",2,1,0.2,1,32,32,-16,-24)
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

        check_interact = function(id,player_id)
            local plant = game.plants[id]
            if plant.growth > 1 then
                return true
            end
        end,

        interact = function(id,player_id)
            -- check if self is ready to be harvested.
            local player = game.players[player_id]
            local plant = game.plants[id]
            if plant.growth > 1 then
                if add_harvest_to_inventory(player_id,"sunflower_harvest") then
                    -- set tile to be hole
                    kill_entity(id)
                end
            end
        end,
    },

    sunflower_seed = {
        create = function(id)
            game.item_properties[id] = {
                amount = 4
            }

            set_sprite(id,"objects.png",1,3,0.2,1,32,32,-16,-24)

            print("Sunflower seed CREATE")
        end,

        check_interact = function(id,player_id)
            return true
        end,

        interact = function(id,player_id)
            print("Sunflower SEED!" .. id)
            --check if player has room in inventory
            local player = game.players[player_id]

            local inventory_id = get_free_slot(player_id) 
            if inventory_id then
                    -- set the interactable world object to be unactive
                    game.sprites[id].active = false
                    game.interactables[id].active = false
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = id
            else 
                print("NO SLOTS FREE!")
            end
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
            local planted = false
            if tile ~= nil then
                local props = tileset.properties[tile]
                if props ~= nil then
                    for key,val in pairs(props) do
                        local px = game.pos[player_id].x
                        local py = game.pos[player_id].y
                        if key == 'plantable' and val == 'true' then
                            set_tile(px, py, layer, 63)
                            add_interactable(math.floor(px),math.floor(py),'sunflower')
                            planted = true
                        end
                    end
                end
            end

            if planted then
                consume_inventory_item(player_id)



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

        check_interact = function(id,player_id)
            return true
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

        check_interact = function(id,player_id)
            return true
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

        check_interact = function(id,player_id)
            return true
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

        check_interact = function(id,player_id)
            return true
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
                    local gui = game.players[player_id].gui
                    local active_item = gui.inventory[gui.active_slot]
                    local x,y = to_canvas_coord(game.pos[id].x,game.pos[id].y)
                    local bkg = load_resource("shop_gui.png","sprite")
                    local icon   = load_resource("shop_icons.png","sprite")
                    print(icon)
                    local grid = anim8.newGrid(32,32,icon:getWidth(),icon:getHeight())
                    local anim = anim8.newAnimation(grid(active_item.sprite.x,active_item.sprite.y),0.2)
                    love.graphics.push()
                    love.graphics.translate(x-48,y-110)
                    love.graphics.draw(bkg)
                    love.graphics.print(active_item.price,59+4,48)
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
                        price = 300,
                        sprite = {x=3,y=1},
                        name = "hoe_iron",
                    })
            game.players[player_id].gui = gui
            return true
        end
    },

    market = {
        create = function(id,player_id)
            set_sprite(id,"vending_machine.png",1,2,0.2,1,32,64,-16,-64+8)
        end,

        check_interact = function(id,player_id)
            return true
        end,
        
        interact = function(id,player_id)
            --set_sprite(id,"vending_machine.png","2-4",1,0.2,1,32,64,-16,-64+8)
            return true
        end
    },
}
