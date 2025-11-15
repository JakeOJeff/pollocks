local backpack = {}

function backpack:load()
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
            name = "Ballistic Nylon",
            cost = 16000,
            capacity = 25000,
            id = 6,
            owned = false
        },
        {
            name = "X-Pac",
            cost = 65000,
            capacity = 150000,
            id = 7,
            owned = false
        },
        {
            name = "Dyneema Grid",
            cost = 180000,
            capacity = 400000,
            id = 8,
            owned = false
        },
        {
            name = "Dyneema Hybrid",
            cost = 550000,
            capacity = 750000,
            id = 9,
            owned = false
        },
        {
            name = "Kevlar-Weave",
            cost = 1600000,
            capacity = 2000000,
            id = 10,
            owned = false
        },
        {
            name = "Carbon Fabric",
            cost = 5000000,
            capacity = 12500000,
            id = 11,
            owned = false
        }
    }
end

function backpack()
    
end




return backpack