local p = {}

-- util.state is a table used to store global variables, shared across
-- the entirety of the program.
p.state = {}

function p.isEmpty(i)
    return i == nil or i == ''
end

function p.titleCase(str)
    return (str:gsub("^%l", string.upper))
end

function p.seedRandom(seed)
    p.state.seed = seed
    math.randomseed(seed)
    for i=1,3 do
        math.random(10000, 65000)
    end
end

function p.weightedRandomList(pool)
    local poolSize = 0

    for k,v in pairs(pool) do
        poolSize = poolSize + v[1]
    end

    local selection = math.random(1,poolSize)

    for k,v in pairs(pool) do
        selection = selection - v[1]
        if (selection <= 0) then
            return v[2]
        end
    end
end

function p.randomFloat(a, b)
    return a + math.random() * (b-a)
end

-- Override an argument. Checks a given name against the arguments list. If
-- the target argument is not found, the default value is returned instead.
function p.overrideArgument(argument, default)
    if p.isEmpty(p.state.args[argument]) == false then
        return p.state.args[argument]
    else
        return default
    end
end

return p;
