local stars = {}


function stars:load()
    self.sets = {}
    for i = 1, 200 do
        table.insert(self.sets, {
            x = math.random(0, wW),
            y = math.random(0, wH),
            size = math.random(0, 3)
        })
    end
end


function stars:draw()
    for i, v in ipairs(self.sets) do
        love.graphics.circle("fill",v.x, v.y, v.size) -- + love.math.random(-0.2, 0.2
    end
end

return stars