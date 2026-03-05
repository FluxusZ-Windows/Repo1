local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ShopMonitor"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 280, 0, 400)
frame.Position = UDim2.new(0, 20, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 255, 120)
stroke.Thickness = 1.5
stroke.Parent = frame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
title.BorderSizePixel = 0
title.Text = "🌱 SEED SHOP"
title.TextColor3 = Color3.fromRGB(60, 255, 120)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = title

-- Seed ID label
local seedLabel = Instance.new("TextLabel")
seedLabel.Size = UDim2.new(1, -20, 0, 25)
seedLabel.Position = UDim2.new(0, 10, 0, 50)
seedLabel.BackgroundTransparency = 1
seedLabel.Text = "Seed: —"
seedLabel.TextColor3 = Color3.fromRGB(120, 120, 140)
seedLabel.TextScaled = true
seedLabel.Font = Enum.Font.Gotham
seedLabel.TextXAlignment = Enum.TextXAlignment.Left
seedLabel.Parent = frame

-- Scrolling list
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -130)
scrollFrame.Position = UDim2.new(0, 10, 0, 82)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 255, 120)
scrollFrame.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = scrollFrame

-- Кнопка обновить
local refreshBtn = Instance.new("TextButton")
refreshBtn.Size = UDim2.new(1, -20, 0, 35)
refreshBtn.Position = UDim2.new(0, 10, 1, -45)
refreshBtn.BackgroundColor3 = Color3.fromRGB(40, 200, 90)
refreshBtn.BorderSizePixel = 0
refreshBtn.Text = "🔄 Обновить"
refreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshBtn.TextScaled = true
refreshBtn.Font = Enum.Font.GothamBold
refreshBtn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = refreshBtn

-- Функция создания строки семени
local function createSeedRow(name, amount, maxAmount)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 55)
    row.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    row.BorderSizePixel = 0
    row.Parent = scrollFrame

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 8)
    rowCorner.Parent = row

    local available = amount > 0
    
    -- Иконка ✅/❌
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 35, 1, 0)
    icon.Position = UDim2.new(0, 8, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = available and "✅" or "❌"
    icon.TextScaled = true
    icon.Parent = row

    -- Название
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, -110, 0, 28)
    nameLabel.Position = UDim2.new(0, 48, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = available and Color3.fromRGB(220, 255, 220) or Color3.fromRGB(160, 160, 160)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = row

    -- Количество
    local amountLabel = Instance.new("TextLabel")
    amountLabel.Size = UDim2.new(1, -110, 0, 20)
    amountLabel.Position = UDim2.new(0, 48, 0, 30)
    amountLabel.BackgroundTransparency = 1
    amountLabel.Text = "Кол-во: " .. amount .. " / " .. maxAmount
    amountLabel.TextColor3 = Color3.fromRGB(100, 200, 120)
    amountLabel.TextScaled = true
    amountLabel.Font = Enum.Font.Gotham
    amountLabel.TextXAlignment = Enum.TextXAlignment.Left
    amountLabel.Parent = row

    -- Полоска прогресса
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(0, 55, 0, 8)
    barBg.Position = UDim2.new(1, -63, 0.5, -4)
    barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    barBg.BorderSizePixel = 0
    barBg.Parent = row

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 4)
    barCorner.Parent = barBg

    local barFill = Instance.new("Frame")
    local ratio = maxAmount > 0 and (amount / maxAmount) or 0
    barFill.Size = UDim2.new(ratio, 0, 1, 0)
    barFill.BackgroundColor3 = available and Color3.fromRGB(60, 255, 120) or Color3.fromRGB(255, 80, 80)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg

    local barFillCorner = Instance.new("UICorner")
    barFillCorner.CornerRadius = UDim.new(0, 4)
    barFillCorner.Parent = barFill
end

-- Функция обновления данных
local function fetchData()
    -- Очищаем старые строки
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local success, result = pcall(function()
        return ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("GetShopData"):InvokeServer("SeedShop")
    end)

    if success and result then
        seedLabel.Text = "Seed ID: " .. tostring(result.Seed or "—")

        if result.Items then
            local count = 0
            for name, data in pairs(result.Items) do
                createSeedRow(name, data.Amount or 0, data.MaxAmount or 0)
                count = count + 1
            end
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 63)
        end
    else
        seedLabel.Text = "Ошибка загрузки"
    end
end

-- Кнопка обновить
refreshBtn.MouseButton1Click:Connect(fetchData)

-- Авто-обновление каждые 30 сек
task.spawn(function()
    while true do
        fetchData()
        task.wait(30)
    end
end)
