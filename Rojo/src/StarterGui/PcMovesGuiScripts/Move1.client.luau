local UIS = game:GetService("UserInputService")

local Move1Event:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Move1")
local SetMove1ClickableEvent:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1Clickable")
local Move1Time = 0
local Move1Clickable = true

SetMove1ClickableEvent.OnClientEvent:Connect(function(clickable:boolean, cooldowntime:number)
    Move1Clickable = clickable
    print("Move1Clickable set to: "..tostring(Move1Clickable))
    print("Move1 cooldown time set to: "..tostring(cooldowntime).." seconds.")
end)

UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    local CanAttack = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("CanAttack").Value
    if CanAttack == false then return end

    if input.KeyCode == Enum.KeyCode.One then
        --print(Move1Clickable)
        Move1Event:FireServer(Move1Time)
        if Move1Clickable == false then return end
        Move1Time = tick()
        -- if Move1Clickable == true then  end 
    end
end)
