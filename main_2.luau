-- ========================================================
-- 🎨 SUBWAY SURFERS: GRAFFITI ESCAPE SYSTEM
-- ========================================================

print("🏃 Starting Graffiti Escape Game logic...")

-- 1. BUILD THE CITY ALLEYWAY
local floor = Instance.new("Part")
floor.Size = Vector3.new(20, 1, 300)
floor.Position = Vector3.new(0, 0.5, 0)
floor.BrickColor = BrickColor.new("Dark stone grey")
floor.Material = Enum.Material.Concrete
floor.Anchored = true
floor.Parent = workspace

local wallLeft = Instance.new("Part")
wallLeft.Size = Vector3.new(1, 15, 300)
wallLeft.Position = Vector3.new(-10, 7.5, 0)
wallLeft.BrickColor = BrickColor.new("Medium stone grey")
wallLeft.Material = Enum.Material.Brick
wallLeft.Anchored = true
wallLeft.Parent = workspace

-- 2. SPAWN A WALL WITH GRAFFITI TO PAINT OVER
local graffitiWall = Instance.new("Part")
graffitiWall.Size = Vector3.new(0.2, 6, 8)
graffitiWall.Position = Vector3.new(-9.4, 4, 30) -- Placed along the left wall
graffitiWall.BrickColor = BrickColor.new("Really red") -- Red represents graffiti text
graffitiWall.Material = Enum.Material.Neon
graffitiWall.Anchored = true
graffitiWall.Parent = workspace

-- Prompt tool to clean/repaint the wall
local proximityPrompt = Instance.new("ProximityPrompt")
proximityPrompt.ObjectText = "Graffiti Wall"
proximityPrompt.ActionText = "Paint Over / Clean"
proximityPrompt.HoldDuration = 2.0 -- Holds button for 2 seconds to paint
proximityPrompt.Parent = graffitiWall

-- When player finishes painting, the wall goes back to clean gray
proximityPrompt.Triggered:Connect(function(player)
    graffitiWall.BrickColor = BrickColor.new("Medium stone grey")
    graffitiWall.Material = Enum.Material.Brick
    proximityPrompt:Destroy() -- Removes prompt since it's clean
    print(player.Name .. " cleaned the wall!")
end)

-- 3. SPAWN THE SCARY ANGRY GUARD
local guard = Instance.new("Part")
guard.Size = Vector3.new(3, 6, 3)
guard.Position = Vector3.new(0, 3.5, -40) -- Starts right behind the spawn point
guard.BrickColor = BrickColor.new("Navy blue")
guard.Material = Enum.Material.SmoothPlastic
guard.Anchored = false -- Must be unanchored to move!
guard.Parent = workspace

-- Keep guard balanced so he doesn't fall over
local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(400000, 0, 400000)
bodyGyro.Parent = guard

-- 4. GUARD CHASE LOGIC LOOP
task.spawn(function()
    while true do
        task.wait(0.1)
        -- Find closest player to chase
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local playerPos = player.Character.HumanoidRootPart.Position
                -- Move guard toward player position
                local direction = (playerPos - guard.Position).Unit
                guard.Velocity = direction * 14 -- Speed of the guard
            end
        end
    end
end)

-- 5. GUARD CATCHES PLAYER
guard.Touched:Connect(function(hit)
    local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0 -- Busted! Player is caught and respawns
        print("🚨 Busted! The Guard caught the player!")
    end
end)

print("✨ Game world generated! Run away from the blue block and clean the red wall!")
