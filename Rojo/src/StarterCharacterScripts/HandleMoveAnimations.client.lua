local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid:Humanoid = Character:WaitForChild("Humanoid")
local Animator:Animator = Humanoid:WaitForChild("Animator")
local HRP:Part = Character:WaitForChild("HumanoidRootPart")

local PlayMoveAnimationEvent = game.ReplicatedStorage.RemoteEvents.PlayMoveAnimation

PlayMoveAnimationEvent.OnClientEvent:Connect(function(data)
    if data.AnimationVariant == "AirVariant" then
        print("Animation Playing is An Air Variant Move")

        local Animation = Instance.new("Animation")
        Animation.AnimationId = data.AnimationId
        local AnimationTrack = Animator:LoadAnimation(Animation)
        AnimationTrack.Name = data.AnimationName

        local BelowCharacterRaycastParams = RaycastParams.new()
        BelowCharacterRaycastParams.FilterType = Enum.RaycastFilterType.Exclude
        BelowCharacterRaycastParams.FilterDescendantsInstances = Character:GetDescendants()
        local BelowCharacterRaycast = workspace:Raycast(HRP.Position, Vector3.new(HRP.Position.X, -500, HRP.Position.Z), BelowCharacterRaycastParams)
        local Distance = BelowCharacterRaycast and (HRP.Position.Y - BelowCharacterRaycast.Instance.Position.Y)

        if Distance > 13 then
            AnimationTrack:Play(0.35,1, data.AnimationSpeed)
        else 
            AnimationTrack:Play(0,1, data.AnimationSpeed)
        end

        while true do
            BelowCharacterRaycast = workspace:Raycast(HRP.Position, Vector3.new(HRP.Position.X, -500, HRP.Position.Z), BelowCharacterRaycastParams)
            local Distance = BelowCharacterRaycast and (HRP.Position.Y - BelowCharacterRaycast.Instance.Position.Y)

            if Distance > 13 then
                print("Yep, too high to stop!")
            else
                break -- close enough to ground
            end

            task.wait(0.01)
        end

        task.delay(0.12, function()
            AnimationTrack:Stop(0.5)
        end)

        


    elseif data.AnimationVariant == "GroundVariant" then
        print("Animation Playing is A Ground Variant Move")

        Humanoid.WalkSpeed = 0
        Humanoid.JumpHeight = 0

        local Animation = Instance.new("Animation")
        Animation.AnimationId = data.AnimationId
        local AnimationTrack = Animator:LoadAnimation(Animation)
        AnimationTrack.Name = data.AnimationName
        AnimationTrack:Play(0.00001,1, data.AnimationSpeed)

        if data.UnStunAfterAnim == true then
            AnimationTrack.Ended:Connect(function()
                Humanoid.WalkSpeed = 24
                Humanoid.JumpHeight = 14
            end)
        end
        
        if data.AnimationEventName  then
           -- AnimationTrack.
        end
    end
    
end)

