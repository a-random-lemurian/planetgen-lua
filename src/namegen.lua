local data = require("seeddata")
local util = require("util")
local p = {}

p.nameProviders = {
}

function p.nameProviders.generic()
    local name = ""
    local possibleShards = data.nameShards

    -- TODO: minimize code duplication with new function
    local minShards = util.overrideArgument("min_name_shards", data.defaults.minNameShards);
    local maxShards = util.overrideArgument("max_name_shards", data.defaults.maxNameShards);

    local shardsCount = math.random(minShards, maxShards)

    for i=1,shardsCount do
        name = name .. util.randomItemFromList(possibleShards)
    end

    return name
end

function p.getName()
    return util.randomItemFromHashTable(p.nameProviders)()
end

return p
