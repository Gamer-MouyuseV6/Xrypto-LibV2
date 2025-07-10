local Library = {}

-- Default settings
local DefaultScheme = {
    BackgroundColor = Color3.fromRGB(0, 0, 0),
    OutlineColor = Color3.fromRGB(0, 255, 0)
}

function Library:CreateConfig(config)
    -- Placeholder config system
    local cfg = {}
    cfg.Enabled = config.Enable or true
    cfg.Folder = config.Folder or "XryptoHub"
    cfg.FileName = config.fileName or "Config"
    -- You can expand here to save/load files
    return cfg
end

function Library:CreateLoader(options)
    options = options or {}
    local toggleKey = options.ToggleKeybind or "RightControl"

    -- Destroy old UI
    local oldUI = game:GetService("CoreGui"):FindFirstChild("UI")
    if oldUI then oldUI:Destroy() end

    -- Create UI
    local UI = Instance.new("ScreenGui")
    UI.Name = "UI"
    UI.ResetOnSpawn = false
    UI.Parent = game:GetService("CoreGui")

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = UDim2.new(0, 282, 0, 239)
    Main.Position = UDim2.new(0.318356872, 0, 0.297800332, 0)
    Main.BorderSizePixel = 0
    Main.BackgroundColor3 = DefaultScheme.BackgroundColor
    Main.Parent = UI

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = DefaultScheme.OutlineColor
    UIStroke.Parent = Main

    -- Dragging logic
    coroutine.wrap(function()
        local UIS = game:GetService('UserInputService')
        local frame = Main
        local dragging, dragStart, startPos
        local dragSpeed = 0.25

        local function updateInput(input)
            local delta = input.Position - dragStart
            local pos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                  startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = pos}):Play()
        end

        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateInput(input)
            end
        end)
    end)()

    -- Toggle visibility with keybind
    local UIS = game:GetService("UserInputService")
    UIS.InputBegan:Connect(function(input, processed)
        if not processed and input.KeyCode == Enum.KeyCode[toggleKey] then
            UI.Enabled = not UI.Enabled
        end
    end)

    -- Return loader object
    local Loader = {}

    -- Scheme setter
    Loader.Scheme = setmetatable({}, {
        __newindex = function(_, k, v)
            if k == "Backgroundcolor" then
                Main.BackgroundColor3 = BrickColor.new(v).Color
            elseif k == "OutlineColor" then
                UIStroke.Color = BrickColor.new(v).Color
            end
        end
    })

    return Loader
end

return Library
