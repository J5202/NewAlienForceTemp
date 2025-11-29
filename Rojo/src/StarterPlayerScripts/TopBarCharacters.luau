local Icon = require(script.Parent:WaitForChild("topbarplus"))

local ChangeCharacterEvent = game.ReplicatedStorage.RemoteEvents.ChangeStyle
local ResetForCharacterSwitchEvent = game.ReplicatedStorage.BindableFunctions.ResetForCharacterSwitch

local FireMan = Icon.new()
FireMan:autoDeselect(true)
FireMan:debounce(1)
FireMan:bindEvent("selected", function()
	task.delay(0.01, function()
		FireMan:deselect()
	end)
	local CanReset = ResetForCharacterSwitchEvent:Invoke()
	if CanReset == false then
		return
	else 
		ChangeCharacterEvent:FireServer("HeatBlast")
	end
end)
FireMan:setEnabled(true)
FireMan:setName("HeatBlast")
FireMan:setLabel("Fire Man", "Deselected")
FireMan:setImage("rbxassetid://121250798600170", "Deselected")

local RedMan = Icon.new()
RedMan:autoDeselect(true)
RedMan:debounce(1)
RedMan:bindEvent("selected", function()
	task.delay(0.01, function()
		RedMan:deselect()
	end)
	local CanReset = ResetForCharacterSwitchEvent:Invoke()
	if CanReset == false then
		return
	else
		ChangeCharacterEvent:FireServer("FourArms")	
	end
end)
RedMan:setEnabled(true)
RedMan:setName("FourArms")
RedMan:setLabel("Red Man", "Deselected")
RedMan:setImage("rbxassetid://98468629387566", "Deselected")

local SpeedMan = Icon.new()
SpeedMan:setName("XLR8")
SpeedMan:setLabel("Speed Man")
SpeedMan:setImage("rbxassetid://70977876464174", "Deselected")

module = {
    FireMan = FireMan,
    RedMan = RedMan,
	SpeedMan = SpeedMan
}

return module