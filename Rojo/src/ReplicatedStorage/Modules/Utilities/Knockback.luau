local module = {}
module.__index = module

function module:ApplyKnockBack(HRP, EnemyHRP, Force: number)
    if not EnemyHRP then
        warn("HumanoidRootPart not found!")
        return
    end

    local CheckForVelocity = EnemyHRP:FindFirstChildOfClass("LinearVelocity")
    if CheckForVelocity then
        local LinearAttachment = EnemyHRP:FindFirstChildWhichIsA("Attachment")
        if LinearAttachment.Name == "LinearAttachment" then
            LinearAttachment:Destroy()
        end
        CheckForVelocity:Destroy()
    end

    local EnemyHRPPosition = Vector3.new(EnemyHRP.Position.X, HRP.Position.Y, EnemyHRP.Position.Z)

    local LinearAttachment = Instance.new("Attachment")
    LinearAttachment.Name = "LinearAttachment"
    LinearAttachment.Parent = EnemyHRP

    local highlight = Instance.new("Highlight")
    highlight.Parent = EnemyHRP.Parent
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.FillColor = Color3.new(1, 1, 1)
    highlight.FillTransparency = 0.95
    highlight.OutlineTransparency = 0.7
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    local linearvelocity = Instance.new("LinearVelocity")
    linearvelocity.MaxForce = math.huge
    linearvelocity.Attachment0 = LinearAttachment
    linearvelocity.Parent = EnemyHRP
    linearvelocity.VectorVelocity = (EnemyHRPPosition - HRP.Position).Unit * Force

    game:GetService("Debris"):AddItem(linearvelocity, 0.04)
    game:GetService("Debris"):AddItem(highlight, 0.2)
    
end

function module:ApplySuperKnockBackForFinishers(HRP, EnemyHRP, Force: number)
    if not EnemyHRP then
        warn("HumanoidRootPart not found!")
        return
    end

    local CheckForVelocity = EnemyHRP:FindFirstChildOfClass("LinearVelocity")
    if CheckForVelocity then
        local LinearAttachment = EnemyHRP:FindFirstChildWhichIsA("Attachment")
        if LinearAttachment.Name == "LinearAttachment" then
            LinearAttachment:Destroy()
        end
        CheckForVelocity:Destroy()
    end

    local EnemyHRPPosition = Vector3.new(EnemyHRP.Position.X, EnemyHRP.Position.Y, EnemyHRP.Position.Z)

    local LinearAttachment = Instance.new("Attachment")
    LinearAttachment.Name = "LinearAttachment"
    LinearAttachment.Parent = EnemyHRP

    local highlight = Instance.new("Highlight")
    highlight.Adornee = EnemyHRP.Parent
    highlight.OutlineColor = Color3.new(1, 1, 1)
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0.7
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

    local linearvelocity = Instance.new("LinearVelocity")
    linearvelocity.MaxForce = math.huge
    linearvelocity.Attachment0 = LinearAttachment
    linearvelocity.Parent = EnemyHRP
    linearvelocity.VectorVelocity = (EnemyHRPPosition - HRP.Position).Unit * Force

    game:GetService("Debris"):AddItem(linearvelocity, 3)
    
end

-- function module:ApplyKnockUp(HRP, EnemyHRP, Force: number, upwardForce: number, knockbacktimelength: number)
--     if not EnemyHRP then
--         warn("HumanoidRootPart not found!")
--         return
--     end

--     local CheckForVelocity = EnemyHRP:FindFirstChildOfClass("LinearVelocity")
--     if CheckForVelocity then
--         local LinearAttachment = EnemyHRP:FindFirstChildWhichIsA("Attachment")
--         if LinearAttachment.Name == "LinearAttachment" then
--             LinearAttachment:Destroy()
--         end
--         CheckForVelocity:Destroy()
--     end

--     local EnemyHeightPosition = EnemyHRP.Position.Y + upwardForce
--     local EnemyHRPPosition = Vector3.new(EnemyHRP.Position.X, EnemyHeightPosition, EnemyHRP.Position.Z)

--     local LinearAttachment = Instance.new("Attachment")
--     LinearAttachment.Name = "LinearAttachment"
--     LinearAttachment.Parent = EnemyHRP

--     local highlight = Instance.new("Highlight")
--     highlight.Adornee = EnemyHRP.Parent
--     highlight.OutlineColor = Color3.new(1, 1, 1)
--     highlight.FillColor = Color3.new(1, 0, 0)
--     highlight.FillTransparency = 0.7
--     highlight.OutlineTransparency = 0.7
--     highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

--     local linearvelocity = Instance.new("LinearVelocity")
--     linearvelocity.MaxForce = math.huge
--     linearvelocity.Attachment0 = LinearAttachment
--     linearvelocity.Parent = EnemyHRP
--     linearvelocity.VectorVelocity = (EnemyHRPPosition - HRP.Position).Unit * Force

--     game:GetService("Debris"):AddItem(linearvelocity, knockbacktimelength or 0.05)
    
-- end

function module:ApplyKnockUp(HRP, EnemyHRP, Force: number, upwardForce: number, knockbacktimelength: number)
    if not EnemyHRP then
        warn("HumanoidRootPart not found!")
        return
    end

    -- Remove old velocity
    local oldVel = EnemyHRP:FindFirstChildOfClass("LinearVelocity")
    if oldVel then
        local att = EnemyHRP:FindFirstChild("LinearAttachment")
        if att then att:Destroy() end
        oldVel:Destroy()
    end

    -- New attachment
    local att = Instance.new("Attachment")
    att.Name = "LinearAttachment"
    att.Parent = EnemyHRP

    -- Horizontal direction away from player
    local dir = (EnemyHRP.Position - HRP.Position)
    dir = Vector3.new(dir.X, 0, dir.Z).Unit  -- remove Y

    local horizontalVelocity = dir * Force          -- push away
    local verticalVelocity   = Vector3.new(0, upwardForce, 0)  -- push up

    local final = horizontalVelocity + verticalVelocity

    -- Apply final velocity
    local lv = Instance.new("LinearVelocity")
    lv.MaxForce = math.huge
    lv.Attachment0 = att
    lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    lv.VectorVelocity = final
    lv.Parent = EnemyHRP

    game:GetService("Debris"):AddItem(lv, knockbacktimelength or 0.1)
end

return module
