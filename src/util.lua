local p = {}

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

return p;
