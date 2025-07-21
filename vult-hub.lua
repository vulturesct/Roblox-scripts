-- VULT HUB - Final Mobile Version (No loading screen)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Settings
local boostedSpeed = 60
local boostedJumpPower = 200

-- State flags
local speedOn = false
local jumpOn = false
local infJumpOn = false

-- UI Setup
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "VultHub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 180)
frame.Position = UDim2.new(0.5, -130, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = gui
Instance.new("UICorner", frame)

local function makeBtn(text, y)
    local b = Instance.new("TextButton")
    b.Parent = frame
    b.Position = UDim2.new(0, 10, 0, y)
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Instance.new("UICorner", b)
    return b
end

local speedBtn = makeBtn("💨 Speed Boost", 10)
local jumpBtn = makeBtn("🦘 Jump Boost", 60)
local infJumpBtn = makeBtn("♾️ Infinite Jump", 110)

-- Toggle buttons
speedBtn.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    speedBtn.Text = speedOn and "💨 Speed ON" or "💨 Speed OFF"
end)

jumpBtn.MouseButton1Click:Connect(function()
    jumpOn = not jumpOn
    jumpBtn.Text = jumpOn and "🦘 Jump ON" or "🦘 Jump OFF"
end)

infJumpBtn.MouseButton1Click:Connect(function()
    infJumpOn = not infJumpOn
    infJumpBtn.Text = infJumpOn and "♾️ Inf Jump ON" or "♾️ Inf Jump OFF"
end)

-- Apply effects
RunService.RenderStepped:Connect(function()
    if speedOn and humanoid then
        humanoid.WalkSpeed = boostedSpeed
    end
end)

UserInputService.JumpRequest:Connect(function()
    if jumpOn and humanoid then
        humanoid.JumpPower = boostedJumpPower
    end
    if infJumpOn and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
