repeat
	wait()
until game:IsLoaded()
repeat
	wait()
until game.Players.LocalPlayer.Character
wait()
_G.On = false
_G.auto = false
local Codes = {
	"strongman",
	"100m",
	"Chad",
	"10m",
	"25k",
	"1500likes",
	"5000likes",
	"10000",
	"500likes"
}
local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
local pairs = pairs
local rs = game:GetService("RunService")
local area = game:GetService("Workspace").Areas["Area14_Retro"]
local fireproximityprompt = fireproximityprompt
local prox
local function GetBadges()
	for _, v in pairs(game:GetService("Workspace").BadgeColliders:GetChildren()) do
		firetouchinterest(HumanoidRootPart, v, 0)
		firetouchinterest(HumanoidRootPart, v, 1)
	end
end
local function autoworkout()
	wait(0.1)
	for i, v in pairs(game:GetService("Workspace").Areas.Area1.Gym.TrainingEquipment:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			HumanoidRootPart.CFrame = game:GetService("Workspace").Areas.Area1.Gym.TrainingEquipment.WorkoutStation.Collider.CFrame
			repeat
				wait()
				fireproximityprompt(v)
			until HumanoidRootPart.Anchored == true
		end
	end
	while _G.auto do
		task.wait()
		if not _G.multipier or _G.multipier == 0 then
			game:GetService("ReplicatedStorage").StrongMan_UpgradeStrength:InvokeServer()
		else
			game:GetService("ReplicatedStorage").StrongMan_UpgradeStrength:InvokeServer(_G.multipier)
		end
	end
end
local function LagServer()
	wait(0.1)
	for i, v in pairs(game:GetService("Workspace").Areas.Area1.Gym.TrainingEquipment:GetDescendants()) do
		if v:IsA("ProximityPrompt") then
			HumanoidRootPart.CFrame = game:GetService("Workspace").Areas.Area1.Gym.TrainingEquipment.WorkoutStation.Collider.CFrame
			repeat
				wait()
				fireproximityprompt(v)
			until HumanoidRootPart.Anchored == true
		end
	end
	for i = 1, 400 do
		pcall(function()
			game:GetService("ReplicatedStorage").StrongMan_UpgradeStrength:InvokeServer(2 ^ 1024)
		end)
	end
end

local function BreakExits()
	for _, v in pairs(game:GetService("Workspace").Areas:GetDescendants()) do
		if v.Name:lower():find("exit") or v.Name:lower():find("copy") then
			v:Destroy()
		end
	end
end
game:GetService("Workspace").Avoid:ClearAllChildren()
game:GetService("Workspace").Avoid.ChildAdded:Connect(function(add)
	rs.RenderStepped:Wait()
	add:Destroy()
end)

local rs = game:GetService("RunService")
game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId].DescendantAdded:Connect(function(added)
	if added.Name == "ExtraWeight" and _G.noweight then
		added:Destroy()
	end
end)
game:GetService("Workspace").PlayerDraggables[game.Players.LocalPlayer.UserId].DescendantAdded:Connect(function(added)
	rs.RenderStepped:Wait()
	if  added:IsA("Part") and added:FindFirstChild("Coins") ~= nil then
		if not _G.On then
			return
		end
		repeat
			wait(0.1)
			firetouchinterest(added, game:GetService("Workspace").Areas["Area14_Retro"].Goal, 0)
			firetouchinterest(added, game:GetService("Workspace").Areas["Area14_Retro"].Goal, 1)
		until added == nil
	end
end)


local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Strongman Simulator", 5013109572)

local main = venyx:addPage("Main", 5012544693)

local farm = venyx:addPage("Farming", 5012544693)

local page = venyx:addPage("Character", 5012544693)
local settings = venyx:addPage("Settings", 5012544693)
local autofarm = farm:addSection("Auto Farm")
local autostrength = farm:addSection("Auto Strength")
local char = page:addSection("Character")
local mainsec = main:addSection("Main")
local Settingss = settings:addSection("Settings")

mainsec:addButton("Get all badges", function()
	GetBadges()
end)

mainsec:addButton("Break Exits", function()
	BreakExits()
end)

mainsec:addButton("Lag Server", function()
	LagServer()
end)

Settingss:addButton("Rejoin Server", function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)
local oldpos = HumanoidRootPart.CFrame
HumanoidRootPart.CFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1)
wait(0.25)
HumanoidRootPart.CFrame = oldpos
for _, v in pairs(area.DraggableItems:GetDescendants()) do
	if v:IsA("StringValue") and v.Name == "Title" and v.Value == "PYRAMID" then
		local part = v.Parent.InteractionPoint
		_G.Prox = v.Parent.InteractionPoint.ProximityPrompt
	end
end

mainsec:addToggle("Disable Purchase Prompts", nil, function(value)
	_G.Value = value
	if _G.Value then
		game:GetService("CoreGui").PurchasePromptApp.Enabled = false
	else
		_G.Value = value
		game:GetService("CoreGui").PurchasePromptApp.Enabled = true
	end
end)

autofarm:addToggle("Enabled", nil, function(value)
	_G.On = value
	HumanoidRootPart.CFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1)
	wait(0.1)
	task.defer(function()
		game.RunService.RenderStepped:connect(function()
			task.wait(0.1)
			if _G.On then
				HumanoidRootPart.CFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				fireproximityprompt(_G.Prox, 0)
			end
		end)
	end)
end)
autostrength:addToggle("Enabled", nil, function(value)
	_G.auto = value
	if _G.auto then
		game:GetService("CoreGui").PurchasePromptApp.Enabled = false
		task.defer(autoworkout)
	else
		game:GetService("CoreGui").PurchasePromptApp.Enabled = true
	end
end)
autostrength:addSlider("Muliplier", 0, 0, 500, function(value)
	_G.multipier = value
end)
char:addSlider("WalkSpeed", 0, 0, 1000, function(value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
char:addSlider("JumpPower", 0, 0, 1000, function(value)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)
