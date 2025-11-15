local backpacks = {}

function backpacks:load()
    self.inventory = 0
    self.packs = {
        {
            name = "Cloth",
            cost = 0,
            capacity = 10,
            id = 1,
            equipped = false,
            owned = true
        },
        {
            name = "Canvas",
            cost = 200,
            capacity = 100,
            id = 2,
            equipped = false,
            owned = false
        },
        {
            name = "Reinforced Canvas",
            
        }
    }
end


return backpacks