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
end

function controller:update(dt)
    self.y = self.y + self.yVel
    self.yVel = self.yVel - 5 * dt
    if love.keyboard.isDown("s") then
        self.yVel = self.yVel - 20 * dt
    elseif love.graphics.isDown("w") then
        self.yVel = self.yVel + 20 * dt
    end
    if love.graphics.isDown("a") then
        self.rotation = self.rotation - 10 * dt
    elseif love.graphics.isDown("d") then
        self.rotation = self.rotation + 10 * dt
    end
end

function controller:draw()
    love.graphics.draw(self.img, self.x, self.y, self.rotation, self.scaleX, self.scaleY)
end

return controller