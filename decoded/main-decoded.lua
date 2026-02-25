-- File: decode/main-decode.lua

task.wait(2)

local githubBaseUrl = "https://raw.githubusercontent.com/denoyey/script-roblox/main/encode/"

local successRayfield, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not successRayfield or not Rayfield then 
    warn("Gagal memuat Rayfield UI Library")
    return 
end 

local Window = Rayfield:CreateWindow({
    Name                 = "Script by xnoname008",
    LoadingTitle         = "Memuat Menu...",
    LoadingSubtitle      = "Menyiapkan Modul",
    ConfigurationSaving  = { Enabled = false }
})


-- Memuat script universal

local universalUrl = githubBaseUrl .. "core/universal.lua"
local successUniversal, responseUniversal = pcall(function()
    return game:HttpGet(universalUrl)
end)

if successUniversal and responseUniversal and not string.find(responseUniversal, "404: Not Found") then
    local loadSuccess, universalModule = pcall(function()
        return loadstring(responseUniversal)()
    end)
    
    if loadSuccess and type(universalModule) == "function" then
        universalModule(Window, Rayfield)
    else
        Rayfield:Notify({Title = "Error", Content = "Gagal memuat Modul Universal.", Duration = 5})
    end
else
    Rayfield:Notify({Title = "Network Error", Content = "Tidak dapat mengunduh Modul Universal.", Duration = 5})
end


-- Memuat script khusus game

local currentPlaceId = tostring(game.PlaceId)
local gameScriptUrl = githubBaseUrl .. "games/" .. currentPlaceId .. ".lua"

local successGame, responseGame = pcall(function()
    return game:HttpGet(gameScriptUrl)
end)

if successGame and responseGame and not string.find(responseGame, "404: Not Found") then
    local loadGameSuccess, gameModule = pcall(function()
        return loadstring(responseGame)()
    end)
    
    if loadGameSuccess and type(gameModule) == "function" then
        gameModule(Window)
        Rayfield:Notify({Title = "Game Detected!", Content = "Tab khusus game berhasil dimuat.", Duration = 5})
    else
        Rayfield:Notify({Title = "Error", Content = "Modul Game error saat dimuat.", Duration = 5})
    end
else
    Rayfield:Notify({Title = "Info", Content = "Game ini belum memiliki script khusus. Hanya fitur Universal yang dimuat.", Duration = 5})
end

Rayfield:LoadConfiguration()