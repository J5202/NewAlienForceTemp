local module = {}
module.__index = module

function module.Data(AnimationId, AnimationEventName, AnimationVariant, AnimationSpeed)
    local Data = {}
    Data.AnimationId = AnimationId
    Data.AnimationEventName = AnimationEventName
    Data.AnimationVariant = AnimationVariant
    Data.AnimationSpeed = AnimationSpeed
    return Data
end

return module