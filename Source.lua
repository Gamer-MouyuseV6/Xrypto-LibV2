local Library = {}

function Library:CreateLoader(options)
    -- Ensure options and SecondAction are provided
    if not options or not options.SecondAction then
        return {}
    end

    -- UI setup (as provided)
    local M4xKr9PvZsT2LwQ8 = Instance.new("ScreenGui")
    local Screen = Instance.new("Frame")
    local Key = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Tittle1 = Instance.new("TextLabel")
    local Tittle2 = Instance.new("TextLabel")
    local KeyBoxFrame = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local KeyBox = Instance.new("TextBox")
    local GetLinkFrame = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")

    -- Set up ScreenGui
    M4xKr9PvZsT2LwQ8.Name = "M4x-Kr9Pv-ZsT2-LwQ8"
    M4xKr9PvZsT2LwQ8.Parent = game:GetService("CoreGui")
    M4xKr9PvZsT2LwQ8.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    M4xKr9PvZsT2LwQ8.ResetOnSpawn = false

    -- Set up Screen Frame
    Screen.Name = "Screen"
    Screen.Parent = M4xKr9PvZsT2LwQ8
    Screen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Screen.BackgroundTransparency = 1.000
    Screen.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Screen.BorderSizePixel = 0
    Screen.Position = UDim2.new(-0.00770218251, 0, 0, 0)
    Screen.Size = UDim2.new(1, 910, 1, 0)

    -- Set up Key Frame
    Key.Name = "Key"
    Key.Parent = Screen
    Key.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Key.BackgroundTransparency = 0.200
    Key.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Key.BorderSizePixel = 0
    Key.Position = UDim2.new(0.110716403, 0, 0.25172922, 0)
    Key.Size = UDim2.new(0, 373, 0, 191)

    UICorner.CornerRadius = UDim.new(0, 3)
    UICorner.Parent = Key

    -- Set up Title1
    Tittle1.Name = "Tittle1"
    Tittle1.Parent = Key
    Tittle1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tittle1.BackgroundTransparency = 1.000
    Tittle1.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tittle1.BorderSizePixel = 0
    Tittle1.Position = UDim2.new(0.0179027729, 0, -0.00472583063, 0)
    Tittle1.Size = UDim2.new(0, 234, 0, 30)
    Tittle1.Font = Enum.Font.Code
    Tittle1.Text = options.Tittle or "Frog Hub"
    Tittle1.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tittle1.TextSize = 21.000
    Tittle1.TextXAlignment = Enum.TextXAlignment.Left

    -- Set up Title2
    Tittle2.Name = "Tittle2"
    Tittle2.Parent = Key
    Tittle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tittle2.BackgroundTransparency = 1.000
    Tittle2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tittle2.BorderSizePixel = 0
    Tittle2.Position = UDim2.new(0.0179027729, 0, 0.154034361, 0)
    Tittle2.Size = UDim2.new(0, 234, 0, 19)
    Tittle2.Font = Enum.Font.Code
    Tittle2.Text = options.Tittle2 or "Key system"
    Tittle2.TextColor3 = Color3.fromRGB(255, 255, 255)
    Tittle2.TextSize = 13.000
    Tittle2.TextXAlignment = Enum.TextXAlignment.Left

    -- Set up KeyBoxFrame
    KeyBoxFrame.Name = "KeyBoxFrame"
    KeyBoxFrame.Parent = Key
    KeyBoxFrame.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
    KeyBoxFrame.BackgroundTransparency = 0.300
    KeyBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyBoxFrame.BorderSizePixel = 0
    KeyBoxFrame.Position = UDim2.new(0.155495971, 0, 0.366492152, 0)
    KeyBoxFrame.Size = UDim2.new(0, 257, 0, 48)

    UICorner_2.Parent = KeyBoxFrame

    -- Set up KeyBox
    KeyBox.Name = "KeyBox"
    KeyBox.Parent = KeyBoxFrame
    KeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.BackgroundTransparency = 1.000
    KeyBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyBox.BorderSizePixel = 0
    KeyBox.Position = UDim2.new(0.023346303, 0, 0, 0)
    KeyBox.Size = UDim2.new(0, 251, 0, 48)
    KeyBox.Font = Enum.Font.Code
    KeyBox.PlaceholderText = "Insert Key"
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.TextSize = 19.000
    KeyBox.TextXAlignment = Enum.TextXAlignment.Left

    -- Set up GetLinkFrame
    GetLinkFrame.Name = "GetLinkFrame"
    GetLinkFrame.Parent = Key
    GetLinkFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    GetLinkFrame.BorderSizePixel = 0
    GetLinkFrame.Position = UDim2.new(0.233243972, 0, 0.654450238, 0)
    GetLinkFrame.Size = UDim2.new(0, 198, 0, 41)

    -- Set button color based on Link type
    local link = options.SecondAction.Link or ""
    if string.match(link:lower(), "discord") then
        GetLinkFrame.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Blue for Discord
    else
        GetLinkFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green for Website
    end

    UICorner_3.Parent = GetLinkFrame

    -- Dragging functionality (unchanged)
    local Drag = Key
    local gsCoreGui = game:GetService("CoreGui")
    local gsTween = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

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

    -- Return the UI or relevant objects
    return {
        ScreenGui = M4xKr9PvZsT2LwQ8,
        KeyBox = KeyBox,
        GetLinkFrame = GetLinkFrame
    }
end

return Library
