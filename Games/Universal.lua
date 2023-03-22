-- << Yield Until Game Loaded >> --
local PreLoadTick = tick();

if not game:IsLoaded() then
    game.Loaded:Wait();
end

-- << Load Handler >> --
local ESP = loadstring(game:HttpGet('https://scripts.luawl.com/17507/ESP.lua'))();
local LoadHandler = loadstring(game:HttpGet(("https://github.com/yPolar7/Project/blob/main/Handlers/Load%20Handler.lua?raw=true")))();
local CreateUI = LoadHandler("CreateUI");

-- << Library >> --
local Library = CreateUI.Library;
local ThemeManager = CreateUI.ThemeManager;
local SaveManager = CreateUI. SaveManager;

function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local Window = Library:CreateWindow({
    Title = "Project: Universal",
    Center = true,
    AutoShow = true,
})

local Tabs = {
    ["ESP"] = LoadHandler("EspTab")(Window),
    ["UI Settings"] = Window:AddTab("UI Settings"),
};

ThemeManager:SetLibrary(Library);
SaveManager:SetLibrary(Library);

SaveManager:BuildConfigSection(Tabs["UI Settings"]);
ThemeManager:BuildThemeSection(Tabs["UI Settings"]);

warn("Project loaded in " .. round(tick() - PreLoadTick, 2) .. ' seconds')