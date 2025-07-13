local Library = {}

function Library:CreateWindow(options)
    local titleText = options.Tittle or "Window"
    local toggleKey = Enum.KeyCode[options.ToggleKey] or Enum.KeyCode.LeftControl

    -- UI Instances
    local ScreenGui = Instance.new("ScreenGui")
    local Screen = Instance.new("Frame")
    local UI = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")
    local Title = Instance.new("TextLabel")

    -- ScreenGui settings
    ScreenGui.Name = "XryptoWindow"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    -- Screen Frame
    Screen.Name = "Screen"
    Screen.Parent = ScreenGui
    Screen.BackgroundTransparency = 1
    Screen.Size = UDim2.new(1, 0, 1, 0)

    -- Main UI Frame
    UI.Name = "UI"
    UI.Parent = Screen
    UI.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Default background
    UI.BackgroundTransparency = 0.1
    UI.Position = UDim2.new(0.4, 0, 0.4, 0)
    UI.Size = UDim2.new(0, 200, 0, 100)

    -- Rounded Corners
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = UI

    -- UIStroke (Outline)
    UIStroke.Parent = UI
    UIStroke.Color = Color3.fromRGB(81, 0, 255) -- Default outline
    UIStroke.Thickness = 1.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Title Label
    Title.Name = "Title"
    Title.Parent = UI
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.1, 0, 0.3, 0)
    Title.Size = UDim2.new(0.8, 0, 0.4, 0)
    Title.Font = Enum.Font.Code
    Title.Text = ""
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextWrapped = true

    -- Typewriter Effect
    coroutine.wrap(function()
        while true do
            -- Type out
            for i = 1, #titleText do
                Title.Text = string.sub(titleText, 1, i)
                task.wait(0.05)
            end
            task.wait(0.5)
            -- Delete
            for i = #titleText, 0, -1 do
                Title.Text = string.sub(titleText, 1, i)
                task.wait(0.05)
            end
            task.wait(0.5)
        end
    end)()

    -- Dragging
    local UIS = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        local goal = {}
        goal.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(UI, TweenInfo.new(0.1), goal):Play()
    end

    UI.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = UI.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UI.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Toggle Key to hide/show
    local visible = true
    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == toggleKey then
            visible = not visible
            UI.Visible = visible
        end
    end)

    -- Return Window object
    local Window = {}

    Window.Theme = setmetatable({}, {
        __newindex = function(_, key, value)
            if key == "BackGroundColor" then
                UI.BackgroundColor3 = value
            elseif key == "OutlineColor" then
                UIStroke.Color = value
            end
        end
    })

    Window.SetTitle = function(newTitle)
        titleText = newTitle
    end

    Window.Destroy = function()
        ScreenGui:Destroy()
    end

    return Window
end

return Library
