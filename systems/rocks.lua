local rocks = {}

function rocks:load()
    self.bodies = {}
    self:create()
end


-- Create a random rock
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
        },
        initialDurability = 100,
        durability = 100,
        canSplit = true
    })
end


-- Draw all rocks
function rocks:draw()
    for _, v in ipairs(self.bodies) do
        love.graphics.polygon("line", v.points)
        love.graphics.print(v.durability, v.points[1], v.points[2])
    end
end


-- Destroy, split, or damage rocks
function rocks:destroy()
    for i = #self.bodies, 1, -1 do
        local rock = self.bodies[i]

        -- If durability reaches 0, delete rock
        if rock.durability <= 0 then
            table.remove(self.bodies, i)
        
        -- Split when enough damage has been done
        elseif rock.canSplit and (rock.initialDurability - rock.durability >= 25) then
            local factor = rock.durability / 100

            -- Create two fragments
            for splitIndex = 1, 2 do
                -- Correct point indexing
                local px = rock.points[(splitIndex - 1) * 2 + 1]
                local py = rock.points[(splitIndex - 1) * 2 + 2]

                table.insert(self.bodies, {
                    points = {
                        px, py,
                        px + math.random(-20 * factor, 20 * factor),
                        py + math.random(-20 * factor, 20 * factor),

                        px + math.random(-30 * factor, 30 * factor),
                        py + math.random(-30 * factor, 30 * factor),

                        px + math.random(-40 * factor, 40 * factor),
                        py + math.random(-40 * factor, 40 * factor)
                    },
                    initialDurability = rock.durability,
                    durability = rock.durability,
                    -- canSplit = false -- fragments do not split again
                })
            end

            table.remove(self.bodies, i)

        else
            -- Default durability decay
            rock.durability = rock.durability - 1
        end
    end
end

return rocks
