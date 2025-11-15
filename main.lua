local controller = require "controller"

wW = love.graphics.getWidth()
wH = love.graphics.getHeight()

function love.load()
    controller:load()
end
function love.update(dt)
    controller:update(dt)
end

function love.draw()
    controller:draw()
end