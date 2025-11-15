local controller = {}


function controller:load()
    self.x = 0
    self.y = 0
    self.img = love.graphics.newImage("character.png")
    self.width = 100
    self.height = 100
    self.scaleX = self.width/self.img:getWidth()
    self.scaleY = self.height/self.img:getHeight()
end

function controller:draw()
    love.graphics.draw(self.img, self.x, self.y, 0, self.scaleX, self.scaleY)
end

return controller