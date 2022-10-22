local math = require("math")
local json = require("json")
local data = require("seeddata")
local util = require("util")
local stats = require("stats")

local p = {}

function p.genSystemName()
    local name = ""
    local possibleShards = data.nameShards

    -- TODO: minimize code duplication with new function
    local minShards = util.overrideArgument("min_name_shards", data.defaults.minNameShards);
    local maxShards = util.overrideArgument("max_name_shards", data.defaults.maxNameShards);

    local shardsCount = math.random(minShards, maxShards)

    for i=1,shardsCount do
        name = name .. possibleShards[math.random(#possibleShards)]
    end

    return util.titleCase(name)
end

function p.genStar()
    local types = data.stars.possibleTypes

    local starType = util.weightedRandomList(types)
    
    local star = {
        type = starType.name,
        temperature = math.random(starType.minTemp, starType.maxTemp)
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

function p.calculateChz(star)
    local chz = {}

    chz.begin = star.temperature * 8000
    chz.finish = chz.begin * 1.6

    return chz
end

function p.genStarSystem()
    local system = {
        metadata = {
            generated = os.date("%Y-%m-%d %H:%M:%S",os.time()),
            randseed = util.state.seed
        },
        name = p.genSystemName(),
        star = p.genStar(),
        planets = {},
        stats = {}
    }

    system.chz = p.calculateChz(system.star)

    local planetCount = math.random(2,9)

    for i=1,planetCount do
        system.planets[i] = p.genPlanet()

        local i_str = tostring(i)
        system.planets[i].name = system.name .. " " .. i_str
    end

    system.chz = p.calculateChz(system.star)



    return system
end

return p