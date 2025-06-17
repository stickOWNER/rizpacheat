local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "Rizpa"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false

-- Create the menu frame
local menuFrame = Instance.new("Frame", screenGui)
menuFrame.Size = UDim2.new(0.4, 0, 0.6, 0)
menuFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(128, 0, 255)  -- Purple background
menuFrame.BackgroundTransparency = 0.4  -- Transparent background
menuFrame.BorderSizePixel = 0

-- Title
local titleLabel = Instance.new("TextLabel", menuFrame)
titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
titleLabel.Text = "Rizpa Menu"
titleLabel.TextScaled = true
titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White background
titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)  -- Black text

-- Tab bar
local tabBar = Instance.new("Frame", menuFrame)
tabBar.Size = UDim2.new(1, 0, 0.1, 0)
tabBar.Position = UDim2.new(0, 0, 0.1, 0)
tabBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- Create a function for adding buttons
local function createTabButton(name, pos)
    local button = Instance.new("TextButton", tabBar)
    button.Text = name
    button.TextScaled = true
    button.Size = UDim2.new(0.33, 0, 1, 0)
    button.Position = UDim2.new(pos, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.TextColor3 = Color3.fromRGB(0, 0, 0)
    return button
end

-- Tab buttons for different features
local homeTabButton = createTabButton("Home", 0)
local espTabButton = createTabButton("ESP", 0.33)
local aimbotTabButton = createTabButton("Aimbot", 0.66)
local flyTabButton = createTabButton("Fly", 1)

-- Content Frames
local function createContentFrame()
    local frame = Instance.new("Frame", menuFrame)
    frame.Size = UDim2.new(1, 0, 0.8, 0)
    frame.Position = UDim2.new(0, 0, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    frame.BackgroundTransparency = 0.5  -- Make it a bit transparent
    frame.Visible = false
    return frame
end

-- Creating content for each tab
local homeContent = createContentFrame()
local espContent = createContentFrame()
local aimbotContent = createContentFrame()
local flyContent = createContentFrame()

-- Home Page Content (Discord button)
local discordButton = Instance.new("TextButton", homeContent)
discordButton.Size = UDim2.new(0.5, 0, 0.1, 0)
discordButton.Position = UDim2.new(0.25, 0, 0.4, 0)
discordButton.Text = "Join Discord"
discordButton.TextScaled = true
discordButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- ESP button functionality
local espButton = Instance.new("TextButton", espContent)
espButton.Size = UDim2.new(0.5, 0, 0.1, 0)
espButton.Position = UDim2.new(0.25, 0, 0.4, 0)
espButton.Text = "Enable ESP"
espButton.TextScaled = true
espButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Aimbot button functionality
local aimbotButton = Instance.new("TextButton", aimbotContent)
aimbotButton.Size = UDim2.new(0.5, 0, 0.1, 0)
aimbotButton.Position = UDim2.new(0.25, 0, 0.4, 0)
aimbotButton.Text = "Enable Aimbot"
aimbotButton.TextScaled = true
aimbotButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Fly button functionality
local flyButton = Instance.new("TextButton", flyContent)
flyButton.Size = UDim2.new(0.5, 0, 0.1, 0)
flyButton.Position = UDim2.new(0.25, 0, 0.4, 0)
flyButton.Text = "Enable Fly"
flyButton.TextScaled = true
flyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle visibility function for tabs
local function showTab(tab)
    homeContent.Visible = false
    espContent.Visible = false
    aimbotContent.Visible = false
    flyContent.Visible = false

    if tab == "Home" then
        homeContent.Visible = true
    elseif tab == "ESP" then
        espContent.Visible = true
    elseif tab == "Aimbot" then
        aimbotContent.Visible = true
    elseif tab == "Fly" then
        flyContent.Visible = true
    end
end

-- Button clicks to show respective tabs
homeTabButton.MouseButton1Click:Connect(function() showTab("Home") end)
espTabButton.MouseButton1Click:Connect(function() showTab("ESP") end)
aimbotTabButton.MouseButton1Click:Connect(function() showTab("Aimbot") end)
flyTabButton.MouseButton1Click:Connect(function() showTab("Fly") end)

-- Discord button opens Discord link
discordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/HujSyrD72W")
end)

-- ESP functionality
local espEnabled = false
local espHighlights = {}

local function toggleESP()
    espEnabled = not espEnabled
    -- Clear previous ESP Highlights
    for _, highlight in pairs(espHighlights) do
        if highlight.Parent then
            highlight:Destroy()
        end
    end
    table.clear(espHighlights)

    if espEnabled then
        -- Add ESP logic here
        for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = otherPlayer.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.FillTransparency = 0.3
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
                highlight.Parent = otherPlayer.Character
                table.insert(espHighlights, highlight)
            end
        end
    end
end
espButton.MouseButton1Click:Connect(toggleESP)

-- Aimbot functionality: Right-click to lock onto the nearest player
local aimbotEnabled = false
local nearestPlayer = nil
local function findNearestPlayer()
    local closestDistance = math.huge
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
            if distance < closestDistance then
                closestDistance = distance
                nearestPlayer = plr
            end
        end
    end
end

local function aimbot()
    if nearestPlayer and nearestPlayer.Character then
        local characterHead = nearestPlayer.Character:FindFirstChild("Head")
        if characterHead then
            -- Aim at the player's head
            local camera = game.Workspace.CurrentCamera
            local lookAtCFrame = CFrame.new(camera.CFrame.Position, characterHead.Position)
            camera.CFrame = lookAtCFrame
        end
    end
end

-- Detect right-click to lock on player
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.UserInputType == Enum.UserInputType.MouseButton2 then  -- Right-click
        aimbotEnabled = true
        findNearestPlayer()  -- Find nearest player on right-click
    end

    if input.KeyCode == Enum.KeyCode.F then
        -- Fly toggle functionality
        if not flying then
            flying = true
            flyButton.Text = "Disable Fly"
        else
            flying = false
            flyButton.Text = "Enable Fly"
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then  -- Right-click released
        aimbotEnabled = false
    end
end)

-- Fly functionality
local flying = false
local function fly()
    if flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
        bodyVelocity.Parent = player.Character.HumanoidRootPart
    end
end

-- Main Update Loop (to constantly update the Aimbot and Fly)
game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        aimbot()
    end

    if flying then
        fly()
    end
end)

-- Toggle Menu with "P"
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.P then
        screenGui.Enabled = not screenGui.Enabled
    end
end)
