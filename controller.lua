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
    self.maxSpeed = 2000
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

    self.particles = self:normalizeEffects(self.width/2, 0, rand(4, -4), rand(2, -2), self.particles, self.speed/4, dt)
    self.leftPath = self:normalizeEffects(self.width/2, self.height/2, 0, 0, self.leftPath, 45, dt)
    self.rightPath = self:normalizeEffects(self.width/2, -self.height/2, 0, 0, self.rightPath, 45, dt)

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
    love.graphics.draw(self.img, self.x, self.y, -self.rotation, self.scaleX, self.scaleY, self.img:getWidth() / 2, self.img:getHeight() / 2)
end

function controller:mousepressed(x, y, button)
    if button == 1 then
        local dx = math.sin(self.rotation)
        local dy = math.cos(self.rotation)
        self:shoot(dx, dy)
    end
end

function controller:normalizeEffects(ox, oy, insertRand, moveRand, t, rate, dt)
    local dx = math.sin(self.rotation)
    local dy = math.cos(self.rotation)
    local rx = ox * dx - oy * dy
    local ry = ox * dy + oy * dx

    for i = 1, rate do
        table.insert(t, {
            x = self.x + rx + insertRand,
            y = self.y + ry + insertRand,
            life = 0,
            maxLife = 0.1
        })
    end

    for i, v in ipairs(t) do
        v.x = v.x + moveRand 
        v.y = v.y + moveRand 

        v.life = v.life + dt
        if v.life > v.maxLife then
            table.remove(t, i)
        end
    end

    return t
end
function controller:drawTrails()


    local leftL = {}
    local rightL = {}
   if self.accelerating then
        for i,v in ipairs(self.particles) do

            love.graphics.setColor(1,1,1, v.life/v.maxLife)
            love.graphics.circle("fill", v.x, v.y, 3 )
            love.graphics.setColor(1,1,1)
        end
    end

    love.graphics.setColor(1,1,1,0.6)

    for _, v in ipairs(self.leftPath) do
        table.insert(leftL, v.x)
        table.insert(leftL, v.y)
    end
    for _, v in ipairs(self.rightPath) do
        table.insert(rightL, v.x)
        table.insert(rightL, v.y)
    end

    love.graphics.line(leftL)
    love.graphics.line(rightL)

    love.graphics.setColor(1,1,1)
end
function rand(range1, range2)
    return love.math.random(range1, range2)
end
return controller