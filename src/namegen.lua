local data = require("seeddata")
local util = require("util")
local p = {}

local minShards = util.overrideArgument("min_name_shards", data.defaults.minNameShards);
local maxShards = util.overrideArgument("max_name_shards", data.defaults.maxNameShards);

p.katakana = {
    startFragments = {
        "kyo", "gyo", "shu", "sho", "chu", "cho", "hyu", "myo",
        "ryu", "chi", "tsu", "shi", "ka", "ki", "ku", "ke",
        "ko", "ga", "gi", "gu", "ge", "go", "sa", "su",
        "se", "so", "za", "zu", "ze", "ta", "te", "to",
        "da", "na", "ni", "nu", "ne", "no", "ha", "hi",
        "fu", "he", "ho", "ba", "bi", "bu", "be", "ma",
        "mi", "mu", "me", "mo", "ya", "yu", "yo", "ri",
        "ru", "wa", "jo", "a", "i", "u", "e", "o"
    },
    middleFragments = {
        "sshi", "ppo", "tto", "mbo", "kka", "kyu", "sho", "chu",
        "chi", "tsu", "shi", "ka", "ki", "ku", "ke", "ko",
        "ga", "gi", "gu", "ge", "go", "sa", "su", "se",
        "so", "za", "ji", "zu", "ze", "ta", "te", "to",
        "da", "de", "do", "na", "ni", "nu", "ne", "no",
        "ha", "hi", "fu", "ho", "ba", "bi", "bu", "be",
        "bo", "ma", "mi", "mu", "me", "mo", "ya", "yo",
        "ra", "ri", "ru", "re", "ro", "wa", "ju", "jo",
        "a", "i", "u", "e", "o", "n"
    },
    endFragments = {
        "ttsu", "ppu", "ssa", "tto", "tte", "noh", "mba", "kko",
        "kyo", "shu", "chu", "nyu", "nyo", "ryu", "chi", "tsu",
        "shi", "ka", "ki", "ku", "ke", "ko", "ga", "gi",
        "gu", "go", "sa", "su", "se", "so", "za", "ji",
        "zu", "ze", "zo", "ta", "te", "to", "da", "de",
        "do", "na", "ni", "ne", "no", "ha", "hi", "fu",
        "he", "ho", "ba", "bi", "bu", "be", "bo", "ma",
        "mi", "mu", "me", "mo", "ya", "yo", "ra", "ri",
        "ru", "re", "ro", "wa", "ja", "jo", "i", "e",
        "o", "n"
    }
}

p.greekAlphabetLetters = {
    "Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Eta",
    "Theta", "Kappa", "Lambda", "Mu", "Rho", "Sigma", "Tau"
}

p.nameProviders = {
}

function p.nameProviders.katakana()
    local name = ""
    local middleFragmentCount = math.random(0, 2)
    
    name = name .. util.randomItemFromList(p.katakana.startFragments)
    
    for i=0,middleFragmentCount do
        name = name .. util.randomItemFromList(p.katakana.middleFragments)
    end

    name = name .. util.randomItemFromList(p.katakana.endFragments)

    return name
end

function p.nameProviders.generic()
    local name = ""
    local possibleShards = data.nameShards

    local shardsCount = math.random(minShards, maxShards)

    for i=1,shardsCount do
        name = name .. util.randomItemFromList(possibleShards)
    end

    return name
end

function p.nameProviders.greekLetterPrefixed()
    local name = ""
    name = name..util.randomItemFromList(p.greekAlphabetLetters).." "

    local func;
    func = p.getName()
    
    name = name..util.titleCase(func())

    return name
end

function p.getName()
    return util.randomItemFromHashTable(p.nameProviders)
end

return p
