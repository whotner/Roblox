local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local espCache = {}
local playersCache = {}

-- Colors
local DEFAULT_COLOR = Color3.fromRGB(255, 0, 0)
local VISIBLE_COLOR = Color3.fromRGB(0, 255, 0)
local NOT_VISIBLE_COLOR = Color3.fromRGB(255, 0, 0)


local UPDATE_INTERVAL = 0.1 
local DISTANCE_CHECK_INTERVAL = 0.5 
local MAX_ESP_DISTANCE = 500 
local RAYCAST_DISTANCE_LIMIT = 200 


local lastVisibilityUpdate = 0
local lastDistanceUpdate = 0
local lastScanUpdate = 0


local function isCharacterVisible(targetCharacter, localCharacter)
    if not targetCharacter or not localCharacter then
        return false
    end
    
    local targetHead = targetCharacter:FindFirstChild("Head")
    local localHead = localCharacter:FindFirstChild("Head")
    
    if not targetHead or not localHead then
        return false
    end
    

    local distance = (targetHead.Position - localHead.Position).Magnitude
    if distance > RAYCAST_DISTANCE_LIMIT then
        return false
    end
    

    local direction = (targetHead.Position - localHead.Position).Unit
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {localCharacter, targetCharacter}
    raycastParams.IgnoreWater = true
    
    local raycastResult = workspace:Raycast(localHead.Position, direction * math.min(distance, RAYCAST_DISTANCE_LIMIT), raycastParams)
    
    return raycastResult == nil or raycastResult.Instance:IsDescendantOf(targetCharacter)
end


local function createEsp(character, player)
    if espCache[character] then return end
    if not character or not character:FindFirstChild("Humanoid") then return end
    
    -- Highlight
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = character
    highlight.FillTransparency = 0.9
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = DEFAULT_COLOR
    highlight.OutlineColor = DEFAULT_COLOR
    highlight.Parent = character
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = character:WaitForChild("Head", 2)
    if not billboard.Adornee then
        highlight:Destroy()
        return
    end
    
    billboard.Size = UDim2.new(0, 200, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = MAX_ESP_DISTANCE
    billboard.Enabled = true
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESP_Text"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = DEFAULT_COLOR
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextStrokeTransparency = 0.3
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamSemibold
    textLabel.TextXAlignment = Enum.TextXAlignment.Center
    textLabel.Parent = billboard
    
    billboard.Parent = character
    
    espCache[character] = {
        highlight = highlight,
        billboard = billboard,
        textLabel = textLabel,
        player = player,
        isVisible = false,
        lastDistance = 0,
        lastDistanceText = "",
        billboardEnabled = true
    }
    
    local function cleanup()
        if espCache[character] then
            espCache[character].highlight:Destroy()
            espCache[character].billboard:Destroy()
            espCache[character] = nil
        end
    end
    
    character.AncestryChanged:Connect(function()
        if not character:IsDescendantOf(workspace) then
            cleanup()
        end
    end)
    
    character:WaitForChild("Humanoid").Died:Connect(cleanup)
end

local function updateDistanceOnly(character, espData, distance)
    local distanceText = string.format("%.0fm", distance)
    if espData.lastDistanceText ~= distanceText then
        espData.textLabel.Text = espData.player.Name .. " [" .. distanceText .. "]"
        espData.lastDistanceText = distanceText
        espData.lastDistance = distance
    end
    
    local shouldBeEnabled = distance <= MAX_ESP_DISTANCE
    if espData.billboardEnabled ~= shouldBeEnabled then
        espData.billboard.Enabled = shouldBeEnabled
        espData.billboardEnabled = shouldBeEnabled
    end
end

local function optimizedUpdate()
    local currentTime = tick()
    local localCharacter = localPlayer.Character
    
    if not localCharacter then return end
    
    local localHead = localCharacter:FindFirstChild("Head")
    local localRoot = localCharacter:FindFirstChild("HumanoidRootPart")
    if not localHead or not localRoot then return end
    
    local updateVisibility = (currentTime - lastVisibilityUpdate) > UPDATE_INTERVAL
    local updateDistance = (currentTime - lastDistanceUpdate) > DISTANCE_CHECK_INTERVAL
    
    if updateVisibility then
        lastVisibilityUpdate = currentTime
    end
    
    if updateDistance then
        lastDistanceUpdate = currentTime
    end
    
    for character, espData in pairs(espCache) do
        if not character or not character.Parent then
            espCache[character] = nil
            continue
        end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid or humanoid.Health <= 0 then
            removeEsp(character)
            continue
        end
        
        local targetRoot = character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        local distance = (targetRoot.Position - localRoot.Position).Magnitude
        
        if updateDistance then
            updateDistanceOnly(character, espData, distance)
        end
        
        if updateVisibility and distance <= RAYCAST_DISTANCE_LIMIT then
            local targetHead = character:FindFirstChild("Head")
            if not targetHead then continue end
            
            local isVisible = isCharacterVisible(character, localCharacter)
            
            if espData.isVisible ~= isVisible then
                espData.isVisible = isVisible
                local color = isVisible and VISIBLE_COLOR or NOT_VISIBLE_COLOR
                
                espData.highlight.FillColor = color
                espData.highlight.OutlineColor = color
                espData.textLabel.TextColor3 = color
            end
        end
    end
end

local function removeEsp(character)
    local espData = espCache[character]
    if espData then
        pcall(function()
            espData.highlight:Destroy()
            espData.billboard:Destroy()
        end)
        espCache[character] = nil
    end
end

local function optimizedScan()
    local currentTime = tick()
    if currentTime - lastScanUpdate < 2 then return end
    lastScanUpdate = currentTime
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            local character = player.Character
            if character:FindFirstChild("Humanoid") and not espCache[character] then
                createEsp(character, player)
            end
        end
    end
    
    for character in pairs(espCache) do
        if not character or not character.Parent or not character:FindFirstChild("Humanoid") then
            removeEsp(character)
        end
    end
end

local function setupPlayerEvents(player)
    if player == localPlayer then return end
    
    player.CharacterAdded:Connect(function(character)
        task.wait(0.5)
        if character:FindFirstChild("Humanoid") then
            createEsp(character, player)
        end
    end)
    
    if player.Character then
        task.spawn(function()
            task.wait(1)
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                createEsp(player.Character, player)
            end
        end)
    end
end

for _, player in pairs(Players:GetPlayers()) do
    setupPlayerEvents(player)
end

Players.PlayerAdded:Connect(setupPlayerEvents)

Players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeEsp(player.Character)
    end
end)

localPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    optimizedScan()
end)

task.spawn(function()
    while task.wait(0.5) do
        optimizedScan()
    end
end)

RunService.Heartbeat:Connect(optimizedUpdate)
