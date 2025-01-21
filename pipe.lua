Pipe = {}
PipeMeta = {__index = Pipe}

function Pipe.new()
    local instance = {}
    setmetatable(instance, PipeMeta)

    return instance
end

return Pipe