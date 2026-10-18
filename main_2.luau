-- ========================================================
-- GERADOR DE TERRENO REALISTA VIA GITHUB (CÓDIGO AVANÇADO)
-- ========================================================

print("🌊 Iniciando a geração de terreno via GitHub...")

local terrain = workspace:Terrain
-- Limpa terrenos anteriores para não acumular quando você reiniciar
terrain:Clear() 

-- 1. CRIANDO UMA ENORME PISCINA DE ÁGUA NATURAL (Para nadar no Tablet!)
-- Vector3.new(X, Y, Z) -> Posição Central (0, -5, 20) e Tamanho (100, 10, 100)
local posicaoAgua = CFrame.new(0, -5, 20)
local tamanhoAgua = Vector3.new(100, 10, 100)

-- O motor do Roblox transforma essa região em água física e fluida
terrain:FillBlock(posicaoAgua, tamanhoAgua, Enum.Material.Water)
print("💧 Água física gerada com sucesso!")

-- 2. CRIANDO UMA MONTANHA DE PEDRA PROXIMAL
local posicaoMontanha = CFrame.new(0, 15, 80) -- Mais ao fundo do mapa
local tamanhoMontanha = Vector3.new(40, 40, 40)

terrain:FillBlock(posicaoMontanha, tamanhoMontanha, Enum.Material.Rock)
print("⛰️ Montanha de pedra esculpida!")

-- 3. ADICIONANDO UMA PRAIA DE AREIA AO REDOR DA MONTANHA
local posicaoPraia = CFrame.new(0, -1, 50)
local tamanhoPraia = Vector3.new(60, 2, 40)

terrain:FillBlock(posicaoPraia, tamanhoPraia, Enum.Material.Sand)
print("🏖️ Praia de areia adicionada!")

print("✨ Todo o terreno foi renderizado pelo GitHub!")
