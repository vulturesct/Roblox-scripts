-- VULT HUB mobile-ready: speed, jump, infinite jump, minimize & drag

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local hrp = character:WaitForChild("HumanoidRootPart")

-- Config
local WALK_SPEED = 100
local JUMP_POWER = 400

-- State flags
local speedOn, jumpOn, infJumpOn = false, false, false

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "VultHub"
gui.ResetOnSpawn = false

-- Main frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 220)
frame.Position = UDim2.new(0.5, -130, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", frame)

-- Make frame draggable
frame.Active = true
frame.Draggable = true

-- Minimize button
local minBtn = Instance.new("TextButton", frame)
minBtn.Text = "–"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextColor3 = Color3.new(1, 1, 1)
minBtn.TextScaled = true
minBtn.Size = UDim2.new(0, 30, 0, 20)
minBtn.Position = UDim2.new(1, -35, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", minBtn)

-- Draggable minimized bar
local miniBar = Instance.new("Frame", gui)
miniBar.Size = UDim2.new(0, 120, 0, 40)
miniBar.Position = UDim2.new(0.5, -60, 0.8, -20)
miniBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miniBar.Visible = false
Instance.new("UICorner", miniBar)
miniBar.Active = true
miniBar.Draggable = true

local miniLbl = Instance.new("TextLabel", miniBar)
miniLbl.Text = "VULT HUB"
miniLbl.Font = Enum.Font.GothamBold
miniLbl.TextColor3 = Color3.new(1, 1, 1)
miniLbl.TextScaled = true
miniLbl.Size = UDim2.new(1, -10, 1, 0)
miniLbl.Position = UDim2.new(0, 5, 0, 0)
miniLbl.BackgroundTransparency = 1

-- Buttons
local function makeBtn(txt, y)
	local b = Instance.new("TextButton", frame)
	b.Size = UDim2.new(1, -20, 0, 40)
	b.Position = UDim2.new(0, 10, 0, y)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = Color3.new(1, 1, 1)
	b.TextScaled = true
	b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", b)
	return b
end

local speedBtn = makeBtn("💨 Speed OFF", 40)
local jumpBtn = makeBtn("🦘 Jump OFF", 90)
local infBtn = makeBtn("♾️ Inf Jump OFF", 140)

-- Event Logic
minBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	miniBar.Visible = true
end)

miniBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		frame.Visible = true
		miniBar.Visible = false
	end
end)

speedBtn.MouseButton1Click:Connect(function()
	speedOn = not speedOn
	speedBtn.Text = speedOn and "💨 Speed ON" or "💨 Speed OFF"
	if not speedOn then humanoid.WalkSpeed = 16 end
end)

jumpBtn.MouseButton1Click:Connect(function()
	jumpOn = not jumpOn
	jumpBtn.Text = jumpOn and "🦘 Jump ON" or "🦘 Jump OFF"
end)

infBtn.MouseButton1Click:Connect(function()
	infJumpOn = not infJumpOn
	infBtn.Text = infJumpOn and "♾️ Inf Jump ON" or "♾️ Inf Jump OFF"
end)

-- Effects Loop
RunService.RenderStepped:Connect(function()
	if speedOn then humanoid.WalkSpeed = WALK_SPEED end
end)

UserInputService.JumpRequest:Connect(function()
	if jumpOn then humanoid.JumpPower = JUMP_POWER end
	if infJumpOn then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
