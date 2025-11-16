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
    self.x = (self.x - dx * self.speed * dt) % wW
    self.y = (self.y - dy * self.speed * dt) % wH


    local ox = self.width/2
    local oy = 0

    local rx = ox * dx - oy * dy
    local ry = ox * dy + oy * dx

    for i = 1, 45 do
        table.insert(self.particles, {
            x = self.x + rx +  love.math.random(-4, 4),
            y = self.y + ry + love.math.random(-2, 2),
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
    if self.accelerating then
        for i,v in ipairs(self.particles) do
            love.graphics.setColor(1,1,1, v.life/v.maxLife)
            love.graphics.circle("fill", v.x, v.y, 3 )
            love.graphics.setColor(1,1,1)
        end
    end
    local lineLeft = {}
    local lineRight = {}
    love.graphics.setColor(1,1,1,0.7)
    for i, v in ipairs(self.leftPath) do
        table.insert(lineLeft, v.x)
        table.insert(lineLeft, v.y)
    end
    for i, v in ipairs(self.rightPath) do
        table.insert(lineRight, v.x)
        table.insert(lineRight, v.y)
    end
    love.graphics.line(lineLeft)
    love.graphics.line(lineRight)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.img, self.x, self.y, -self.rotation, self.scaleX, self.scaleY, self.img:getWidth() / 2, self.img:getHeight() / 2)
end

return controller