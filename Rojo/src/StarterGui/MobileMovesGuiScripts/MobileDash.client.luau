local UIS = game:GetService("UserInputService")
local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui")

local DashButton:ImageButton = MobileMovesGui.Dash

local swipe_Direction = "Up"

function resetswipeDirection()
    task.delay(4,function()
        swipe_Direction = "Up"
    end)
end

UIS.TouchDrag:Connect(function(swipeDirection, numberOfTouches, gameProcessedEvent)
    if gameProcessedEvent then return end

    if swipeDirection == Enum.SwipeDirection.Up then
        swipe_Direction = "Up"
    elseif swipeDirection == Enum.SwipeDirection.Down then 
        swipe_Direction = "Down"
        resetswipeDirection()
    elseif swipeDirection == Enum.SwipeDirection.Left then  
        swipe_Direction = "Left"
        resetswipeDirection()
    elseif swipeDirection == Enum.SwipeDirection.Right then
        swipe_Direction = "Right"
        resetswipeDirection()
    end
end)

DashButton.InputBegan:Connect(function(input)
    if swipe_Direction ~= nil then
        print(swipe_Direction)
    end
end)