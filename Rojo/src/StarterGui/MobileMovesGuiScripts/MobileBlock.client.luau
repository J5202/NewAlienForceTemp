local BlockingEvent = game.ReplicatedStorage.RemoteEvents.Blocking

local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui", 2)
if not MobileMovesGui then
    warn("MobileBlock button not found in MobileMovesGui.")
    return
end
local MobileBlock:ImageButton = MobileMovesGui:WaitForChild("Block",2)

MobileBlock.InputBegan:Connect(function(input)
    print("Blocking Press")
	local Animator:Animator = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):WaitForChild("Animator")
	local IsAwakening = game.Players.LocalPlayer.Character.States.IsAwakening
	local Stunned = game.Players.LocalPlayer.Character.States.Stunned

	if IsAwakening.Value == true then return end

	if Stunned.Value == false then
		BlockingEvent:FireServer(true)
		local BlockingAnimationId = "rbxassetid://105839001345701"
		local BlockingAnimation = Instance.new("Animation")
		BlockingAnimation.Name = "BlockingAnim"
		BlockingAnimation.AnimationId = BlockingAnimationId
		Animator:LoadAnimation(BlockingAnimation):Play()
	end    
end)

MobileBlock.InputEnded:Connect(function(input)
    local Animator:Animator = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):WaitForChild("Animator")
    BlockingEvent:FireServer(false)
    for i, animation in pairs(Animator:GetPlayingAnimationTracks()) do
        if animation.Name == "BlockingAnim" then
            animation:Stop()
        end
    end
end)