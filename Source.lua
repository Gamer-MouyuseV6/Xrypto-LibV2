local Library = {}

function Library.CreateLoader(options)
    options = options or {}
    local toggleKey = options.ToggleKeybind or "RightControl"
    local uiColor = options.UIColor or Color3.fromRGB(39, 86, 255)
    local titleText = options.Tittle or "My UI"

    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Remove existing UI if already there
    local existingUI = playerGui:FindFirstChild("UI")
    if existingUI then
        existingUI:Destroy()
    end

    -- UI Setup
    local UI = Instance.new("ScreenGui")
    UI.Name = "UI"
    UI.Parent = playerGui
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UI.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = UI
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 409, 0, 347)
    Main.BackgroundTransparency = 1 -- Start invisible for fade-in

    local UISTROKE = Instance.new("UIStroke")
    UISTROKE.Color = uiColor
    UISTROKE.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UISTROKE.Thickness = 1
    UISTROKE.Transparency = 0.4
    UISTROKE.Parent = Main

    local HeaderLine = Instance.new("Frame")
    HeaderLine.Parent = Main
    HeaderLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HeaderLine.BorderSizePixel = 0
    HeaderLine.Position = UDim2.new(0, 0, 0.072, 0)
    HeaderLine.Size = UDim2.new(0, 408, 0, 1)

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(44, 44, 44)),
        ColorSequenceKeypoint.new(0.50, uiColor),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(44, 44, 44))
    }
    UIGradient.Parent = HeaderLine

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.02, 0, 0, 0)
    Title.Size = UDim2.new(0, 197, 0, 25)
    Title.Font = Enum.Font.Code
    Title.Text = titleText
    Title.TextColor3 = uiColor
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Main
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(0.93, 0, 0.01, 0)
    Close.Size = UDim2.new(0, 18, 0, 18)
    Close.Image = "rbxassetid://10747384394"

    local Minimize = Instance.new("ImageButton")
    Minimize.Name = "Minimize"
    Minimize.Parent = Main
    Minimize.BackgroundTransparency = 1
    Minimize.Position = UDim2.new(0.87, 0, 0.01, 0)
    Minimize.Size = UDim2.new(0, 18, 0, 18)
    Minimize.Image = "rbxassetid://10734896206"

    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    Sidebar.Position = UDim2.new(0.02, 0, 0.103, 0)
    Sidebar.Size = UDim2.new(0, 73, 0, 302)

    local UISTROKE2 = Instance.new("UIStroke")
    UISTROKE2.Color = Color3.fromRGB(44, 44, 44)
    UISTROKE2.Thickness = 1
    UISTROKE2.Parent = Sidebar

    local UICorner1 = Instance.new("UICorner")
    UICorner1.CornerRadius = UDim.new(0, 2)
    UICorner1.Parent = Sidebar

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = Main

    -- Templates for buttons and tabs
    local ButtonTemplate = Instance.new("TextButton")
    ButtonTemplate.Size = UDim2.new(1, -10, 0, 30)
    ButtonTemplate.Position = UDim2.new(0, 5, 0, 5)
    ButtonTemplate.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ButtonTemplate.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonTemplate.Font = Enum.Font.Code
    ButtonTemplate.TextSize = 14
    ButtonTemplate.Text = "Tab"
    ButtonTemplate.Visible = false
    ButtonTemplate.Parent = Sidebar

    -- Button logic
    Minimize.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
    Close.MouseButton1Click:Connect(function()
        UI:Destroy()
    end)

    -- Draggable logic
    local dragging, dragInput, dragStart, startPos
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local function update(input)
        local delta = input.Position - dragStart
        local goal = {}
        goal.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(Main, TweenInfo.new(0.04, Enum.EasingStyle.Sine), goal):Play()
    end
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Fade in Main
    TweenService:Create(Main, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()

    -- Toggle with keybind
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode[toggleKey] then
            UI.Enabled = not UI.Enabled
        end
    end)

    -- Tabs logic
    local Window = {}
    Window.Tabs = {}

    function Window.CreateTab(tabName)
        -- Create button
        local newButton = ButtonTemplate:Clone()
        newButton.Text = tabName
        newButton.Visible = true
        newButton.Position = UDim2.new(0, 5, 0, (#Sidebar:GetChildren() - 2) * 35)
        newButton.Parent = Sidebar

        -- Create tab frame
        local newTab = Instance.new("Frame")
        newTab.Name = tabName
        newTab.Parent = Main
        newTab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        newTab.Position = UDim2.new(0.21, 0, 0.103, 0)
        newTab.Size = UDim2.new(0.77, 0, 0.88, 0)
        newTab.Visible = false

        local UICornerTab = Instance.new("UICorner")
        UICornerTab.CornerRadius = UDim.new(0, 4)
        UICornerTab.Parent = newTab

        -- Button click shows tab
        newButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(Window.Tabs) do
                tab.Visible = false
            end
            newTab.Visible = true
        end)

        Window.Tabs[tabName] = newTab
        return newTab
    end

    Window.UI = UI
    Window.Visible = function(self, bool) UI.Enabled = bool end
    Window.Destroy = function(self) UI:Destroy() end

    return Window
end

return Library
