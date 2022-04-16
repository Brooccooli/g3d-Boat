local funcs = {}

function funcs.getNoiseOctave(x, y, offsetX, offsetY, zoom, timer)
    local Z = love.math.noise((x + offsetX) * zoom, (y + offsetY) * zoom, timer * 2)
    tempZoom = zoom * 2
    Z = Z + (love.math.noise((x + offsetX) * tempZoom, (y + offsetY) * tempZoom, timer * 2) * 0.5)
    tempZoom = zoom * 4
    Z = Z + (love.math.noise((x + offsetX) * tempZoom, (y + offsetY) * tempZoom, timer * 2) * 0.25)

    return Z
end

function funcs.getNoiseLayered(x, y, offsetX, offsetY, zoom, timer)
    local Z = love.math.noise((x + offsetX) * zoom, (y + offsetY) * zoom)
    Z = Z + love.math.noise((x + offsetX) * zoom + 50, (y + offsetY) * zoom + 50)
    Z = Z + love.math.noise((x + offsetX) * zoom + 100, (y + offsetY) * zoom + 100)

    return Z
end

return funcs