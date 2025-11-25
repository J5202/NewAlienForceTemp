local PcMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PcMovesGui", 5)
local CharacterMoves = require(script.Parent:WaitForChild("CharactersMoves"))

local Holder = PcMovesGui:WaitForChild("Holder", 5)

local Move1 = Holder:WaitForChild("Move1", 5)
local Move2 = Holder:WaitForChild("Move2", 5)
local Move3 = Holder:WaitForChild("Move3", 5)
local Move4 = Holder:WaitForChild("Move4", 5)

local Style = game.Players.LocalPlayer:WaitForChild("Style", 5).Value
local Awakened = game.Players.LocalPlayer.Character:WaitForChild("States", 10):WaitForChild("Awakened", 5)

function updateMoves()
    if Awakened.Value == false then
        Move1.Text = CharacterMoves.NormalMoves[Style].Move1
        Move2.Text = CharacterMoves.NormalMoves[Style].Move2
        Move3.Text = CharacterMoves.NormalMoves[Style].Move3
        Move4.Text = CharacterMoves.NormalMoves[Style].Move4
    else
        -- -- Assuming there is an AwakenedMoves table similar to NormalMoves
        Move1.Text = CharacterMoves.AwakenedMoves[Style].Move1
        Move2.Text = CharacterMoves.AwakenedMoves[Style].Move2
        Move3.Text = CharacterMoves.AwakenedMoves[Style].Move3
        Move4.Text = CharacterMoves.AwakenedMoves[Style].Move4
    end
end

updateMoves()

Awakened.Changed:Connect(updateMoves)