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
    },
    ["XLR8"] = {
        Move1 = "Speed Rush",
        Move2 = "Tornado SpinKick",
        Move3 = "Rapid Strikes",
        Move4 = "Time Slip"
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
    },
    ["XLR8"] = {
        Move1 = "Boom Dash",
        Move2 = "Time Breaker",
        Move3 = "Cyclone Acceleration",
        Move4 = "Afterimage Barrage"
    }
}

return module