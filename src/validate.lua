local util = require "util"
local p = {}

local hadError = false

function p.validateMinMax(args, min, max)
    if util.isEmpty(args[min]) or util.isEmpty(args[max]) then
        return true
    end

    if args[min] > args[max] then
        io.stderr:write("error in --"..min.." and --"..max..": "
                      .."min ("..args[min]..") cannot be higher "
                      .."than max ("..args[max]..")\n")
        hadError = true
        return false
    end

    return true
end

function p.ensureNumber(args, item)
    if util.isEmpty(args[item]) then
        return true
    end

    io.stderr:write("error in --"..item..": expected a number and "
                  .."got argument of type "..type(item).." instead\n")
end

function p.validateArguments(args)
    p.validateMinMax(args, "min_name_shards", "max_name_shards")
    p.validateMinMax(args, "minp", "maxp")
    p.ensureNumber(args, "seed")

    if hadError then
        io.stderr:write("Errors detected - exiting\n")
        os.exit(1)
    end
end

return p