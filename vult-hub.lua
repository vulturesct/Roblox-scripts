local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "VultHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

local speedBtn = Instance.new("TextButton", frame)
speedBtn.Size = UDim2.new(0, 120, 0, 40)
speedBtn.Position = UDim2.new(0, 10, 0, 10)
speedBtn.Text = "Speed Boost"
speedBtn.MouseButton1Click:Connect(function()
    player.Character.Humanoid.WalkSpeed = 50
end)

local jumpBtn = Instance.new("TextButton", frame)
jumpBtn.Size = UDim2.new(0, 120, 0, 40)
jumpBtn.Position = UDim2.new(0, 10, 0, 60)
jumpBtn.Text = "Jump Boost"
jumpBtn.MouseButton1Click:Connect(function()
    player.Character.Humanoid.JumpPower = 100
end)
