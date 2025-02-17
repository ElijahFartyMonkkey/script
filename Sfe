-- Anti AFK Bypass
pcall(function()
    for _, v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
        v:Disable()
    end
end)

-- Determine exploit environment
local exploit = "Unknown"
if syn then
    exploit = "Synapse X"
elseif secure_load or pebc_execute then
    exploit = "Script-Ware"
elseif isvm then
    exploit = "ProtoSmasher"
elseif KRNL_LOADED then
    exploit = "KRNL"
elseif fluxus then
    exploit = "Fluxus"
elseif getexecutorname then
    exploit = getexecutorname()
end

-- Load UI library
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

-- Create UI window
local Window = Library:CreateWindow({
    Title = 'Script Hub - ' .. exploit,
    Center = true,
    AutoShow = true
})

-- Tabs
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}

-- Add Toggle Button
Tabs.Main:AddToggle('ExampleToggle', {
    Text = 'Enable Feature',
    Default = false,
    Tooltip = 'This is an example toggle',
    Callback = function(Value)
        print('Toggle state:', Value)
    end
})

-- File Handling
local function writeFile(filename, data)
    if writefile then
        writefile(filename, data)
    else
        print("Writefile not supported")
    end
end

local function readFile(filename)
    if readfile and isfile(filename) then
        return readfile(filename)
    end
    return nil
end

-- Auto Execution Example
local scriptContent = readFile("autoexec.lua")
if scriptContent then
    loadstring(scriptContent)()
end

-- UI Management
Library:SetWatermarkVisibility(true)
Library:SetWatermark("Exploit: " .. exploit)

Library.KeybindFrame.Visible = true
Library:OnUnload(function()
    print('Unloading script...')
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:BuildConfigSection(Tabs.Settings)

Library:Notify("Script Loaded Successfully", 3)
