local InvokeTopBar = game.ReplicatedStorage.RemoteFunctions.InvokeTopBar
local ActivateSettings:BindableEvent = game.ReplicatedStorage.BindableEvents.ActivateSetting

InvokeTopBar.OnClientInvoke = function()   
    local Icon = require(script.Parent:WaitForChild("topbarplus"))
    local Characters = require(script.Parent:WaitForChild("TopBarCharacters"))

    local CharactersList = {
        Characters.FireMan,
        Characters.RedMan,
        Characters.SpeedMan
    }

    local Emotes = Icon.getIcon("Emotes")
    if Emotes then
        print("Emotes found, destroying...")
        Emotes:destroy()
    end

    local Settings = Icon.getIcon("Settings")
    if Settings then
        print("Settings found, destroying...")
        Settings:destroy()
    end

    local CharacterDropDown = Icon.new()
    CharacterDropDown:setLabel("Characters")
    CharacterDropDown:setDropdown(CharactersList)
    CharacterDropDown:setName("Characters")

    local EmotesIcon = Icon.new()
    EmotesIcon:setName("Emotes")
    EmotesIcon:setLabel("Emotes")
    EmotesIcon:bindEvent("selected", function()
        print("Emotes Button Pressed, Add popup")
        EmotesIcon:deselect()
    end)

    local Settings = Icon.new()
    Settings:setName("Settings")
    Settings:setLabel("Settings")
    Settings:bindEvent("selected", function()
        ActivateSettings:Fire()
        Settings:deselect()
    end)

end


