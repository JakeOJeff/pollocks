local stars = {}


function stars:load()
    self.chunkSize = 400
    self.starsPerChunk = 40
    self.chunks = {}
    self.playerX = 0
    self.playerY = 0
    -- self.sets = {}
    -- for i = 1, 200 do
    --     table.insert(self.sets, {
    --         x = math.random(0, wW),
    --         y = math.random(0, wH),
    --         size = math.random(0, 3)
    --     })
    -- end
end

local function getChunkCoord(v, chunkSize)
    if v >= 0 then
        return math.floor(v / chunkSize)
    else
        return math.floor(v / chunkSize) - 1
    end
end

function stars:generateChunk(cx, cy)
    local key = cx  .. ":" .. cy
    if self.chunks[key] then return end

    local list = {}
    for i = 1, self.starsPerChunk do
        local x = cx * self.chunkSize + math.random(0, self.chunkSize)
        local y = cy * self.chunkSize + math.random(0, self.chunkSize)

        table.insert(list, {
            x = x,
            y = y,
            size = math.random(1, 3)
        })
    end

    self.chunks[key] = list
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

    for ix = -1, 1 do
        for iy = -1, 1 do
            self:generateChunk(cx + ix, cy + iy)
        end
    end
end


function stars:draw()

    local screenCenterX = wW/2
    local screenCenterY = wH/2

    for _, list in pairs(self.chunks) do
        for _, s in ipairs(list) do
            local sx = s.x - self.playerX + screenCenterX
            local sy = s.y - self.playerY + screenCenterY

            love.graphics.circle("fill", sx, sy, s.size)    
        end
    end
end

return stars