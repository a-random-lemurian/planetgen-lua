local math = require("math")
local json = require("json")
local data = require("seeddata")
local util = require("util")
local stats = require("stats")
local namegen = require("namegen")
local planet = require("planet")
local star   = require("star")

local p = {}

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
        name = util.titleCase(namegen.getName()()),
        star = star.genStar(),
        planets = {},
        stats = {}
    }

    system.chz = p.calculateChz(system.star)

    local minPlanetCount = util.overrideArgument("minp", data.defaults.minPlanets)
    local maxPlanetCount = util.overrideArgument("maxp", data.defaults.maxPlanets)
    local planetCount = math.random(minPlanetCount, maxPlanetCount)

    system.planets = planet.genPlanets(system, planetCount)

    system.stats.totalPopulation = stats.totalPopulation(system.planets)

    return system
end

return p