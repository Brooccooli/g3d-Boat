-- written by groverbuger for g3d
-- september 2021
-- MIT license

local g3d = require "g3d"
local ocean = require "Ocean"

local background = g3d.newModel("assets/sphere.obj", "assets/Sky.png", nil, nil, 500)

local timer = 0

local zoom = 0.01
local pos = {x = 0, y = 0}
local speed = 1

-- Settings
local fullscreen = false
local oldFKey = love.keyboard.isDown('f')

function love.load()
    love.window.setMode(800, 600, {depth=1, minwidth=800, minheight=600, resizable=true})
    love.mouse.setRelativeMode(true)
    love.mouse.setGrabbed(true)
end

function love.update(dt)
    timer = timer + dt

    ocean.Update(dt)

    if love.keyboard.isDown('f') and not oldFKey then
        if fullscreen then fullscreen = false else fullscreen = true end
        love.window.setFullscreen(fullscreen)
    end

    if love.keyboard.isDown('w') then pos.x = pos.x + speed end

    --g3d.camera.firstPersonMovement(dt)
    if love.keyboard.isDown "escape" then
        love.event.push "quit"
    end

    
    oldFKey = love.keyboard.isDown('f')
end

function love.draw()
    --ocean.draw(offsetX, offsetY, zoom, timer)
    ocean.draw(pos.x + timer, pos.y, zoom, timer)
    background:draw()
end

function love.mousemoved(x,y, dx,dy)
    --g3d.camera.firstPersonLook(dx,dy)
end
