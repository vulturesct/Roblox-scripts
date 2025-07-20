local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- Function to create white ESP
local function createESP(player)
	if player == localPlayer then return end

	local function applyESP(character)
		if character:FindFirstChild("Head") then
			-- Highlight (white)
			local highlight = Instance.new("Highlight")
			highlight.Adornee = character
			highlight.FillColor = Color3.fromRGB(255, 255, 255)
			highlight.FillTransparency = 0.25
			highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			highlight.OutlineTransparency = 0
			highlight.Parent = character

			-- Name tag (white)
			local billboard = Instance.new("BillboardGui")
			billboard.Name = "ESP_Name"
			billboard.Adornee = character.Head
			billboard.Size = UDim2.new(0, 200, 0, 50)
			billboard.StudsOffset = Vector3.new(0, 3, 0)
			billboard.AlwaysOnTop = true

			local text = Instance.new("TextLabel")
			text.Size = UDim2.new(1, 0, 1, 0)
			text.BackgroundTransparency = 1
			text.Text = player.Name
			text.TextColor3 = Color3.new(1, 1, 1) -- white
			text.TextStrokeTransparency = 0.5
			text.Font = Enum.Font.SourceSansBold
			text.TextScaled = true
			text.Parent = billboard

			billboard.Parent = character
		end
	end

	if player.Character then
		applyESP(player.Character)
	end

	player.CharacterAdded:Connect(function(char)
		task.wait(1)
		applyESP(char)
	end)
end

-- Existing players
for _, player in ipairs(Players:GetPlayers()) do
	createESP(player)
end

-- New players
Players.PlayerAdded:Connect(function(player)
	createESP(player)
end)
