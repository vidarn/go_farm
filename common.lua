function sign(x)
  return (x<0 and -1) or 1
end

function get_current_inv_id(player_id) 
    local active_slot = game.players[player_id].active_inventory_slot
    return game.players[player_id].inventory[active_slot]
end

function get_tile_and_tileset(x,y,layer)
    x = math.floor(x)
    y = math.floor(y)
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
            return tile,tileset
        end
    else
        return nil, nil
    end
end

function set_tile(x,y,layer,tile)
    x = math.floor(x)
    y = math.floor(y)
    layer.data[x+(y-1)*layer.width] = tile+1
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

function get_current_chunk(player_id)
    local player_tile_x, player_tile_y = game.pos[player_id].x, game.pos[player_id].y
    local x = math.floor((player_tile_x-1)/game.chunksize)
    local y = math.floor((player_tile_y-1)/game.chunksize)
    return x,y
end

