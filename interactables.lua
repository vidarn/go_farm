-- A file containing the functions to call when an object is being interacted with.
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
    shovel_iron = {
        create = function(id,player_id)
            game.item_properties[id] = {
                uses_left = 10 --example
            }
            set_sprite(id,"objects.png",3,1,0.2,1,32,32,-16,-24)

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
                print("INGA SLOTS LEDIGA, sorry grabbar!")
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

        end,

    },

    plant = {}
}
