-- Create the main baseplate (floor)
local baseplate = Instance.new("Part")
baseplate.Size = Vector3.new(100, 1, 100)
baseplate.Position = Vector3.new(0, 0, 0)
baseplate.Anchored = true
baseplate.BrickColor = BrickColor.new("Dark green")
baseplate.Parent = game.Workspace

-- Create a glowing, moving obstacle
local obstacle = Instance.new("Part")
obstacle.Size = Vector3.new(10, 10, 10)
obstacle.Position = Vector3.new(0, 5, 20)
obstacle.Anchored = true
obstacle.Material = Enum.Material.Neon
obstacle.BrickColor = BrickColor.new("Really red")
obstacle.Parent = game.Workspace

-- Script the obstacle to spin completely via code
task.spawn(function()
	while true do
		obstacle.CFrame = obstacle.CFrame * CFrame.Angles(0, math.rad(2), 0)
		task.wait()
	end
end)
