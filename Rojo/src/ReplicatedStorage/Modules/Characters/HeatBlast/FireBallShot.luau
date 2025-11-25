local FireBallShot = {}
FireBallShot.__index = FireBallShot

local HitboxModule = require(game.ReplicatedStorage.Modules.Utilities.Hitbox)

function FireBallShot.UseMove()
    print("FireBallShot move used!")
end

return FireBallShot