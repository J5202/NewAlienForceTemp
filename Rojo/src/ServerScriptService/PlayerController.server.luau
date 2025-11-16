local PlayerService = game:GetService("Players")

local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local RemoteFunctions = game.ReplicatedStorage.RemoteFunctions

local StatesModule = require(Modules.States)

local GiveStates = RemoteEvents.GiveStates
local SetStunnable = RemoteEvents.SetStunnable
local ChangeStyle = RemoteEvents.ChangeStyle

local InvokeTopBar = RemoteFunctions.InvokeTopBar

GiveStates.OnServerEvent:Connect(function(player)
	StatesModule.GiveStates(player)
	InvokeTopBar:InvokeClient(player)
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
	local RemoveTopbar = RemoteEvents.RemoveTopbar
	RemoveTopbar:FireClient(player)
	print("Yea remove topbar")
	player:LoadCharacter()
	if Style then
		Style.Value = StyleValue
		print("Setting Style to ", StyleValue, " for player ", player.Name)
	else
		warn("Style value not found for player ", player.Name)
	end
end)

