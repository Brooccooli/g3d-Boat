local g3d = require "g3d"
local funcs = require "Function"
local player = require "player"

local water = g3d.newModel("assets/cube.obj", "assets/Water.png")
local boat = g3d.newModel("assets/cube.obj", "assets/wood.png")
boat:setScale(3, 2, 1)

local floorHeightDifference = 3

local OCEAN_SIZE = {x = 150, y = 40}

local Ocean = {}

function Ocean.Update(dt)
    player.update(dt)
end

function Ocean.draw(offsetX, offsetY, zoom, timer)
    player.setRotation(0, 0, 90)

    for x = OCEAN_SIZE.x, 1, -1 do
        for y = OCEAN_SIZE.y, 1, -1 do
            local z = funcs.getNoiseLayered(x, y, offsetX, offsetY, zoom, timer)
            water:setTranslation((x * 2) - OCEAN_SIZE.x, (y * 2) - OCEAN_SIZE.y, (z * floorHeightDifference) - 50)

            local light = 1 - (1 - z * 0.5)
            love.graphics.setColor(light, light, light)
            water:draw()
            love.graphics.setColor(1, 1, 1)

            if x == OCEAN_SIZE.x / 2 and y == OCEAN_SIZE.y / 2 then
                boat:setTranslation((x * 2) - OCEAN_SIZE.x, (y * 2) - OCEAN_SIZE.y, (z * floorHeightDifference) - 49)
                player.setPosition((x * 2) - OCEAN_SIZE.x, (y * 2) - OCEAN_SIZE.y, (z * floorHeightDifference) - 47)
                boat:draw()
            end 
        end
    end

    player.draw()
end

return Ocean