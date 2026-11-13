-- VDX PRIVATE HUB | Utility module
-- Local session HUD and movement readout. Does not modify gameplay movement.
return function(Config)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local old = playerGui:FindFirstChild("VDX_UtilityHUD")
    if old then old:Destroy() end

    local gui = Instance.new("ScreenGui")
    gui.Name = "VDX_UtilityHUD"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 15
    gui.Parent = playerGui

    local panel = Instance.new("Frame")
    panel.Name = "UtilityPanel"
    panel.AnchorPoint = Vector2.new(1, 0)
    panel.Position = UDim2.new(1, -18, 0, 18)
    panel.Size = UDim2.fromOffset(210, 94)
    panel.BackgroundColor3 = Config.Background
    panel.BackgroundTransparency = 0.12
    panel.BorderSizePixel = 0
    panel.Parent = gui
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 8)

    local outline = Instance.new("UIStroke")
    outline.Color = Config.Accent
    outline.Thickness = 1
    outline.Parent = panel

    local title = Instance.new("TextLabel")
    title.Position = UDim2.fromOffset(10, 7)
    title.Size = UDim2.new(1, -20, 0, 18)
    title.BackgroundTransparency = 1
    title.Text = "VDX SESSION"
    title.TextColor3 = Config.Accent
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = panel

    local details = Instance.new("TextLabel")
    details.Position = UDim2.fromOffset(10, 29)
    details.Size = UDim2.new(1, -20, 0, 53)
    details.BackgroundTransparency = 1
    details.TextColor3 = Config.Text
    details.Font = Enum.Font.Gotham
    details.TextSize = 11
    details.TextXAlignment = Enum.TextXAlignment.Left
    details.TextYAlignment = Enum.TextYAlignment.Top
    details.Parent = panel

    local started = os.clock()
    local elapsed = 0
    local visible = true
    local showSpeed = true
    local updateAccumulator = 0

    local function formatTime(seconds)
        seconds = math.floor(seconds)
        local h = math.floor(seconds / 3600)
        local m = math.floor((seconds % 3600) / 60)
        local s = seconds % 60
        return string.format("%02d:%02d:%02d", h, m, s)
    end

    local function getLocalSpeed()
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not root then return 0 end
        local velocity = root.AssemblyLinearVelocity
        return Vector3.new(velocity.X, 0, velocity.Z).Magnitude
    end

    local function refresh()
        elapsed = os.clock() - started
        local lines = {
            "Session: " .. formatTime(elapsed),
            "Role: " .. tostring(player:GetAttribute("Role") or "Not detected"),
        }
        if showSpeed then
            table.insert(lines, string.format("Local speed: %.1f", getLocalSpeed()))
        end
        details.Text = table.concat(lines, "\n")
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.F10 then
            visible = not visible
            panel.Visible = visible
        elseif input.KeyCode == Enum.KeyCode.F11 then
            showSpeed = not showSpeed
            refresh()
        end
    end)

    RunService.Heartbeat:Connect(function(dt)
        updateAccumulator += dt
        if updateAccumulator >= 0.25 then
            updateAccumulator = 0
            if visible then refresh() end
        end
    end)

    refresh()
    print("[VDX] Utility loaded | F10 HUD toggle, F11 speed readout toggle")
end
