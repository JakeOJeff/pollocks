local stars = {}


function stars:load()
    self.sets = {}
    for i = 1, 200 do
        table.insert(self.sets, {
            x = love.math.random(0, wW),
            y = love.math.random(0, wH),
            size = love.math.random(0, 3)
        })
    end
end


function stars:draw()
    for i, v in ipairs(self.sets) do
        love.graphics.circle("fill",v.x, v.y, v.size)
    end
end

return stars