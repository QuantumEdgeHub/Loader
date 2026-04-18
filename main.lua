local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Arka plan
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(10,10,10)
bg.Parent = gui

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.2,0)
title.Position = UDim2.new(0,0,0.35,0)
title.BackgroundTransparency = 1
title.Text = "ZyroHub Loading"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Parent = bg

-- Progress bar arka
local barBG = Instance.new("Frame")
barBG.Size = UDim2.new(0.4,0,0.03,0)
barBG.Position = UDim2.new(0.3,0,0.6,0)
barBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
barBG.BorderSizePixel = 0
barBG.Parent = bg

-- Progress bar dolan
local bar = Instance.new("Frame")
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(0,170,255)
bar.BorderSizePixel = 0
bar.Parent = barBG

-- Tween (başta hızlı, sonda yavaş)
local TweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(
	60, -- süre
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.Out
)

local tween = TweenService:Create(bar, tweenInfo, {
	Size = UDim2.new(1,0,1,0)
})

tween:Play()
tween.Completed:Wait()

-- Bitince GUI silinir
gui:Destroy()

-- burdan sonra kendi scriptin çalışır
print("ZyroHub Loaded")
