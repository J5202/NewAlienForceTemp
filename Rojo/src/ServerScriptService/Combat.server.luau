local Modules = game.ReplicatedStorage.Modules
local RemoteEvents = game.ReplicatedStorage.RemoteEvents

local M1Module = require(Modules.M1)
local BlockingModule = require(Modules.Blocking)

local BlockingEvent = RemoteEvents.Blocking

M1Module.m1()

BlockingEvent.OnServerEvent:Connect(function(player:Player, blockingvalue:boolean)
	local Blocker = BlockingModule.Player(player)
	Blocker:SetBlocking(player, blockingvalue)
end)
