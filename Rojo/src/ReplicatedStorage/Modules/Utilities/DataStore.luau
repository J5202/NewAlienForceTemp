local DataStoreService = game:GetService("DataStoreService")

module = {}
module.__index = module

function module.NewDataStore(DataStoreName:string)
    local self = setmetatable({}, module)
    self.DataStore = DataStoreService:GetDataStore(DataStoreName)
    return self
end

function module:GetAsync(key:string)
    local success, result = pcall(function()
        return self.DataStore:GetAsync(key)
    end)
    if success then
        print("Successfully retrieved data for key:", key)
        return result
    else
        warn("Failed to get data for key:", key, "Error:", result)
        return nil
    end
end

function module:SetAsync(key:string, value:any)
    local success, result = pcall(function()
        self.DataStore:SetAsync(key, value)
    end)
    if success then
        print("Successfully set data for key:", key)
    else
        warn("Failed to set data for key:", key, "Error:", result)
    end
end

return module