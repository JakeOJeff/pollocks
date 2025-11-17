local miner = {}

function miner:load()
    self.multipler = 1
    self.equipped = 1
    self.owned = {}
    self.tools = {
        {
            name = ""
        }
    }
end

return miner