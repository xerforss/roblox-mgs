-- ==========================================
-- SCRIPT DE MODIFICAÇÃO DE MAPA VIA GITHUB 🚀
-- ==========================================

print("🌲 Modificando o ambiente através do GitHub...")

-- 1. CRIANDO UMA ÁRVORE SIMPLES (Tronco e Folhas)
local tronco = Instance.new("Part")
tronco.Size = Vector3.new(2, 8, 2)
tronco.Position = Vector3.new(0, 4, 10) -- Posição perto do spawn
tronco.BrickColor = BrickColor.new("Brown")
tronco.Material = Enum.Material.Wood
tronco.Anchored = true
tronco.Parent = workspace

local folhas = Instance.new("Part")
folhas.Size = Vector3.new(6, 6, 6)
folhas.Position = Vector3.new(0, 9, 10) -- No topo do tronco
folhas.BrickColor = BrickColor.new("Bright green")
folhas.Material = Enum.Material.Grass
folhas.Shape = Enum.PartType.Ball
folhas.Anchored = true
folhas.Parent = workspace

-- 2. CRIANDO UM BLOCO DE ÁGUA REALISTA
local piscina = Instance.new("Part")
piscina.Size = Vector3.new(20, 1, 20)
piscina.Position = Vector3.new(15, 0.5, 10)
piscina.BrickColor = BrickColor.new("Bright blue")
piscina.Material = Enum.Material.ForceField -- Dá um efeito brilhante
piscina.Transparency = 0.3
piscina.Anchored = true
piscina.CanCollide = false -- Faz o jogador conseguir afundar/nadar nela
piscina.Parent = workspace

-- 3. MUDANDO A COR DO CÉU E O CLIMA DO JOGO
game:GetService("Lighting").ClockTime = 18 -- Muda o horário para o pôr do sol (18:00)
game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(255, 150, 100) -- Tom alaranjado

print("✨ Cenário atualizado com sucesso!")

