local Icon = require(script.Parent:WaitForChild("topbarplus"))

local ChangeCharacterEvent = game.ReplicatedStorage.RemoteEvents.ChangeStyle

local FireMan = Icon.new()
FireMan:autoDeselect(true)
FireMan:debounce(1)
FireMan:bindEvent("selected", function()
	task.delay(0.01, function()
		FireMan:deselect()
		print("Selected")
	end)
	ChangeCharacterEvent:FireServer("HeatBlast")
end)
FireMan:setEnabled(true)
FireMan:setName("HeatBlast")
FireMan:setLabel("Fire Man", "Deselected")

local RedMan = Icon.new()
RedMan:autoDeselect(true)
RedMan:debounce(1)
RedMan:bindEvent("selected", function()
	task.delay(0.01, function()
		ChangeCharacterEvent:FireServer("FourArms")
		RedMan:deselect()
	end)
end)
RedMan:setEnabled(true)
RedMan:setName("FourArms")
RedMan:setLabel("Red Man", "Deselected")

module = {
    FireMan = FireMan,
    RedMan = RedMan
}

return module