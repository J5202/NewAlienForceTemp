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

return module
