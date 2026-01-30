-- BLOX FRUITS CFRAME SPEED | XENO | BIND Y

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local SPEED = 1.8-- 🔥 1.8–2.8 оптимально
local ENABLED = false

local char, hrp, humanoid

local function setup()
    char = player.Character or player.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
end

setup()
player.CharacterAdded:Connect(function()
    task.wait(1)
    setup()
end)

-- ⚡ Реальное ускорение через CFrame
RunService.RenderStepped:Connect(function()
    if ENABLED and hrp and humanoid then
        local dir = humanoid.MoveDirection
        if dir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (dir * SPEED)
        end
    end
end)

-- 🎮 БИНД Y
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Y then
        ENABLED = not ENABLED
        if ENABLED then
            warn("🚀 CFRAME SPEED ON")
        else
            warn("🐢 CFRAME SPEED OFF")
        end
    end
end)
