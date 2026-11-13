return function(Config)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UIS = game:GetService("UserInputService")
    local Stats = game:GetService("Stats")
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "VDX_PRIVATE_HUB"
    gui.ResetOnSpawn = false
    local old = player:WaitForChild("PlayerGui"):FindFirstChild(gui.Name)
    if old then old:Destroy() end
    gui.Parent = player.PlayerGui
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(330, 250)
    frame.Position = UDim2.new(.5, -165, .5, -125)
    frame.BackgroundColor3 = Config.Background
    frame.BorderSizePixel = 0
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Config.Accent
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Config.Accent
    title.Text = Config.WindowTitle .. " | v" .. Config.Version
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.Parent = frame
    local function label(text, y)
        local x = Instance.new("TextLabel")
        x.Position = UDim2.fromOffset(12, y)
        x.Size = UDim2.new(1, -24, 0, 24)
        x.BackgroundTransparency = 1
        x.Text = text
        x.TextColor3 = Config.Text
        x.Font = Enum.Font.Gotham
        x.TextSize = 12
        x.TextXAlignment = Enum.TextXAlignment.Left
        x.Parent = frame
        return x
    end
    local function button(text, y, fn)
        local x = Instance.new("TextButton")
        x.Position = UDim2.fromOffset(12, y)
        x.Size = UDim2.new(1, -24, 0, 32)
        x.BackgroundColor3 = Config.Panel
        x.TextColor3 = Config.Text
        x.Text = text
        x.Font = Enum.Font.Gotham
        x.TextSize = 12
        x.Parent = frame
        Instance.new("UICorner", x).CornerRadius = UDim.new(0, 6)
        x.MouseButton1Click:Connect(fn)
    end
    local cam = workspace.CurrentCamera
    local original = cam and cam.FieldOfView or Config.DefaultFOV
    label("CAMERA | Local field of view", 50)
    local fovText = label("FOV: " .. math.floor(original), 76)
    local function setFov(v)
        v = math.clamp(v, Config.MinFOV, Config.MaxFOV)
        if workspace.CurrentCamera then workspace.CurrentCamera.FieldOfView = v end
        fovText.Text = "FOV: " .. math.floor(v)
    end
    button("Decrease FOV (-5)", 108, function() local c=workspace.CurrentCamera if c then setFov(c.FieldOfView-5) end end)
    button("Increase FOV (+5)", 146, function() local c=workspace.CurrentCamera if c then setFov(c.FieldOfView+5) end end)
    button("Reset FOV", 184, function() setFov(original) end)
    local info = label("FPS: -- | Ping: --", 220)
    local frames, last = 0, os.clock()
    RunService.RenderStepped:Connect(function()
        frames += 1
        local now = os.clock()
        if now-last >= 1 then
            local fps = math.floor(frames/(now-last)); frames=0; last=now
            local ping="N/A"
            pcall(function() ping=Stats.Network.ServerStatsItem["Data Ping"]:GetValueString() end)
            info.Text = "FPS: " .. fps .. " | Ping: " .. tostring(ping)
        end
    end)
    UIS.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode.RightShift then frame.Visible = not frame.Visible end
    end)
    print("[VDX] Core loaded. RightShift hides/shows the panel.")
end
