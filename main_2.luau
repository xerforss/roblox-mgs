print("🌐 Successfully loaded code from a production GitHub Repository!")

-- Generate a small neon structure
local pad = Instance.new("Part")
pad.Size = Vector3.new(20, 1, 20)
pad.Position = Vector3.new(0, 0.5, 0)
pad.Material = Enum.Material.Neon
pad.BrickColor = BrickColor.new("Deep blue")
pad.Anchored = true
pad.Parent = workspace
