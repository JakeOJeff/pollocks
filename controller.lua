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
    for i = 1, 600 do
        table.insert(self.particles, {
            x = self.x + math.random(-4, 4),
            y = self.y + math.random(-2, 2),
            life = 0 + math.random(0.2, 0.5),
            maxLife = 1
        })
    end
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


    
end

function controller:draw()
    for i,v in ipairs(self.particles) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end
    love.graphics.draw(self.img, self.x, self.y, -self.rotation, self.scaleX, self.scaleY)
end

return controller