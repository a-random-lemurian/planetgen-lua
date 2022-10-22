local argparse = require("argparse")
local stargen = require("stargen")
local util = require("util")

local parser = argparse("stargen")

parser:option("--seed", "Use a specific seed")
parser:flag("--json", "Output in JSON format")

local args = parser:parse()

if util.isEmpty(args.seed) == false then
    util.seedRandom(args.seed)
else
    util.seedRandom(os.clock()*1000000000)
end

stargen.main(args)
