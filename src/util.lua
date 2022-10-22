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

return p;
