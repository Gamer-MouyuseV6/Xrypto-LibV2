local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

function Library.CreateLoader(options)
    options = options or {}
    local toggleKey = options.ToggleKeybind or "RightControl"
    local uiColor = (options.UIColor or "Blue"):lower()

    local UI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local AspectRatio = Instance.new("UIAspectRatioConstraint")
    local UIStroke = Instance.new("UIStroke")

    UI.Name = "UI"
    UI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    UI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    UI.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = UI
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(13, 13, 13)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 232, 0, 197)
    Main.BackgroundTransparency = 1

    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()

    UIStroke.Color = Color3.fromRGB(76, 79, 255)
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.4
    UIStroke.Parent = Main

    AspectRatio.Name = "AspectRatio"
    AspectRatio.Parent = Main
    AspectRatio.AspectRatio = 1.177

    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        local dragTime = 0.04
        local goal = {}
        goal.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(Main, TweenInfo.new(dragTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goal):Play()
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

    local colorMap = {
        blue = Color3.fromRGB(76, 79, 255),
        red = Color3.fromRGB(255, 0, 0),
        green = Color3.fromRGB(0, 255, 0),
        yellow = Color3.fromRGB(255, 255, 0),
        purple = Color3.fromRGB(128, 0, 128)
    }
    local rainbowRunning = false

    if uiColor == "rainbow" then
        rainbowRunning = true
        coroutine.wrap(function()
            while rainbowRunning do
                local t = tick() * 2
                UIStroke.Color = Color3.fromHSV((t % 1), 1, 1)
                RunService.RenderStepped:Wait()
            end
        end)()
    elseif colorMap[uiColor] then
        UIStroke.Color = colorMap[uiColor]
    end

    local toggleKeyCode = Enum.KeyCode[toggleKey] or Enum.KeyCode.RightControl
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKeyCode then
            UI.Enabled = not UI.Enabled
        end
    end)

    return {
        UI = UI,
        Main = Main
    }
end

return Library
