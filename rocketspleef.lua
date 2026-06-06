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
    -- Key System (same as before)
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Parent = RSScript
    KeyFrame.Size = isMobile and UDim2.new(0.9, 0, 0, 170) or UDim2.new(0, 356, 0, 147)
    KeyFrame.Position = UDim2.new(0.5, isMobile and -170 or -178, 0.5, -85)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Visible = true

    -- ... (Key System code remains the same - Title, textbox, buttons, dragging) ...

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
MainFrame.Size = isMobile and UDim2.new(0.85, 0, 0.52, 0) or UDim2.new(0, 434, 0, 378)
MainFrame.Position = isMobile and UDim2.new(0.075, 0, 0.22, 0) or UDim2.new(0.343, 0, 0.196, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = getgenv().RSKeyVerified or false

-- Mobile Button
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

-- Dragging, Title, Close, Credit, LeftFrame, Tab1Frame (same as before)...

-- Labels (PC positions untouched)
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

-- Toggles (PC positions untouched)
createToggle(Tab1Frame, 0.095, "AntiDie", function(state) ... end)

local aimlockConnection = nil
createToggle(Tab1Frame, 0.493, "Aimlock", function(state) ... end)

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
