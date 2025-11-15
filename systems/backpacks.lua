local backpacks = {}

function backpacks:load()
    self.inventory = 0
    self.equipped = 1
    self.owned = {}
    self.packs = {
        {
            name = "Cloth",
            cost = 0,
            capacity = 10,
            id = 1,
            owned = true
        },
        {
            name = "Canvas",
            cost = 200,
            capacity = 100,
            id = 2,
            owned = false
        },
        {
            name = "Reinforced Canvas",
            cost = 1250,
            capacity = 650,
            id = 3,
            owned = false,
        },
        {
            name = "Ripstop Nylon",
            cost = 3500,
            capacity = 2000,
            id = 4,
            owned = false
        },
        {
            name = "Cordura",
            cost = 8000,
            capacity = 10000,
            id = 5,
            owned = false
        },
        {
            
        }
    }
end


return backpacks