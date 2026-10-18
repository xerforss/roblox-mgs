-- ========================================================
-- GERADOR DE TERRENO CORRIGIDO (STREAMING FORÇADO) 🚀
-- ========================================================

print("🌲 [GitHub] Iniciando renderização forçada de terreno...")

local terrain = workspace:Terrain
terrain:Clear()

-- 1. CONSTRUINDO UMA PLATAFORMA SÓLIDA DE AREIA
-- Criando uma base firme abaixo do spawn para o avatar não cair no vácuo
terrain:FillBlock(CFrame.new(0, 0, 0), Vector3.new(100, 4, 100), Enum.Material.Sand)

-- 2. GERANDO A MONTANHA DE PEDRA ATRÁS DO SPAWN
terrain:FillBlock(CFrame.new(0, 20, 60), Vector3.new(50, 40, 50), Enum.Material.Rock)

-- 3. GERANDO UM LAGO DE ÁGUA NATURAL NA FRENTE DO SPAWN
terrain:FillBlock(CFrame.new(0, -2, -40), Vector3.new(80, 10, 80), Enum.Material.Water)

-- 4. FORÇAR TELETRANSPORTE E RENDERIZAÇÃO NO TABLET
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        local humRoot = character:WaitForChild("HumanoidRootPart", 10)
        if humRoot then
            task.wait(2) -- Tempo necessário para o tablet carregar o motor gráfico
            humRoot.CFrame = CFrame.new(0, 6, 0) -- Coloca você em cima da areia
            print("⚡ Personagem posicionado com sucesso na Ilha!")
        end
    end)
end)

-- Aplica para o servidor atual caso você já esteja conectado
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 6, 0)
    end
end

print("✨ [GitHub] Configuração aplicada globalmente.")
