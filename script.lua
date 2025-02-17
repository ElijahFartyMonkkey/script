-- Wait for game to fully load before proceeding
repeat task.wait() until game:IsLoaded()

-- Custom asset handling function
shared.oldgetcustomasset = shared.oldgetcustomasset or getcustomasset
task.spawn(function()
    repeat task.wait() until shared.VapeFullyLoaded
    getgenv().getcustomasset = shared.oldgetcustomasset -- vape bad code moment
end)

-- Cheat Engine Detection
local CheatEngineMode = false
if (not getgenv) or (getgenv and type(getgenv) ~= "function") then CheatEngineMode = true end
if getgenv and not getgenv().shared then CheatEngineMode = true; getgenv().shared = {}; end
if getgenv and not getgenv().debug then CheatEngineMode = true; getgenv().debug = {traceback = function(string) return string end} end
if getgenv and not getgenv().require then CheatEngineMode = true; end
if getgenv and getgenv().require and type(getgenv().require) ~= "function" then CheatEngineMode = true end

-- Define debug checks
local debugChecks = {
    Type = "table",
    Functions = {
        "getupvalue",
        "getupvalues",
        "getconstants",
        "getproto"
    }
}

-- Function to check executor
local function checkExecutor()
    if identifyexecutor ~= nil and type(identifyexecutor) == "function" then
        local suc, res = pcall(function()
            return identifyexecutor()
        end)
        local blacklist = {'solara', 'cryptic', 'xeno'}
        if suc then
            for i,v in pairs(blacklist) do
                if string.find(string.lower(tostring(res)), v) then CheatEngineMode = true end
            end
        end
    end
end
task.spawn(function() pcall(checkExecutor) end)

-- Function to check require status
local function checkRequire()
    if CheatEngineMode then return end
    local bedwarsID = {
        game = {6872274481, 8444591321, 8560631822},
        lobby = {6872265039}
    }
    if table.find(bedwarsID.game, game.PlaceId) then
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character
        repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TopBarAppGui")
        local suc, data = pcall(function()
            return require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
        end)
        if (not suc) or type(data) ~= 'table' or (not data.Get) then CheatEngineMode = true end
    end
end

-- Function to check debug status
local function checkDebug()
    if CheatEngineMode then return end
    if not getgenv().debug then
        CheatEngineMode = true
    else
        if type(debug) ~= debugChecks.Type then
            CheatEngineMode = true
        else
            for i, v in pairs(debugChecks.Functions) do
                if not debug[v] or (debug[v] and type(debug[v]) ~= "function") then
                    CheatEngineMode = true
                else
                    local suc, res = pcall(debug[v])
                    if tostring(res) == "Not Implemented" then
                        CheatEngineMode = true
                    end
                end
            end
        end
    end
end

if (not CheatEngineMode) then checkDebug() end

-- Folder and file setup
local RiseMode = true
local baseDirectory = RiseMode and "rise/" or "vape/"
if (not isfolder('vape')) then makefolder('vape') end
if (not isfolder('rise')) then makefolder('rise') end
shared.CheatEngineMode = shared.CheatEngineMode or CheatEngineMode

-- Identity and file operations
local setidentity = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity or function() end
local getidentity = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity or function() return 8 end
local isfile = isfile or function(file)
    local suc, res = pcall(function() return readfile(file) end)
    return suc and res ~= nil
end
local delfile = delfile or function(file) writefile(file, "") end
if not isfolder(baseDirectory) then makefolder(baseDirectory) end

-- VW Functions (statistics, profiles, etc.)
local VWFunctions = {}
function VWFunctions.CreateID()
    -- [Creation of ID logic, omitted for brevity]
end

function VWFunctions.LogStats()
    -- [Logging stats, omitted for brevity]
end

function VWFunctions.GetHttpData()
    -- [Fetching HTTP data, omitted for brevity]
end

shared.VWFunctions = VWFunctions
getgenv().VWFunctions = VWFunctions

-- Profile installation functions
local function install_profiles(num)
    -- [Installation logic for profiles, omitted for brevity]
end
local function are_installed_1()
    -- [Check if profiles are installed, omitted for brevity]
end
local function are_installed_2()
    -- [Check for closet profiles, omitted for brevity]
end
if not are_installed_1() then install_profiles(1) end
if not are_installed_2() then install_profiles(2) end

-- Further actions related to Github, commits, etc.
-- [More code for managing files from GitHub, omitted for brevity]

-- Final script setup
local url = RiseMode and "https://github.com/VapeVoidware/VWRise/" or "https://github.com/VapeVoidware/VoidwareBakup"
local commit = '465a8ada802ed05b4e32d87997e6a493e39a9816'
writefile(baseDirectory.."commithash2.txt", commit)
