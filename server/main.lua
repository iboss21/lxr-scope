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
║   🐺 Weapon Scope System - Server Script                                                     ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   DESCRIPTION:                                                                                ║
║   Server-side scope management including item handling, validation,                          ║
║   anti-cheat protection, and framework integration.                                          ║
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

local playerCooldowns = {}
local suspiciousActivity = {}

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ███████████████████████████████ UTILITY FUNCTIONS ████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Check if player is on cooldown
]]
local function IsOnCooldown(source, action)
    if not Config.Security.enableCooldowns then
        return false
    end
    
    local identifier = GetPlayerIdentifier(source, 0)
    if not identifier then
        return true -- Block if can't get identifier
    end
    
    if not playerCooldowns[identifier] then
        playerCooldowns[identifier] = {}
    end
    
    if playerCooldowns[identifier][action] and os.time() < playerCooldowns[identifier][action] then
        return true
    end
    
    return false
end

--[[
    Set cooldown for player action
]]
local function SetCooldown(source, action)
    if not Config.Security.enableCooldowns then
        return
    end
    
    local identifier = GetPlayerIdentifier(source, 0)
    if not identifier then
        return
    end
    
    if not playerCooldowns[identifier] then
        playerCooldowns[identifier] = {}
    end
    
    playerCooldowns[identifier][action] = os.time() + (Config.Security.cooldownTime / 1000)
end

--[[
    Log suspicious activity
]]
local function LogSuspicious(source, reason)
    if not Config.Security.logSuspicious then
        return
    end
    
    local identifier = GetPlayerIdentifier(source, 0)
    local playerName = GetPlayerName(source)
    
    print(string.format("^1[SUSPICIOUS]^7 Player: %s (%s) | Reason: %s", playerName, identifier, reason))
    
    -- Track suspicious activity count
    if not suspiciousActivity[identifier] then
        suspiciousActivity[identifier] = 0
    end
    suspiciousActivity[identifier] = suspiciousActivity[identifier] + 1
    
    -- Could add Discord webhook logging here
end

--[[
    Validate player has required tool
]]
local function HasRequiredTool(source)
    if not Config.General.requireAttachTool then
        return true
    end
    
    local toolCount = Framework.GetItemCount(source, Config.Items.attachTool)
    return toolCount > 0
end

--[[
    Validate scope item for weapon type
]]
local function ValidateScopeItem(itemName, weaponType)
    for key, scopeItem in pairs(Config.Items.scopes) do
        if scopeItem == itemName then
            return true
        end
    end
    return false
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ SCOPE ITEM USAGE HANDLERS ███████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Generic scope item handler
]]
local function HandleScopeItemUse(source, itemName, weaponType, scopeType)
    -- Cooldown check
    if IsOnCooldown(source, "scope_attach") then
        Framework.Notify(source, "Please wait before using another scope", "warning")
        return
    end
    
    -- Tool requirement check
    if Config.General.requireAttachTool then
        if not HasRequiredTool(source) then
            Framework.Notify(source, string.format(Config.Notifications.messages.noTool, Config.Items.attachTool), "error")
            return
        end
        
        -- Remove tool if configured
        if Config.General.removeToolAfterUse then
            Framework.RemoveItem(source, Config.Items.attachTool, 1)
        end
    end
    
    -- Remove scope item from inventory
    if not Framework.RemoveItem(source, itemName, 1) then
        LogSuspicious(source, "Failed to remove scope item: " .. itemName)
        return
    end
    
    -- Set cooldown
    SetCooldown(source, "scope_attach")
    
    -- Trigger client to attach scope
    TriggerClientEvent("lxr-scopes:client:AttachScope", source, weaponType, scopeType)
    
    -- Close inventory if enabled
    if Config.General.closeInventory then
        Framework.CloseInventory(source)
    end
    
    if Config.Debug then
        print(string.format("^3[Wolves Scopes]^7 Player %s used scope item: %s", GetPlayerName(source), itemName))
    end
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████████████ EVENT HANDLERS ████████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Handle scope successfully attached on client
]]
RegisterNetEvent("lxr-scopes:server:ScopeAttached", function(weaponType, scopeType)
    local source = source
    
    if Config.Debug then
        print(string.format("^3[Wolves Scopes]^7 Scope attached confirmation from player %s", GetPlayerName(source)))
    end
    
    -- Additional logging could go here
end)

--[[
    Handle returning scope item to inventory when removed
]]
RegisterNetEvent("lxr-scopes:server:ReturnScopeItem", function(scopeItem)
    local source = source
    
    if not scopeItem then
        LogSuspicious(source, "Attempted to return invalid scope item")
        return
    end
    
    -- Validate scope item exists in config
    if not ValidateScopeItem(scopeItem, nil) then
        LogSuspicious(source, "Attempted to return unknown scope item: " .. scopeItem)
        return
    end
    
    -- Check if player can carry the item
    if not Framework.CanCarryItem(source, scopeItem, 1) then
        Framework.Notify(source, Config.Notifications.messages.noSpace, "error")
        return
    end
    
    -- Add item to inventory
    if Framework.AddItem(source, scopeItem, 1) then
        if Config.Debug then
            print(string.format("^3[Wolves Scopes]^7 Returned scope item %s to player %s", scopeItem, GetPlayerName(source)))
        end
    else
        LogSuspicious(source, "Failed to add scope item: " .. scopeItem)
    end
end)

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ REGISTER USABLE SCOPE ITEMS █████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

Citizen.CreateThread(function()
    -- Wait for framework to be ready
    while not Framework.Ready do
        Wait(100)
    end
    
    if not Config.General.useItems then
        return
    end
    
    -- Register all scope items as usable
    for weaponType, itemName in pairs(Config.Items.scopes) do
        -- Extract scope type from weapon type string
        local scopeType = "short"
        if weaponType:find("MEDIUM") then
            scopeType = "medium"
        elseif weaponType:find("LONG") then
            scopeType = "long"
        end
        
        Framework.RegisterUsableItem(itemName, function(data)
            local source = data.source or source
            HandleScopeItemUse(source, itemName, weaponType, scopeType)
        end)
        
        if Config.Debug then
            print(string.format("^3[Wolves Scopes]^7 Registered usable item: %s (%s scope)", itemName, scopeType))
        end
    end
    
    -- Register tool as usable for scope removal (if enabled)
    if Config.General.requireToolForRemoval then
        Framework.RegisterUsableItem(Config.Items.attachTool, function(data)
            local source = data.source or source
            
            if IsOnCooldown(source, "scope_remove") then
                Framework.Notify(source, "Please wait before removing another scope", "warning")
                return
            end
            
            SetCooldown(source, "scope_remove")
            TriggerClientEvent("lxr-scopes:client:RemoveScope", source)
            
            if Config.General.closeInventory then
                Framework.CloseInventory(source)
            end
        end)
        
        if Config.Debug then
            print(string.format("^3[Wolves Scopes]^7 Registered tool for scope removal: %s", Config.Items.attachTool))
        end
    end
end)

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████ ADMIN COMMANDS ██████████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

if Config.General.adminCommand then
    -- Admin add scope command
    RegisterCommand(Config.Commands.adminAddScope, function(source, args, rawCommand)
        if not Framework.HasPermission(source, "command.adminscope") then
            Framework.Notify(source, Config.Notifications.messages.adminOnly, "error")
            return
        end
        
        TriggerClientEvent("lxr-scopes:client:AdminAttachScope", source)
        
        if Config.Security.logAdminActions then
            print(string.format("^5[ADMIN]^7 %s used admin add scope command", GetPlayerName(source)))
        end
    end, false)
    
    -- Admin remove scope command
    RegisterCommand(Config.Commands.adminRemoveScope, function(source, args, rawCommand)
        if not Framework.HasPermission(source, "command.adminscope") then
            Framework.Notify(source, Config.Notifications.messages.adminOnly, "error")
            return
        end
        
        TriggerClientEvent("lxr-scopes:client:AdminRemoveScope", source)
        
        if Config.Security.logAdminActions then
            print(string.format("^5[ADMIN]^7 %s used admin remove scope command", GetPlayerName(source)))
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
    
    print("^2[Wolves Scopes]^7 Server script initialized successfully")
    print(string.format("^2[Wolves Scopes]^7 Framework: %s | Items: %s | Commands: %s", 
        Framework.Type, 
        Config.General.useItems and "Enabled" or "Disabled",
        Config.General.useCommands and "Enabled" or "Disabled"
    ))
end)

if Config.Debug then
    print("^3[Wolves Scopes]^7 Server script loaded in debug mode")
end
