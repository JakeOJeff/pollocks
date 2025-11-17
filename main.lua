local controller = require "controller"
local backpack = require "systems.backpack"
local stars = require "systems.stars"
local location = require "systems.location"

wW = love.graphics.getWidth()
wH = love.graphics.getHeight()

function love.load()
    controller:load()
    backpack:load()
    location:load()
    stars:load()
end
function love.update(dt)
    controller:update(dt)
    stars:update(dt, controller.x, controller.y)
end

function love.draw()
    stars:draw()
    love.graphics.print(backpack.inventory.."/"..backpack.packs[backpack.equipped].capacity)
    controller:draw()
    love.graphics.push()
    love.graphics.translate(controller.x, controller.y)
    location:draw()
    love.graphics.pop()
end

function love.mousepressed(x, y, button)
    controller:mousepressed(x, y, button)
    
end