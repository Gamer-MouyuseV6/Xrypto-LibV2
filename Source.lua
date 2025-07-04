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

    local Frame = Instance.new("Frame")
    Frame.Parent = Main
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.072, 0)
    Frame.Size = UDim2.new(0, 408, 0, 1)

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(44, 44, 44)),
        ColorSequenceKeypoint.new(0.50, uiColor),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(44, 44, 44))
    }
    UIGradient.Parent = Frame

    local Tittle = Instance.new("TextLabel")
    Tittle.Name = "Tittle"
    Tittle.Parent = Main
    Tittle.BackgroundTransparency = 1
    Tittle.Position = UDim2.new(0.02, 0, 0, 0)
    Tittle.Size = UDim2.new(0, 197, 0, 25)
    Tittle.Font = Enum.Font.Code
    Tittle.Text = titleText
    Tittle.TextColor3 = uiColor
    Tittle.TextSize = 15
    Tittle.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Main
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(0.93, 0, 0.01, 0)
    Close.Size = UDim2.new(0, 18, 0, 18)
    Close.Image = "rbxassetid://10747384394"

    local Minus = Instance.new("ImageButton")
    Minus.Name = "Minus"
    Minus.Parent = Main
    Minus.BackgroundTransparency = 1
    Minus.Position = UDim2.new(0.87, 0, 0.01, 0)
    Minus.Size = UDim2.new(0, 18, 0, 18)
    Minus.Image = "rbxassetid://10734896206"

    local Tab = Instance.new("Frame")
    Tab.Name = "Tab"
    Tab.Parent = Main
    Tab.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    Tab.Position = UDim2.new(0.02, 0, 0.103, 0)
    Tab.Size = UDim2.new(0, 73, 0, 302)

    local UISTROKE2 = Instance.new("UIStroke")
    UISTROKE2.Color = Color3.fromRGB(44, 44, 44)
    UISTROKE2.Thickness = 1
    UISTROKE2.Parent = Tab

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = Tab

    local UICorner2 = Instance.new("UICorner")
    UICorner2.CornerRadius = UDim.new(0, 3)
    UICorner2.Parent = Main

    -- Button logic
    Minus.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
    Close.MouseButton1Click:Connect(function()
        UI:Destroy()
    end)

    -- Draggable
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

    return {
        UI = UI,
        Main = Main,
        Visible = function(self, bool) UI.Enabled = bool end,
        Destroy = function(self) UI:Destroy() end
    }
end

return Library
