local argparse = require("argparse")
local stargen = require("stargen")
local util = require("util")
local json = require("json")
local prettyprint = require("prettyprint")

local function main()
    local parser = argparse("stargen")

    parser:help_max_width(80)

    parser:option("--seed", "Use a specific seed")
    parser:option("--max-name-shards --maxnsh",
                  "Set the maximum number of name shards. Default is 5."
                  .."This program generates planet and star system names by "
                  .."stringing together a random arrangement of 'name "
                  .."fragments', like 'ca', 'mel', 'ral', and 'dan'.")
    parser:option("--min-name-shards --minnsh",
                  "Set the minimum number of name shards. Default is 2.")
    parser:flag("--json", "Output in JSON format")

    local args = parser:parse()

    util.state.args = args

    if util.isEmpty(args.seed) == false then
        util.seedRandom(args.seed)
    else
        util.seedRandom(os.clock()*1000000000)
    end

    local system = stargen.genStarSystem();

    if args.json then
        print(json.encode(system))
    else
        prettyprint.printSystem(system)
    end
end

main()
