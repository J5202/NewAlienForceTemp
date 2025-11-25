local module = {}
module.__index = module

module.NormalMoves = {
    ["HeatBlast"] = {
        Move1 = "Fireball Shot",
        Move2 = "Flame Burst",
        Move3 = "Flame Dash",
        Move4 = "HeatBlast"
    },
    ["FourArms"] = {
        Move1 = "Ground Slam",
        Move2 = "Double Punch Combo",
        Move3 = "Boulder Throw",
        Move4 = "FourArms"
    }
}

module.AwakenedMoves = {
    ["HeatBlast"] = {
        Move1 = "Solar Flare Barrage",
        Move2 = "Supernova Explosion",
        Move3 = "Meteor Flare",
        Move4 = "HeatWave Dominion"
    },
    ["FourArms"] = {
        Move1 = "Earthquake Slam",
        Move2 = "Quadruple Punch",
        Move3 = "Mountain Crush",
        Move4 = "Awakened FourArms"
    }
}

return module