local argparse = require("argparse")
local stargen = require("stargen")
local util = require("util")
local json = require("json")
local prettyprint = require("prettyprint")

local function main()
    local parser = argparse("stargen")

    parser:option("--seed", "Use a specific seed")
    parser:flag("--json", "Output in JSON format")

    local args = parser:parse()

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
