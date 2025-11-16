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
        return math
    end
end

function stars:update(dt)
    for i, v in ipairs(self.sets) do
        v.x = v.x + math.random(-3, 3) * dt
        v.y = v.y + math.random(-3, 3) * dt
    end
end

function stars:draw()
    for i, v in ipairs(self.sets) do
        love.graphics.circle("fill",v.x, v.y, v.size) -- + love.math.random(-0.2, 0.2
    end
end

return stars