local module = {}
module.__index = module

local HeatBlast = require(script.Parent:WaitForChild("HeatBlast"):WaitForChild("HeatblastMain"))
local FourArms = require(script.Parent:WaitForChild("FourArms"):WaitForChild("FourArmsMain"))

function module.Moveset(move1, move2, move3, move4, awkmove1, awkmove2, awkmove3, awkmove4)
    local self = setmetatable({}, module)
    self.Move1 = move1
    self.Move2 = move2
    self.Move3 = move3
    self.Move4 = move4
    self.AwkMove1 = awkmove1
    self.AwkMove2 = awkmove2   
    self.AwkMove3 = awkmove3
    self.AwkMove4 = awkmove4
    return self
end

module.CharacterModules = {
    ["HeatBlast"] = module.Moveset(HeatBlast.Move1, nil, nil, nil, nil, nil, nil, nil),
    ["FourArms"] = module.Moveset(nil, nil, nil, nil, nil, nil, nil, nil)
}

return module