local RemoteEvents = game.ReplicatedStorage.RemoteEvents

local UIS = game:GetService("UserInputService")

local GiveStates = RemoteEvents.GiveStates
local SetStunnable = RemoteEvents.SetStunnable

GiveStates:FireServer()

task.delay(20, function()
    SetStunnable:FireServer(true)
end)

local Debounce = false

UIS.InputBegan:Once(function(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.Keyboard and Debounce == false then SetStunnable:FireServer(true) Debounce = true end
end)