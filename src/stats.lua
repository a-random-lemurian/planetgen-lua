local p = {}

function p.totalPopulation(planets)
    local pop = 0
    for k,v in pairs(planets) do
        pop = pop + v.population
    end

    return pop;
end

return p