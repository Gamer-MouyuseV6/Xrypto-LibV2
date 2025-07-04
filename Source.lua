local Library = {}

function Library.CreateLoader(options)
    local title = options.Title or "UI Library"
    local toggleKey = options.ToggleKeybind or Enum.KeyCode.RightControl
    local uiColor = options.UIColor or Color3.fromRGB(255, 100, 100)
    
    -- Create main UI instance
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UILibrary"
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ResetOnSpawn = false
    
    -- Create main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    -- Add corner rounding
    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = mainFrame
    
    -- Create title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = uiColor
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 1, 0)
    titleLabel.Position = UDim2.new(0, 5, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 14
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    
    -- Create side tab container
    local sideTab = Instance.new("Frame")
    sideTab.Size = UDim2.new(0, 120, 1, -30)
    sideTab.Position = UDim2.new(0, 0, 0, 30)
    sideTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sideTab.BorderSizePixel = 0
    sideTab.Parent = mainFrame
    
    local sideTabCorner = Instance.new("UICorner")
    sideTabCorner.CornerRadius = UDim.new(0, 8)
    sideTabCorner.Parent = sideTab
    
    -- Create content area
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -120, 1, -30)
    contentArea.Position = UDim2.new(0, 120, 0, 30)
    contentArea.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    contentArea.BorderSizePixel = 0
    contentArea.Parent = mainFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 8)
    contentCorner.Parent = contentArea
    
    -- Toggle functionality
    local userInputService = game:GetService("UserInputService")
    local isVisible = false
    
    local function toggleUI()
        isVisible = not isVisible
        mainFrame.Visible = isVisible
    end
    
    userInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKey then
            toggleUI()
        end
    end)
    
    -- Window functions
    local window = {}
    
    function window:Visible(state)
        isVisible = state
        mainFrame.Visible = state
    end
    
    return window
end

return Library
