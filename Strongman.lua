-- this code is full of retarded microoptimizations and the code may not work since i didnt test it /shrug but i assume you can fix it 
if not game:IsLoaded() then
	game.Loaded:Wait()
end

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
getgenv().Settings = {
	['Toggle'] = false;
	['Automatic'] = false;
	['WeightToggle'] = true;
	['Multiplier'] = 0;
	['DisablePurchase'] = false;
	['Proximity'] = 0;
};

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
};

local HitList = {
	'exit';
	'copy';
};

-- // Services \\ --
local game = game
local Players = game:GetService('Players');
local RunService = game:GetService('RunService');
local workspace = game:GetService("Workspace"); -- I could localize workspace with (workspace the global) but namecall is winning?
local ReplicatedStorage = game:GetService('ReplicatedStorage');
local TeleportService = game:GetService("TeleportService");
local CoreGui = game:GetService("CoreGui");

--// Variables \\ --
local Player = Players.LocalPlayer;
local Character = Player.Character or Player.CharacterAdded;
local HumanoidRootPart = Character:FindFirstChild('HumanoidRootPart') or Character.PrimaryPart;
local Humanoid = Character:FindFirstChild('Humanoid')
local PlayerDraggablesObject = workspace.PlayerDraggables[LocalPlayer.UserId];
local OldCFrame = HumanoidRootPart.CFrame
local prox;

local Areas = workspace.Areas:GetDescendants();
local Gym = workspace.Areas.Area1.Gym;
local Avoid = workspace.Avoid;
local Goal = workspace.Areas["Area14_Retro"].Goal

local Badges = workspace.BadgeColliders:GetChildren();
local TrainingEquipment = Gym.TrainingEquipment:GetDescendants();

local Collider = Gym.TrainingEquipment.WorkoutStation.Collider;

local TheNumberZero = 0;
local TheNumberOne = 1;
local TheNumberFourHundred = 400;
local WTFInteger = 2 ^ 1024;

local ProximityPromptString = "ProximityPrompt";
local WeightString = 'ExtraWeight';
local PartString = 'Part';
local CoinString = 'Coin';

local UpgradeStrength = ReplicatedStorage.StrongMan_UpgradeStrength;
local NewCFrame = CFrame.new(-79.9094696, 19.8263607, 8124.82129, 1, 0, 0, 0, 1, 0, 0, 0, 1)

--// Functions \\ --
local fireproximityprompt = fireproximityprompt;
local firetouchinterest = firetouchinterest;
local task.spawn = task.spawn or coroutine.wrap;
local task.wait = task.wait or wait;
local pairs = pairs;

local function GetBadges()
	for Index, Variable in pairs(Badges) do
		firetouchinterest(HumanoidRootPart, Variable, TheNumberZero)
		firetouchinterest(HumanoidRootPart, Variable, TheNumberOne)
	end
end

local function AutoWorkOut()
	for Index, Variable in pairs(TrainingEquipment) do
		if Variable:IsA(ProximityPromptString) then
			HumanoidRootPart.CFrame = Collider.CFrame

			repeat wait() fireproximityprompt(Variable) until HumanoidRootPart.Anchored
		end
	end
	
	task.spawn(function()
		while getgenv().Settings.Automatic do 
			UpgradeStrength:InvokeServer(getgenv().Settings.Multiplier)
			task.wait()
		end
	end)
end

local function LagServer()
	for Index, Variable in pairs(TrainingEquipment) do
		if Variable:IsA(ProximityPromptString) then
			HumanoidRootPart.CFrame = Collider.CFrame

			repeat wait() fireproximityprompt(Variable) until HumanoidRootPart.Anchored
		end
	end

	for _ = TheNumberOne, TheNumberFourHundred do
		task.spawn(function()
			UpgradeStrength:InvokeServer(WTFInteger)
		end)
	end
end

local function BreakExits()
	for Index, Variable in pairs(Areas) do
		for Index2 = TheNumberOne, #HitList do
			if Variable:lower():find(HitList[Index2]) then
				Variable:Destroy()
			end
		end
	end
end

local function Rejoin()
	TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

local function DisablePurchasePrompt()
	if getgenv().Settings.DisablePurchase then
		getgenv().Settings.DisablePurchase = false
		CoreGui.PurchasePromptApp.Enabled = false

		elseif not getgenv().Settings.DisablePurchase then

		getgenv().Settings.DisablePurchase = true
		CoreGui.PurchasePromptApp.Enabled = true
	end
end

-- Don't know why you did this
HumanoidRootPart.CFrame = NewCFrame
task.wait(0.25)
HumanoidRootPart.CFrame = OldCFrame

-- Ui

for _, v in pairs(workspace.Area.DraggableItems:GetDescendants()) do
	if v:IsA("StringValue") and v.Name == "Title" and v.Value == "PYRAMID" then
		local part = v.Parent.InteractionPoint
		getgenv().Settings.Prox = v.Parent.InteractionPoint.ProximityPrompt
	end
end

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
	Rejoin()
end)


mainsec:addToggle("Disable Purchase Prompts", nil, function(value)
	DisablePurchasePrompt()
end)

autofarm:addToggle("Enabled", nil, function(value) -- i'll optimize this code later
	getgenv().Settings.Toggle = value
	HumanoidRootPart.CFrame = NewCFrame
	wait(0.1)
	task.spawn(function()
		while getgenv().Settings.Toggle do
			task.wait(0.1)
			HumanoidRootPart.CFrame = NewCFrame
			fireproximityprompt(getgenv().Settings.Proximity, TheNumberZero)
		end
	end)
end)
autostrength:addToggle("Enabled", nil, function(value) -- i'll optimize this code later
	
	getgenv().Settings.Automatic = value

	task.spawn(function()
		CoreGui.PurchasePromptApp.Enabled = false
		while getgenv().Settings.Automatic do
			AutoWorkOut()
		end
		CoreGui.PurchasePromptApp.Enabled = true
	end)
end)
autostrength:addSlider("Muliplier", 0, 0, 500, function(value) -- i'll optimize this code later 
	getgenv().Settings.Multipier = value
end)
char:addSlider("WalkSpeed", 0, 0, 1000, function(value) -- i'll optimize this code later 
	Humanoid.WalkSpeed = value
end)
char:addSlider("JumpPower", 0, 0, 1000, function(value) -- i'll optimize this code later
	Humanoid.JumpPower = value 
end)













-- // Signals \\ --
PlayerDraggablesObject.DescendantAdded:Connect(function(AddedObject)
	if AddedObject.Name == WeightString and getgenv().Settings.WeightToggle then
		AddedObject:Destroy()

	elseif getgenv().Settings.Toggle and AddedObject:IsA(PartString) and AddedObject:FindFirstChild(CoinString) then
		repeat task.wait() until firetouchinterest(AddedObject, Goal, TheNumberZero); firetouchinterest(AddedObject, Goal, TheNumberOne); not AddedObject
	end
end)

Avoid:ClearAllChildren()
Avoid.ChildAdded:Connect(function(AddedObject)
	task.wait()
	AddedObject:Destroy()
end)

--[[for _, v in pairs(Area.DraggableItems:GetDescendants()) do
	if v:IsA("StringValue") and v.Name == "Title" and v.Value == "PYRAMID" then
		local part = v.Parent.InteractionPoint
		_G.Prox = v.Parent.InteractionPoint.ProximityPrompt
	end
end]] -- i dont know what this does
