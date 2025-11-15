local controller = require "controller"

function love.load()
    controller:load()
end
function love.update(dt)
    controller:update(dt)
end

function love.draw()
    controller:draw()
end