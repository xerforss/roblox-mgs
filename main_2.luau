-- ========================================================================
-- 👮 SUBWAY SURFERS ENGINE: THE FAIL-SAFE HIGH-END TACTICAL GUARD
-- ========================================================================

print("👮 Loading visual-safe high-end Guard engine...")

-- 1. CLEAN PREVIOUS MAP ELEMENTS
local oldMap = workspace:FindFirstChild("ChaseWorld")
if oldMap then oldMap:Destroy() end

local worldFolder = Instance.new("Folder")
worldFolder.Name = "ChaseWorld"
worldFolder.Parent = workspace

-- Premium Asphalt track
local street = Instance.new("Part")
street.Size = Vector3.new(24, 1, 500)
street.Position = Vector3.new(0, 0.5, 0)
street.BrickColor = BrickColor.new("Dark stone grey")
street.Material = Enum.Material.Asphalt
street.Anchored = true
street.Parent = worldFolder

-- 2. BUILDING THE FULLY VISIBLE TACTICAL CHARACTER MODEL
local guard = Instance.new("Model")
guard.Name = "The Tactical Inspector"
guard.Parent = worldFolder

local hrp = Instance.new("Part")
hrp.Name = "HumanoidRootPart"
hrp.Size = Vector3.new(2, 2, 1)
hrp.Position = Vector3.new(0, 6, 25) -- Spawns right in front of the player
hrp.Transparency = 1
hrp.Parent = guard

local humanoid = Instance.new("Humanoid")
humanoid.Parent = guard

-- DESIGNING A HANDSOME HIGH-DEFINITION COPS UNIFORM VIA BLOCKS
local torso = Instance.new("Part") 
torso.Name = "Torso" 
torso.Size = Vector3.new(2, 2, 1) 
torso.Color = Color3.fromRGB(15, 32, 67) -- Midnight Police Blue Shirt
torso.Material = Enum.Material.SmoothPlastic
torso.Parent = guard

local tacticalVest = Instance.new("Part")
tacticalVest.Size = Vector3.new(2.2, 1.6, 1.2) -- Bulky swat armor plate overlay
tacticalVest.Color = Color3.fromRGB(20, 20, 20) -- Matte Tactical Black
tacticalVest.Material = Enum.Material.DiamondPlate -- Gives an amazing Kevlar look!
tacticalVest.Parent = guard

local head = Instance.new("Part") 
head.Name = "Head" 
head.Size = Vector3.new(1.2, 1.2, 1.2) 
head.BrickColor = BrickColor.new("Pastel brown") -- Skin tone
head.Shape = Enum.PartType.Ball
head.Parent = guard

local policeCap = Instance.new("Part")
policeCap.Size = Vector3.new(1.5, 0.4, 1.5)
policeCap.Color = Color3.fromRGB(15, 32, 67) -- Matching officer cap
policeCap.Material = Enum.Material.SmoothPlastic
policeCap.Parent = guard

local visor = Instance.new("Part")
visor.Size = Vector3.new(1.4, 0.1, 0.4)
visor.Color = Color3.fromRGB(10, 10, 10) -- Shiny dark hat visor
stairs = Enum.Material.Glass
visor.Parent = guard

-- Arms (Police sleeves)
local leftArm = Instance.new("Part") leftArm.Name = "Left Arm" leftArm.Size = Vector3.new(1, 2, 1) leftArm.Color = Color3.fromRGB(15, 32, 67) leftArm.Parent = guard
local rightArm = Instance.new("Part") rightArm.Name = "Right Arm" rightArm.Size = Vector3.new(1, 2, 1) rightArm.Color = Color3.fromRGB(15, 32, 67) rightArm.Parent = guard

-- Legs (Tactical cargo trousers)
local leftLeg = Instance.new("Part") leftLeg.Name = "Left Leg" leftLeg.Size = Vector3.new(1, 2, 1) leftLeg.Color = Color3.fromRGB(25, 25, 25) leftLeg.Parent = guard
local rightLeg = Instance.new("Part") rightLeg.Name = "Right Leg" rightLeg.Size = Vector3.new(1, 2, 1) rightLeg.Color = Color3.fromRGB(25, 25, 25) rightLeg.Parent = guard

-- 3. SOLID WELD JOINTS ASSEMBLY
local function makeWeld(p0, p1)
	local w = Instance.new("WeldConstraint")
	w.Part0 = p0
	w.Part1 = p1
	w.Parent = p0
end
makeWeld(hrp, torso)
makeWeld(torso, tacticalVest)
makeWeld(torso, head)
makeWeld(head, policeCap)
makeCapWeld = makeWeld(policeCap, visor)
makeWeld(torso, leftArm)
makeWeld(torso, rightArm)
makeWeld(torso, leftLeg)
makeWeld(torso, rightLeg)

-- Locking joints positions perfectly
torso.CFrame = hrp.CFrame
tacticalVest.CFrame = torso.CFrame * CFrame.new(0, 0.1, 0)
head.CFrame = torso.CFrame * CFrame.new(0, 1.5, 0)
policeCap.CFrame = head.CFrame * CFrame.new(0, 0.7, 0)
visor.CFrame = policeCap.CFrame * CFrame.new(0, -0.15, -0.6)
leftArm.CFrame = torso.CFrame * CFrame.new(-1.5, 0, 0)
rightArm.CFrame = torso.CFrame * CFrame.new(1.5, 0, 0)
leftLeg.CFrame = torso.CFrame * CFrame.new(-0.5, -2, 0)
rightLeg.CFrame = torso.CFrame * CFrame.new(0.5, -2, 0)

-- Balance stabilizer loop
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = torso

-- 4. POWERFUL CHASE LOOP AI
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

-- 5. BUSTED SYSTEM
torso.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and hit.Parent.Name ~= "The Tactical Inspector" then
		hit.Parent.Humanoid.Health = 0
		print("🚨 Caught by the Tactical Officer!")
	end
end)

print("✨ Ultimate fancy guard built perfectly without external catalog links!")
