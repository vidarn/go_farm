-- A file containing the functions to call when an object is being interacted with.
return {
    ball = {
        create = function(id,player_id)
            set_sprite(id,"objects.png",1,1,0.2,1,32,32,-16,-24)
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
        interact = function(id)
        end
    },

    sunflower = {
        create = function(id)
            set_sprite(id,"plants.png",'1-4',1,0.8,1,32,64,-16,-64+4)
        end,
        interact = function(id)
        end
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
                    
                    -- make inventory item          --NOTE(What to do here??)
                    local item_id = new_entity()
                    game.inventory[item_id] = id --use this stored id to get the original item
                    
                    -- add to player slot
                    game.players[player_id].inventory[inventory_id] = item_id
            else 
                print("NO SLOTS FREEEE")
            end
        end
    },

    plant = {}
}
