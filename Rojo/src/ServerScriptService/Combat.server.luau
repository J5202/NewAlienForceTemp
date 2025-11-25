local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = game.ReplicatedStorage.RemoteEvents

local M1Module = require(Modules.M1)
local BlockingModule = require(Modules.Blocking)
local MovesetsMain = require(Modules.Characters.MovesetsMain)

local BlockingEvent = RemoteEvents.Blocking
local Move1Event = RemoteEvents.Move1

M1Module.m1()

BlockingEvent.OnServerEvent:Connect(function(player:Player, blockingvalue:boolean)
	local Blocker = BlockingModule.Player(player)
	Blocker:SetBlocking(player, blockingvalue)
end)

Move1Event.OnServerEvent:Connect(function(player, Move1Time)
	local Style = player:FindFirstChild("Style").Value
	local Awakened = player.Character:WaitForChild("States"):WaitForChild("Awakened")
	if Awakened.Value == false then
		MovesetsMain.CharacterModules[Style].Move1(player, Move1Time)
	else 
		MovesetsMain.CharacterModules[Style].AwkMove1(player, Move1Time)
	end
end)
