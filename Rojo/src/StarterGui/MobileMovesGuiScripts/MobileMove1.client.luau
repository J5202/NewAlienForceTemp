local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui")

local Holder = MobileMovesGui:WaitForChild("Holder")

local Move1Event:RemoteEvent = game.ReplicatedStorage.RemoteEvents:WaitForChild("Move1")
local SetMove1ClickableEventMobile:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1ClickableMobile")

local Move1Button:TextButton = Holder:WaitForChild("Move1")
local Move1Time = 0
local Move1Clickable = true

-- SetMove1ClickableEventMobile.OnClientEvent:Connect(function(clickable:boolean, cooldowntime:number)
--     Move1Clickable = clickable
--     print(Move1Clickable)
--     print("Move1Clickable set to: "..tostring(Move1Clickable))
--     print("Move1 cooldown time set to: "..tostring(cooldowntime).." seconds.")
-- end)

local CooldownFrame: Frame = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui"):WaitForChild("Holder"):WaitForChild("Move1"):WaitForChild("CooldownFrame")

SetMove1ClickableEventMobile.OnClientEvent:Connect(function(clickable: boolean, cooldowntime: number)
    Move1Clickable = clickable

    -- Reset cooldown bar to empty
    CooldownFrame.Size = UDim2.new(1, 0, 0, 0)
    CooldownFrame.Visible = true

    if cooldowntime and cooldowntime > 0 then
        local elapsed = 0

        -- Smoothly fill the bar over time
        while elapsed < cooldowntime do
            elapsed += task.wait()

            local percent = math.clamp(elapsed / cooldowntime, 0, 1)
            CooldownFrame.Size = UDim2.new(1, 0, percent, 0)
        end

        -- Ensure fully filled at the end
        CooldownFrame.Visible = false
        CooldownFrame.Size = UDim2.new(1, 0, 1, 0)
    end
end)

Move1Button.InputEnded:Connect(function(input)
        local CanAttack = game.Players.LocalPlayer.Character:WaitForChild("States"):WaitForChild("CanAttack").Value
        if CanAttack == false then return end

        if Move1Clickable == false then return end
        Move1Event:FireServer(Move1Time)
        print("Move1Clickable is "..Move1Clickable)
        Move1Time = tick()
end)