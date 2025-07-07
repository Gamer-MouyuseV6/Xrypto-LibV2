local Library = {}

function Library.CreateLoader(options)
    options = options or {}
    local toggleKey = Enum.KeyCode[options.ToggleKeybind] or Enum.KeyCode.LeftControl
    local uiColors = options.UIColor or {}
    local mainColor = uiColors.MainUI or Color3.fromRGB(6, 6, 6)
    local outlineColor = uiColors.OutLineUI or Color3.fromRGB(0, 47, 255)

    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local existingUI = playerGui:FindFirstChild("Key")

    if existingUI then
        existingUI:Destroy()
    end

    local Key = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UISTROKE = Instance.new("UIStroke")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")

    Key.Name = "Key"
    Key.Parent = playerGui
    Key.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Key.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = Key
    Main.BackgroundColor3 = mainColor
    Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.35, 0, 0.35, 0)
    Main.Size = UDim2.new(0, 247, 0, 207)

    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = Main

    UISTROKE.Color = outlineColor
    UISTROKE.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UISTROKE.Thickness = 1
    UISTROKE.Transparency = 0
    UISTROKE.Parent = Main

    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        local goal = { Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) }
        TweenService:Create(Main, TweenInfo.new(0.04, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal):Play()
    end

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    local function toggleFrame()
        Main.Visible = not Main.Visible
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == toggleKey then
            toggleFrame()
        end
    end)

    local API = {}
    function API:Visible(bool)
        Main.Visible = bool
    end

    return API
end

return Library
