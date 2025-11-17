local miner = {}

function miner:load()
    self.multipler = 1
    self.equipped = 1
    self.owned = {}
    self.tools = {
        {
            name = "Scrap Hands",
            cost = 0,
            power = 1,
            efficiency = 1,
            id = 1,
            owned = true
        },
        {
            name = "Rusty Drill",
            cost = 150,
            power = 5,
            efficiency = 2,
            id = 2,
            owned = false
        },
        {
            name = "Standard Drill",
            cost = 1200,
            power = 20,
            efficiency = 5,
            id = 3,
            owned = false
        },
        {
            name = "Advanced Drill",
            cost = 13500,
            power = 90,
            efficiency = 15,
            id = 4,
            owned = false
        },
        {
            name = "Giant Saw",
            cost = 60000,
            power = 230,
            efficiency = 50,
            id = 5,
            owned = false
        },
        {
            name = "Plasma Cutter",
            cost = 250000,
            power = 800,
            efficiency = 120,
            id = 6,
            owned = false
        }
    }
end

return miner