local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local gui = Instance.new("ScreenGui")
gui.Name = "VultHubGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Main UI Frame (start hidden)
local mainUI = Instance.new("Frame", gui)
mainUI.Name = "MainUI"
mainUI.Size = UDim2.new(0, 300, 0, 200)
mainUI.Position = UDim2.new(0.5, -150, 0.5, -100)
mainUI.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainUI.Visible = false
Instance.new("UICorner", mainUI)

-- Jump Boost Button
local jumpButton = Instance.new("TextButton", mainUI)
jumpButton.Size = UDim2.new(0, 130, 0, 50)
jumpButton.Position = UDim2.new(0, 20, 0, 30)
jumpButton.Text = "Jump Boost"
jumpButton.Font = Enum.Font.GothamBold
jumpButton.TextScaled = true
jumpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
jumpButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", jumpButton)

-- Speed Boost Button
local speedButton = Instance.new("TextButton", mainUI)
speedButton.Size = UDim2.new(0, 130, 0, 50)
speedButton.Position = UDim2.new(0, 150, 0, 30)
speedButton.Text = "Speed Boost"
speedButton.Font = Enum.Font.GothamBold
speedButton.TextScaled = true
speedButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
speedButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", speedButton)

-- Infinite Jump Button
local infiniteJumpButton = Instance.new("TextButton", mainUI)
infiniteJumpButton.Size = UDim2.new(0, 260, 0, 50)
infiniteJumpButton.Position = UDim2.new(0, 20, 0, 100)
infiniteJumpButton.Text = "Infinite Jump (OFF)"
infiniteJumpButton.Font = Enum.Font.GothamBold
infiniteJumpButton.TextScaled = true
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
infiniteJumpButton.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", infiniteJumpButton)

-- Loading Screen Frame
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(0, 220, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", loadingFrame)

local loadingLabel = Instance.new("TextLabel", loadingFrame)
loadingLabel.Size = UDim2.new(1, 0, 1, 0)
loadingLabel.BackgroundTransparency = 1
loadingLabel.Text = "VULT HUB"
loadingLabel.Font = Enum.Font.GothamBold
loadingLabel.TextColor3 = Color3.new(1, 1, 1)
loadingLabel.TextScaled = true

-- Buttons container frame for close & minimize
local buttonFrame = Instance.new("Frame", loadingFrame)
buttonFrame.Size = UDim2.new(0, 70, 0, 30)
buttonFrame.Position = UDim2.new(1, -75, 0, 5)
buttonFrame.BackgroundTransparency = 1

-- Close Button
local closeButton = Instance.new("TextButton", buttonFrame)
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextColor3 = Color3.new(1, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", closeButton)

-- Minimize Button
local minimizeButton = Instance.new("TextButton", buttonFrame)
minimizeButton.Size = UDim2.new(0, 30, 1, 0)
minimizeButton.Position = UDim2.new(0, 0, 0, 0)
minimizeButton.Text = "_"
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", minimizeButton)

-- Variables to track boosts
local jumpBoostEnabled = false
local speedBoostEnabled = false
local infiniteJumpEnabled = false

-- Store original humanoid values to restore later
local originalJumpPower = humanoid.JumpPower
local originalWalkSpeed = humanoid.WalkSpeed

-- Function to toggle jump boost
local function toggleJumpBoost()
    if jumpBoostEnabled then
        humanoid.JumpPower = originalJumpPower
        jumpButton.Text = "Jump Boost"
        jumpBoostEnabled = false
    else
        humanoid.JumpPower = 50 -- fixed jump power
        jumpButton.Text = "Jump Boost (ON)"
        jumpBoostEnabled = true
    end
end

-- Function to toggle speed boost
local function toggleSpeedBoost()
    if speedBoostEnabled then
        humanoid.WalkSpeed = originalWalkSpeed
        speedButton.Text = "Speed Boost"
        speedBoostEnabled = false
    else
        humanoid.WalkSpeed = 32 -- fixed speed value
        speedButton.Text = "Speed Boost (ON)"
        speedBoostEnabled = true
    end
end

-- Infinite jump logic
local function onJumpRequest()
    if infiniteJumpEnabled then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Toggle infinite jump
local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        infiniteJumpButton.Text = "Infinite Jump (ON)"
    else
        infiniteJumpButton.Text = "Infinite Jump (OFF)"
    end
end

-- Connect buttons
jumpButton.MouseButton1Click:Connect(toggleJumpBoost)
speedButton.MouseButton1Click:Connect(toggleSpeedBoost)
infiniteJumpButton.MouseButton1Click:Connect(toggleInfiniteJump)

UserInputService.JumpRequest:Connect(onJumpRequest)

-- Minimized bar (starts hidden)
local minimizedBar = Instance.new("Frame", gui)
minimizedBar.Size = UDim2.new(0, 120, 0, 40)
minimizedBar.Position = UDim2.new(0, 10, 0, 10)
minimizedBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
minimizedBar.Visible = false
Instance.new("UICorner", minimizedBar)

local minimizedLabel = Instance.new("TextLabel", minimizedBar)
minimizedLabel.Size = UDim2.new(1, -10, 1, 0)
minimizedLabel.Position = UDim2.new(0, 5, 0, 0)
minimizedLabel.BackgroundTransparency = 1
minimizedLabel.Text = "VULT HUB"
minimizedLabel.Font = Enum.Font.GothamBold
minimizedLabel.TextColor3 = Color3.new(1,1,1)
minimizedLabel.TextScaled = true

-- Make minimizedBar clickable and draggable
minimizedBar.Active = true
minimizedBar.Draggable = true

minimizedBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        minimizedBar.Draggable = true
    end
end)

minimizedBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        minimizedBar.Draggable = false
    end
end)

-- Clicking minimized bar restores UI
minimizedBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        minimizedBar.Visible = false
        mainUI.Visible = true
    end
end)

-- Close button functionality: destroy whole GUI
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize button functionality:
minimizeButton.MouseButton1Click:Connect(function()
    -- Hide both loading and main UI
    loadingFrame.Visible = false
    mainUI.Visible = false
    minimizedBar.Visible = true
end)

-- Loading screen fadeout and show main UI after 10 seconds
spawn(function()
    wait(10)
    for i = 1, 20 do
        loadingFrame
