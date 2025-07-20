local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BrainrotGui"
gui.Parent = game:GetService("CoreGui")

-- Loading Frame
local loadFrame = Instance.new("Frame", gui)
loadFrame.Size = UDim2.new(0, 220, 0, 100)
loadFrame.Position = UDim2.new(0.5, -110, 0.5, -50)
loadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadFrame.BorderSizePixel = 0
Instance.new("UICorner", loadFrame).CornerRadius = UDim.new(0, 12)

-- Loading TextLabel
local loadingText = Instance.new("TextLabel", loadFrame)
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.Position = UDim2.new(0, 0, 0, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "VULT HUB"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextScaled = true

-- Wait 10 seconds, then destroy loading and show hub
task.delay(10, function()
    loadFrame:Destroy()

    -- Main Frame
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 220, 0, 140)
    frame.Position = UDim2.new(0, 15, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

    -- Speed Button
    local speedBtn = Instance.new("TextButton", frame)
    speedBtn.Size = UDim2.new(1, -20, 0, 50)
    speedBtn.Position = UDim2.new(0, 10, 0, 10)
    speedBtn.Text = "💨 Speed 64"
    speedBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
    speedBtn.TextColor3 = Color3.new(1, 1, 1)
    speedBtn.Font = Enum.Font.GothamBold
    speedBtn.TextScaled = true
    Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0, 8)

    -- Jump Button
    local jumpBtn = Instance.new("TextButton", frame)
    jumpBtn.Size = UDim2.new(1, -20, 0, 50)
    jumpBtn.Position = UDim2.new(0, 10, 0, 80)
    jumpBtn.Text = "🦘 Jump 200"
    jumpBtn.BackgroundColor3 = Color3.fromRGB(250, 150, 50)
    jumpBtn.TextColor3 = Color3.new(1, 1, 1)
    jumpBtn.Font = Enum.Font.GothamBold
    jumpBtn.TextScaled = true
    Instance.new("UICorner", jumpBtn).CornerRadius = UDim.new(0, 8)

    -- Function setup
    local speedBoost = false
    local jumpBoost = false

    local function getHumanoid()
        local char = player.Character or player.CharacterAdded:Wait()
        return char:WaitForChild("Humanoid")
    end

    speedBtn.MouseButton1Click:Connect(function()
        speedBoost = not speedBoost
        if speedBoost then
            speedBtn.Text = "💨 Speed 64 (ON)"
            task.spawn(function()
                while speedBoost do
                    local h = getHumanoid()
                    if h then h.WalkSpeed = 64 end
                    task.wait(0.1)
                end
            end)
        else
            speedBtn.Text = "💨 Speed 64"
            local h = getHumanoid()
            if h then h.WalkSpeed = 16 end
        end
    end)

    jumpBtn.MouseButton1Click:Connect(function()
        jumpBoost = not jumpBoost
        if jumpBoost then
            jumpBtn.Text = "🦘 Jump 200 (ON)"
            task.spawn(function()
                while jumpBoost do
                    local h = getHumanoid()
                    if h then h.JumpPower = 200 end
                    task.wait(0.1)
                end
            end)
        else
            jumpBtn.Text = "🦘 Jump 200"
            local h = getHumanoid()
            if h then h.JumpPower = 50 end
        end
    end)
end)
