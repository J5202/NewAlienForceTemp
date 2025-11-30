local PcMovesGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PcMovesGui", 20)
local CharacterMoves = require(game.Players.LocalPlayer.PlayerGui.CharactersMoves)

local Holder = PcMovesGui:WaitForChild("Holder", 30)

local Move1 = Holder:WaitForChild("Move1", 30)
local Move2 = Holder:WaitForChild("Move2", 30)
local Move3 = Holder:WaitForChild("Move3", 30)
local Move4 = Holder:WaitForChild("Move4", 30)

local Style:StringValue = game.Players.LocalPlayer:WaitForChild("Style", 30)
local Awakened = game.Players.LocalPlayer.Character:WaitForChild("States", 10):WaitForChild("Awakened", 30)

function updateMoves()
    if Awakened.Value == false then
        Move1.Text = CharacterMoves.NormalMoves[Style.Value].Move1
        Move2.Text = CharacterMoves.NormalMoves[Style.Value].Move2
        Move3.Text = CharacterMoves.NormalMoves[Style.Value].Move3
        Move4.Text = CharacterMoves.NormalMoves[Style.Value].Move4
    else
        -- -- Assuming there is an AwakenedMoves table similar to NormalMoves
        Move1.Text = CharacterMoves.AwakenedMoves[Style.Value].Move1
        Move2.Text = CharacterMoves.AwakenedMoves[Style.Value].Move2
        Move3.Text = CharacterMoves.AwakenedMoves[Style.Value].Move3
        Move4.Text = CharacterMoves.AwakenedMoves[Style.Value].Move4
    end
end

updateMoves()

task.wait(3)

function updateMoves()
    if Awakened.Value == false then
        Move1.Text = CharacterMoves.NormalMoves[Style.Value].Move1
        Move2.Text = CharacterMoves.NormalMoves[Style.Value].Move2
        Move3.Text = CharacterMoves.NormalMoves[Style.Value].Move3
        Move4.Text = CharacterMoves.NormalMoves[Style.Value].Move4
    else
        -- -- Assuming there is an AwakenedMoves table similar to NormalMoves
        Move1.Text = CharacterMoves.AwakenedMoves[Style.Value].Move1
        Move2.Text = CharacterMoves.AwakenedMoves[Style.Value].Move2
        Move3.Text = CharacterMoves.AwakenedMoves[Style.Value].Move3
        Move4.Text = CharacterMoves.AwakenedMoves[Style.Value].Move4
    end
end

updateMoves()

Style.Changed:Connect(updateMoves)

Awakened.Changed:Connect(updateMoves)