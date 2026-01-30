-- SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Фрукты и их цвета
local FruitsColors = {
    ["Rocket Fruit"] = Color3.fromRGB(255,0,0),
    ["Spin Fruit"] = Color3.fromRGB(0,255,0),
    ["Blade Fruit"] = Color3.fromRGB(0,0,255),
    ["Spring Fruit"] = Color3.fromRGB(255,128,0),
    ["Bomb Fruit"] = Color3.fromRGB(255,255,0),
    ["Smoke Fruit"] = Color3.fromRGB(128,128,128),
    ["Spike Fruit"] = Color3.fromRGB(0,255,255),
    ["Flame Fruit"] = Color3.fromRGB(255,64,64),
    ["Ice Fruit"] = Color3.fromRGB(64,192,255),
    ["Sand Fruit"] = Color3.fromRGB(194,178,128),
    ["Dark Fruit"] = Color3.fromRGB(50,50,50),
    ["Diamond Fruit"] = Color3.fromRGB(0,255,255),
    ["Light Fruit"] = Color3.fromRGB(255,255,255),
    ["Rubber Fruit"] = Color3.fromRGB(255,192,203),
    ["Ghost Fruit"] = Color3.fromRGB(128,0,128),
    ["Magma Fruit"] = Color3.fromRGB(255,69,0),
    ["Quake Fruit"] = Color3.fromRGB(139,69,19),
    ["Buddha Fruit"] = Color3.fromRGB(255,215,0),
    ["Love Fruit"] = Color3.fromRGB(255,0,128),
    ["Spider Fruit"] = Color3.fromRGB(0,128,0),
    ["Sound Fruit"] = Color3.fromRGB(128,0,255),
    ["Phoenix Fruit"] = Color3.fromRGB(255,140,0),
    ["Portal Fruit"] = Color3.fromRGB(0,0,128),
    ["Rumble Fruit"] = Color3.fromRGB(128,128,0),
    ["Pain Fruit"] = Color3.fromRGB(64,0,0),
    ["Blizzard Fruit"] = Color3.fromRGB(173,216,230),
    ["Gravity Fruit"] = Color3.fromRGB(192,192,192),
    ["Mammoth Fruit"] = Color3.fromRGB(139,69,19),
    ["T-Rex Fruit"] = Color3.fromRGB(34,139,34),
    ["Dough Fruit"] = Color3.fromRGB(245,222,179),
    ["Shadow Fruit"] = Color3.fromRGB(0,0,0),
    ["Venom Fruit"] = Color3.fromRGB(0,100,0),
    ["Control Fruit"] = Color3.fromRGB(255,20,147),
    ["Spirit Fruit"] = Color3.fromRGB(0,255,127),
    ["Dragon Fruit"] = Color3.fromRGB(255,69,0),
    ["Tiger Fruit"] = Color3.fromRGB(255,165,0),
    ["Kitsune Fruit"] = Color3.fromRGB(255,215,0)
}

-- Таблица для ESP
local ESPs = {}

-- Создание ESP
local function createESP(part, fruitName)
    if ESPs[part] then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "FruitESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0,120,0,50)
    billboard.StudsOffset = Vector3.new(0,2,0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = FruitsColors[fruitName] or Color3.new(1,1,0)
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Text = fruitName

    billboard.Parent = game.CoreGui
    ESPs[part] = {Billboard = billboard, TextLabel = textLabel, Name = fruitName}
end

-- Обновление ESP
local function updateESP()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    local rootPos = character.HumanoidRootPart.Position

    for part, data in pairs(ESPs) do
        -- Убираем ESP если фрукт исчез или находится у игрока
        if not part.Parent or part.Parent:IsA("Backpack") or part.Parent:FindFirstChildOfClass("Humanoid") then
            if data.Billboard then data.Billboard:Destroy() end
            ESPs[part] = nil
        else
            local distance = (rootPos - part.Position).Magnitude
            data.TextLabel.Text = data.Name .. "\n" .. math.floor(distance) .. " studs"
        end
    end
end

-- Проверка фруктов в мире
local function checkFruits()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") and obj:FindFirstChild("Handle") and FruitsColors[obj.Name] then
            createESP(obj.Handle, obj.Name)
        end
    end
end

-- Главный цикл, оптимизированно
spawn(function()
    while true do
        checkFruits()
        updateESP()
        wait(1) -- обновление раз в секунду для лёгкой работы на телефоне
    end
end)
