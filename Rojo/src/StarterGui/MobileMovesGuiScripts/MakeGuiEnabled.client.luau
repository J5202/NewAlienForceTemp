local MobileMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MobileMovesGui", 5)
local MobileMovesGuiScripts = game.Players.LocalPlayer.PlayerGui.MobileMovesGuiScripts

if game:GetService("UserInputService").TouchEnabled then
    if MobileMovesGui then
        MobileMovesGui.Enabled = true
    else
        warn("MobileMovesGui not found in PlayerGui.")
    end
else
    if MobileMovesGui then
        MobileMovesGuiScripts:Destroy()
        MobileMovesGui.Enabled = false
        MobileMovesGui:Destroy()
    end
end