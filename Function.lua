local funcs = {}

local debugStr = ""

function funcs.getNoiseOctave(x, y, offsetX, offsetY, zoom, timer)
    local Z = love.math.noise((x + offsetX) * zoom, (y + offsetY) * zoom, timer * 2)
    tempZoom = zoom * 0.8
    Z = Z + (love.math.noise((x + offsetX) * tempZoom, (y + offsetY) * tempZoom, timer * 2) * 2)
    tempZoom = zoom * 0.4
    Z = Z + (love.math.noise((x + offsetX) * tempZoom, (y + offsetY) * tempZoom, timer * 2) * 1.5)

    return Z
end

function funcs.getNoiseLayered(x, y, offsetX, offsetY, zoom, timer)
    local Z = love.math.noise((x + offsetX) * zoom + timer, (y + offsetY) * zoom  + timer, timer)
    Z = Z + love.math.noise((x + offsetX) * zoom + 50  + timer, (y + offsetY) * zoom + 50  + timer, timer + 50)
    Z = Z + love.math.noise((x + offsetX) * zoom + 100  + timer, (y + offsetY) * zoom + 100  + timer, timer + 100)

    return Z
end

function funcs.resetDebug()
    debugStr = ""
end

function funcs.debugString(str)
    debugStr = debugStr .. "\n " .. str
end

function funcs.DebugWrite()
    love.filesystem.setIdentity( "Debug")
    success, message = love.filesystem.write( "Debug.txt", debugStr)
end


return funcs