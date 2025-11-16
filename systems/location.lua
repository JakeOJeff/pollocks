local location = {}

function location:load()
    self.places = {
        {name = "shop", x = 100, y = 200}
    }
end


function location:draw()
    love.graphics.circle("fill", self.places[1].x, self.places[1].y, 10)
end

return location