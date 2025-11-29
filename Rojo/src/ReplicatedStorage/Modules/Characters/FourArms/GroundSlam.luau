local module = {}
module.__index = module

local AnimationDataModule = require(game.ReplicatedStorage.Modules.Utilities.AnimationData)

local PlayMoveAnimationEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents").PlayMoveAnimation
local EndOfMoveEvent = game.ReplicatedStorage.RemoteEvents.EndOfMoveEvent

-- local data = {
--     AnimationId = "InputAnimationId",
--     AnimationEventName = "Slam",
--     AnimationVariant = nil,
--     AnimationSpeed = 0.75,
--    -- ApplyEffectAtAnimEnd = true
-- }

local data = AnimationDataModule.Data("InputAnimationId", "Slam", nil, 0.9)

function module.UseMove(player, MoveTime)
    local Humanoid:Humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    
    if Humanoid then
        print("FourArms GroundSlam move used by player: "..player.Name.." at time: "..MoveTime)
        if Humanoid.FloorMaterial == Enum.Material.Air then
            print("GroundSlam executed while in Freefall state for player: "..player.Name)
            data.AnimationVariant = "AirVariant"
            data.AnimationId = "rbxassetid://138359359331086"
            data:AddRangeToDoEffect(15)
            PlayMoveAnimationEvent:FireClient(player, data)
            -- Add actual GroundSlam air variant implementation here

        else
            print("GroundSlam executed while NOT in Freefall state for player: "..player.Name)
            data.AnimationVariant = "GroundVariant"
            data.AnimationId = "rbxassetid://73931025616831"
            PlayMoveAnimationEvent:FireClient(player, data)
            -- Add actual GroundSlam ground variant implementation here
        end
    else
        print("Cannot use GroundSlam move: Humanoid not found for player "..player.Name)
    end
end

return module