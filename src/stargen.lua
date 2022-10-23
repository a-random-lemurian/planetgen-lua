local math = require("math")
local json = require("json")
local data = require("seeddata")
local util = require("util")
local stats = require("stats")
local namegen = require("namegen")

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

function p.genPlanet(system, dist)
    local types = p.getPlanetTypes(system.chz, dist)

    local planet = {
        type = util.weightedRandomList(types).name,
        population = math.random(1,800000)*100
    }

    return planet;
end

function p.isHabitable(chz, distance)
    return util.between(distance, chz.begin, chz.finish)
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

function p.genPlanets(system, planetCount)
    local distance = math.random(700000, 1340000)
    local planets = {}

    for i=1,planetCount do
        planets[i] = p.genPlanet(system, distance)
        
        local i_str = tostring(i)
        
        planets[i].name = system.name .. " " .. i_str
        planets[i].distance = distance
        planets[i].habitable = p.isHabitable(system.chz, distance)
        
        distance = distance + math.random(7700000, 9650000)
    end

    return planets
end

function p.genStarSystem()
    local system = {
        metadata = {
            generated = os.date("%Y-%m-%d %H:%M:%S",os.time()),
            randseed = util.state.seed
        },
        name = util.titleCase(namegen.getName()()),
        star = p.genStar(),
        planets = {},
        stats = {}
    }

    system.chz = p.calculateChz(system.star)

    local minPlanetCount = util.overrideArgument("minp", data.defaults.minPlanets)
    local maxPlanetCount = util.overrideArgument("maxp", data.defaults.maxPlanets)
    local planetCount = math.random(minPlanetCount, maxPlanetCount)

    system.planets = p.genPlanets(system, planetCount)

    system.stats.totalPopulation = stats.totalPopulation(system.planets)

    return system
end

return p