local rocks = {}

function rocks:load()
    self.bodies = {}
end


local function calculatePolygonArea()
    
end

function rocks:create()
    local startX = math.random(0, wW)
    local startY = math.random(0, wH)
    table.insert(self.bodies, {
        points = {
            startX, startY,
            startX + math.random(-20, 20), startY + math.random(-20, 20),
            startX + math.random(-30, 30), startY + math.random(-30, 30),
            startX + math.random(-40, 40), startY + math.random(-40, 40),
            startX + math.random(-20, 20), startY + math.random(-20, 20)
        }
    })
end