local g3d = require "g3d"

local player = {}

player.model = g3d.newModel("assets/sphere.obj", "assets/Player.png")
player.modelRotation = {x = 0, y = 0, z = 0}
player.position = {x = 0, y = 0, z = 0}
player.rotation = {x = 0, y = 0, z = 0}

local mY = 0

local cameraZoom = 1

function player.setRotation(nx, ny, nz) 
    player.model:setRotation(nx, ny, nz)
end

function player.setPosition(nx, ny, nz) 
    player.position = {x = nx, y = ny, z = nz}
end

function player.update(dt)
    player.rotation.z, mY = -love.mouse.getX() * 0.01, math.max(0, math.min((love.mouse.getY() - 200) * 0.05, 100)) * 0.1

    g3d.camera.lookAt(player.position.x + math.cos(player.rotation.z) * (mY + 10 * cameraZoom), 
    player.position.y + math.sin(player.rotation.z)  * (mY + 10 * cameraZoom),
     player.position.z + ((mY * 2) * cameraZoom * 3) + 5,
     player.position.x, player.position.y, player.position.z)
end

function player.draw()
    player.model:setTranslation(player.position.x, player.position.y, player.position.z)
    player.model:draw()
end


return player