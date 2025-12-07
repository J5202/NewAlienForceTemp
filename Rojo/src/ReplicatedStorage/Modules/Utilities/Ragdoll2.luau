-- RagdollModule.lua
-- Adds Colliders to prevent limbs from clipping through torso

local Ragdoll = {}

local LIMB_COLLIDERS = {
    ["LeftUpperArm"]  = Vector3.new(0.7, 1.3, 0.7),
    ["LeftLowerArm"]  = Vector3.new(0.7, 1.3, 0.7),
    ["RightUpperArm"] = Vector3.new(0.7, 1.3, 0.7),
    ["RightLowerArm"] = Vector3.new(0.7, 1.3, 0.7),

    ["LeftUpperLeg"]  = Vector3.new(0.8, 1.8, 0.8),
    ["LeftLowerLeg"]  = Vector3.new(0.8, 1.8, 0.8),
    ["RightUpperLeg"] = Vector3.new(0.8, 1.8, 0.8),
    ["RightLowerLeg"] = Vector3.new(0.8, 1.8, 0.8),

    ["Torso"]         = Vector3.new(2, 3, 1),
    ["UpperTorso"]    = Vector3.new(2, 2, 1),
    ["LowerTorso"]    = Vector3.new(2, 2, 1),
}

local function createCollider(limb)
    if limb:FindFirstChild("RagdollCollider") then return end

    local size = LIMB_COLLIDERS[limb.Name]
    if not size then return end

    local collider = Instance.new("Part")
    collider.Name = "RagdollCollider"
    collider.Size = size
    collider.Transparency = 1
    collider.CanCollide = true
    collider.CanQuery = false
    collider.CanTouch = false
    collider.Massless = true
    collider.Parent = limb

    local weld = Instance.new("WeldConstraint")
    weld.Part0 = limb
    weld.Part1 = collider
    weld.Parent = collider
end

local function getMotors(character)
    local motors = {}
    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("Motor6D") then
            table.insert(motors, v)
        end
    end
    return motors
end

local function createBallSocket(part0, part1)
    local a0 = Instance.new("Attachment", part0)
    a0.Name = "RagdollA0"

    local a1 = Instance.new("Attachment", part1)
    a1.Name = "RagdollA1"

    local socket = Instance.new("BallSocketConstraint")
    socket.Attachment0 = a0
    socket.Attachment1 = a1
    socket.LimitsEnabled = true
    socket.TwistLimitsEnabled = true
    socket.Parent = part0

    return socket
end

function Ragdoll.Enable(character)
    if character:FindFirstChild("_IsRagdolled") then return end
    Instance.new("BoolValue", character).Name = "_IsRagdolled"

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.AutoRotate = false
        humanoid.PlatformStand = true
    end

    for limbName, _ in pairs(LIMB_COLLIDERS) do
        local limb = character:FindFirstChild(limbName, true)
        if limb then
            createCollider(limb)
        end
    end

    for _, motor in ipairs(getMotors(character)) do
        if motor.Part0 and motor.Part1 then
            createBallSocket(motor.Part0, motor.Part1)
        end
        motor.Enabled = false
    end

    local animator = humanoid:FindFirstChild("Animator")
    if animator then
        animator:Destroy()
    end
end

function Ragdoll.Disable(character)
    local flag = character:FindFirstChild("_IsRagdolled")
    if not flag then return end
    flag:Destroy()

    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = false
        humanoid.AutoRotate = true
    end

    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("BallSocketConstraint") then
            v:Destroy()
        elseif v:IsA("Attachment") and (v.Name == "RagdollA0" or v.Name == "RagdollA1") then
            v:Destroy()
        elseif v:IsA("Part") and v.Name == "RagdollCollider" then
            v:Destroy()
        end
    end

    for _, motor in ipairs(getMotors(character)) do
        motor.Enabled = true
    end

    if humanoid then
        local anim = Instance.new("Animator")
        anim.Parent = humanoid
    end
end

return Ragdoll
