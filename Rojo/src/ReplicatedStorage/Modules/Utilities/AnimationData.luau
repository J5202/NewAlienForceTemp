local module = {}
module.__index = module

function module.Data(AnimationId, AnimationEventName, AnimationVariant, AnimationSpeed)
    local Data = setmetatable({}, module)
    Data.AnimationId = AnimationId
    Data.AnimationEventName = AnimationEventName
    Data.AnimationVariant = AnimationVariant
    Data.AnimationSpeed = AnimationSpeed
    return Data
end

function module:AddRangeToDoEffect(AirVariantRangeToDoEffect:number)
    local AnimationVariant = self.AnimationVariant
    if AnimationVariant == "AirVariant" then
        self.AirVariantRange = AirVariantRangeToDoEffect
    end
end

return module