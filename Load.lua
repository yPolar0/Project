if isfile("Project/Loader.lua") then
    loadfile("Project/Loader.lua")();
else
    local Status, Script = pcall(game.HttpGet, game, "https://raw.githubusercontent.com/yPolar7/Project/main/Loader.lua");

    if Status then
        loadstring(Script)()
    else
        game:GetService("Players").LocalPlayer:Kick("Failed to grab loader, join the discord for support.");
    end
end