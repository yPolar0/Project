--<< Project Loader >>--
if typeof(syn) == "table" and gethui then
    syn.protect_gui = not gethui and syn.protect_gui or function(Instance) Instance.Parent = gethui() end;
end

if not game:IsLoaded() then
    game.Loaded:Wait();
end

warn("--<< Project Loader >>--")

--<< Handlers >>--
local LoadHandler = loadstring(game:HttpGet(("https://raw.githubusercontent.com/yPolar7/Project/main/Handlers/Load%20Handler.lua")))();
local File = LoadHandler("File");
local Notify = LoadHandler("Notification");

Notify("Info", "[Project]", "Setting up file handler. (1/3)", 5);

File:Setup("Project", "1.0.0", {
    "Games",
})

Notify("Info", "[Project]", "Downloading files. (2/3)", 5);

File:Download("Project/Games/PlaceIds.lua", "https://raw.githubusercontent.com/yPolar7/Project/main/Games/PlaceIds.lua");
File:Download("Project/Loader.lua", "https://raw.githubusercontent.com/yPolar7/Project/main/Loader.lua");
File:Download("Project/Universal.lua", "https://raw.githubusercontent.com/yPolar7/Project/main/Games/Universal.lua");

for _, Game in next, File:GetFilesFrom("https://github.com/yPolar7/Project/tree/main/Games") do
    local Name = Game:match("([^/]+)$");
    local Url = string.format("https://raw.githubusercontent.com/yPolar7/Project/main/Games/%s", Name);

    if Name ~= "PlaceIds.lua" and Name ~= "Universal.lua" then
        File:Download(string.format("Project/Games/%s", Name), Url);
    end
end

Notify("Info", "[Project]", "Finished setting up loader. (3/3)", 5);

--<< Services >>--
local Players = cloneref(game:GetService("Players"));
local LocalPlayer = Players.LocalPlayer;
local MarketplaceService = cloneref(game:GetService("MarketplaceService"));

--<< Variables >>--
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name;

local function GetGameFromPlaceId()
    local Games = File:Load("Project/Games/PlaceIds.lua");

    for Game, PlaceId in next, Games do
        if PlaceId == game.PlaceId then
            return Game;
        end
    end

    return false;
end

--<< Main >>--
local Game = GetGameFromPlaceId();

if not isfile("Project/Games/" .. Game .. ".lua") then
    Notify("Info", "Unknown Game", "Game not found, loading universal script.", 5);

    File:Load("Project/Universal.lua");

    Notify("Info", "[Project]", "Loaded universal script.", 5);
    return;
end

Notify("Info", "[Project]", string.format("Loading script for %s.", GameName), 5);

File:Load(string.format("Project/Games/%s.lua", Game));

Notify("Info", "[Project]", "Loaded script.", 5);