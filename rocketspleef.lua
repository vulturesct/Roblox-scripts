local RSScript = Instance.new("ScreenGui")
RSScript.Name = "RSscript"
RSScript.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
RSScript.IgnoreGuiInset = true
RSScript.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = RSScript
MainFrame.Size = UDim2.new(0, 434, 0, 378)
MainFrame.Position = UDim2.new(0.343, 0, 0.196, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true

-- FIXED DRAGGING FOR XENO (moved to main script + extra RenderStepped force)
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    if not dragging then return end
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

-- Use Title for dragging (more reliable on Xeno)
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -50, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Rocket Spleef"
Title.Font = Enum.Font.FredokaOne
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BorderSizePixel = 0

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Parent = Title
TitleStroke.Thickness = 3
TitleStroke.Color = Color3.fromRGB(0, 0, 0)

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
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

-- Extra Xeno force
game:GetService("RunService").RenderStepped:Connect(function()
    if dragging and dragInput then
        update(dragInput)
    end
end)

-- Close Button (X)
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = 28
CloseButton.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.BorderSizePixel = 0
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0.3, 0)
CloseCorner.Parent = CloseButton
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Name = "Credit"
Credit.Parent = MainFrame
Credit.Size = UDim2.new(0, 221, 0, 33)
Credit.Position = UDim2.new(0.258, 0, 0.894, 0)
Credit.BackgroundTransparency = 1
Credit.Text = "made by vulturewastaken7."
Credit.Font = Enum.Font.FredokaOne
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.TextScaled = true

local LeftFrame = Instance.new("Frame")
LeftFrame.Name = "LeftFrame"
LeftFrame.Parent = MainFrame
LeftFrame.Size = UDim2.new(0, 92, 0, 328)
LeftFrame.Position = UDim2.new(0, 0, 0.132, 0)
LeftFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
LeftFrame.BorderSizePixel = 0

local Tab1Frame = Instance.new("Frame")
Tab1Frame.Name = "Tab1Frame"
Tab1Frame.Parent = MainFrame
Tab1Frame.Size = UDim2.new(0, 336, 0, 328)
Tab1Frame.Position = UDim2.new(0, 92, 0.132, 0)
Tab1Frame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
Tab1Frame.BorderSizePixel = 0

local function createToggle(parent, yScale, labelText, toggleFunc)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Parent = parent
    toggleFrame.Size = UDim2.new(0, 92, 0, 42)
    toggleFrame.Position = UDim2.new(0.67, 0, yScale, 0)
    toggleFrame.BackgroundTransparency = 1
   
    local colorFrame = Instance.new("Frame")
    colorFrame.Name = "colorframe"
    colorFrame.Parent = toggleFrame
    colorFrame.Size = UDim2.new(0, 84, 0, 37)
    colorFrame.Position = UDim2.new(0, 4, 0.5, -18.5)
    colorFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    colorFrame.BorderSizePixel = 0
   
    Instance.new("UICorner", colorFrame).CornerRadius = UDim.new(0.5, 0)
   
    local knob = Instance.new("ImageButton")
    knob.Name = "ImageButton"
    knob.Parent = colorFrame
    knob.Size = UDim2.new(0, 32, 0, 32)
    knob.Position = UDim2.new(0, 5, 0.5, -16)
    knob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    knob.BorderSizePixel = 0
    knob.ZIndex = 2
   
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0.5, 0)
   
    local isOn = false
    local tweenService = game:GetService("TweenService")
    local knobSize = 32
   
    knob.MouseButton1Click:Connect(function()
        isOn = not isOn
       
        if isOn then
            colorFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
            knob.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            tweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                Position = UDim2.new(1, -(knobSize + 10), 0.5, -knobSize/2)
            }):Play()
            toggleFunc(true)
        else
            colorFrame.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
            knob.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            tweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0, 5, 0.5, -knobSize/2)
            }):Play()
            toggleFunc(false)
        end
    end)
   
    return toggleFrame
end

-- Labels
local antiDieText = Instance.new("TextLabel")
antiDieText.Parent = Tab1Frame
antiDieText.Size = UDim2.new(0, 186, 0, 40)
antiDieText.Position = UDim2.new(0.146, 0, 0.095, 0)
antiDieText.BackgroundTransparency = 1
antiDieText.Text = "AntiDie"
antiDieText.Font = Enum.Font.FredokaOne
antiDieText.TextSize = 44
antiDieText.TextColor3 = Color3.fromRGB(255, 255, 255)

local aimText = Instance.new("TextLabel")
aimText.Parent = Tab1Frame
aimText.Size = UDim2.new(0, 186, 0, 40)
aimText.Position = UDim2.new(0.116, 0, 0.493, 0)
aimText.BackgroundTransparency = 1
aimText.Text = "Aimlock"
aimText.Font = Enum.Font.FredokaOne
aimText.TextSize = 44
aimText.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoText = Instance.new("TextLabel")
autoText.Parent = Tab1Frame
autoText.Size = UDim2.new(0, 209, 0, 40)
autoText.Position = UDim2.new(0.048, 0, 0.29, 0)
autoText.BackgroundTransparency = 1
autoText.Text = "AutoShoot"
autoText.Font = Enum.Font.FredokaOne
autoText.TextSize = 42
autoText.TextColor3 = Color3.fromRGB(255, 255, 255)

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

-- AutoShoot
local autoShootEnabled = false  -- Shared state

createToggle(Tab1Frame, 0.29, "AutoShoot", function(state)
    autoShootEnabled = state
    
    if state then
        task.spawn(function()
            local e = nil
            
            while autoShootEnabled do  -- Now uses the shared variable
                task.wait(0.07)
                local p = game.Players.LocalPlayer
                local c = p.Character
                if not c or not c:FindFirstChild("HumanoidRootPart") then 
                    task.wait(0.1)
                    continue 
                end
             
                if not e then
                    for _, v in ipairs(game:GetDescendants()) do
                        if v.Name == "RocketLauncherEvent" and v:IsA("RemoteEvent") then
                            e = v
                            break
                        end
                    end
                end
             
                if e then
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
            end
        end)
    end
end)

-- Keybind to toggle MainFrame (RightShift)
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

print("UI Loaded with Keybind (RightShift), Close Button, and Fixed Xeno Dragging")
