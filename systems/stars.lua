local stars = {}


function stars:load()
    self.chunkSize = 500
    self.layers = {
        {speed = 0.3, starsPerChunk = 10, chunks = {}},
        {speed = 0.6, starsPerChunk = 20, chunks = {}},
        {speed = 1, starsPerChunk = 30, chunks = {}}

    }
    self.playerX = 0
    self.playerY = 0
    -- self.sets = {}
    -- for i = 1, 200 do
    --     table.insert(self.sets, {
    --         x = math.random(0, wW),
    --         y = math.random(0, wH),
    --         size = math.random(0, 3)
    --     })
    -- ende
end

local function getChunkCoord(v, chunkSize)
    if v >= 0 then
        return math.floor(v / chunkSize)
    else
        return math.floor(v / chunkSize) - 1
    end
end

function stars:generateChunk(layer, cx, cy)
    local key = cx  .. ":" .. cy
    if layer.chunks[key] then return end

    local list = {}
    for i = 1, layer.starsPerChunk do
        local x = cx * self.chunkSize + math.random(0, self.chunkSize)
        local y = cy * self.chunkSize + math.random(0, self.chunkSize)

        table.insert(list, {
            x = x,
            y = y,
            size = math.random(1, 3)
        })
    end

    layer.chunks[key] = list
end

function stars:update(dt, playerX, playerY)
    -- for i, v in ipairs(self.sets) do
    --     v.x = v.x + math.random(-3, 3) * dt
    --     v.y = v.y + math.random(-3, 3) * dt
    -- end
    self.playerX = playerX
    self.playerY = playerY

    local cx = getChunkCoord(playerX, self.chunkSize)
    local cy = getChunkCoord(playerY, self.chunkSize)


    for _, layer in ipairs (self.layers) do
        for ix = -1, 1 do
            for iy = -1, 1 do
                self:generateChunk(layer, cx + ix, cy + iy)
            end
        end
    end
   
end


function stars:draw()

    local screenCenterX = wW/2
    local screenCenterY = wH/2

   for _, layer in ipairs(self.layers) do
        for _, chunk in pairs(layer.chunks) do
            for _, s in ipairs(chunk) do
                local sx = s.x - self.playerX * layer.speed + screenCenterX
                local sy = s.y - self.playerY * layer.speed + screenCenterY
                love.graphics.circle("fill", sx, sy, s.size)
            end
        end
    end
end

return stars