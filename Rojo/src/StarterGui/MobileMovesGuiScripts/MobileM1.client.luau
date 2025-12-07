local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui", 2)
if not MobileMovesGui then
    warn("MobileBlock button not found in MobileMovesGui.")
    return
end
local M1Button:ImageButton = MobileMovesGui:WaitForChild("M1Button", 2)

local M1OneAnimId = "rbxassetid://99719359851694"
local M1TwoAnimId = "rbxassetid://103412070853654"
local M1ThreeAnimId = "rbxassetid://139782183247884"
local M1DownslamAnimId = "rbxassetid://103688037581254"

local inputholders = {combostep = 1, lastclicktime = tick(), lasttime = tick(), punchtimegap = tick()}

M1Button.InputBegan:Connect(function(input:InputObject)
        print("M1 Pressed")
		local Humanoid =game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
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
			elseif  inputholders.combostep == 4 then
				if Humanoid.FloorMaterial == Enum.Material.Air then
					print("Do DownSlam")
					Animation.AnimationId = M1DownslamAnimId
					Animator:LoadAnimation(Animation):Play()	
					inputholders.combostep = "DownSlam"
				end			 	
			end
				
			
			game.ReplicatedStorage.RemoteEvents.M1:FireServer(inputholders.combostep)
			if inputholders.combostep == "DownSlam" then
				inputholders.combostep = 5
			else 
				inputholders.combostep += 1
			end			
			inputholders.punchtimegap = tick()
			inputholders.lasttime = tick()
			
			if inputholders.combostep > 4 then
				inputholders.lastclicktime = tick()
				inputholders.lasttime = tick()
				inputholders.combostep = 1
			end	
		end    
end)

M1Button.InputEnded:Connect(function(input:InputObject)
    inputholders.holdtime = tick()
end)