local PcMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PcMovesGui", 5)

if game:GetService("UserInputService").KeyboardEnabled then
    if PcMovesGui then
        PcMovesGui.Enabled = true
    else
        warn("PcMovesGui not found in PlayerGui.")
    end
else
    if PcMovesGui then
        PcMovesGui.Enabled = false
        PcMovesGui:Destroy()
    end
end