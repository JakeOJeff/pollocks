local controller = require "controller"
local backpack = require "systems.backpack"
local miner = require "systems.miner"
local stars = require "systems.stars"
local location = require "systems.location"
local rocks = require "systems.rocks"

wW = love.graphics.getWidth()
wH = love.graphics.getHeight()

function love.load()
    controller:load()
    backpack:load()
    location:load()
    stars:load()
    rocks:load()
end
function love.update(dt)
    controller:update(dt)
    stars:update(dt, controller.x, controller.y)
end

function love.draw()
    stars:draw()
    love.graphics.print(backpack.inventory.."/"..backpack.packs[backpack.equipped].capacity)
    controller:draw()
    rocks:draw()
    love.graphics.push()
    love.graphics.translate(controller.x, controller.y)
    location:draw()
    love.graphics.pop()
end

function love.mousepressed(x, y, button)
    controller:mousepressed(x, y, button)
    
end