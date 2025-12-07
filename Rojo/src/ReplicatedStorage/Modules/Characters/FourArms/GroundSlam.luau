local module = {}
module.__index = module

local AnimationDataModule = require(game.ReplicatedStorage.Modules.Utilities.AnimationData)
local HitboxModule = require(game.ReplicatedStorage.Modules.Utilities.Hitbox)
local KnockbackModule = require(game.ReplicatedStorage.Modules.Utilities.Knockback)
local RagdollModule = require(game.ReplicatedStorage.Modules.Utilities.Ragdoll)

local PlayMoveAnimationEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents").PlayMoveAnimation
local GroundSlamEffectEvent = game.ReplicatedStorage:WaitForChild("RemoteEvents").GroundSlamEffectEvent

local Hitbox:Part = game.ReplicatedStorage:WaitForChild("Hitbox").FourArms.GroundSlamHitbox

-- local data = {
--     AnimationId = "InputAnimationId",
--     AnimationEventName = "Slam",
--     AnimationVariant = nil,
--     AnimationSpeed = 0.75,
--    -- ApplyEffectAtAnimEnd = true
-- }

local data = AnimationDataModule.Data("GroundSlam", "InputAnimationId", "Slam", nil, 0.9, GroundSlamEffectEvent)

function module.UseMove(player, MoveTime)
    local Humanoid:Humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    local Animator:Animator = Humanoid:WaitForChild("Animator")
    
    if Humanoid then
        print("FourArms GroundSlam move used by player: "..player.Name.." at time: "..MoveTime)
        if Humanoid.FloorMaterial == Enum.Material.Air then
            print("GroundSlam executed while in Freefall state for player: "..player.Name)
            data.AnimationName = "GroundSlamAirVariant"
            data.AnimationVariant = "AirVariant"
            data.AnimationId = "rbxassetid://138359359331086"
            data:AddRangeToDoEffect(15)
            PlayMoveAnimationEvent:FireClient(player, data)
            -- Add actual GroundSlam air variant implementation here

        else
            print("GroundSlam executed while NOT in Freefall state for player: "..player.Name)
            data.AnimationName = "GroundSlamGroundVariant"
            data.AnimationVariant = "GroundVariant"
            data.AnimationId = "rbxassetid://139339279286412"
            data:UnstunAfterAnimation(3)
            PlayMoveAnimationEvent:FireClient(player, data)
            --task.wait(0)
            GroundSlamEffectEvent.OnServerEvent:Connect(function(player)
                local Hitbox = HitboxModule.Hitbox(Hitbox)
                local PartsinHitbox = Hitbox:PlaceHitboxAround(player)
                
                local HumanoidRootParts = {}
                table.clear(HumanoidRootParts)

                for i, part in pairs(PartsinHitbox) do
                    if part.Name == "HumanoidRootPart" then
                        if not table.find(HumanoidRootParts, part) then 
                            table.insert(HumanoidRootParts, part)
                        else 
                            print("Duplicate HumanoidRootPart found for character: "..part.Parent.Name)
                        end
                    end
                end
                
                for i, EnemyHRP in pairs(HumanoidRootParts) do
                    print("Applying GroundSlam effect to character: "..EnemyHRP.Parent.Name)
                    local EnemyCharacter = EnemyHRP.Parent
                    local States:Folder = EnemyCharacter:WaitForChild("States")
                    local Humanoid:Humanoid = EnemyCharacter:FindFirstChildOfClass("Humanoid")
                    local EnemyAnimator:Animator = Humanoid:FindFirstChildOfClass("Animator")
                    --local EnemyPlayer = game.Players:GetPlayerFromCharacter(Character)

                    local Stunned:BoolValue = States:FindFirstChild("Stunned")
                    local Blocking:BoolValue = States:FindFirstChild("Blocking")
                    local Stunnable:BoolValue = States:FindFirstChild("Stunnable")

                    if Blocking.Value == true then
                        Blocking.Value = false
                        for i , track in pairs(EnemyAnimator:GetPlayingAnimationTracks()) do
                            if track.Priority == Enum.AnimationPriority.Action then
                                track:Stop(0.2)
                            end
                        end
                    end

                    if Stunned and Stunnable.Value == true then
                        if Humanoid.Health - 8 <= 0 then
                            KnockbackModule:ApplyKnockUp(player.Character.HumanoidRootPart, EnemyHRP, 20, 100, 1)
                            RagdollModule:Ragdoll(EnemyHRP.Parent, nil, 5)
                            Humanoid.Health = 0
                        else 
                            task.spawn(function()
                                print(Humanoid.Health)
                                Humanoid:TakeDamage(8)
                                print(Humanoid.Health)
                                Stunned.Value = true
                                Stunnable.Value = false
                                print("Stunning character: "..EnemyCharacter.Name.." for 5 seconds.")
                                task.delay(5, function()
                                    Stunned.Value = false
                                    Stunnable.Value = true
                                 end)                            
                                KnockbackModule:ApplyKnockUp(player.Character.HumanoidRootPart, EnemyHRP, 15, 20, 1)
                                RagdollModule:Ragdoll(EnemyHRP.Parent, nil, 5)
                            end)
                        end
                    elseif not Stunned then 
                        print("No Stunned state found for character: "..EnemyCharacter.Name)
                    end

                end

            end)
            
            -- Add actual GroundSlam ground variant implementation here
        end
    else
        print("Cannot use GroundSlam move: Humanoid not found for player "..player.Name)
    end
end

return module