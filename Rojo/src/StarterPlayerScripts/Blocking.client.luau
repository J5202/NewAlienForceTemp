local BlockingEvent = game.ReplicatedStorage.RemoteEvents.Blocking

local UserInputService = game:GetService("UserInputService")

local Animator:Animator = game.Players.LocalPlayer.CharacterAdded:Wait():WaitForChild("Humanoid"):WaitForChild("Animator")

UserInputService.InputBegan:Connect(function(input:InputObject, gpe:boolean)
	if gpe then return end
	
	if input.KeyCode == Enum.KeyCode.F then
		local Stunned = game.Players.LocalPlayer.Character.States.Stunned
		if Stunned.Value == false then
			BlockingEvent:FireServer(true)
			local BlockingAnimationId = "rbxassetid://105839001345701"
			local BlockingAnimation = Instance.new("Animation")
			BlockingAnimation.Name = "BlockingAnim"
			BlockingAnimation.AnimationId = BlockingAnimationId
			Animator:LoadAnimation(BlockingAnimation):Play()
		end
	end
end)

UserInputService.InputEnded:Connect(function(input:InputObject, gpe:boolean)
	if gpe then return end

	if input.KeyCode == Enum.KeyCode.F then
		BlockingEvent:FireServer(false)
		for i, animation in pairs(Animator:GetPlayingAnimationTracks()) do
			if animation.Name == "BlockingAnim" then
				animation:Stop()
			end
		end
	end
end)