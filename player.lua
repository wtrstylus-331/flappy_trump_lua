Player = {}
PlayerMeta = {__index = Player}

function Player.new()
    local instance = {}
    setmetatable(instance, PlayerMeta)

    instance.name = "test"

    return instance
end

-- debug
function Player:Print()
    print(self.name)
end

return Player