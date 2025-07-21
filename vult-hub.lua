-- Vult Hub Script
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VultHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = false

-- Title Bar (for dragging)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Text = "Vult Hub"
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1,1,1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 20
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 20
closeBtn.Parent = titleBar

-- Minimize Button
local minBtn = Instance.new("TextButton")
minBtn.Text = "—"
minBtn.Size = UDim2.new(0, 30, 1, 0)
minBtn.Position = UDim2.new(1, -60, 0, 0)
minBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.Font = Enum.Font.SourceSansBold
minBtn.TextSize = 20
minBtn.Parent = titleBar

-- Small minimized frame
local miniFrame = Instance.new("Frame")
miniFrame.Size = UDim2.new(0, 150, 0, 40)
miniFrame.Position = UDim2.new(0, 10, 0, 10)
miniFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miniFrame.Visible = false
miniFrame.Parent = screenGui
miniFrame.Active = true

local miniLabel = Instance.new("TextLabel")
miniLabel.Text = "Vult Hub"
miniLabel.Size = UDim2.new(1, 0, 1, 0)
miniLabel.BackgroundTransparency = 1
miniLabel.TextColor3 = Color3.new(1,1,1)
miniLabel.Font = Enum.Font.SourceSansBold
miniLabel.TextSize = 20
miniLabel.Parent = miniFrame

-- Buttons: Speed Boost, Jump Boost, Infinite Jump
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(0, 120, 0, 40)
speedBtn.Position = UDim2.new(0, 20, 0, 50)
speedBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
speedBtn.TextColor3 = Color3.new(1,1,1)
speedBtn.Font = Enum.Font.SourceSans
speedBtn.TextSize = 18
speedBtn.Text = "Speed Boost"
speedBtn.Parent = mainFrame

local jumpBtn = Instance.new("TextButton")
jumpBtn.Size = UDim2.new(0, 120, 0, 40)
jumpBtn.Position = UDim2.new(0, 160, 0, 50)
jumpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
jumpBtn.TextColor3 = Color3.new(1,1,1)
jumpBtn.Font = Enum.Font.SourceSans
jumpBtn.TextSize = 18
jumpBtn.Text = "Jump Boost"
jumpBtn.Parent = mainFrame

local infiniteJumpBtn = Instance.new("TextButton")
infiniteJumpBtn.Size = UDim2.new(0, 260, 0, 40)
infiniteJumpBtn.Position = UDim2.new(0, 20, 0, 110)
infiniteJumpBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
infiniteJumpBtn.TextColor3 = Color3.new(1,1,1)
infiniteJumpBtn.Font = Enum.Font.SourceSans
infiniteJumpBtn.TextSize = 18
infiniteJumpBtn.Text = "Infinite Jump: OFF"
infiniteJumpBtn.Parent = mainFrame

-- Variables to track boosts
local speedBoostOn = false
local jumpBoostOn = false
local infiniteJumpOn = false

-- Functions to apply boosts
local function applySpeedBoost()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if speedBoostOn then
            humanoid.WalkSpeed = 100
        else
            humanoid.WalkSpeed = 16 -- default Roblox walkspeed
        end
    end
end

local function applyJumpBoost()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if jumpBoostOn then
            humanoid.JumpPower = 400
        else
            humanoid.JumpPower = 50 -- default Roblox jumppower
        end
    end
end

-- Button handlers
speedBtn.MouseButton1Click:Connect(function()
    speedBoostOn = not speedBoostOn
    speedBtn.Text = speedBoostOn and "Speed Boost: ON" or "Speed Boost"
    applySpeedBoost()
end)

jumpBtn.MouseButton1Click:Connect(function()
    jumpBoostOn = not jumpBoostOn
    jumpBtn.Text = jumpBoostOn and "Jump Boost: ON" or "Jump Boost"
    applyJumpBoost()
end)

-- Infinite jump logic
UIS.JumpRequest:Connect(function()
    if infiniteJumpOn then
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and not humanoid:GetState().Value == Enum.HumanoidStateType.Freefall then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            else
                -- Always jump regardless of state if infinite jump is ON
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

infiniteJumpBtn.MouseButton1Click:Connect(function()
    infiniteJumpOn = not infiniteJumpOn
    infiniteJumpBtn.Text = infiniteJumpOn and "Infinite Jump: ON" or "Infinite Jump: OFF"
end)

-- Close button hides UI
closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    miniFrame.Visible = true
end)

-- Minimize button hides main frame, shows mini frame
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)

-- Clicking mini frame restores main frame
miniFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        mainFrame.Visible = true
        miniFrame.Visible = false
    end
end)

-- Draggable mainFrame with titleBar (mouse + touch)
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or
       input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Make sure boosts reapply on respawn
player.CharacterAdded:Connect(function()
    wait(1)
    applySpeedBoost()
    applyJumpBoost()
end)
