local RSScript = Instance.new("ScreenGui")
RSScript.Name = "RSscript"
RSScript.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
RSScript.IgnoreGuiInset = true
RSScript.ResetOnSpawn = false 

local UIS = game:GetService("UserInputService")
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled

-- === PERMANENT KEY CHECK ===
if getgenv().RSKeyVerified then
    print("Key already verified - Loading UI directly")
else
    -- === KEY SYSTEM ===
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Parent = RSScript
    KeyFrame.Size = isMobile and UDim2.new(0.9, 0, 0, 170) or UDim2.new(0, 356, 0, 147)
    KeyFrame.Position = UDim2.new(0.5, isMobile and -170 or -178, 0.5, -85)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Visible = true

    local Title = Instance.new("Frame")
    Title.Name = "Title"
    Title.Parent = KeyFrame
    Title.Size = UDim2.new(1, 0, 0, 46)
    Title.Position = UDim2.new(0, 0, -0.313, 0)
    Title.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    Title.BorderSizePixel = 0

    local textlabel = Instance.new("TextLabel")
    textlabel.Parent = Title
    textlabel.Size = UDim2.new(1, 0, 1, 0)
    textlabel.BackgroundTransparency = 1
    textlabel.Text = "Key System"
    textlabel.TextSize = isMobile and 28 or 39
    textlabel.Font = Enum.Font.FredokaOne
    textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)

    -- Dragging for Key System
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        if not dragging then return end
        local delta = input.Position - dragStart
        KeyFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    Title.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = KeyFrame.Position
        end
    end)

    Title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    Title.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)

    game:GetService("RunService").RenderStepped:Connect(function()
        if dragging and dragInput then update(dragInput) end
    end)

    local textbox = Instance.new("TextBox")
    textbox.Parent = KeyFrame
    textbox.Size = isMobile and UDim2.new(0.8, 0, 0, 35) or UDim2.new(0, 179, 0, 28)
    textbox.Position = UDim2.new(0.247, 0, 0.401, 0)
    textbox.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
    textbox.BorderSizePixel = 0
    textbox.PlaceholderText = "enter the key"
    textbox.TextSize = isMobile and 16 or 14
    textbox.Text = ""
    textbox.Font = Enum.Font.FredokaOne
    textbox.PlaceholderColor3 = Color3.fromRGB(127, 127, 127)
    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)

    local submitBtn = Instance.new("TextButton")
    submitBtn.Parent = KeyFrame
    submitBtn.Size = isMobile and UDim2.new(0.35, 0, 0, 40) or UDim2.new(0, 93, 0, 30)
    submitBtn.Position = UDim2.new(0.1, 0, 0.687, 0)
    submitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    submitBtn.BorderSizePixel = 0
    submitBtn.Text = "Submit"
    submitBtn.Font = Enum.Font.FredokaOne
    submitBtn.TextSize = isMobile and 18 or 14
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

    local getBtn = Instance.new("TextButton")
    getBtn.Parent = KeyFrame
    getBtn.Size = isMobile and UDim2.new(0.35, 0, 0, 40) or UDim2.new(0, 93, 0, 30)
    getBtn.Position = UDim2.new(0.55, 0, 0.687, 0)
    getBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    getBtn.BorderSizePixel = 0
    getBtn.Text = "Get Key"
    getBtn.Font = Enum.Font.FredokaOne
    getBtn.TextSize = isMobile and 18 or 14
    getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

    local correctKey = "rocketspleefvulture"

    getBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/5QWF3XqkV")
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Copied"; Text = "Discord link copied!"; Duration = 3;})
    end)

    submitBtn.MouseButton1Click:Connect(function()
        if textbox.Text == correctKey then
            getgenv().RSKeyVerified = true
            KeyFrame:Destroy()
            MainFrame.Visible = true
            if isMobile then MobileOpenButton.Visible = true end
        else
            submitBtn.Text = "Wrong Key"
            submitBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
            task.wait(1.5)
            submitBtn.Text = "Submit"
            submitBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)
end

-- === MAIN FRAME ===
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = RSScript
MainFrame.Size = isMobile and UDim2.new(0.88, 0, 0.58, 0) or UDim2.new(0, 434, 0, 378)
MainFrame.Position = isMobile and UDim2.new(0.06, 0, 0.18, 0) or UDim2.new(0.343, 0, 0.196, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = getgenv().RSKeyVerified or false

-- Mobile RS Button
local MobileOpenButton = Instance.new("TextButton")
MobileOpenButton.Parent = RSScript
MobileOpenButton.Size = UDim2.new(0, 60, 0, 60)
MobileOpenButton.Position = UDim2.new(0, 20, 1, -90)
MobileOpenButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
MobileOpenButton.Text = "RS"
MobileOpenButton.Font = Enum.Font.FredokaOne
MobileOpenButton.TextSize = 22
MobileOpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileOpenButton.Visible = false
MobileOpenButton.ZIndex = 999

local MobileCorner = Instance.new("UICorner")
MobileCorner.CornerRadius = UDim.new(0.5, 0)
MobileCorner.Parent = MobileOpenButton

MobileOpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Dragging
local draggingMain = false
local dragInputMain = nil
local dragStartMain = nil
local startPosMain = nil

local function updateMain(input)
    if not draggingMain then return end
    local delta = input.Position - dragStartMain
    MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
end

local TitleMain = Instance.new("TextLabel")
TitleMain.Name = "Title"
TitleMain.Parent = MainFrame
TitleMain.Size = UDim2.new(1, -50, 0, isMobile and 42 or 50)
TitleMain.Position = UDim2.new(0, 0, 0, 0)
TitleMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleMain.Text = "Rocket Spleef"
TitleMain.Font = Enum.Font.FredokaOne
TitleMain.TextScaled = true
TitleMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleMain.BorderSizePixel = 0

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Parent = TitleMain
TitleStroke.Thickness = 3
TitleStroke.Color = Color3.fromRGB(0, 0, 0)

TitleMain.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = true
        dragStartMain = input.Position
        startPosMain = MainFrame.Position
    end
end)

TitleMain.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMain = false
    end
end)

TitleMain.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMain = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateMain(input)
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if draggingMain and dragInputMain then updateMain(dragInputMain) end
end)

-- Close Button, Credit, Frames...
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, isMobile and 38 or 40, 0, isMobile and 38 or 40)
CloseButton.Position = UDim2.new(1, isMobile and -42 or -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = isMobile and 26 or 28
CloseButton.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0.3, 0)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local Credit = Instance.new("TextLabel")
Credit.Parent = MainFrame
Credit.Size = UDim2.new(0, 221, 0, 33)
Credit.Position = UDim2.new(0.258, 0, 0.9, 0)
Credit.BackgroundTransparency = 1
Credit.Text = "made by vulturewastaken7."
Credit.Font = Enum.Font.FredokaOne
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.TextScaled = true

local LeftFrame = Instance.new("Frame")
LeftFrame.Parent = MainFrame
LeftFrame.Size = isMobile and UDim2.new(0.23, 0, 0.82, 0) or UDim2.new(0, 92, 0, 328)
LeftFrame.Position = UDim2.new(0, 0, 0.13, 0)
LeftFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
LeftFrame.BorderSizePixel = 0

local Tab1Frame = Instance.new("Frame")
Tab1Frame.Parent = MainFrame
Tab1Frame.Size = isMobile and UDim2.new(0.74, 0, 0.82, 0) or UDim2.new(0, 336, 0, 328)
Tab1Frame.Position = UDim2.new(0.24, 0, 0.13, 0)
Tab1Frame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
Tab1Frame.BorderSizePixel = 0

local function createToggle(parent, yScale, labelText, toggleFunc)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = parent
    toggleFrame.Size = isMobile and UDim2.new(0, 78, 0, 42) or UDim2.new(0, 92, 0, 42)
    toggleFrame.Position = UDim2.new(0.67, 0, yScale, 0)
    toggleFrame.BackgroundTransparency = 1

    local colorFrame = Instance.new("Frame")
    colorFrame.Name = "colorframe"
    colorFrame.Parent = toggleFrame
    colorFrame.Size = isMobile and UDim2.new(0, 70, 0, 36) or UDim2.new(0, 84, 0, 37)
    colorFrame.Position = UDim2.new(0, 4, 0.5, isMobile and -18 or -18.5)
    colorFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    colorFrame.BorderSizePixel = 0
    Instance.new("UICorner", colorFrame).CornerRadius = UDim.new(0.5, 0)

    local knob = Instance.new("ImageButton")
    knob.Name = "ImageButton"
    knob.Parent = colorFrame
    knob.Size = isMobile and UDim2.new(0, 28, 0, 28) or UDim2.new(0, 32, 0, 32)
    knob.Position = UDim2.new(0, 5, 0.5, isMobile and -14 or -16)
    knob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    knob.BorderSizePixel = 0
    knob.ZIndex = 2
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0.5, 0)

    local isOn = false
    local tweenService = game:GetService("TweenService")
    local knobSize = isMobile and 28 or 32

    knob.MouseButton1Click:Connect(function()
        isOn = not isOn
        if isOn then
            colorFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            knob.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            tweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(1, -(knobSize + 9), 0.5, -knobSize/2)}):Play()
            toggleFunc(true)
        else
            colorFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            knob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            tweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Position = UDim2.new(0, 5, 0.5, -knobSize/2)}):Play()
            toggleFunc(false)
        end
    end)
    return toggleFrame
end

-- Labels (PC positions unchanged)
local antiDieText = Instance.new("TextLabel")
antiDieText.Parent = Tab1Frame
antiDieText.Size = UDim2.new(0, 186, 0, 40)
antiDieText.Position = UDim2.new(0.146, 0, 0.095, 0)
antiDieText.BackgroundTransparency = 1
antiDieText.Text = "AntiDie"
antiDieText.Font = Enum.Font.FredokaOne
antiDieText.TextSize = isMobile and 30 or 44
antiDieText.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoText = Instance.new("TextLabel")
autoText.Parent = Tab1Frame
autoText.Size = UDim2.new(0, 209, 0, 40)
autoText.Position = UDim2.new(0.048, 0, 0.29, 0)
autoText.BackgroundTransparency = 1
autoText.Text = "AutoShoot"
autoText.Font = Enum.Font.FredokaOne
autoText.TextSize = isMobile and 28 or 42
autoText.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimText = Instance.new("TextLabel")
aimText.Parent = Tab1Frame
aimText.Size = UDim2.new(0, 186, 0, 40)
aimText.Position = UDim2.new(0.116, 0, 0.493, 0)
aimText.BackgroundTransparency = 1
aimText.Text = "Aimlock"
aimText.Font = Enum.Font.FredokaOne
aimText.TextSize = isMobile and 30 or 44
aimText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- === TOGGLES ===
-- AntiDie
createToggle(Tab1Frame, 0.095, "AntiDie", function(state)
    if state then
        local p = workspace:FindFirstChild("hello") or Instance.new("Part")
        p.Name = "hello"
        p.Size = Vector3.new(250, 0.5, 250)
        p.CFrame = CFrame.new(12, 174.6, -160)
        p.Anchored = true
        p.BrickColor = BrickColor.new("Bright red")
        p.Parent = workspace
    else
        local p = workspace:FindFirstChild("hello")
        if p then p:Destroy() end
    end
end)

-- Aimlock
local aimlockConnection = nil
createToggle(Tab1Frame, 0.493, "Aimlock", function(state)
    if state then
        if aimlockConnection then aimlockConnection:Disconnect() end
        local RunService = game:GetService("RunService")
        local Players = game:GetService("Players")
        local camera = workspace.CurrentCamera
        local localPlayer = Players.LocalPlayer
        local MAX_DISTANCE = 35
        local SMOOTHNESS = 0.10
        
        aimlockConnection = RunService.RenderStepped:Connect(function()
            local myChar = localPlayer.Character
            local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
            if not myRoot then return end
            local closest, closestDist = nil, MAX_DISTANCE
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= localPlayer and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (myRoot.Position - hrp.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closest = hrp
                        end
                    end
                end
            end
            if closest then
                local camCF = camera.CFrame
                local direction = (closest.Position - camCF.Position).Unit
                local desiredCF = CFrame.lookAt(camCF.Position, camCF.Position + direction)
                camera.CFrame = camCF:Lerp(desiredCF, SMOOTHNESS)
            end
        end)
    else
        if aimlockConnection then
            aimlockConnection:Disconnect()
            aimlockConnection = nil
        end
    end
end)

-- AutoShoot (Improved for Mobile)
local autoShootEnabled = false
createToggle(Tab1Frame, 0.29, "AutoShoot", function(state)
    autoShootEnabled = state
    if state then
        task.spawn(function()
            local e = nil
            while autoShootEnabled do
                task.wait(isMobile and 0.09 or 0.07)
                local p = game.Players.LocalPlayer
                local c = p.Character
                if not c or not c:FindFirstChild("HumanoidRootPart") then task.wait(0.2) continue end
                if not e then
                    for _, v in ipairs(game:GetDescendants()) do
                        if v.Name == "RocketLauncherEvent" and v:IsA("RemoteEvent") then
                            e = v
                            break
                        end
                    end
                    if not e then task.wait(0.5) continue end
                end
                local root = c.HumanoidRootPart
                local closest, minD = nil, math.huge
                for _, pl in ipairs(game.Players:GetPlayers()) do
                    if pl ~= p and pl.Character and pl.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = pl.Character.HumanoidRootPart
                        local d = (root.Position - hrp.Position).Magnitude
                        if d < minD then
                            minD = d
                            closest = hrp
                        end
                    end
                end
                if closest then
                    e:FireServer(CFrame.new(root.Position, closest.Position))
                end
            end
        end)
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("Rocket Spleef Exploit Has Loaded!")
