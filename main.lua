local Players = game:GetService("Players")
local CAS = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- 1. AGRESİF UI GİZLEME (TopBar dahil her şeyi kapatır)
task.spawn(function()
	local success
	repeat
		success = pcall(function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
			StarterGui:SetCore("TopbarEnabled", false) -- Üst çubuğu ve logoyu pasif yapar
		end)
		task.wait(0.1)
	until success
end)

local gui = Instance.new("ScreenGui")
gui.Name = "QuantumFinalLoading"
gui.IgnoreGuiInset = true -- Ekranın en üstündeki logolu alanı zorla kaplar
gui.DisplayOrder = 999999
gui.Parent = player:WaitForChild("PlayerGui")

-- 2. GİRİŞ KİLİDİ (Klavye ve Mouse tamamen iptal)
CAS:BindActionAtPriority("FullLock", function() return Enum.ContextActionResult.Sink end, false, 4000,
	unpack(Enum.KeyCode:GetEnumItems()), 
	unpack(Enum.UserInputType:GetEnumItems())
)

-- 3. ARKA PLAN (Daha Açık ve Canlı Deniz Mavisi)
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1.1, 0, 1.1, 0) -- Ekranı taşacak kadar büyük yaparak boşluk bırakmaz
bg.Position = UDim2.new(-0.05, 0, -0.05, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 90, 160) -- Daha açık, canlı deniz mavisi
bg.BorderSizePixel = 0
bg.Active = true -- Üstteki logoya tıklanmasını engellemek için dokunuşları yutar
bg.Parent = gui

-- 4. ANA BAŞLIK
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.6, 0, 0.2, 0)
title.Position = UDim2.new(0.2, 0, 0.4, 0)
title.BackgroundTransparency = 1
title.Text = "QUANTUMEDGEHUB"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.fromRGB(0, 210, 255) -- Parlak Turkuaz/Mavi
title.Parent = bg

local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(255, 255, 255)
titleStroke.Thickness = 10 -- Kalın beyaz hat
titleStroke.Parent = title

-- 5. YÜKLEME BARI SİSTEMİ
local barFrame = Instance.new("Frame")
barFrame.Size = UDim2.new(0.3, 0, 0.015, 0)
barFrame.Position = UDim2.new(0.35, 0, 0.6, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
barFrame.BorderSizePixel = 0
barFrame.Parent = bg

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(1, 0)
frameCorner.Parent = barFrame

local barStroke = Instance.new("UIStroke")
barStroke.Color = Color3.fromRGB(255, 255, 255)
barStroke.Thickness = 2.5
barStroke.Parent = barFrame

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 210, 255)
bar.BorderSizePixel = 0
bar.Parent = barFrame

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = bar

-- 6. ÖZEL 60 SANİYE ANİMASYONU (Hızlı başlar, sonlarda iyice yavaşlar)
-- Quart/Out stili %80'e kadar hızlı gelir, sonra milimetrik ilerler.
local info = TweenInfo.new(60, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tween = TweenService:Create(bar, info, {Size = UDim2.new(1, 0, 1, 0)})

tween:Play()
tween.Completed:Wait()

-- 7. SİSTEMİ GERİ AÇ VE TEMİZLE
CAS:UnbindAction("FullLock")
pcall(function()
	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
	StarterGui:SetCore("TopbarEnabled", true)
end)
gui:Destroy()
