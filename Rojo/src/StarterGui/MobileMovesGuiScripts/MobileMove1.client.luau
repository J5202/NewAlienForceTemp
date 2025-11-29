local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui")

local Holder = MobileMovesGui:WaitForChild("Holder")

local Move1Event:RemoteEvent = game.ReplicatedStorage.RemoteEvents:WaitForChild("Move1")
local SetMove1ClickableEvent:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1ClickableMobile")

local Move1Button:TextButton = Holder:WaitForChild("Move1")
local Move1Time = 0
local Move1Clickable = true

SetMove1ClickableEvent.OnClientEvent:Connect(function(clickable:boolean, cooldowntime:number)
    Move1Clickable = clickable
    print(Move1Clickable)
    print("Move1Clickable set to: "..tostring(Move1Clickable))
    print("Move1 cooldown time set to: "..tostring(cooldowntime).." seconds.")
end)

Move1Button.InputEnded:Connect(function(input)
        local CanAttack = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("CanAttack").Value
        if CanAttack == false then return end

        Move1Event:FireServer(Move1Time)
        print("Move1Clickable is "..Move1Clickable)
        if Move1Clickable == false then return end
        Move1Time = tick()
end)