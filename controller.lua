local controller = {}


function controller:load()
    self.x = wW / 2
    self.y = wH / 2
    self.img = love.graphics.newImage("character.png")
    self.width = 50
    self.height = 50
    self.rotation = 0
    self.xVel = 0
    self.yVel = 0
    self.scaleX = self.width/self.img:getWidth()
    self.scaleY = self.height/self.img:getHeight()

    self.accelerating = false
    self.speed = 0
    self.maxSpeed = 600
    self.acceleration = 200
    self.friction = 2

    self.particles = {}
    self.leftPath = {}
    self.rightPath = {}

    self.bullets = {}
end

function controller:update(dt)

    -- Turning

    if love.keyboard.isDown("d") then
        self.rotation = self.rotation - math.rad(90) * dt
    elseif love.keyboard.isDown("a") then
        self.rotation = self.rotation + math.rad(90) * dt
    end



    -- Movement
    if love.keyboard.isDown("w") then
        self.speed = math.min(self.speed + self.acceleration * dt, self.maxSpeed)
        self.accelerating = true
    elseif love.keyboard.isDown("s") then
        self.speed = math.max(self.speed - self.acceleration * dt, -self.maxSpeed)
        self.accelerating = true
    else
        self.accelerating = false
        if self.speed > 0 then
            self.speed = math.max(0, self.speed - self.friction * dt)
        elseif self.speed < 0 then
            self.speed = math.min(0, self.speed + self.friction * dt)
        end
    end

    local dx = math.sin(self.rotation)
    local dy = math.cos(self.rotation)
    -- APPLY VELOCITY
    self.x = (self.x - dx * self.speed * dt)
    self.y = (self.y - dy * self.speed * dt)


    local ox = self.width/2
    local oy = 0

    local rx = ox * dx - oy * dy
    local ry = ox * dy + oy * dx

    for i = 1, 45 do
        table.insert(self.particles, {
            x = wW/2 + rx +  love.math.random(-4, 4),
            y = wH/2 + ry + love.math.random(-self.speed, self.speed),
            life = 0,
            maxLife = 0.1
        })
    end

    for i, v in ipairs(self.particles) do
        v.x = v.x + math.random(2, -2)
        v.y = v.y + math.random(2, -2)

        v.life = v.life + dt
        if v.life > v.maxLife then
            table.remove(self.particles, i)
        end
    end

    ox = self.width/2
    oy = self.height/2

    rx = ox * dx - oy * dy
    ry = ox * dy + oy * dx

    

    for i = 1, 45 do
        table.insert(self.leftPath, {
            x = self.x + rx,
            y = self.y + ry,
            life = 0,
            maxLife = 0.1
        })
    end
    
    for i, v in ipairs(self.leftPath) do
        v.x = v.x
        v.y = v.y

        v.life = v.life + dt
        if v.life > v.maxLife then
            table.remove(self.leftPath, i)
        end
    end

    ox = self.width/2
    oy = -self.height/2

    rx = ox * dx - oy * dy
    ry = ox * dy + oy * dx

    

    for i = 1, 45 do
        table.insert(self.rightPath, {
            x = self.x + rx,
            y = self.y + ry,
            life = 0,
            maxLife = 0.1
        })
    end
    
    for i, v in ipairs(self.rightPath) do
        v.x = v.x
        v.y = v.y

        v.life = v.life + dt
        if v.life > v.maxLife then
            table.remove(self.rightPath, i)
        end
    end

    for i,v in ipairs(self.bullets) do
        v.x = v.x + v.xVel * dt
        v.y = v.y + v.yVel * dt
    end
end

function controller:shoot(dx, dy)
    local ox = -self.width/2
    local oy = 0
    local rx = ox * dx - oy * dy
    local ry = ox * dy + oy * dx
    table.insert(self.bullets, {
        x = self.x + rx,
        y = self.y + ry,
        xVel = -dx * 200,
        yVel = -dy * 200,
    })
end

function controller:draw()
 
    self:drawTrails()


    love.graphics.setColor(1,1,1)
    for i,v in ipairs(self.bullets) do
        love.graphics.circle("line", v.x, v.y, 2)
    end
    love.graphics.draw(self.img, wW/2, wH/2, -self.rotation, self.scaleX, self.scaleY, self.img:getWidth() / 2, self.img:getHeight() / 2)
end

function controller:mousepressed(x, y, button)
    if button == 1 then
        local dx = math.sin(self.rotation)
        local dy = math.cos(self.rotation)
        self:shoot(dx, dy)
    end
end
function controller:drawTrails()
    local cx = wW/2
    local cy = wH/2

    local leftL = {}
    local rightL = {}


    love.graphics.setColor(1,1,1,0.6)

    for _, v in ipairs(self.leftPath) do
        local sx = v.x - self.x + cx
        local sy = v.y - self.y + cy
        table.insert(leftL, sx)
        table.insert(leftL, sy)
    end

    for _, v in ipairs(self.rightPath) do
        local sx = v.x - self.x + cx
        local sy = v.y - self.y + cy
        table.insert(rightL, sx)
        table.insert(rightL, sy)
    end

    love.graphics.line(leftL)
    love.graphics.line(rightL)

    love.graphics.setColor(1,1,1)
end

return controller