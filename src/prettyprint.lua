local util = require("util")

local p = {}

local hr = '---------------------------------------------------------------'

function p.printSystem(system)
    print(string.format("%s system", system.name))
    print(hr)
    print(string.format("%s star", util.titleCase(system.star.type)))
    print(hr)

    for i, planet in ipairs(system.planets) do
        print(string.format("%s (%s type), population %d",
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
end

return p
