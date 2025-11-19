local UIS = game:GetService("UserInputService")

local M1OneAnimId = "rbxassetid://99719359851694"
local M1TwoAnimId = "rbxassetid://103412070853654"
local M1ThreeAnimId = "rbxassetid://139782183247884"

local BlockingEvent = game.ReplicatedStorage.RemoteEvents.Blocking

local inputholders = {combostep = 1, lastclicktime = tick(), lasttime = tick(), punchtimegap = tick()}
local ButtonHold = false

UIS.InputBegan:Connect(function(input:InputObject, gpe:boolean)
	if gpe then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		print("M1 Pressed")
		local IsAwakening = game.Players.LocalPlayer.Character.States.IsAwakening
		local Animator = game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):WaitForChild("Animator", 0.2)
		local Stunned = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("Stunned", 0.2)
		local Blocking = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("Blocking", 0.2)
		
		if IsAwakening.Value == true then return end
		if Stunned == false then return end
		if Blocking == false then return end
		if Stunned.Value == true then return end
		if Blocking.Value == true then return end
		
		
		local timediff = tick() - inputholders.lastclicktime
		local resettimecheck = tick() - inputholders.lasttime
		local punchtimegap = tick() - inputholders.punchtimegap
		
		if resettimecheck > 1.5 then
			inputholders.combostep = 1
		end

		if inputholders.combostep < 5 and timediff > 1.4 and punchtimegap > 0.3 then
			print("M1 Executed")
			local Animation = Instance.new("Animation")
			if inputholders.combostep == 1 then
				Animation.AnimationId = M1OneAnimId
				Animator:LoadAnimation(Animation):Play()
			elseif inputholders.combostep == 2 then
				Animation.AnimationId = M1TwoAnimId
				Animator:LoadAnimation(Animation):Play()
			elseif inputholders.combostep == 3 then
				Animation.AnimationId = M1ThreeAnimId
				Animator:LoadAnimation(Animation):Play()	
			end
				
			
			game.ReplicatedStorage.RemoteEvents.M1:FireServer(inputholders.combostep)
			inputholders.combostep += 1
			inputholders.punchtimegap = tick()
			inputholders.lasttime = tick()
			
			if inputholders.combostep > 4 then
				inputholders.lastclicktime = tick()
				inputholders.lasttime = tick()
				inputholders.combostep = 1
			end	
		end
		
	end
end)

UIS.InputEnded:Connect(function(input:InputObject, gpe:boolean)
	if gpe then return end
	
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		inputholders.holdtime = tick()
	end
end)