local module = {}
module.__index = module

function module.Hitbox(HitboxInUse)
	local self = setmetatable({}, module)
	self.HitboxInUse = HitboxInUse
	
	return self
end

function module:PlaceHitboxInFront(player:Player)
	local Hitbox:Part = self.HitboxInUse:Clone()
	Hitbox.Parent = player.Character
	Hitbox.Anchored = true
	Hitbox.CanCollide = false
	
	local PlayerHRP:Part = player.Character.HumanoidRootPart
	Hitbox.CFrame = PlayerHRP.CFrame * CFrame.new(0,0,-2)
	
	local Params = OverlapParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {player.Character}
	
	local partsinregion = workspace:GetPartBoundsInBox(Hitbox.CFrame, Hitbox.Size, Params)
	local partsinregiontable = {}
	
	for i, parts in pairs(partsinregion) do
		if parts ~= Hitbox then
			table.insert(partsinregiontable, parts)
		end
	end
	
	--task.wait(2) 
	Hitbox:Destroy()
	return partsinregiontable
	
end

function module:PlaceHitboxInfrontDown(player)
	local Hitbox:Part = self.HitboxInUse:Clone()
	Hitbox.Parent = player.Character
	Hitbox.Anchored = true
	Hitbox.CanCollide = false
	
	local PlayerHRP:Part = player.Character.HumanoidRootPart
	Hitbox.CFrame = PlayerHRP.CFrame * CFrame.new(0,-9,-2)
	
	local Params = OverlapParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {player.Character}
	
	local partsinregion = workspace:GetPartBoundsInBox(Hitbox.CFrame, Hitbox.Size, Params)
	local partsinregiontable = {}
	
	for i, parts in pairs(partsinregion) do
		if parts ~= Hitbox then
			table.insert(partsinregiontable, parts)
		end
	end
	
	--task.wait(2) 
	Hitbox:Destroy()
	return partsinregiontable	
end

function module:PlaceHitboxAround(player)
	local Hitbox:Part = self.HitboxInUse:Clone()
	Hitbox.Parent = player.Character
	Hitbox.Anchored = true
	Hitbox.CanCollide = false
	
	local PlayerHRP:Part = player.Character.HumanoidRootPart
	Hitbox.CFrame = PlayerHRP.CFrame * CFrame.new(0,0,0)
	
	local Params = OverlapParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = {player.Character}
	
	local partsinregion = workspace:GetPartBoundsInBox(Hitbox.CFrame, Hitbox.Size, Params)
	local partsinregiontable = {}
	
	for i, parts in pairs(partsinregion) do
		if parts ~= Hitbox then
			table.insert(partsinregiontable, parts)
		end
	end
	
	--task.wait(2) 
	Hitbox:Destroy()
	return partsinregiontable
end

function module:IsAttackerInfront(attackerRoot, defenderRoot)
	if not (attackerRoot and defenderRoot) then return false end

	-- Vector from defender to attacker
	local directionToAttacker = (attackerRoot.Position - defenderRoot.Position).Unit

	-- Defender's forward direction
	local defenderForward = defenderRoot.CFrame.LookVector

	-- Compare their alignment
	local dot = defenderForward:Dot(directionToAttacker)

	-- dot > 0 means attacker is in front (within 180°)
	-- dot > 0.5 means roughly within a 90° front cone
	return dot > 0
end

return module
