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

    self.acceleration = 200
    self.friction = 500

    self.particles = {}
    
end

function controller:update(dt)

    -- Turning

    if love.keyboard.isDown("d") then
        self.rotation = self.rotation - math.rad(90) * dt
    elseif love.keyboard.isDown("a") then
        self.rotation = self.rotation + math.rad(90) * dt
    end


    local dx = math.sin(self.rotation)
    local dy = math.cos(self.rotation)

    -- Movement
    if love.keyboard.isDown("w") then
        self.xVel = self.xVel - dx * self.acceleration * dt
        self.yVel = self.yVel - dy * self.acceleration * dt
    elseif love.keyboard.isDown("s") then
        self.xVel = self.xVel + dx * self.acceleration * dt
        self.yVel = self.yVel + dy * self.acceleration * dt
    else

        if self.yVel > 0 then
            self.yVel = math.max(0, self.yVel - self.friction * dt)
            self.xVel = math.max(0, self.xVel - self.friction * dt)
        elseif self.yVel < 0 then
            self.yVel = math.min(0, self.yVel + self.friction * dt)
            self.xVel = math.min(0, self.xVel + self.friction * dt)
        end
    end


    self.x = (self.x + self.xVel * dt) % wW
    self.y = (self.y + self.yVel * dt) % wH

    for i = 1, 45 do
        table.insert(self.particles, {
            x = self.x + self.width/2 +  love.math.random(-4, 4),
            y = self.y + self.height + love.math.random(-2, 2),
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
end

function controller:draw()
    for i,v in ipairs(self.particles) do
        love.graphics.setColor(1,1,1, v.life/v.maxLife)
        love.graphics.circle("fill", v.x, v.y, 3)
        love.graphics.setColor(1,1,1)
    end
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.img, self.x, self.y, -self.rotation, self.scaleX, self.scaleY)
end

return controller