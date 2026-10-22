-- ========================================================================
-- 🌌 SUBWAY SURFERS: FANCY NIGHT CITY, REAL POLICE & CHASE MUSIC
-- ========================================================================

print("🌌 Initializing Fancy Night City Engine via GitHub...")

-- CLEAR PREVIOUS WORLD MAP GENERATION
local oldMap = workspace:FindFirstChild("SubwayCity")
if oldMap then oldMap:Destroy() end

local cityFolder = Instance.new("Folder")
cityFolder.Name = "SubwayCity"
cityFolder.Parent = workspace

-- 1. SETUP ENDLESS FANCY NIGHT ENVIRONMENT
local lighting = game:GetService("Lighting")
lighting.ClockTime = 0 -- Sets game to absolute Midnight (00:00)
lighting.OutdoorAmbient = Color3.fromRGB(15, 15, 30) -- Deep midnight purple vibe
lighting.Atmosphere.Density = 0.25 -- Adds a touch of realistic city fog

-- Concrete Street Track
local street = Instance.new("Part")
street.Size = Vector3.new(30, 1, 600)
street.Position = Vector3.new(0, 0.5, 0)
street.BrickColor = BrickColor.new("Black")
street.Material = Enum.Material.Asphalt
street.Anchored = true
street.Parent = cityFolder

-- Generate Fancy Night Skyscrapers with Glowing Neon Windows
local neonColors = {Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 128), Color3.fromRGB(255, 255, 0)}

for i = -300, 300, 60 do
	if i ~= 0 then
		-- Left Side Luxury Building
		local bLeft = Instance.new("Part")
		bLeft.Size = Vector3.new(40, math.random(80, 160), 40)
		bLeft.Position = Vector3.new(-45, bLeft.Size.Y/2, i)
		bLeft.Color = Color3.fromRGB(20, 20, 25)
		bLeft.Material = Enum.Material.Glass
		bLeft.Anchored = true
		bLeft.Parent = cityFolder
		
		-- Neon Accent Lines on Left Building
		local neonLeft = Instance.new("Part")
		neonLeft.Size = Vector3.new(0.5, bLeft.Size.Y, 0.5)
		neonLeft.Position = bLeft.Position + Vector3.new(20.1, 0, 20.1)
		neonLeft.Color = neonColors[math.random(1, #neonColors)]
		neonLeft.Material = Enum.Material.Neon
		neonLeft.Anchored = true
		neonLeft.Parent = cityFolder

		-- Right Side Luxury Building
		local bRight = Instance.new("Part")
		bRight.Size = Vector3.new(40, math.random(80, 160), 40)
		bRight.Position = Vector3.new(45, bRight.Size.Y/2, i)
		bRight.Color = Color3.fromRGB(20, 20, 25)
		bRight.Material = Enum.Material.Glass
		bRight.Anchored = true
		bRight.Parent = cityFolder
		
		-- Neon Accent Lines on Right Building
		local neonRight = Instance.new("Part")
		neonRight.Size = Vector3.new(0.5, bRight.Size.Y, 0.5)
		neonRight.Position = bRight.Position + Vector3.new(-20.1, 0, -20.1)
		neonRight.Color = neonColors[math.random(1, #neonColors)]
		neonRight.Material = Enum.Material.Neon
		neonRight.Anchored = true
		neonRight.Parent = cityFolder
	end
end

-- Main Brick Wall to Spray Paint
local mainWall = Instance.new("Part")
mainWall.Size = Vector3.new(1, 16, 500)
mainWall.Position = Vector3.new(-15, 8, 0)
mainWall.BrickColor = BrickColor.new("Medium stone grey")
mainWall.Material = Enum.Material.Brick
mainWall.Anchored = true
mainWall.Parent = cityFolder

-- 2. INTEGRATE ACTION CHASE BACKGROUND MUSIC
local oldMusic = game:GetService("SoundService"):FindFirstChild("ChaseMusic")
if oldMusic then oldMusic:Destroy() end

local music = Instance.new("Sound")
music.Name = "ChaseMusic"
music.SoundId = "rbxassetid://9043887014" -- Premium fast-paced electronic action soundtrack
music.Volume = 0.5
music.Looped = true
music.PlayOnRemove = false
music.Parent = game:GetService("SoundService")
music:Play()

-- 3. SYSTEM TO DRAW MULTIPLE GRAFFITI LINES ON WALLS
local wallsToTag = {60, 160, 260}
for _, zPos in ipairs(wallsToTag) do
	local tagArea = Instance.new("Part")
	tagArea.Size = Vector3.new(0.5, 8, 12)
	tagArea.Position = Vector3.new(-14.4, 4, zPos - 150)
	tagArea.Color = Color3.fromRGB(40, 40, 45)
	tagArea.Material = Enum.Material.SmoothPlastic
	tagArea.Anchored = true
	tagArea.Parent = cityFolder

	local prompt = Instance.new("ProximityPrompt")
	prompt.ObjectText = "Fancy City Wall"
	prompt.ActionText = "Spray Neon Tags"
	prompt.HoldDuration = 1.8
	prompt.Parent = tagArea

	prompt.Triggered:Connect(function(player)
		prompt.Enabled = false
		tagArea.BrickColor = BrickColor.new("Dark stone grey")
		
		-- Generates 4 sharp neon glowing drawing lines across the brick structure
		for lineNum = 1, 4 do
			local paintLine = Instance.new("Part")
			paintLine.Size = Vector3.new(0.1, 0.3, 9)
			paintLine.Position = tagArea.Position + Vector3.new(0.3, (lineNum * 1.3) - 2.5, 0)
			paintLine.Color = neonColors[math.random(1, #neonColors)]
			paintLine.Material = Enum.Material.Neon
			paintLine.Anchored = true
			paintLine.Parent = cityFolder
		end
	end)
end

-- 4. SPRAY CAN WITH ATTACHED EMITTER SMOKE EFFECT
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
		fx.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255)) -- Glowing Cyan smoke output
		fx.Parent = handle
		
		tool.Activated:Connect(function()
			fx.Rate = 50
			task.wait(1.5)
			fx.Rate = 0
		end)
		
		tool.Parent = player.Backpack
	end)
end)

-- 5. REALISTIC PROFESSIONAL POLICE GUARD CHARACTER DESIGN
local guardModel = Instance.new("Model")
guardModel.Name = "Realistic Police Officer"
guardModel.Parent = cityFolder

local hrp = Instance.new("Part")
hrp.Name = "HumanoidRootPart"
hrp.Size = Vector3.new(2, 2, 1)
hrp.Position = Vector3.new(0, 5, -140)
hrp.Transparency = 1
hrp.Parent = guardModel

local humanoid = Instance.new("Humanoid")
humanoid.Parent = guardModel

local gTorso = Instance.new("Part")
gTorso.Name = "Torso"
gTorso.Size = Vector3.new(2, 2, 1)
gTorso.Position = hrp.Position
gTorso.Parent = guardModel

local gHead = Instance.new("Part")
gHead.Name = "Head"
gHead.Size = Vector3.new(1.2, 1.2, 1.2)
gHead.Parent = guardModel

-- Real Clothing Layer Insertion (Loads realistic textures automatically)
local shirt = Instance.new("Shirt")
shirt.Name = "Shirt"
shirt.ShirtTemplate = "rbxassetid://13110293121" -- Official police uniform jacket asset ID
shirt.Parent = guardModel

local pants = Instance.new("Pants")
pants.Name = "Pants"
pants.PantsTemplate = "rbxassetid://13110300185" -- Official tactical police pants asset ID
pants.Parent = guardModel

local cap = Instance.new("Part")
cap.Size = Vector3.new(1.6, 0.4, 1.6)
cap.BrickColor = BrickColor.new("Black")
cap.Material = Enum.Material.SmoothPlastic
cap.Parent = guardModel

local lLeg = Instance.new("Part")
lLeg.Name = "LeftLeg"
lLeg.Size = Vector3.new(1, 2, 1)
lLeg.Parent = guardModel

local rLeg = Instance.new("Part")
rLeg.Name = "RightLeg"
rLeg.Size = Vector3.new(1, 2, 1)
rLeg.Parent = guardModel

local function joint(p0, p1)
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

-- Position limb segments around the body structure
gHead.CFrame = gTorso.CFrame * CFrame.new(0, 1.5, 0)
cap.CFrame = gHead.CFrame * CFrame.new(0, 0.7, 0)
lLeg.CFrame = gTorso.CFrame * CFrame.new(-0.5, -2, 0)
rLeg.CFrame = gTorso.CFrame * CFrame.new(0.5, -2, 0)

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = gTorso

-- 6. GUARD MOVEMENT INTELLIGENCE
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

gTorso.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= "Realistic Police Officer" then
		hit.Parent.Humanoid.Health = 0
		print("🚨 You were busted by the Police Officer!")
	end
end)

print("✨ Fancy Night City Fully Rendered! Run and Tag!")
