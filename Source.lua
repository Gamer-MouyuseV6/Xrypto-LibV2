local Library = {}

function Library.CreateLoader(options)
    options = options or {}
    local title = options.Tittle or "My Script"
    local toggleKeybind = options.ToggleKeybind or "RightControl"
    local uiColor = options.UIColor or Color3.fromRGB(255, 100, 100)

    local gsCoreGui = game:GetService("CoreGui")
    local gsTween = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")

    local UI = Instance.new("ScreenGui")
    UI.Name = "UI"
    UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = UI
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 409, 0, 347)

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = Main

    local UISTROKE = Instance.new("UIStroke")
    UISTROKE.Color = uiColor
    UISTROKE.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UISTROKE.Thickness = 1
    UISTROKE.Transparency = 0.4
    UISTROKE.Parent = Main

    local Frame = Instance.new("Frame")
    Frame.Name = ""
    Frame.Parent = Main
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.072538875, 0)
    Frame.Size = UDim2.new(0, 408, 0, 1)

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(44, 44, 44)),
        ColorSequenceKeypoint.new(0.51, uiColor),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(44, 44, 44))
    }
    UIGradient.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.BorderSizePixel = 0
    Title.Position = UDim2.new(0.019780241, 0, 0, 0)
    Title.Size = UDim2.new(0, 197, 0, 25)
    Title.Font = Enum.Font.Code
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Main
    Close.BackgroundTransparency = 1
    Close.BorderSizePixel = 0
    Close.Position = UDim2.new(0.93154043, 0, 0.00864553358, 0)
    Close.Size = UDim2.new(0, 18, 0, 18)
    Close.Image = "rbxassetid://10747384394"

    local Minus = Instance.new("ImageButton")
    Minus.Name = "Minus"
    Minus.Parent = Main
    Minus.BackgroundTransparency = 1
    Minus.BorderSizePixel = 0
    Minus.Position = UDim2.new(0.87286073, 0, 0.00864553358, 0)
    Minus.Size = UDim2.new(0, 18, 0, 18)
    Minus.Image = "rbxassetid://10734896206"

    local Tab = Instance.new("Frame")
    Tab.Name = "Tab"
    Tab.Parent = Main
    Tab.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    Tab.BorderSizePixel = 0
    Tab.Position = UDim2.new(0.0195599031, 0, 0.103746399, 0)
    Tab.Size = UDim2.new(0, 73, 0, 302)

    local UICorner_2 = Instance.new("UICorner")
    UICorner_2.CornerRadius = UDim.new(0, 2)
    UICorner_2.Parent = Tab

    local UISTROKE2 = Instance.new("UIStroke")
    UISTROKE2.Color = Color3.fromRGB(44, 44, 44)
    UISTROKE2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UISTROKE2.Thickness = 1
    UISTROKE2.Transparency = 0
    UISTROKE2.Parent = Tab

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = Tab
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 3)

    local Dontworry = Instance.new("Frame")
    Dontworry.Name = "Dontworry"
    Dontworry.Parent = Tab
    Dontworry.BackgroundTransparency = 1
    Dontworry.BorderSizePixel = 0
    Dontworry.Size = UDim2.new(0, 86, 0, 0)

    local TESTBUTTON = Instance.new("TextButton")
    TESTBUTTON.Name = "TESTBUTTON"
    TESTBUTTON.Parent = Tab
    TESTBUTTON.BackgroundTransparency = 1
    TESTBUTTON.BorderSizePixel = 0
    TESTBUTTON.Position = UDim2.new(0.0684931502, 0, 0.043046359, 0)
    TESTBUTTON.Size = UDim2.new(0, 68, 0, 19)
    TESTBUTTON.Font = Enum.Font.Code
    TESTBUTTON.Text = "TEST"
    TESTBUTTON.TextColor3 = Color3.fromRGB(255, 255, 255)
    TESTBUTTON.TextSize = 14

    local TESTTAB = Instance.new("Frame")
    TESTTAB.Name = "TESTTAB"
    TESTTAB.Parent = Main
    TESTTAB.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    TESTTAB.BorderSizePixel = 0
    TESTTAB.Position = UDim2.new(0.229829073, 0, 0. three, 0)
    TESTTAB.Size = UDim2.new(0, 305, 0, 302)

    local UICorner_3 = Instance.new("UICorner")
    UICorner_3.CornerRadius = UDim.new(0, 2)
    UICorner_3.Parent = TESTTAB

    local UISTROKE3 = Instance.new("UIStroke")
    UISTROKE3.Color = Color3.fromRGB(44, 44, 44)
    UISTROKE3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UISTROKE3.Thickness = 1
    UISTROKE3.Transparency = 0
    UISTROKE3.Parent = TESTTAB

    local Drag = Main
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        local dragTime = 0.04
        local SmoothDrag = {}
        SmoothDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        local dragSmoothFunction = gsTween:Create(Drag, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), SmoothDrag)
        dragSmoothFunction:Play()
    end

    Drag.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Drag.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Drag.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging and Drag.Size then
            update(input)
        end
    end)

    Close.MouseButton1Click:Connect(function()
        UI.Enabled = false
    end)

    Minus.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)

    local keybindEnum = Enum.KeyCode[toggleKeybind] or Enum.KeyCode.RightControl
    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if not gameProcessedEvent and input.KeyCode == keybindEnum then
            UI.Enabled = not UI.Enabled
        end
    end)

    local Window = {}
    function Window:Visible(state)
        UI.Enabled = state
    end

    return Window
end

return Library
