local InvokeTopBar = game.ReplicatedStorage.RemoteFunctions.InvokeTopBar

InvokeTopBar.OnClientInvoke = function()   
    local Icon = require(script.Parent:WaitForChild("topbarplus"))
    local Characters = require(script.Parent:WaitForChild("TopBarCharacters"))

    local CharactersList = {
        Characters.FireMan,
        Characters.RedMan
    }

    local Emotes = Icon.getIcon("Emotes")
    if Emotes then
        print("Emotes found, destroying...")
        Emotes:destroy()
    end

    local CharacterDropDown = Icon.new()
    CharacterDropDown:setLabel("Characters")
    CharacterDropDown:setDropdown(CharactersList)
    CharacterDropDown:setName("Characters")

    local EmotesIcon = Icon.new()
    EmotesIcon:setName("Emotes")
    EmotesIcon:setLabel("Emotes")
    EmotesIcon:bindEvent("selected", function()
        print("Emotes Button Selected")
        EmotesIcon:deselect()
    end)

end


