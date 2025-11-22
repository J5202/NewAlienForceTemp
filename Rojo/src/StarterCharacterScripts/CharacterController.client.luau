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

    if input and Debounce == false then SetStunnable:FireServer(true) Debounce = true end
end)

local Stunned = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("Stunned", 0.2) or game.Players.LocalPlayer.CharacterAdded:WaitForChild("States"):WaitForChild("Stunned", 5)

Stunned.Changed:Connect(function()
    if Stunned.Value == true then
        print("Player is stunned, disable controls")
    else
        print("Player is no longer stunned, enable controls")
    end
end)
