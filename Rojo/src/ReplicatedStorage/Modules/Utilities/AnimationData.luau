local module = {}
module.__index = module

function module.Data(AnimationName, AnimationId, AnimationEventName, AnimationVariant, AnimationSpeed, AnimationEffectRemoteEvent)
    local Data = setmetatable({}, module)
    Data.AnimationName = AnimationName
    Data.AnimationId = AnimationId
    Data.AnimationEventName = AnimationEventName
    Data.AnimationVariant = AnimationVariant
    Data.AnimationSpeed = AnimationSpeed
    Data.AnimationEffectRemoteEvent = AnimationEffectRemoteEvent
    return Data
end

function module:AddRangeToDoEffect(AirVariantRangeToDoEffect:number)
    local AnimationVariant = self.AnimationVariant
    if AnimationVariant == "AirVariant" then
        self.AirVariantRange = AirVariantRangeToDoEffect
    end
end

function module:UnstunAfterAnimation()
    self.UnStunAfterAnim = true
end

return module