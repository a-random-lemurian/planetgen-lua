-- seeddata.lua
--
-- Contains data needed for planetgen-lua, such as possible planet and star
-- types and their probabilities.
--
-- maybe rename this file to just "data.lua"?
--
-- Chz means [c]ircumstellar [h]abitable [z]one, the formal scientific name
-- for the "goldilocks zone".

local data = {
    planets = {
        -- TODO: If planet being generated is in the circumstellar habitable
        -- zone, increase the odds in favor of terran and ocean.
        possibleTypes = {
            { 46, { name = "barren" } },
            { 13, { name = "frozen" } },
            { 12, { name = "lava" } },
            { 11, { name = "toxic" } },
            { 9, { name = "ocean" } },
            { 4, { name = "terran" } },
            { 3, { name = "desert" } },
            { 2, { name = "venusian" } }
        },
        possibleTypesInsideChz = {
            { 28, { name = "terran" } },
            { 19, { name = "ocean" } },
            { 14, { name = "desert" } },
            { 10, { name = "barren" } },
            { 13, { name = "frozen" } },
            { 13, { name = "lava" } },
            { 12, { name = "toxic" } },
            { 1, { name = "venusian" } }
        }
    },
    stars = {
        -- Temperatures are in Kelvin. Not in Fahrenheit.
        possibleTypes = {
            { 70, {  name = "red",
                    minTemp = 2400,
                    maxTemp = 3700 }
            },
            { 10, { name = "yellow",
                    minTemp = 3700,
                    maxTemp = 5200 }
            },
            { 8, {  name = "orange",
                    minTemp = 4200,
                    maxTemp = 7800 }
            },
            { 5, {  name = "blue",
                    minTemp = 10000,
                    maxTemp = 60000 }
            },
            { 4, {  name = "white",
                    minTemp = 6000,
                    maxTemp = 10000 }
            },
            { 2, {  name = "blackhole",
                    minTemp = 400,
                    maxTemp = 900 }
            },
            { 1, {  name = "neutron",
                    minTemp = 800,
                    maxTemp = 2000 }
            }
        },
    },
    nameShards = {
        "sh", "ca", "ma", "lop", "nar", "le", "mel", "ral", "dan",
        "kam", "kai", "ai", "ei", "ro", "de", "ze", "ya", "ik", "vot",
        "sen"
    },
    -- Default options. Used as a single source of truth for calls to
    -- util.argumentOverride().
    defaults = {
        minNameShards = 2,
        maxNameShards = 5,
        minPlanets = 2,
        maxPlanets = 9
    }
}

return data;
