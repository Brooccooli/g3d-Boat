-- written by groverbuger for g3d
-- september 2021
-- MIT license

local g3d = require "g3d"
local ocean = require "Ocean"

local background = g3d.newModel("assets/sphere.obj", "assets/Sky.png", nil, nil, 500)

local timer = 0

local pos = { x = 0, y = 0 }
local speed = 0.005
local maxSpeed = 1.5
local velocity = 0

-- Settings
local fullscreen = false
local funcs = require "Function"
local oldFKey = love.keyboard.isDown('f')

function love.load()
    love.window.setMode(800, 600, { depth = 1, minwidth = 800, minheight = 600, resizable = true })
    love.mouse.setRelativeMode(true)
    love.mouse.setGrabbed(true)

    g3d.camera.position[3] = 1000
end

function love.update(dt)
    funcs.resetDebug()

    if love.keyboard.isDown('lctrl') then
        g3d.camera.firstPersonMovement(dt)
        return
    end

    timer = timer + dt

    ocean.Update(dt)

    if love.keyboard.isDown('f') and not oldFKey then
        if fullscreen then fullscreen = false else fullscreen = true end
        love.window.setFullscreen(fullscreen)
    end

    if love.keyboard.isDown('w') and velocity < maxSpeed then
         velocity = velocity + speed 
    elseif velocity > 0 then
        velocity = velocity - (speed / 2)
    else
        velocity = 0
    end

    funcs.debugString("Velocity: " ..  (1.5 - (velocity)))

    pos.x = pos.x + velocity

    if love.keyboard.isDown "escape" then
        love.event.push "quit"
    end


    oldFKey = love.keyboard.isDown('f')
end

function love.draw()
    --ocean.draw(offsetX, offsetY, zoom, timer)
    ocean.draw(pos.x + timer, pos.y, velocity, timer)
    --background:draw()

    funcs.DebugWrite()
end


function love.mousemoved(x, y, dx, dy)
    g3d.camera.firstPersonLook(dx, dy)

    --mouse.x, mouse.y = mouse.x - dx, mouse.y - dy
    --uncs.debugString("MOVED")
end

