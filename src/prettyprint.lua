local util = require("util")

local p = {}

-- `hr` is a long line meant as a separator. Its name is derived from the
-- element <hr> in HTML.
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

    -- To allow reproducibility, we print the random
    -- seed used to generate the star system.
    print("seed: "..tostring(system.metadata.randseed)..", "
        .."generated"..tostring(system.metadata.generated)
    )

    print("chz: "..tostring(system.chz.begin)
        .." - "..tostring(system.chz.finish))

    -- print(string.format(
    --     "population total: %d",
    --     system.stats.totalPopulation)
    -- )
end

return p
