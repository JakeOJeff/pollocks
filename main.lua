local controller = require "controller"
local backpack = require "systems.backpack"
local stars = require "systems.stars"

wW = love.graphics.getWidth()
wH = love.graphics.getHeight()

function love.load()
    controller:load()
    backpack:load()
    stars:load()
end
function love.update(dt)
    controller:update(dt)
end

function love.draw()
    stars:draw()
    love.graphics.print(backpack.inventory.."/"..backpack.packs[backpack.equipped].capacity)
    controller:draw()
end