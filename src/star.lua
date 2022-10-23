local data = require("seeddata")
local util = require("util")

local p = {}

function p.genStar()
    local types = data.stars.possibleTypes

    local starType = util.weightedRandomList(types)
    
    local star = {
        type = starType.name,
        temperature = math.random(starType.minTemp, starType.maxTemp)
    }

    return star;
end

return p
