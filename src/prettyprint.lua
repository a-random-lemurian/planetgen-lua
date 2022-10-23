local util = require("util")

local p = {}

local hr = '---------------------------------------------------------------'

function p.printSystem(system)
    print(string.format("%s system", system.name))
    print(hr)
    print(string.format("%s star (%dK)", util.titleCase(system.star.type), system.star.temperature))
    print(hr)

    for i, planet in ipairs(system.planets) do
        print(string.format("%-30s %-18s %d",
            planet.name, util.titleCase(planet.type),
            planet.population
        ))
    end

    print(hr)

    print(string.format(
        "seed: %s, generated %s",
        system.metadata.randseed,
        system.metadata.generated)
    )

    print(string.format(
        "chz: %d - %d",
        system.chz.begin,
        system.chz.finish)
    )

    -- print(string.format(
    --     "population total: %d",
    --     system.stats.totalPopulation)
    -- )
end

return p
