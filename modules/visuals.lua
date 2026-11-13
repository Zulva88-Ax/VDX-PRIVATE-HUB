-- VDX PRIVATE HUB | Visual module
-- Local-only crosshair customization. No player tracking or opponent ESP.
return function(Config)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local old = playerGui:FindFirstChild("VDX_Crosshair")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "VDX_Crosshair"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 20
    gui.Parent = playerGui

    local colors = {
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(255, 70, 85),
        Color3.fromRGB(80, 220, 150),
        Color3.fromRGB(90, 170, 255),
        Color3.fromRGB(255, 210, 80),
    }
    local colorIndex = 1
    local size = 8
    local baseGap = 5
    local thickness = 2
    local enabled = true
    local dynamic = true

    local function makePart(name)
        local part = Instance.new("Frame")
        part.Name = name
        part.AnchorPoint = Vector2.new(0.5, 0.5)
        part.BackgroundColor3 = colors[colorIndex]
        part.BorderSizePixel = 0
        part.Parent = gui
        return part
    end

    local top = makePart("Top")
    local bottom = makePart("Bottom")
    local left = makePart("Left")
    local right = makePart("Right")
    local dot = makePart("CenterDot")
    dot.Size = UDim2.fromOffset(3, 3)

    local function apply(gap)
        local center = Vector2.new(0.5, 0.5)
        top.Position = UDim2.new(center.X, 0, center.Y, -(gap + size / 2))
        bottom.Position = UDim2.new(center.X, 0, center.Y, gap + size / 2)
        left.Position = UDim2.new(center.X, -(gap + size / 2), center.Y, 0)
        right.Position = UDim2.new(center.X, gap + size / 2, center.Y, 0)

        top.Size = UDim2.fromOffset(thickness, size)
        bottom.Size = UDim2.fromOffset(thickness, size)
        left.Size = UDim2.fromOffset(size, thickness)
        right.Size = UDim2.fromOffset(size, thickness)

        for _, part in ipairs({top, bottom, left, right, dot}) do
            part.BackgroundColor3 = colors[colorIndex]
            part.Visible = enabled
        end
    end

    local function getMovementGap()
        if not dynamic then return baseGap end
        local character = player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return baseGap end
        local moving = humanoid.MoveDirection.Magnitude
        local speedFactor = math.clamp(humanoid.WalkSpeed / 16, 0.5, 2)
        return baseGap + moving * 5 * speedFactor
    end

    local function setEnabled(value)
        enabled = value
        apply(getMovementGap())
    end

    local function setSize(value)
        size = math.clamp(value, 4, 20)
        apply(getMovementGap())
    end

    local function cycleColor()
        colorIndex = colorIndex % #colors + 1
        apply(getMovementGap())
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.F6 then
            setEnabled(not enabled)
        elseif input.KeyCode == Enum.KeyCode.F7 then
            setSize(size + 2)
            if size >= 20 then size = 4 end
            apply(getMovementGap())
        elseif input.KeyCode == Enum.KeyCode.F8 then
            cycleColor()
        elseif input.KeyCode == Enum.KeyCode.F9 then
            dynamic = not dynamic
            apply(getMovementGap())
        end
    end)

    RunService.RenderStepped:Connect(function()
        if enabled then apply(getMovementGap()) end
    end)

    apply(baseGap)
    print("[VDX] Visuals loaded | F6 toggle, F7 size, F8 color, F9 dynamic")
end
