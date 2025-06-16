-- LocalScript in StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local holdingRightClick = false
local currentTarget = nil

-- Highlight all players except the local one
local function highlightCharacter(character)
	if not character:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.FillColor = Color3.fromRGB(255, 255, 0)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Adornee = character
		highlight.Parent = character
	end
end

-- Highlight all current players
for _, player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		player.CharacterAdded:Connect(highlightCharacter)
		if player.Character then
			highlightCharacter(player.Character)
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		player.CharacterAdded:Connect(highlightCharacter)
	end
end)

-- Find closest character to mouse
local function getClosestPlayer()
	local shortestDistance = math.huge
	local closestPlayer = nil

	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local screenPoint, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			if onScreen then
				local mousePos = Vector2.new(Mouse.X, Mouse.Y)
				local dist = (mousePos - Vector2.new(screenPoint.X, screenPoint.Y)).Magnitude
				if dist < shortestDistance then
					shortestDistance = dist
					closestPlayer = player
				end
			end
		end
	end

	return closestPlayer
end

-- Lock-on function
RunService.RenderStepped:Connect(function()
	if holdingRightClick then
		local target = getClosestPlayer()
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			currentTarget = target
			local hrp = target.Character.HumanoidRootPart
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position)
		end
	else
		currentTarget = nil
	end
end)

-- Input handling
UserInputService.InputBegan:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = true
	end
end)

UserInputService.InputEnded:Connect(function(input, processed)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = false
	end
end)
