Camera = require "libs.camera"

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
    camera = Camera(controller.x, controller.y)
end
function love.update(dt)
    controller:update(dt)
    local dx, dy = controller.x - camera.x, controller.y - camera.y
    camera:move(dx/2, dy/2)
    if love.mouse.isDown(1) then
        rocks:destroy()
    end
    stars:update(dt, controller.x, controller.y)
end

function love.draw()
    camera:attach()
    stars:draw()
    rocks:draw()
    location:draw()
        controller:draw()

    camera:detach()

        -- love.graphics.print(backpack.inventory.."/"..backpack.packs[backpack.equipped].capacity)

end

function love.mousepressed(x, y, button)
    controller:mousepressed(x, y, button)
    
end