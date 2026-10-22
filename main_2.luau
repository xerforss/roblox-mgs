-- ========================================================
-- 🎨 SUBWAY SURFERS: GRAFFITI & REAL GUARD SYSTEM
-- ========================================================

print("🏃 Loading updated Subway Surfers logic...")

-- LIMPAR O WORKSPACE ANTES DE GERAR (Evita duplicar itens ao atualizar)
local oldMap = workspace:FindFirstChild("CityAlley")
if oldMap then oldMap:Destroy() end

local mapFolder = Instance.new("Folder")
mapFolder.Name = "CityAlley"
mapFolder.Parent = workspace

-- 1. CONSTRUIR A RUA COMPRIDA
local floor = Instance.new("Part")
floor.Size = Vector3.new(24, 1, 500)
floor.Position = Vector3.new(0, 0.5, 0)
floor.BrickColor = BrickColor.new("Dark stone grey")
floor.Material = Enum.Material.Concrete
floor.Anchored = true
floor.Parent = mapFolder

local wallLeft = Instance.new("Part")
wallLeft.Size = Vector3.new(1, 16, 500)
wallLeft.Position = Vector3.new(-12, 8, 0)
wallLeft.BrickColor = BrickColor.new("Medium stone grey")
wallLeft.Material = Enum.Material.Brick
wallLeft.Anchored = true
wallLeft.Parent = mapFolder

-- 2. GERAR VÁRIOS MUROS PARA PICHAR (Distribuídos pela rua)
local wallPositions = {60, 120, 180, 240, 300, 360, 420}

for i, zPos in ipairs(wallPositions) do
    local tagWall = Instance.new("Part")
    tagWall.Name = "GraffitiWall_" .. i
    tagWall.Size = Vector3.new(0.4, 7, 10)
    tagWall.Position = Vector3.new(-11.4, 4.5, zPos - 250) -- Centralizado na pista
    tagWall.BrickColor = BrickColor.new("Light stone grey") -- Muro limpo inicialmente
    tagWall.Material = Enum.Material.Concrete
    tagWall.Anchored = true
    tagWall.Parent = mapFolder

    -- Prompt de Proximity para interagir e pichar
    local prompt = Instance.new("ProximityPrompt")
    prompt.ObjectText = "Muro Limpo"
    prompt.ActionText = "Pichar / Graffitar"
    prompt.HoldDuration = 1.5 -- Tempo segurando o botão
    prompt.RequiresLineOfSight = false
    prompt.Parent = tagWall

    -- Quando o jogador picha o muro
    prompt.Triggered:Connect(function(player)
        tagWall.BrickColor = BrickColor.new("Really red") -- Fica vermelho simulando o spray
        tagWall.Material = Enum.Material.Neon
        prompt.ActionText = "Já está pichado!"
        prompt.Enabled = false -- Desativa para não pichar o mesmo muro duas vezes
        print(player.Name .. " fez um graffiti no muro " .. i)
    end)
end

-- 3. DAR UMA LATA DE SPRAY AUTOMÁTICA PARA O JOGADOR
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        -- Criar a ferramenta da Lata de Spray
        local tool = Instance.new("Tool")
        tool.Name = "Spray Paint Can"
        tool.RequiresHandle = true
        
        -- O modelo visual da lata
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(0.6, 1.2, 0.6)
        handle.BrickColor = BrickColor.new("Really blue") -- Cor da lata
        handle.Material = Enum.Material.Metal
        handle.Parent = tool
        
        -- Bico do spray
        local nozzle = Instance.new("Part")
        nozzle.Size = Vector3.new(0.2, 0.2, 0.2)
        nozzle.Position = handle.Position + Vector3.new(0, 0.6, 0)
        nozzle.BrickColor = BrickColor.new("Crimson")
        nozzle.Anchored = false
        nozzle.Parent = tool
        
        -- Soldar o bico na lata
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = handle
        weld.Part1 = nozzle
        weld.Parent = handle

        tool.Parent = player.Backpack
    end)
end)

-- 4. SPAWN DO GUARDA REALISTA (Construído com blocos acoplados)
local guardGroup = Instance.new("Model")
guardGroup.Name = "AngryGuard"
guardGroup.Parent = mapFolder

-- Tronco (Uniforme de Guarda)
local torso = Instance.new("Part")
torso.Name = "Torso"
torso.Size = Vector3.new(3, 3, 1.5)
torso.Position = Vector3.new(0, 4.5, -200) -- Começa no início da pista
torso.BrickColor = BrickColor.new("Navy blue") -- Azul Policial
torso.Material = Enum.Material.SmoothPlastic
torso.CanCollide = true
torso.Parent = guardGroup

-- Cabeça
local head = Instance.new("Part")
head.Name = "Head"
head.Size = Vector3.new(1.5, 1.5, 1.5)
head.Position = torso.Position + Vector3.new(0, 2.25, 0)
head.BrickColor = BrickColor.new("Pastel brown") -- Tom de pele
head.Shape = Enum.PartType.Ball
head.Parent = guardGroup

-- Chapéu de Guarda
local hat = Instance.new("Part")
hat.Size = Vector3.new(2, 0.4, 2)
hat.Position = head.Position + Vector3.new(0, 0.8, 0)
hat.BrickColor = BrickColor.new("Black")
hat.Parent = guardGroup

-- Pernas do Guarda (Calças pretas)
local legs = Instance.new("Part")
legs.Name = "Legs"
legs.Size = Vector3.new(2.5, 3, 1.2)
legs.Position = torso.Position - Vector3.new(0, 3, 0)
legs.BrickColor = BrickColor.new("Black")
legs.Parent = guardGroup

-- Soldar as partes do guarda para andarem juntas
local function weldParts(p0, p1)
    local w = Instance.new("WeldConstraint")
    w.Part0 = p0
    w.Part1 = p1
    w.Parent = p0
end
weldParts(torso, head)
weldParts(head, hat)
weldParts(torso, legs)

-- Giroscópio para o guarda não tombar
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = torso

-- 5. MOVIMENTAÇÃO DO GUARDA (MAIS LENTO!)
task.spawn(function()
    while true do
        task.wait(0.1)
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local playerPos = player.Character.HumanoidRootPart.Position
                local guardPos = torso.Position
                
                -- Direção até o jogador
                local direction = (playerPos - guardPos).Unit
                -- VELOCIDADE REDUZIDA: De 14 para 10 para dar chance ao jogador!
                torso.Velocity = Vector3.new(direction.X, 0, direction.Z) * 10 
            end
        end
    end
end)

-- 6. O GUARDA PEGA O JOGADOR (BUSTED!)
torso.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0 -- Busted!
        print("🚨 O Guarda pegou o pichador!")
    end
end)

print("✨ Cenário pronto! Fuja do guarda policial azul e piche os muros cinzas com seu spray!")
