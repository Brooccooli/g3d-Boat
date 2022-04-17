local g3d = require "g3d"
local funcs = require "Function"

local player = {}

local scale = 1

player.model = g3d.newModel("assets/sphere.obj", "assets/Player.png", nil, nil, scale)
player.sword = g3d.newModel("assets/sphere.obj", "assets/Metal.png")
player.sword:setScale(0.1 * scale, 0.1 * scale, 1 * scale)
player.swordHandle = g3d.newModel("assets/sphere.obj", "assets/wood.png")
player.swordHandle:setScale(0.2  * scale, 0.2 * scale, 0.4 * scale )

player.modelRotation = {x = 0, y = 0, z = 0}
player.position = {x = 0, y = 0, z = 0}
player.rotation = {x = 0, y = 0, z = 0}

mouse = {x = 0, y = 0}

local mY = 0

local cameraZoom = 1

function player.setRotation(nx, ny, nz) 
    player.model:setRotation(nx, ny, nz)
end

function player.setPosition(nx, ny, nz) 
    player.position = {x = nx, y = ny, z = nz}
end

function player.moveTo(nx, ny, nz, force)
    if player.position.x ~= nx then player.position.x = player.position.x + (( nx - player.position.x) * force) end
    if player.position.y ~= ny then player.position.y = player.position.y + (( ny - player.position.y) * force) end
    if player.position.z ~= nz then player.position.z = player.position.z + (( nz -player.position.z) * force) end
end

function player.update(dt)
    player.rotation.z, mY = -love.mouse.getX() * 0.01, math.max(0, math.min((love.mouse.getY() - 200) * 0.05, 100)) * 0.1

    --[[g3d.camera.lookAt(player.position.x + math.cos(player.rotation.z) * (mY + 10 * cameraZoom), 
    player.position.y + math.sin(player.rotation.z)  * (mY + 10 * cameraZoom),
     player.position.z + ((mY * 2) * cameraZoom * 3) + 5,
     player.position.x , player.position.y, player.position.z)]]--
end



function player.draw()
    local direction, pitch = g3d.camera.getDirectionPitch()


    g3d.camera.lookInDirection(player.position.x, player.position.y, player.position.z, mouse.x * 0.01, mouse.y * 0.01)
    player.model:setTranslation(player.position.x, player.position.y, player.position.z)
    --player.model:draw()
    player.sword:setTranslation(player.position.x + math.cos(direction + 1), player.position.y + math.sin(direction + 1), player.position.z)
    player.sword:setRotation(0, 20, direction)
    player.sword:draw()
    player.swordHandle:setTranslation(player.position.x + math.cos(direction + 1.2), player.position.y + math.sin(direction + 1.2), player.position.z)
    player.swordHandle:setRotation(0, 20, 0 + direction)
    love.graphics.setColor(0.8, 0.8, 0.8)
    player.swordHandle:draw()
    love.graphics.setColor(1, 1, 1)
end


return player