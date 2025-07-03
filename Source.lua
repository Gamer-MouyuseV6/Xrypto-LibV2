local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library.CreateLoader(options)
    options = options or {}
    local toggleKey = options.ToggleKeybind or "RightControl"
    local uiColor = (options.UIColor or "Blue"):lower()
    local titleText = options.Tittle or "UI"

    -- Check for existing UI to allow only one
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local existingUI = playerGui:FindFirstChild("UI")
    if existingUI then
        local mainFrame = existingUI:FindFirstChild("Main")
        return {
            UI = existingUI,
            Main = mainFrame,
            Visible = function(self, bool) existingUI.Enabled = bool end,
            Destroy = function(self) existingUI:Destroy() end
        }
    end

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
    Main.Size = UDim2.new(0, 232, 0, 197)
    Main.BackgroundTransparency = 1

    TweenService:Create(Main, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()

    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.4
    UIStroke.Parent = Main

    local AspectRatio = Instance.new("UIAspectRatioConstraint")
    AspectRatio.Name = "AspectRatio"
    AspectRatio.Parent = Main
    AspectRatio.AspectRatio = 1.177

    local ColorLine = Instance.new("Frame")
    ColorLine.Name = "ColorLine"
    ColorLine.Parent = Main
    ColorLine.BackgroundColor3 = Color3.new(1,1,1)
    ColorLine.BorderSizePixel = 0
    ColorLine.Position = UDim2.new(0, 0, 0.142, 0)
    ColorLine.Size = UDim2.new(0, 231, 0, 1)

    local ColorLine2 = Instance.new("Frame")
    ColorLine2.Name = "ColorLine2"
    ColorLine2.Parent = Main
    ColorLine2.BackgroundColor3 = Color3.new(1,1,1)
    ColorLine2.BorderSizePixel = 0
    ColorLine2.Position = UDim2.new(0.185, 0, 0.147, 0)
    ColorLine2.Size = UDim2.new(0, 1, 0, 168)

    local Tittle = Instance.new("TextLabel")
    Tittle.Name = "Tittle"
    Tittle.Parent = Main
    Tittle.BackgroundTransparency = 1
    Tittle.Position = UDim2.new(0.03, 0, 0, 0)
    Tittle.Size = UDim2.new(0, 162, 0, 29)
    Tittle.Font = Enum.Font.Code
    Tittle.TextColor3 = Color3.new(1,1,1)
    Tittle.TextSize = 13
    Tittle.TextXAlignment = Enum.TextXAlignment.Left
    Tittle.Text = titleText

    -- Color map for UI colors
    local colorMap = {
        blue = Color3.fromRGB(76, 79, 255),
        red = Color3.fromRGB(255, 0, 0),
        green = Color3.fromRGB(0, 255, 0),
        yellow = Color3.fromRGB(255, 255, 0),
        purple = Color3.fromRGB(128, 0, 128)
    }

    -- Apply color to stroke, lines, and title text
    local chosenColor = colorMap[uiColor] or colorMap.blue
    UIStroke.Color = chosenColor
    ColorLine.BackgroundColor3 = chosenColor
    ColorLine2.BackgroundColor3 = chosenColor
    Tittle.TextColor3 = chosenColor

    -- Drag logic (same as before)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        local goal = {}
        goal.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
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

    -- Toggle UI visibility on keybind
    local toggleKeyCode = Enum.KeyCode[toggleKey] or Enum.KeyCode.RightControl
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKeyCode then
            UI.Enabled = not UI.Enabled
        end
    end)

    -- Return the UI with custom methods
    return {
        UI = UI,
        Main = Main,
        Visible = function(self, bool)
            UI.Enabled = bool and true or false
        end,
        Destroy = function(self)
            UI:Destroy()
        end
    }
end

return Library
