local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui", 5)

if game:GetService("UserInputService").TouchEnabled then
    if MobileMovesGui then
        MobileMovesGui.Enabled = true
    else
        warn("MobileMovesGui not found in PlayerGui.")
    end
end