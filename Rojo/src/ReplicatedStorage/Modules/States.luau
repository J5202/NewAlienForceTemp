local module = {}

function module.GiveStates(player:Player)
	local States = Instance.new("Folder")
	States.Name = "States"
	States.Parent = player.Character or player.CharacterAdded:Wait()
	
	local Stunned = Instance.new("BoolValue")
	Stunned.Name = "Stunned"
	Stunned.Parent = States
	
	local Blocking = Instance.new("BoolValue")
	Blocking.Name = "Blocking"
	Blocking.Parent = States	
	
	local Stunnable = Instance.new("BoolValue")
	Stunnable.Name = "Stunnable"
	Stunnable.Parent = States
	Stunnable.Value = false

	local InAwakeningAnimation = Instance.new("BoolValue")
	InAwakeningAnimation.Name = "IsAwakening"
	InAwakeningAnimation.Parent = States
	InAwakeningAnimation.Value = false

	local CanReset = Instance.new("BoolValue")
	CanReset.Name = "CanReset"
	CanReset.Parent = States
	CanReset.Value = true
	
	local CanAttack = Instance.new("BoolValue")
	CanAttack.Name = "CanAttack"
	CanAttack.Parent = States
	CanAttack.Value = true

	local Awakened = Instance.new("BoolValue")
	Awakened.Name = "Awakened"
	Awakened.Parent = States
	Awakened.Value = false
	
	if not player:WaitForChild("PlayerAwakening", 0.01) then
		local AwkBar = Instance.new("IntValue")
		AwkBar.Name = "PlayerAwakening"
		AwkBar.Parent = player
		AwkBar.Value = 0
	end

	if not player:WaitForChild("Style", 0.01) then 
		local Style = Instance.new("StringValue")
		Style.Name = "Style"
		Style.Parent = player
		Style.Value = 0
	end
end

function module.GiveLeaderStats(player:Player)
	local Leaderstats = Instance.new("Folder")
	Leaderstats.Name = "leaderstats"
	Leaderstats.Parent = player
	
	local Kills = Instance.new("IntValue")
	Kills.Name = "Kills"
	Kills.Parent = Leaderstats
	Kills.Value = 0
	
end

return module
