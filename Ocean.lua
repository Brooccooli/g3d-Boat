local g3d = require "g3d"
local funcs = require "Function"
local player = require "player"

local myShader = love.graphics.newShader(g3d.shaderpath, "test.vert")

local waterScale = 4
local zoom = 0.01

local water = g3d.newModel("assets/cube.obj", "assets/Water.png", nil, nil, 1 * waterScale)
local darkWater = g3d.newModel("assets/cube.obj", "assets/Water2.png", nil, nil, 1 * waterScale)
local boat = g3d.newModel("assets/cube.obj", "assets/wood.png")
boat:setScale(3, 2, 1)

local floorHeightDifference = 100 * waterScale

local OCEAN_SIZE = {x = 90, y = 110}

local Ocean = {}

function Ocean.Update(dt)
    player.update(dt)
end

function Ocean.draw(offsetX, offsetY, velocity, timer)
    player.setRotation(0, 0, 90)

    for x = OCEAN_SIZE.x, 1, -1 do
        for y = OCEAN_SIZE.y, 1, -1 do
            local z = funcs.getNoiseOctave(x, y, offsetX, offsetY, zoom, timer * 0.1)
            
            local newPos = {x = (x * (2 * waterScale)) - OCEAN_SIZE.x * waterScale, y = (y * (2 * waterScale)) - OCEAN_SIZE.y * waterScale, z = z * floorHeightDifference}
            local light = 1 - (1 - z * 0.5)
            love.graphics.setColor(light, light, light)

            if (math.floor(z * 8) % 2) == 0 then
                darkWater:setTranslation(newPos.x, newPos.y, newPos.z - 50)
                darkWater:draw()
            else
                water:setTranslation(newPos.x, newPos.y, newPos.z - 50)
                water:draw()
            end
            love.graphics.setColor(1, 1, 1)

            if x == OCEAN_SIZE.x / 2 and y == OCEAN_SIZE.y / 2 then
                if player.position.z < newPos.z - 47 + (0.8 * waterScale) then 
                    player.setPosition(newPos.x, newPos.y, newPos.z - 47 +  (0.8 * waterScale))
                else
                    player.moveTo(newPos.x, newPos.y, newPos.z - 47 +  (0.8 * waterScale), (1.55 - (velocity)))
                end
                
                boat:setTranslation(player.position.x, player.position.y, player.position.z - 2)
                
            end 
        end
    end
    player.draw()
    boat:draw()

end

return Ocean