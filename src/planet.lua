local util = require("util")
local data = require("seeddata")

local p = {}

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

return p