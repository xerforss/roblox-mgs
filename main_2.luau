-- ========================================================================
-- 👮 SUBWAY SURFERS ENGINE: THE FANCY REALISTIC GUARD R6
-- ========================================================================

print("👮 Creating high-end realistic Guard engine...")

-- 1. LIMPAR MAPA ANTERIOR
local oldMap = workspace:FindFirstChild("ChaseWorld")
if oldMap then oldMap:Destroy() end

local worldFolder = Instance.new("Folder")
worldFolder.Name = "ChaseWorld"
worldFolder.Parent = workspace

-- Pista de asfalto premium
local street = Instance.new("Part")
street.Size = Vector3.new(24, 1, 500)
street.Position = Vector3.new(0, 0.5, 0)
street.BrickColor = BrickColor.new("Dark stone grey")
street.Material = Enum.Material.Asphalt
street.Anchored = true
street.Parent = worldFolder

-- 2. CRIANDO A ESTRUTURA DO PERSONAGEM (MODELO HUMANO R6)
local guard = Instance.new("Model")
guard.Name = "The Inspector"
guard.Parent = worldFolder

local hrp = Instance.new("Part")
hrp.Name = "HumanoidRootPart"
hrp.Size = Vector3.new(2, 2, 1)
hrp.Position = Vector3.new(0, 5, 25) -- Nasce perto do jogador
hrp.Transparency = 1
hrp.Parent = guard

local humanoid = Instance.new("Humanoid")
humanoid.Parent = guard

-- Partes do corpo oficiais do Roblox R6
local torso = Instance.new("Part") torso.Name = "Torso" torso.Size = Vector3.new(2, 2, 1) torso.Position = hrp.Position torso.Parent = guard
local head = Instance.new("Part") head.Name = "Head" head.Size = Vector3.new(1.2, 1.2, 1.2) head.Parent = guard
local leftArm = Instance.new("Part") leftArm.Name = "Left Arm" leftArm.Size = Vector3.new(1, 2, 1) leftArm.Parent = guard
local rightArm = Instance.new("Part") rightArm.Name = "Right Arm" rightArm.Size = Vector3.new(1, 2, 1) rightArm.Parent = guard
local leftLeg = Instance.new("Part") leftLeg.Name = "Left Leg" leftLeg.Size = Vector3.new(1, 2, 1) leftLeg.Parent = guard
local rightLeg = Instance.new("Part") rightLeg.Name = "Right Leg" rightLeg.Size = Vector3.new(1, 2, 1) rightLeg.Parent = guard

-- Soldagem de Juntas Oficiais
local function makeWeld(p0, p1)
	local w = Instance.new("WeldConstraint")
	w.Part0 = p0
	w.Part1 = p1
	w.Parent = p0
end
makeWeld(hrp, torso)
makeWeld(torso, head)
makeWeld(torso, leftArm)
makeWeld(torso, rightArm)
makeWeld(torso, leftLeg)
makeWeld(torso, rightLeg)

-- Organizar os membros nas posições anatômicas corretas
head.CFrame = torso.CFrame * CFrame.new(0, 1.5, 0)
leftArm.CFrame = torso.CFrame * CFrame.new(-1.5, 0, 0)
rightArm.CFrame = torso.CFrame * CFrame.new(1.5, 0, 0)
leftLeg.CFrame = torso.CFrame * CFrame.new(-0.5, -2, 0)
rightLeg.CFrame = torso.CFrame * CFrame.new(0.5, -2, 0)

-- Estabilizador para o corpo não tombar ao correr
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = torso

-- 3. VESTINDO O GUARDA COM ROUPAS REAIS DO CATÁLOGO DO ROBLOX 👔
local description = Instance.new("HumanoidDescription")
description.Shirt = 13110293121   -- ID do Uniforme Policial Tático Realista
description.Pants = 13110300185   -- ID da Calça de Combate da Polícia
description.Face = 12431413813    -- ID de Expressão Séria/Firme de Guarda
description.GraphicTShirt = 0
humanoid:ApplyDescription(description)

-- 4. INTELIGÊNCIA DE MOVIMENTAÇÃO (CHASE LOOP)
task.spawn(function()
	while true do
		task.wait(0.2)
		for _, player in pairs(game.Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				humanoid:MoveTo(player.Character.HumanoidRootPart.Position)
			end
		end
	end
end)

-- 5. SISTEMA DE CAPTURA (TOUCH KILL)
torso.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= "The Inspector" then
		hit.Parent.Humanoid.Health = 0
		print("🚨 Você foi pego pelo Inspetor Tático!")
	end
end)

print("✨ Elegant and realistic clothing guard fully spawned!")
