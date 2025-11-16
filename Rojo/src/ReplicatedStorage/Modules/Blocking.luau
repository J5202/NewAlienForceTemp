local module = {}
module.__index = module

function module.Player(player:Player)
	local self = setmetatable({}, module)
	self.Stunned = player.Character:WaitForChild("States"):WaitForChild("Stunned")
	self.Blocking = player.Character:WaitForChild("States"):WaitForChild("Blocking")
	
	return self
end

function module:SetBlocking(player:Player, blockingvalue)
	if self.Stunned.Value == false then
		self.Blocking.Value = blockingvalue
		print( player.DisplayName .."'s Blocking Is ")
		print(blockingvalue)
	else
		print("Player is stunned, cannot block")
	end
end

return module
