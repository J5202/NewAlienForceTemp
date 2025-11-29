local module = {}
module.__index = module

local SetMove1ClickableEvent:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1Clickable")
local SetMove1ClickableEventMobile:RemoteEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("SetMove1ClickableMobile")

local GroundSlam = require(game.ReplicatedStorage.Modules.Characters.FourArms.GroundSlam)

function module.Move1(player, Move1Time)
    if tick() - Move1Time > 15 then
    -- Implementation for FourArms Move1 goes here
        print("FourArms Move1 executed at time: "..Move1Time)
        SetMove1ClickableEvent:FireClient(player, false, 10)
        SetMove1ClickableEventMobile:FireClient(player, false, 10)
        GroundSlam.UseMove(player, Move1Time)
        task.delay(15, function()
            print("FourArms Move1 is now off cooldown.")
            SetMove1ClickableEvent:FireClient(player, true, 10)
            SetMove1ClickableEventMobile:FireClient(player, true, 10)
        end)
    else 
        print("FourArms Move1 on cooldown. Time since last use: "..(tick() - Move1Time))
    end
end

return module