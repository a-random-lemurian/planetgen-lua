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

function p.genPlanet(system, dist)
    local types = p.getPlanetTypes(system.chz, dist)

    local planet = {
        type = util.weightedRandomList(types).name,
        population = math.random(1,800000)*100
    }

    return planet;
end

function p.isHabitable(chz, distance)
    -- TODO: add util.between() to replace this
    return distance >= chz.begin and distance <= chz.finish
end

function p.getPlanetTypes(chz, distance)
    if p.isHabitable(chz, distance) then
        return data.planets.possibleTypesInsideChz
    end

    return data.planets.possibleTypes
end

function p.calculateChz(star)
    local chz = {}

    chz.begin = star.temperature * 3000
    chz.finish = chz.begin * util.randomFloat(1.6, 3.7)

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

    local distance = math.random(700000, 1340000)

    local minPlanetCount = util.overrideArgument("minp", data.defaults.minPlanets)
    local maxPlanetCount = util.overrideArgument("maxp", data.defaults.maxPlanets)
    local planetCount = math.random(minPlanetCount, maxPlanetCount)

    for i=1,planetCount do
        system.planets[i] = p.genPlanet(system, distance)

        local i_str = tostring(i)
        system.planets[i].name = system.name .. " " .. i_str
        system.planets[i].distance = distance
        system.planets[i].habitable = p.isHabitable(system.chz, distance)
    
        distance = distance + math.random(7700000, 9650000)
    end

    system.stats.totalPopulation = stats.totalPopulation(system.planets)

    return system
end

return p