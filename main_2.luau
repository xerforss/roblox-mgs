-- ========================================================================
-- 🌆 PARTE 1: SUNSET CITY, ENVIRONMENT, MUSIC & WALL LETTERS
-- ========================================================================

print("🌆 Loading Subway Surfers Environment Engine...")

-- 1. LIMPAR O MAPA ANTERIOR PARA EVITAR REPETIÇÕES
local oldMap = workspace:FindFirstChild("SubwayCity")
if oldMap then oldMap:Destroy() end

local cityFolder = Instance.new("Folder")
cityFolder.Name = "SubwayCity"
cityFolder.Parent = workspace

-- 2. CONFIGURAÇÃO DE ILUMINAÇÃO (FIM DE TARDE / MAIS CLARO)
local lighting = game:GetService("Lighting")
lighting.ClockTime = 17.5 -- 17:30 (Pôr do sol brilhante, clareia o mapa)
lighting.OutdoorAmbient = Color3.fromRGB(140, 110, 100)
if lighting:FindFirstChildOfClass("Atmosphere") then
	lighting:FindFirstChildOfClass("Atmosphere").Density = 0.1
end

-- Rua de Asfalto Cinza Clássica
local street = Instance.new("Part")
street.Size = Vector3.new(30, 1, 600)
street.Position = Vector3.new(0, 0.5, 0)
street.BrickColor = BrickColor.new("Dark stone grey")
street.Material = Enum.Material.Asphalt
street.Anchored = true
street.Parent = cityFolder

-- Prédios Elegantes no Cenário (Background)
local neonColors = {Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 128), Color3.fromRGB(255, 255, 0)}
for i = -300, 300, 60 do
	if i ~= 0 then
		local bLeft = Instance.new("Part")
		bLeft.Size = Vector3.new(40, math.random(80, 160), 40)
		bLeft.Position = Vector3.new(-45, bLeft.Size.Y/2, i)
		bLeft.Color = Color3.fromRGB(50, 50, 55)
		bLeft.Material = Enum.Material.Concrete
		bLeft.Anchored = true
		bLeft.Parent = cityFolder

		local bRight = Instance.new("Part")
		bRight.Size = Vector3.new(40, math.random(80, 160), 40)
		bRight.Position = Vector3.new(45, bRight.Size.Y/2, i)
		bRight.Color = Color3.fromRGB(50, 50, 55)
		bRight.Material = Enum.Material.Concrete
		bRight.Anchored = true
		bRight.Parent = cityFolder
	end
end

-- Muro Principal de Tijolos para Pichar
local mainWall = Instance.new("Part")
mainWall.Size = Vector3.new(1, 16, 500)
mainWall.Position = Vector3.new(-15, 8, 0)
mainWall.BrickColor = BrickColor.new("Medium stone grey")
mainWall.Material = Enum.Material.Brick
mainWall.Anchored = true
mainWall.Parent = cityFolder

-- 3. MÚSICA DE PERSEGUIÇÃO DE FUNDO
local oldMusic = game:GetService("SoundService"):FindFirstChild("ChaseMusic")
if oldMusic then oldMusic:Destroy() end

local music = Instance.new("Sound")
music.Name = "ChaseMusic"
music.SoundId = "rbxassetid://9043887014"
music.Volume = 0.3
music.Looped = true
music.Parent = game:GetService("SoundService")
music:Play()

-- Função auxiliar para criar blocos de letras em 3D simplificados
local function create3DLetter(char, basePosition, color)
	local letterFolder = Instance.new("Folder")
	letterFolder.Name = "Letter_" .. char
	letterFolder.Parent = cityFolder

	if char == "R" then
		local p1 = Instance.new("Part") p1.Size = Vector3.new(0.2, 4, 0.4) p1.Position = basePosition p1.Parent = letterFolder
		local p2 = Instance.new("Part") p2.Size = Vector3.new(0.2, 0.4, 1.5) p2.Position = basePosition + Vector3.new(0, 1.8, -0.55) p2.Parent = letterFolder
		local p3 = Instance.new("Part") p3.Size = Vector3.new(0.2, 0.4, 1.5) p3.Position = basePosition + Vector3.new(0, 0, -0.55) p3.Parent = letterFolder
		local p4 = Instance.new("Part") p4.Size = Vector3.new(0.2, 2.2, 0.4) p4.Position = basePosition + Vector3.new(0, 0.9, -1.1) p4.Parent = letterFolder
		local p5 = Instance.new("Part") p5.Size = Vector3.new(0.2, 2, 0.4) p5.Position = basePosition + Vector3.new(0, -1, -0.8) p5.Parent = letterFolder
	elseif char == "X" then
		local p1 = Instance.new("Part") p1.Size = Vector3.new(0.2, 4, 0.4) p1.Position = basePosition p1.Orientation = Vector3.new(0,0,25) p1.Parent = letterFolder
		local p2 = Instance.new("Part") p2.Size = Vector3.new(0.2, 4, 0.4) p2.Position = basePosition p2.Orientation = Vector3.new(0,0,-25) p2.Parent = letterFolder
	elseif char == "S" then
		local p1 = Instance.new("Part") p1.Size = Vector3.new(0.2, 0.4, 1.5) p1.Position = basePosition + Vector3.new(0, 1.8, -0.55) p1.Parent = letterFolder
		local p2 = Instance.new("Part") p2.Size = Vector3.new(0.2, 1.8, 0.4) p2.Position = basePosition + Vector3.new(0, 0.9, 0) p2.Parent = letterFolder
		local p3 = Instance.new("Part") p3.Size = Vector3.new(0.2, 0.4, 1.5) p3.Position = basePosition + Vector3.new(0, 0, -0.55) p3.Parent = letterFolder
		local p4 = Instance.new("Part") p4.Size = Vector3.new(0.2, 1.8, 0.4) p4.Position = basePosition + Vector3.new(0, -0.9, -1.1) p4.Parent = letterFolder
		local p5 = Instance.new("Part") p5.Size = Vector3.new(0.2, 0.4, 1.5) p5.Position = basePosition + Vector3.new(0, -1.8, -0.55) p5.Parent = letterFolder
	end

	for _, part in ipairs(letterFolder:GetChildren()) do
		part.Color = color
		part.Material = Enum.Material.Neon
		part.Anchored = true
		part.CanCollide = false
	end
end

-- 4. GERAR INTERAÇÃO DE PICHAÇÃO COM LETRAS NOS MUROS
local wallsToTag = {60, 160, 260}
local words = {{"R", "X"}, {"S", "R"}, {"X", "S"}}

for index, zPos in ipairs(wallsToTag) do
	local tagArea = Instance.new("Part")
	tagArea.Size = Vector3.new(0.5, 8, 12)
	tagArea.Position = Vector3.new(-14.4, 4, zPos - 150)
	tagArea.Color = Color3.fromRGB(60, 60, 65)
	tagArea.Material = Enum.Material.SmoothPlastic
	tagArea.Anchored = true
	tagArea.Parent = cityFolder

	local prompt = Instance.new("ProximityPrompt")
	prompt.ObjectText = "Muro de Tijolos"
	prompt.ActionText = "Graffitar Letras Neon"
	prompt.HoldDuration = 1.8
	prompt.Parent = tagArea

	prompt.Triggered:Connect(function(player)
		prompt.Enabled = false
		tagArea.BrickColor = BrickColor.new("Dark stone grey")
		
		local selectedWord = words[index]
		local chosenColor = neonColors[math.random(1, #neonColors)]
		
		create3DLetter(selectedWord, tagArea.Position + Vector3.new(0.3, 1, 2), chosenColor)
		create3DLetter(selectedWord, tagArea.Position + Vector3.new(0.3, 1, -1), chosenColor)
		print(player.Name .. " graffitou letras no muro!")
	end)
end
-- ========================================================================
-- 🎨 PARTE 2: SPRAY CAN, THE INSPECTOR NPC & CHASE SYSTEM
-- ========================================================================

-- 5. LATA DE SPRAY COM FUMAÇA CYAN PARA O JOGADOR
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local tool = Instance.new("Tool")
		tool.Name = "Spray Can"
		tool.RequiresHandle = true
		
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(0.5, 1.2, 0.5)
		handle.BrickColor = BrickColor.new("Deep orange")
		handle.Parent = tool
		
		local fx = Instance.new("ParticleEmitter")
		fx.Name = "SpraySmoke"
		fx.Texture = "rbxassetid://241372545"
		fx.Size = NumberSequence.new(0.1, 1.2)
		fx.Rate = 0
		fx.Speed = NumberRange.new(6)
		fx.Lifetime = NumberRange.new(0.4, 0.8)
		fx.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
		fx.Parent = handle
		
		tool.Activated:Connect(function()
			fx.Rate = 50
			task.wait(1.5)
			fx.Rate = 0
		end)
		
		tool.Parent = player.Backpack
	end)
end)

-- 6. CONSTRUÇÃO DO INSPETOR CLÁSSICO DO SUBWAY SURFERS (NPC)
local guardModel = Instance.new("Model")
guardModel.Name = "The Inspector"
guardModel.Parent = workspace:FindFirstChild("SubwayCity") or workspace

local hrp = Instance.new("Part")
hrp.Name = "HumanoidRootPart"
hrp.Size = Vector3.new(2.5, 2, 1.5)
hrp.Position = Vector3.new(0, 5, -140)
hrp.Transparency = 1
hrp.Parent = guardModel

local humanoid = Instance.new("Humanoid")
humanoid.Parent = guardModel

-- Corpo Largo Verde-Oliva
local torso = Instance.new("Part")
torso.Name = "Torso"
torso.Size = Vector3.new(3, 2.5, 2)
torso.Color = Color3.fromRGB(85, 107, 47)
torso.Material = Enum.Material.SmoothPlastic
torso.Position = hrp.Position
torso.Parent = guardModel

local belt = Instance.new("Part")
belt.Size = Vector3.new(3.2, 0.4, 2.2)
belt.BrickColor = BrickColor.new("Black")
belt.Position = torso.Position - Vector3.new(0, 1.1, 0)
belt.Parent = guardModel

local head = Instance.new("Part")
head.Name = "Head"
head.Size = Vector3.new(1.4, 1.4, 1.4)
head.BrickColor = BrickColor.new("Pastel brown")
head.Parent = guardModel

local mustache = Instance.new("Part")
mustache.Size = Vector3.new(1.2, 0.3, 0.3)
mustache.BrickColor = BrickColor.new("Reddish brown")
mustache.Parent = guardModel

local capBase = Instance.new("Part")
capBase.Size = Vector3.new(1.8, 0.3, 1.8)
capBase.Color = Color3.fromRGB(85, 107, 47)
capBase.Parent = guardModel

local capVisor = Instance.new("Part")
capVisor.Size = Vector3.new(1.6, 0.1, 0.5)
capVisor.BrickColor = BrickColor.new("Black")
capVisor.Parent = guardModel

local lLeg = Instance.new("Part")
lLeg.Name = "LeftLeg"
lLeg.Size = Vector3.new(1.2, 2.2, 1.2)
lLeg.Color = Color3.fromRGB(101, 67, 33)
lLeg.Parent = guardModel

local rLeg = Instance.new("Part")
rLeg.Name = "RightLeg"
rLeg.Size = Vector3.new(1.2, 2.2, 1.2)
rLeg.Color = Color3.fromRGB(101, 67, 33)
rLeg.Parent = guardModel

-- Soldagem Interna (Weld Constraints)
local function joint(p0, p1)
	local w = Instance.new("WeldConstraint")
	w.Part0 = p0
	w.Part1 = p1
	w.Parent = p0
end
joint(hrp, torso)
joint(torso, belt)
joint(torso, head)
joint(head, mustache)
joint(head, capBase)
joint(capBase, capVisor)
joint(torso, lLeg)
joint(torso, rLeg)

head.CFrame = torso.CFrame * CFrame.new(0, 1.8, 0)
mustache.CFrame = head.CFrame * CFrame.new(0, -0.3, -0.65)
capBase.CFrame = head.CFrame * CFrame.new(0, 0.8, 0)
capVisor.CFrame = capBase.CFrame * CFrame.new(0, -0.1, -0.8)
lLeg.CFrame = torso.CFrame * CFrame.new(-0.6, -2.2, 0)
rLeg.CFrame = torso.CFrame * CFrame.new(0.6, -2.2, 0)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = torso

-- 7. SISTEMA DE PERSEGUIÇÃO DO INSPETOR (CHASE LOGIC)
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

-- Sistema de Captura (Busted!)
torso.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= "The Inspector" then
		hit.Parent.Humanoid.Health = 0
		print("🚨 O Inspetor te pegou!")
	end
end)

print("✨ All systems loaded successfully!")
