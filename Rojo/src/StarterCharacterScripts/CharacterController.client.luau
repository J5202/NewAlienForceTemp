local RemoteEvents = game.ReplicatedStorage.RemoteEvents
local BindableEvents = game.ReplicatedStorage.BindableEvents
local RemoteFunctions = game.ReplicatedStorage.RemoteFunctions
local BindableFunctions = game.ReplicatedStorage.BindableFunctions

local UIS = game:GetService("UserInputService")

local GiveStates = RemoteEvents.GiveStates
local SetStunnable = RemoteEvents.SetStunnable
local ResetEvent = BindableEvents.Reset
local ResetForCharacterSwitch = BindableFunctions.ResetForCharacterSwitch

GiveStates:FireServer()

task.delay(20, function()
    SetStunnable:FireServer(true)
end)

ResetEvent.Event:Connect(function()
    local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 0.2) or game.Players.LocalPlayer.CharacterAdded:WaitForChild("Humanoid", 5)
    local CanReset = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("CanReset", 0.2) or game.Players.LocalPlayer.CharacterAdded:WaitForChild("States"):WaitForChild("CanReset", 5)
    if CanReset.Value == true then
        Humanoid.Health = 0
        print("Player has been reset.")
    else
        print("Cannot reset right now.")
    end
end)

ResetForCharacterSwitch.OnInvoke = function()
    local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid", 0.2) or game.Players.LocalPlayer.CharacterAdded:WaitForChild("Humanoid", 5)
    local CanReset = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("CanReset", 0.2) or game.Players.LocalPlayer.CharacterAdded:WaitForChild("States"):WaitForChild("CanReset", 5)
    if CanReset.Value == true then
        --Humanoid.Health = 0
        print("Player has been reset.")
        return true
    else
        print("Cannot reset right now.")
        return false
    end
end

local Debounce = false

task.delay(5, function()
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", ResetEvent)
end)


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

