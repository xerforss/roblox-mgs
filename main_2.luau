-- ========================================================
-- 🌆 SUBWAY SURFERS: TOTAL CITY GRAFFITI & REALISTIC GUARD
-- ========================================================

print("🏙️ Loading City & Realistic Guard logic...")

-- LIMPAR O MAPA ANTERIOR
local oldMap = workspace:FindFirstChild("SubwayCity")
if oldMap then oldMap:Destroy() end

local cityFolder = Instance.new("Folder")
cityFolder.Name = "SubwayCity"
cityFolder.Parent = workspace

-- 1. GERAR A CIDADE E OS PRÉDIOS (BACKGROUND)
local street = Instance.new("Part")
street.Size = Vector3.new(30, 1, 600)
street.Position = Vector3.new(0, 0.5, 0)
street.BrickColor = BrickColor.new("Dark stone grey")
street.Material = Enum.Material.Concrete
street.Anchored = true
street.Parent = cityFolder

-- Gerador de Prédios Simplificados (Não pesa no Dell 1545)
for i = -300, 300, 60 do
	if i ~= 0 then
		-- Prédios do lado esquerdo
		local bLeft = Instance.new("Part")
		bLeft.Size = Vector3.new(40, math.random(60, 120), 40)
		bLeft.Position = Vector3.new(-40, bLeft.Size.Y/2, i)
		bLeft.BrickColor = BrickColor.new("Concrete grey")
		bLeft.Material = Enum.Material.Slate
		bLeft.Anchored = true
		bLeft.Parent = cityFolder
		
		-- Prédios do lado direito
		local bRight = Instance.new("Part")
		bRight.Size = Vector3.new(40, math.random(60, 120), 40)
		bRight.Position = Vector3.new(40, bRight.Size.Y/2, i)
		bRight.BrickColor = BrickColor.new("Cadet blue")
		bRight.Material = Enum.Material.Slate
		bRight.Anchored = true
		bRight.Parent = cityFolder
	end
end

-- Muros Principais de Pichação
local mainWall = Instance.new("Part")
mainWall.Size = Vector3.new(1, 16, 500)
mainWall.Position = Vector3.new(-15, 8, 0)
mainWall.BrickColor = BrickColor.new("Medium stone grey")
mainWall.Material = Enum.Material.Brick
mainWall.Anchored = true
mainWall.Parent = cityFolder

-- 2. SISTEMA DE DESENHAR LINHAS NO MURO (GRAFFITI)
local wallsToTag = {50, 150, 250}
for _, zPos in ipairs(wallsToTag) do
	local tagArea = Instance.new("Part")
	tagArea.Size = Vector3.new(0.5, 8, 12)
	tagArea.Position = Vector3.new(-14.4, 4, zPos - 150)
	tagArea.BrickColor = BrickColor.new("Light stone grey")
	tagArea.Anchored = true
	tagArea.Parent = cityFolder

	local prompt = Instance.new("ProximityPrompt")
	prompt.ObjectText = "Muro da Cidade"
	prompt.ActionText = "Graffitar Linhas"
	prompt.HoldDuration = 2.0
	prompt.Parent = tagArea

	prompt.Triggered:Connect(function(player)
		prompt.Enabled = false
		tagArea.BrickColor = BrickColor.new("Deep orange")
		
		-- Ativa o efeito visual de linhas de tinta aparecendo no muro
		for lineNum = 1, 3 do
			local paintLine = Instance.new("Part")
			paintLine.Size = Vector3.new(0.1, 0.4, 10)
			paintLine.Position = tagArea.Position + Vector3.new(0.3, (lineNum * 1.5) - 2, 0)
			paintLine.BrickColor = BrickColor.new("Really red")
			paintLine.Material = Enum.Material.Neon
			paintLine.Anchored = true
			paintLine.Parent = cityFolder
		end
		print(player.Name .. " desenhou linhas de graffiti!")
	end)
end

-- 3. LATA DE SPRAY COM EFEITO DE FUMAÇA (PARTÍCULAS)
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local tool = Instance.new("Tool")
		tool.Name = "Spray Can"
		tool.RequiresHandle = true
		
		local handle = Instance.new("Part")
		handle.Name = "Handle"
		handle.Size = Vector3.new(0.5, 1.2, 0.5)
		handle.BrickColor = BrickColor.new("Really black")
		handle.Parent = tool
		
		-- O Emissor de Fumaça (Smoke Particles)
		local fx = Instance.new("ParticleEmitter")
		fx.Name = "SpraySmoke"
		fx.Texture = "rbxassetid://241372545" -- Textura de fumaça padrão do Roblox
		fx.Size = NumberSequence.new(0.2, 1.5)
		fx.Rate = 0 -- Começa desligado
		fx.Speed = NumberRange.new(5)
		fx.Lifetime = NumberRange.new(0.5, 1)
		fx.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)) -- Fumaça vermelha!
		fx.Parent = handle
		
		-- Ativa fumaça ao usar a ferramenta
		tool.Activated:Connect(function()
			fx.Rate = 45 -- Liga a fumaça
			task.wait(1.5)
			fx.Rate = 0 -- Desliga a fumaça
		end)
		
		tool.Parent = player.Backpack
	end)
end)

-- 4. GUARDA REALISTA (MODELO R6 INTEGRADO)
local guardModel = Instance.new("Model")
guardModel.Name = "RealisticGuard"
guardModel.Parent = cityFolder

local hrp = Instance.new("Part")
hrp.Name = "HumanoidRootPart"
hrp.Size = Vector3.new(2, 2, 1)
hrp.Position = Vector3.new(0, 5, -120)
hrp.Transparency = 1
hrp.Parent = guardModel

local humanoid = Instance.new("Humanoid")
humanoid.Parent = guardModel

-- Construção Visual do Corpo do Guarda
local gTorso = Instance.new("Part")
gTorso.Name = "Torso"
gTorso.Size = Vector3.new(2, 2, 1)
gTorso.BrickColor = BrickColor.new("Navy blue") -- Uniforme
gTorso.Position = hrp.Position
gTorso.Parent = guardModel

local gHead = Instance.new("Part")
gHead.Name = "Head"
gHead.Size = Vector3.new(1.2, 1.2, 1.2)
gHead.BrickColor = BrickColor.new("Pastel brown")
gHead.Position = gTorso.Position + Vector3.new(0, 1.5, 0)
gHead.Parent = guardModel

-- Chapéu de Policial Realista
local cap = Instance.new("Part")
cap.Size = Vector3.new(1.6, 0.4, 1.6)
cap.BrickColor = BrickColor.new("Black")
cap.Position = gHead.Position + Vector3.new(0, 0.7, 0)
cap.Parent = guardModel

-- Pernas do Policial
local lLeg = Instance.new("Part")
lLeg.Name = "LeftLeg"
lLeg.Size = Vector3.new(1, 2, 1)
lLeg.BrickColor = BrickColor.new("Black")
lLeg.Position = gTorso.Position + Vector3.new(-0.5, -2, 0)
lLeg.Parent = guardModel

local rLeg = Instance.new("Part")
rLeg.Name = "RightLeg"
rLeg.Size = Vector3.new(1, 2, 1)
rLeg.BrickColor = BrickColor.new("Black")
rLeg.Position = gTorso.Position + Vector3.new(0.5, -2, 0)
rLeg.Parent = guardModel

-- Soldagem Interna R6 (Para movimentação correta)
local function joint(p0, p1, name)
	local w = Instance.new("WeldConstraint")
	w.Part0 = p0
	w.Part1 = p1
	w.Parent = p0
end
joint(hrp, gTorso)
joint(gTorso, gHead)
joint(gHead, cap)
joint(gTorso, lLeg)
joint(gTorso, rLeg)

-- 5. MOVIMENTAÇÃO INTELIGENTE (CHASE LOOP)
task.spawn(function()
	while true do
		task.wait(0.2)
		for _, player in pairs(game.Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				-- O guarda usa o sistema pathfinding simplificado através do Humanoid
				humanoid:MoveTo(player.Character.HumanoidRootPart.Position)
			end
		end
	end
end)

-- Sistema de captura
gTorso.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= "RealisticGuard" then
		hit.Parent.Humanoid.Health = 0
		print("🚨 O policial te alcançou!")
	end
end)

print("✨ Engine da cidade carregada com sucesso!")

