local Library = {}

-- Color mapping
local ColorMap = {
    White = Color3.fromRGB(255, 255, 255),
    Red = Color3.fromRGB(255, 0, 0),
    Gray = Color3.fromRGB(128, 128, 128),
    Blue = Color3.fromRGB(0, 0, 255),
    Green = Color3.fromRGB(0, 255, 0),
    Purple = Color3.fromRGB(128, 0, 128),
    Pink = Color3.fromRGB(255, 105, 180),
    Blown = Color3.fromRGB(139, 69, 19), -- "Blown" assumed to mean "Brown"
    Orange = Color3.fromRGB(255, 165, 0),
    Black = Color3.fromRGB(0, 0, 0),
}

local HttpService = game:GetService("HttpService")

-- Config system
function Library:CreateConfig(config)
    local folder = config.Folder or "XryptoHub"
    local fileName = config.fileName or "Config"
    local path = folder.."/"..fileName..".json"

    -- Create folder if it doesn't exist
    if not isfolder(folder) then
        makefolder(folder)
    end

    local cfg = {}
    cfg.FilePath = path
    cfg.Data = {}

    -- Load existing config
    if isfile(path) then
        local success, decoded = pcall(function()
            return HttpService:JSONDecode(readfile(path))
        end)
        if success and typeof(decoded) == "table" then
            cfg.Data = decoded
        end
    else
        -- Write empty config if file doesn't exist
        writefile(path, HttpService:JSONEncode(cfg.Data))
    end

    -- Save function
    function cfg:Save(data)
        self.Data = data or self.Data
        writefile(self.FilePath, HttpService:JSONEncode(self.Data))
    end

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
    Main.BackgroundColor3 = ColorMap.Black
    Main.Parent = UI

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 2)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = ColorMap.Green
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

    -- Rainbow animation
    local rainbowRunning = {Background = false, Outline = false}

    local function startRainbow(target, setColor)
        rainbowRunning[target] = true
        coroutine.wrap(function()
            local hue = 0
            while rainbowRunning[target] do
                hue = (hue + 0.01) % 1
                setColor(Color3.fromHSV(hue, 1, 1))
                task.wait(0.03)
            end
        end)()
    end

    local function stopRainbow(target)
        rainbowRunning[target] = false
    end

    -- Return loader object
    local Loader = {}

    Loader.Scheme = setmetatable({}, {
        __newindex = function(_, k, v)
            if k == "Backgroundcolor" then
                stopRainbow("Background")
                if v:lower() == "rainbow" then
                    startRainbow("Background", function(color)
                        Main.BackgroundColor3 = color
                    end)
                else
                    Main.BackgroundColor3 = ColorMap[v] or ColorMap.Black
                end
            elseif k == "OutlineColor" then
                stopRainbow("Outline")
                if v:lower() == "rainbow" then
                    startRainbow("Outline", function(color)
                        UIStroke.Color = color
                    end)
                else
                    UIStroke.Color = ColorMap[v] or ColorMap.Green
                end
            end
        end
    })

    return Loader
end

return Library
