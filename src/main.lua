local argparse = require("argparse")
local util = require("util")
local json = require("json")
local prettyprint = require("prettyprint")
local validate = require("validate")

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

    util.state.args = args

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
        prettyprint.printSystem(system)
    else
        prettyprint.printSystem(system)
    end
end

main()
