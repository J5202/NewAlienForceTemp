local PlayerService = game:GetService("Players")

local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local RemoteFunctions = game.ReplicatedStorage.RemoteFunctions
local BindableEvents = game.ReplicatedStorage.BindableEvents

local StatesModule = require(Modules.States)

local GiveStates = RemoteEvents.GiveStates
local SetStunnable = RemoteEvents.SetStunnable
local ChangeStyle = RemoteEvents.ChangeStyle
local ResetFromEarlyAccess = BindableEvents.ResetFromEarlyAccess

local InvokeTopBar = RemoteFunctions.InvokeTopBar

GiveStates.OnServerEvent:Connect(function(player)
	StatesModule.GiveStates(player)
	InvokeTopBar:InvokeClient(player)
	local Humanoid:Humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.MaxHealth = 120
	end
	print("Giving States")
end)

SetStunnable.OnServerEvent:Connect(function(player:Player, StunnableValue:boolean)
	local States = player.Character:WaitForChild("States")
	local Stunnable = States:WaitForChild("Stunnable")
	print(StunnableValue)

	Stunnable.Value = StunnableValue
	print("Setting Stunnable to ", StunnableValue, " for player ", player.Name)
end)

ChangeStyle.OnServerEvent:Connect(function(player:Player, StyleValue:string)
	local Style = player:WaitForChild("Style", 0.02)
	if Style and StyleValue ~= Style.Value then
		Style.Value = StyleValue
		player:LoadCharacter()
		print("Setting Style to ", StyleValue, " for player ", player.Name)
	else
		warn("Style value not found for player ", player.Name.." or StyleValue is the same as "..player.Name.."'s current style.")
	end
end)

-- ResetFromEarlyAccess.Event:Connect(function(player)
-- 	local Style = player:WaitForChild("Style", 0.02)
-- 	if Style and "XLR8" ~= Style.Value then
-- 		Style.Value = "XLR8"
-- 		player:LoadCharacter()
-- 		print("Setting Style to XLR8 for player ", player.Name)
-- 	else
-- 		warn("Style value not found for player ", player.Name.." or StyleValue is the same as "..player.Name.."'s current style.")
-- 	end
-- end)

