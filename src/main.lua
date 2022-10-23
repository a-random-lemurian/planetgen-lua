local argparse = require("argparse")
local util = require("util")
local json = require("json")
local validate = require("validate")


local function printSystem(system)
    -- `hr` is a long line meant as a separator. Its name is derived from the
    -- element <hr> in HTML.
    local hr = '---------------------------------------------------------------'

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

    print(string.format(
        "population total: %d",
        system.stats.totalPopulation)
    )
end

local function main()
    local parser = argparse("stargen")

    parser:help_max_width(80)

    parser:group("Initial generation parameters",
        parser:option("--seed", "Use a specific seed")
    )

    parser:group("Configuring limits",
        parser:option("--max-name-shards --maxnsh",
                      "Set the maximum number of name shards. Default is 5."
                      .."This program generates planet and star system names "
                      .."by stringing together a random arrangement of 'name "
                      .."fragments', like 'ca', 'mel', 'ral', and 'dan'."
                      .."\nWarning: setting this value too high may break the "
                      .."pretty print format. "),
        parser:option("--min-name-shards --minnsh",
                      "Set the minimum number of name shards. Default is 2."),
        parser:option("--minp","Minimum planets"),
        parser:option("--maxp","Maximum planets")
    )

    parser:group("Formatting options",
        parser:flag("--json", "Output in JSON format"),
        parser:flag("--pretty", "Output as a beautifully formatted report")
    )

    local args = parser:parse()
    validate.validateArguments(args)

    util.setArguments(args)
    util.seedRandom(util.overrideArgument("seed", os.clock()*1000000000))

    -- We don't require stargen at the top of the file,
    -- as stargen calls the namegen module.
    --
    -- The namegen module calls util.overrideArgument(),
    -- which would be called before the parsed arguments
    -- are copied to util.state.args, which is accessed
    -- by util.overrideArgument(), therefore causing
    -- errors from trying to index a nil value.

    local stargen = require("stargen")
    local system = stargen.genStarSystem();

    if args.json then
        print(json.encode(system))
    elseif args.pretty then
        printSystem(system)
    else
        printSystem(system)
    end
end

main()

-- TODO: make planetgen a library, and try to seperate
-- main.lua and the other files
