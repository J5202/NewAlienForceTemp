local RemoteEvents = game.ReplicatedStorage.RemoteEvents

local UIS = game:GetService("UserInputService")

local GiveStates = RemoteEvents.GiveStates
local SetStunnable = RemoteEvents.SetStunnable

GiveStates:FireServer()

task.delay(20, function()
    SetStunnable:FireServer(true)
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input then SetStunnable:FireServer(true) end
end)