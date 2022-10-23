-- validate.lua
--
-- These functions help validate the command line arguments
-- sent into planetgen. Validation functions should return true
-- when given valid input and false for anything else.
--
-- Validation functions must not exit when detecting invalid
-- input. It should instead run any error handling code, write
-- to stderr with io:stderr:write, set hadError to true, and
-- return false.
--
-- This allows all errors in the command line arguments to be
-- shown to the user all at once instead of one by one which
-- may frustrate the user.
--

local util = require "util"
local p = {}

local hadError = false

-- For obvious reasons, a minimum number cannot be higher than a
-- maximum number. args is a table containing the args from
-- parser:parse(). min and max are self-explanatory.
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

-- Some arguments must be a number. This checks if the argument
-- type is indeed, a number.
function p.ensureNumber(args, item)
    if util.isEmpty(args[item]) then
        return true
    end

    if type(item) == "string" then
        if util.isEmpty(tonumber(args[item])) == false then
            return true
        end
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