--[[
╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                               ║
║     ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗     ║
║     ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝     ║
║     ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗    ███████╗██║     ██║   ██║██████╔╝█████╗       ║
║     ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║    ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝       ║
║     ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║    ███████║╚██████╗╚██████╔╝██║     ███████╗     ║
║      ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝     ║
║                                                                                               ║
║   🐺 Weapon Scope System - Client Script                                                     ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   DESCRIPTION:                                                                                ║
║   Client-side scope management including weapon component attachment/removal,                ║
║   animation handling, and player interaction processing.                                     ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   © 2024-2026 The Lux Empire | wolves.land                                                   ║
║   All Rights Reserved - Licensed for wolves.land use                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████████ LOCAL VARIABLES █████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

local playerPed = PlayerPedId()
local cooldowns = {}

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ███████████████████████████████ UTILITY FUNCTIONS ████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Check if player is on cooldown
]]
local function IsOnCooldown(action)
    if not Config.Security.enableCooldowns then
        return false
    end
    
    if cooldowns[action] and GetGameTimer() < cooldowns[action] then
        return true
    end
    
    return false
end

--[[
    Set cooldown for action
]]
local function SetCooldown(action)
    if Config.Security.enableCooldowns then
        cooldowns[action] = GetGameTimer() + Config.Security.cooldownTime
    end
end

--[[
    Play scope attachment animation
]]
local function PlayScopeAnimation()
    if not Config.Animation.enabled then
        return
    end
    
    local ped = PlayerPedId()
    
    -- Request animation dictionary
    RequestAnimDict(Config.Animation.dict)
    while not HasAnimDictLoaded(Config.Animation.dict) do
        Wait(100)
    end
    
    -- Play animation
    TaskPlayAnim(ped, Config.Animation.dict, Config.Animation.name, 8.0, -8.0, Config.Animation.duration, Config.Animation.flag, 0, false, false, false)
    
    -- Wait for animation to complete
    Wait(Config.Animation.duration)
end

--[[
    Get current weapon hash
]]
local function GetCurrentWeapon()
    local ped = PlayerPedId()
    local ret, weaponHash = GetCurrentPedWeapon(ped, true)
    
    if ret then
        return weaponHash
    end
    
    return nil
end

--[[
    Check if weapon has scope attached
]]
local function HasScopeAttached(weaponHash)
    local ped = PlayerPedId()
    local weaponData = Config.WeaponComponents[weaponHash]
    
    if not weaponData then
        return false
    end
    
    -- Native function to check if component is attached: 0xBBC67A6F965C688A
    return Citizen.InvokeNative(0xBBC67A6F965C688A, ped, weaponData.component, weaponHash)
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████████ SCOPE ATTACHMENT FUNCTIONS ████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Attach scope to weapon
]]
local function AttachScope(weaponHash)
    local ped = PlayerPedId()
    local weaponData = Config.WeaponComponents[weaponHash]
    
    if not weaponData then
        Framework.Notify(source, Config.Notifications.messages.invalidWeapon, "error")
        return false
    end
    
    if HasScopeAttached(weaponHash) then
        Framework.Notify(source, Config.Notifications.messages.alreadyHasScope, "warning")
        return false
    end
    
    -- Play animation
    PlayScopeAnimation()
    
    -- Attach scope component
    GiveWeaponComponentToEntity(ped, weaponData.component, weaponHash, true)
    
    Framework.Notify(source, Config.Notifications.messages.scopeAttached, "success")
    
    if Config.Debug then
        print(string.format("^3[Wolves Scopes]^7 Attached scope to weapon: %s (Component: %s)", weaponHash, weaponData.component))
    end
    
    return true
end

--[[
    Remove scope from weapon
]]
local function RemoveScope(weaponHash, returnItem)
    local ped = PlayerPedId()
    local weaponData = Config.WeaponComponents[weaponHash]
    
    if not weaponData then
        Framework.Notify(source, Config.Notifications.messages.invalidWeapon, "error")
        return false
    end
    
    if not HasScopeAttached(weaponHash) then
        Framework.Notify(source, Config.Notifications.messages.noScopeAttached, "warning")
        return false
    end
    
    -- Play animation
    PlayScopeAnimation()
    
    -- Remove scope component
    RemoveWeaponComponentFromPed(ped, weaponData.component, weaponHash)
    
    -- Return scope item to inventory if requested
    if returnItem then
        local scopeItemKey = "WEAPON_" .. string.upper(GetHashNameForHash(weaponHash):gsub("weapon_", ""))
        local scopeItem = Config.Items.scopes[scopeItemKey .. "_" .. string.upper(weaponData.type)]
        
        if scopeItem then
            TriggerServerEvent("lxr-scopes:server:ReturnScopeItem", scopeItem)
        end
    end
    
    Framework.Notify(source, Config.Notifications.messages.scopeRemoved, "success")
    
    if Config.Debug then
        print(string.format("^3[Wolves Scopes]^7 Removed scope from weapon: %s (Component: %s)", weaponHash, weaponData.component))
    end
    
    return true
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████████ EVENT HANDLERS ██████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Handle scope item usage (triggered from server)
]]
RegisterNetEvent("lxr-scopes:client:AttachScope", function(weaponType, scopeType)
    if IsOnCooldown("scope_attach") then
        Framework.Notify(source, "Please wait before using another scope", "warning")
        return
    end
    
    local currentWeapon = GetCurrentWeapon()
    
    if not currentWeapon then
        Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
        return
    end
    
    local weaponData = Config.WeaponComponents[currentWeapon]
    
    if not weaponData then
        Framework.Notify(source, Config.Notifications.messages.invalidWeapon, "error")
        return
    end
    
    -- Validate scope type matches weapon
    if weaponData.type ~= scopeType then
        Framework.Notify(source, "This scope doesn't fit this weapon", "error")
        return
    end
    
    if AttachScope(currentWeapon) then
        SetCooldown("scope_attach")
        TriggerServerEvent("lxr-scopes:server:ScopeAttached", weaponType, scopeType)
    end
end)

--[[
    Handle scope removal (triggered from server or tool use)
]]
RegisterNetEvent("lxr-scopes:client:RemoveScope", function()
    if IsOnCooldown("scope_remove") then
        Framework.Notify(source, "Please wait before removing another scope", "warning")
        return
    end
    
    local currentWeapon = GetCurrentWeapon()
    
    if not currentWeapon then
        Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
        return
    end
    
    if RemoveScope(currentWeapon, true) then
        SetCooldown("scope_remove")
    end
end)

--[[
    Admin command: Force attach scope
]]
RegisterNetEvent("lxr-scopes:client:AdminAttachScope", function()
    local currentWeapon = GetCurrentWeapon()
    
    if currentWeapon then
        AttachScope(currentWeapon)
    else
        Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
    end
end)

--[[
    Admin command: Force remove scope
]]
RegisterNetEvent("lxr-scopes:client:AdminRemoveScope", function()
    local currentWeapon = GetCurrentWeapon()
    
    if currentWeapon then
        RemoveScope(currentWeapon, false)
    else
        Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
    end
end)

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████ STANDALONE COMMANDS █████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

if Config.General.useCommands and Framework.Type == 'standalone' then
    -- Add scope command
    RegisterCommand(Config.Commands.addScope, function()
        local currentWeapon = GetCurrentWeapon()
        
        if currentWeapon then
            AttachScope(currentWeapon)
        else
            Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
        end
    end, false)
    
    -- Remove scope command
    RegisterCommand(Config.Commands.removeScope, function()
        local currentWeapon = GetCurrentWeapon()
        
        if currentWeapon then
            RemoveScope(currentWeapon, false)
        else
            Framework.Notify(source, Config.Notifications.messages.noWeapon, "error")
        end
    end, false)
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ███████████████████████████████ INITIALIZATION ███████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

Citizen.CreateThread(function()
    -- Wait for framework to be ready
    while not Framework.Ready do
        Wait(100)
    end
    
    -- Update player ped reference periodically
    while true do
        playerPed = PlayerPedId()
        Wait(5000)
    end
end)

if Config.Debug then
    print("^3[Wolves Scopes]^7 Client script initialized")
end
