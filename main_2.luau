-- ============================================================================
-- ALL-IN-ONE ROBLOX TEST SCRIPT: GRAFFITI & GUARDS SYSTEM
-- Place this inside a regular Script under ServerScriptService.
-- ============================================================================

-- 1. EMULATED MODULES (In-script data structures replacing ModuleScripts for testing)
local EconomyModule = {}
local GraffitiModule = {}
local GuardModule = {}

EconomyModule.PlayerData = {}

-- Initialize Player Data
function EconomyModule.InitPlayer(player: Player)
	EconomyModule.PlayerData[player.UserId] = { 
		Coins = 0,
		SprayColor = Color3.fromRGB(255, 0, 0) -- Default starting color: Red
	}
	print("[Data] Initialized profiles for " .. player.Name)
end

-- Reward player with coins
function EconomyModule.RewardPlayer(player: Player, amount: number)
	local data = EconomyModule.PlayerData[player.UserId]
	if data then
		data.Coins += amount
		print(player.Name .. " earned coins! Wallet Total: " .. data.Coins)
	end
end

-- Wipe player coins if caught
function EconomyModule.PenalizePlayer(player: Player)
	local data = EconomyModule.PlayerData[player.UserId]
	if data then
		data.Coins = 0
		print(player.Name .. " was caught by guards! Lost all coins.")
	end
end

-- Handle Spraying Words onto Walls
function GraffitiModule.SprayWall(wall: Part, text: string, color: Color3)
	-- Remove old graffiti if it exists
	local oldGui = wall:FindFirstChild("GraffitiGui")
	if oldGui then oldGui:Destroy() end

	-- Create new Surface Display
	local surfaceGui = Instance.new("SurfaceGui")
	surfaceGui.Name = "GraffitiGui"
	surfaceGui.Face = Enum.NormalId.Front
	surfaceGui.Parent = wall

	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = color
	textLabel.Font = Enum.Font.PermanentMarker
	textLabel.TextSize = 42
	textLabel.Text = text
	textLabel.Parent = surfaceGui
	print("[Graffiti] Wall spray-painted successfully!")
end

-- Clear graffiti from walls
function GraffitiModule.EraseWall(wall: Part)
	local gui = wall:FindFirstChild("GraffitiGui")
	if gui then
		gui:Destroy()
		print("[Graffiti] Guard forced player to erase the wall clean.")
	end
end

-- Check proximity between Guard and Player
function GuardModule.CheckDetection(guardPosition: Vector3, playerCharacter: Model, catchRadius: number)
	local playerRoot = playerCharacter:FindFirstChild("HumanoidRootPart")
	if not playerRoot then return false end

	local distance = (guardPosition - playerRoot.Position).Magnitude
	return distance <= catchRadius
end


-- ============================================================================
-- 2. GAME SETUP & CONNECTIONS
-- ============================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Setup dynamic color cycles for testing (Simulates player hitting 'C')
local testColors = {
	Color3.fromRGB(255, 0, 0),   -- Red
	Color3.fromRGB(0, 255, 0),   -- Green
	Color3.fromRGB(0, 0, 255),   -- Blue
	Color3.fromRGB(255, 255, 0)  -- Yellow
}

Players.PlayerAdded:Connect(function(player)
	EconomyModule.InitPlayer(player)

	-- Wait for the character model to load into the map
	player.CharacterAdded:Connect(function(character)
		task.wait(3) -- Give the player a moment to load

		-- Look for the brick named 'CityWall' in Workspace
		local wall = Workspace:FindFirstChild("CityWall")
		if not wall or not wall:IsA("Part") then
			warn("⚠️ Please create an Anchored Part named 'CityWall' in your Workspace to run the test!")
			return
		end

		-- TEST STEP 1: Player changes color and sprays the wall
		print("\n--- TEST PHASE 1: Spraying Wall ---")
		local randomColor = testColors[math.random(1, #testColors)]
		EconomyModule.PlayerData[player.UserId].SprayColor = randomColor

		GraffitiModule.SprayWall(wall, "CATCH ME!", randomColor)
		EconomyModule.RewardPlayer(player, 50) -- Earned coins

		task.wait(4) -- Hold for 4 seconds before the guards step in

		-- TEST STEP 2: Simulate guards arriving nearby
		print("\n--- TEST PHASE 2: Guard Proximity Check ---")
		local playerRoot = character:FindFirstChild("HumanoidRootPart")
		if playerRoot then
			-- Place an imaginary guard 5 studs away from the player
			local fakeGuardPos = playerRoot.Position + Vector3.new(5, 0, 0) 
			local isCaught = GuardModule.CheckDetection(fakeGuardPos, character, 10) -- 10 studs catch radius

			if isCaught then
				print("🚨 Guards caught the player red-handed!")

				-- TEST STEP 3: Guard forces player to clean up and takes away coins
				print("\n--- TEST PHASE 3: Consequences ---")
				GraffitiModule.EraseWall(wall)
				EconomyModule.PenalizePlayer(player)
			end
		end

	end)
end)
