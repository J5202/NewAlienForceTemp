local module = {}

local HitboxModule = require(game.ReplicatedStorage.Modules.Utilities.Hitbox)
local KnockbackModule = require(game.ReplicatedStorage.Modules.Utilities.Knockback)

local M1Hitbox = game.ReplicatedStorage.Hitbox.M1Hitbox

function module.m1 ()
	local M1Event = game.ReplicatedStorage.RemoteEvents.M1
	M1Event.OnServerEvent:Connect(function(player, combostep)
		print(player.DisplayName.. " just did m1 step ".. combostep)
		local Hitbox = HitboxModule.Hitbox(M1Hitbox)
		local HRP:Part = player.Character:WaitForChild("HumanoidRootPart", 2)
		local PartsInRange = Hitbox:PlaceHitboxInFront(player)
		
		local Target = nil
		
		for i, targets in pairs(PartsInRange) do
			if targets.Name == "HumanoidRootPart" then
				Target = targets.Parent
				print("Target is HRP")
			end
		end
		
		if Target ~= nil then
			local PlayerAwakening = player:WaitForChild("PlayerAwakening", 0.01)
			
			local States:Folder = Target:WaitForChild("States", 0.01)
			local EnemyHumanoid:Humanoid = Target:WaitForChild("Humanoid", 0.01)
			local EnemyHRP:Part = Target:WaitForChild("HumanoidRootPart", 0.01)
			
		if States then
			local Blocking:BoolValue = States:WaitForChild("Blocking", 0.01)
			local Stunnable:BoolValue = States:WaitForChild("Stunnable", 0.01)
			local Stunned:BoolValue = States:WaitForChild("Stunned", 0.01)
			if Blocking.Value == true then
				local IsAttackerForward = HitboxModule:IsAttackerInfront(HRP, EnemyHRP)
				if IsAttackerForward then
					print("Cant do Nothing, Go behind em")
				else
					if EnemyHumanoid and EnemyHumanoid.Health > 0 then
						local EnemyAnimator:Animator = EnemyHumanoid:FindFirstChildOfClass("Animator")

						local M1EffectAnimationId = "rbxassetid://96823706042833"
						local M1EffectAnimation = Instance.new("Animation")
						M1EffectAnimation.AnimationId = M1EffectAnimationId

						local EnemyPlayer = game.Players:GetPlayerFromCharacter(Target)
						--local EnemyHRP:Part = Target:WaitForChild("HumanoidRootPart", 0.01)

						if EnemyPlayer then
							if Stunnable.Value == true then
								print(EnemyPlayer.DisplayName.. " was hit by ".. player.DisplayName)
								EnemyHumanoid.Health -= 4
								PlayerAwakening.Value += math.random(2, 4)
								Blocking.Value = false
								Stunned.Value = true
								task.delay(1, function()
									Stunned.Value = false
								end)
								EnemyAnimator:LoadAnimation(M1EffectAnimation):Play()
								KnockbackModule:ApplyKnockBack(HRP,EnemyHRP,2)
								print("Block Broken")
							end
						else
							print(Target.Name.. " was hit by ".. player.DisplayName)
							EnemyHumanoid.Health -= 4
							PlayerAwakening.Value += math.random(2,4)
							Blocking.Value = false
							EnemyAnimator:LoadAnimation(M1EffectAnimation):Play()
							KnockbackModule:ApplyKnockBack(HRP,EnemyHRP,2)
							print("Block Broken")
						end
					end
				end
			else
				if EnemyHumanoid and EnemyHumanoid.Health > 0 then
					local EnemyPlayer = game.Players:GetPlayerFromCharacter(Target)

					local EnemyAnimator:Animator = EnemyHumanoid:FindFirstChildOfClass("Animator")
					
					local M1EffectAnimationId = "rbxassetid://96823706042833"
					local M1EffectAnimation = Instance.new("Animation")
					M1EffectAnimation.AnimationId = M1EffectAnimationId

					if EnemyPlayer then
						if Stunnable.Value == true then
							print(EnemyPlayer.DisplayName.. " was hit by ".. player.DisplayName)
							EnemyHumanoid.Health -= 4
							PlayerAwakening.Value += 2 or 4
							Stunned.Value = true
							task.delay(1, function()
								Stunned.Value = false
							end)
							EnemyAnimator:LoadAnimation(M1EffectAnimation):Play()
							KnockbackModule:ApplyKnockBack(HRP,EnemyHRP,2)
						end
					else
						print(Target.Name.. " was hit by ".. player.DisplayName)
						EnemyHumanoid.Health -= 4
						PlayerAwakening.Value += math.random(2,4)
						EnemyAnimator:LoadAnimation(M1EffectAnimation):Play()
						KnockbackModule:ApplyKnockBack(HRP,EnemyHRP,2)
					end
				end
			end
			
		end
	end
		
	end)
end

return module
