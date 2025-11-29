local Player = game.Players.LocalPlayer
local Character = Player.Character
local Animator:Animator = Character:WaitForChild("Humanoid"):WaitForChild("Animator")

local PlayMoveAnimationEvent = game.ReplicatedStorage.RemoteEvents.PlayMoveAnimation
local EndOfMoveEvent = game.ReplicatedStorage.RemoteEvents.EndOfMoveEvent

PlayMoveAnimationEvent.OnClientEvent:Connect(function(data)
    if data.AnimationVariant == "AirVariant" then
        print("Animation Playing is An Air Variant Move")
    elseif data.AnimationVariant == "GroundVariant" then
        print("Animation Playing is A Ground Variant Move")

        local Animation = Instance.new("Animation")
        Animation.AnimationId = data.AnimationId
        local AnimationTrack = Animator:LoadAnimation(Animation)
        AnimationTrack:Play(0.00001,1, data.AnimationSpeed)
        
        if data.AnimationEventName  then
           -- AnimationTrack.
        end
    end
    
end)

