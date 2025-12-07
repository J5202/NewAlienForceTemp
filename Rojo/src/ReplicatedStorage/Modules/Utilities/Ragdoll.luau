local Ragdoll = {}
Ragdoll.__index = Ragdoll

function Ragdoll:Ragdoll(Character, player:Player, timetoragdollfor:number)
	if player ~= nil then
		player:SetAttribute("Stunned", true)
	end
	local Humanoid = Character:WaitForChild("Humanoid")
	if Humanoid.Health <= 0 then return end

	local motorData = {}
	local createdConstraints = {}

	for _, motor in pairs(Character:GetDescendants()) do
		if motor:IsA("Motor6D") and motor.Name ~= "RootJoint" and motor.Name ~= "Neck" then
			motorData[motor] = {
				Part0 = motor.Part0,
				Part1 = motor.Part1,
				C0 = motor.C0,
				C1 = motor.C1
			}

			-- ✅ FIXED: Use CFrame, NOT WorldCFrame
			local att0 = Instance.new("Attachment")
			att0.Name = "RagdollAttachment0_" .. motor.Name
			att0.CFrame = motor.C0
			att0.Parent = motor.Part0

			local att1 = Instance.new("Attachment")
			att1.Name = "RagdollAttachment1_" .. motor.Name
			att1.CFrame = motor.C1
			att1.Parent = motor.Part1

			local socket = Instance.new("BallSocketConstraint")
			socket.Name = "RagdollConstraint_" .. motor.Name
			socket.Attachment0 = att0
			socket.Attachment1 = att1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true
			socket.Parent = motor.Part0

			table.insert(createdConstraints, {socket, att0, att1})

			-- Disable after constraints exist
			motor.Enabled = false
		end
	end

	Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	Humanoid.PlatformStand = true

	task.wait(timetoragdollfor)

	for _, set in ipairs(createdConstraints) do
		for _, obj in ipairs(set) do
			if obj and obj.Parent then
				obj:Destroy()
			end
		end
	end

	for motor, data in pairs(motorData) do
		if motor and motor.Parent then
			motor.Enabled = true
		end
	end

	Humanoid.PlatformStand = false
	Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	if player~= nil then
		player:SetAttribute("Stunned", false)
	end
end

return Ragdoll