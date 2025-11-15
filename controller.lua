local controller = {}


function controller:load()
    self.x = 0
    self.y = 0
    self.img = love.graphics.newImage("character.png")
    self.width = 50
    self.height = 50
    self.rotation = 0
    self.xVel = 0
    self.yVel = 0
    self.scaleX = self.width/self.img:getWidth()
    self.scaleY = self.height/self.img:getHeight()

    self.acceleration = 200
    self.friction = 300
end

function controller:update(dt)
    -- Movement
    if love.keyboard.isDown("w") then
        self.yVel = self.yVel - self.acceleration * dt
    elseif love.keyboard.isDown("s") then
        self.yVel = self.yVel + self.acceleration * dt
    else

        if self.yVel > 0 then
            self.yVel = math.max(0, self.yVel - self.friction * dt)
        elseif self.yVel < 0 then
            self.yVel = math.min(0, self.yVel + self.friction * dt)
        end
    end

    if love.keyboard.isDown("a") then
        self.rotation = self.rotation - 10 * dt
    elseif love.keyboard.isDown("d") then
        self.rotation = self.rotation + 10 * dt
    end

    self.y = self.y + self.yVel * dt
end

function controller:draw()
    love.graphics.draw(self.img, self.x, self.y, math.rad(self.rotation), self.scaleX, self.scaleY)
end

return controller