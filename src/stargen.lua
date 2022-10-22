local math = require("math")
local json = require("json")
local data = require("seeddata")
local util = require("util")

local p = {}

function p.genSystemName()
    local name = ""
    local possibleShards = data.nameShards
    local shardsCount = math.random(2, 5)

    for i=1,shardsCount do
        name = name .. possibleShards[math.random(#possibleShards)]
    end

    return util.titleCase(name)
end

function p.genStar()
    local types = data.stars.possibleTypes

    local star = {
        type = util.weightedRandomList(types).name
    }
    return star;
end

function p.genPlanet()
    local types = data.planets.possibleTypes

    local planet = {
        type = util.weightedRandomList(types).name,
        population = math.random(1,800000)*100
    }

    return planet;
end

function p.genStarSystem()
    local system = {
        metadata = {
            generated = os.date("%Y-%m-%d %H:%M:%S",os.time()),
            randseed = util.state.seed
        },
        name = p.genSystemName(),
        star = p.genStar(),
        planets = {}
    }

    local planetCount = math.random(2,9)

    for i=1,planetCount do
        system.planets[i] = p.genPlanet()

        local i_str = tostring(i)
        system.planets[i].name = system.name .. " " .. i_str
    end

    return system
end

return p