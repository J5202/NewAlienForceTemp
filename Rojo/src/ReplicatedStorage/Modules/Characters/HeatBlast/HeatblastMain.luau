local module = {}
module.__index = module

local SetMove1ClickableEvent:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1Clickable")

local FireBallShot = require(game.ReplicatedStorage.Modules.Characters.HeatBlast.FireBallShot)

function module.Move1(player, Move1Time)
    if tick() - Move1Time > 10 then
        print("Heat Blast Move 1 executed at time: "..Move1Time)
        FireBallShot.UseMove()
        print("Cooling down Heat Blast Move 1 for 10 seconds.")
        SetMove1ClickableEvent:FireClient(player, false, 10)
        task.delay(10, function()
            print("Heat Blast Move 1 is now off cooldown.")
            SetMove1ClickableEvent:FireClient(player, true, 10)
        end)
    else
        print("Heat Blast Move 1 on cooldown. Time since last use: "..(tick() - Move1Time))
    end
end

return module