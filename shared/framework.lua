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
║   🐺 Weapon Scope System - Framework Adapter                                                 ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   DESCRIPTION:                                                                                ║
║   Multi-framework adapter layer providing unified API for scope system.                      ║
║   Automatically detects and integrates with LXR-Core, RSG-Core, VORP,                        ║
║   or operates in standalone mode with graceful fallbacks.                                    ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   © 2024-2026 The Lux Empire | wolves.land                                                   ║
║   All Rights Reserved - Licensed for wolves.land use                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████ FRAMEWORK DETECTION █████████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

Framework = {}
Framework.Type = nil
Framework.Object = nil
Framework.Ready = false

-- Auto-detect framework if set to 'auto'
local function DetectFramework()
    if Config.Framework ~= 'auto' then
        return Config.Framework:lower()
    end
    
    -- Priority order: LXR > RSG > VORP > Standalone
    if GetResourceState(Config.FrameworkSettings.LXR.resourceName) == 'started' then
        return 'lxr'
    elseif GetResourceState(Config.FrameworkSettings.RSG.resourceName) == 'started' then
        return 'rsg'
    elseif GetResourceState(Config.FrameworkSettings.VORP.resourceName) == 'started' then
        return 'vorp'
    else
        return 'standalone'
    end
end

Framework.Type = DetectFramework()

if Config.Debug then
    print(string.format("^3[Wolves Scopes]^7 Framework detected: ^2%s^7", Framework.Type))
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████████ FRAMEWORK INITIALIZATION ████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

if Framework.Type == 'lxr' then
    -- LXR-Core Initialization
    if Config.FrameworkSettings.LXR.useExports then
        Citizen.CreateThread(function()
            while not Framework.Object do
                Framework.Object = exports[Config.FrameworkSettings.LXR.exportName]:GetCoreObject()
                if not Framework.Object then
                    Wait(100)
                end
            end
            Framework.Ready = true
            if Config.Debug then
                print("^3[Wolves Scopes]^7 LXR-Core initialized")
            end
        end)
    end

elseif Framework.Type == 'rsg' then
    -- RSG-Core Initialization
    if Config.FrameworkSettings.RSG.useExports then
        Citizen.CreateThread(function()
            while not Framework.Object do
                Framework.Object = exports[Config.FrameworkSettings.RSG.exportName]:GetCoreObject()
                if not Framework.Object then
                    Wait(100)
                end
            end
            Framework.Ready = true
            if Config.Debug then
                print("^3[Wolves Scopes]^7 RSG-Core initialized")
            end
        end)
    end

elseif Framework.Type == 'vorp' then
    -- VORP Initialization
    if Config.FrameworkSettings.VORP.useExports then
        Citizen.CreateThread(function()
            Framework.Object = exports[Config.FrameworkSettings.VORP.exportName]:GetCore()
            Framework.Ready = true
            if Config.Debug then
                print("^3[Wolves Scopes]^7 VORP Core initialized")
            end
        end)
    end

elseif Framework.Type == 'standalone' then
    -- Standalone mode - no framework needed
    Framework.Ready = true
    if Config.Debug then
        print("^3[Wolves Scopes]^7 Standalone mode initialized")
    end
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- ██████████████████████████████ UNIFIED API FUNCTIONS █████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

--[[
    Unified Notification System
    Provides consistent notifications across all frameworks
]]
function Framework.Notify(source, message, type, duration)
    type = type or Config.Notifications.types.info
    duration = duration or Config.Notifications.duration
    
    if not Config.Notifications.enabled then
        return
    end
    
    if IsDuplicityVersion() then
        -- Server-side notification
        if Framework.Type == 'lxr' then
            TriggerClientEvent(Config.FrameworkSettings.LXR.events.notify, source, {
                title = "Weapon Scopes",
                message = message,
                type = type,
                duration = duration
            })
        elseif Framework.Type == 'rsg' then
            TriggerClientEvent(Config.FrameworkSettings.RSG.events.notify, source, message, type, duration)
        elseif Framework.Type == 'vorp' then
            if Framework.Object and Framework.Object.NotifyLeft then
                local notifType = "COLOR_WHITE"
                if type == "success" then notifType = "COLOR_GREEN"
                elseif type == "error" then notifType = "COLOR_RED"
                elseif type == "warning" then notifType = "COLOR_ORANGE" end
                
                Framework.Object.NotifyLeft(source, "Weapon Scopes", message, "itemtype_textures", "itemtype_weapons", duration, notifType)
            else
                TriggerClientEvent('vorp:NotifyLeft', source, "Weapon Scopes", message, "generic_textures", "generic_tick", duration)
            end
        else
            -- Standalone fallback
            TriggerClientEvent('chat:addMessage', source, {
                args = { "[Scopes]", message }
            })
        end
    else
        -- Client-side notification
        if Framework.Type == 'lxr' then
            TriggerEvent(Config.FrameworkSettings.LXR.events.notify, {
                title = "Weapon Scopes",
                message = message,
                type = type,
                duration = duration
            })
        elseif Framework.Type == 'rsg' then
            TriggerEvent(Config.FrameworkSettings.RSG.events.notify, message, type, duration)
        elseif Framework.Type == 'vorp' then
            if Framework.Object and Framework.Object.NotifyLeft then
                local notifType = "COLOR_WHITE"
                if type == "success" then notifType = "COLOR_GREEN"
                elseif type == "error" then notifType = "COLOR_RED"
                elseif type == "warning" then notifType = "COLOR_ORANGE" end
                
                Framework.Object.NotifyLeft("Weapon Scopes", message, "itemtype_textures", "itemtype_weapons", duration, notifType)
            else
                TriggerEvent('vorp:NotifyLeft', "Weapon Scopes", message, "generic_textures", "generic_tick", duration)
            end
        else
            -- Standalone fallback - use native notifications
            SetNotificationTextEntry("STRING")
            AddTextComponentString(message)
            DrawNotification(false, false)
        end
    end
end

--[[
    Check if player has permission
    Server-side only
]]
function Framework.HasPermission(source, permission)
    if not IsDuplicityVersion() then
        return false
    end
    
    if Framework.Type == 'lxr' then
        -- LXR permission check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.PlayerData.job.grade.level >= 1 -- Adjust based on LXR permission system
            end
        end
    elseif Framework.Type == 'rsg' then
        -- RSG permission check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                -- Check if player has admin permission
                return Player.PlayerData.job.grade.level >= 1 -- Adjust based on RSG permission system
            end
        end
    elseif Framework.Type == 'vorp' then
        -- VORP permission check
        local User = Framework.Object.getUser(source)
        if User then
            return User.getGroup() == Config.General.adminGroup
        end
    else
        -- Standalone - check ace permissions
        return IsPlayerAceAllowed(source, permission or "command.adminscope")
    end
    
    return false
end

--[[
    Get player inventory item count
    Server-side only
]]
function Framework.GetItemCount(source, itemName)
    if not IsDuplicityVersion() then
        return 0
    end
    
    if Framework.Type == 'lxr' then
        -- LXR inventory check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                local item = Player.Functions.GetItemByName(itemName)
                return item and item.amount or 0
            end
        end
    elseif Framework.Type == 'rsg' then
        -- RSG inventory check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                local item = Player.Functions.GetItemByName(itemName)
                return item and item.amount or 0
            end
        end
    elseif Framework.Type == 'vorp' then
        -- VORP inventory check
        local count = exports[Config.FrameworkSettings.VORP.inventoryResource]:getItemCount(source, nil, itemName)
        return count or 0
    end
    
    return 0
end

--[[
    Add item to player inventory
    Server-side only
]]
function Framework.AddItem(source, itemName, amount)
    if not IsDuplicityVersion() then
        return false
    end
    
    amount = amount or 1
    
    if Framework.Type == 'lxr' then
        -- LXR add item
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.AddItem(itemName, amount)
            end
        end
    elseif Framework.Type == 'rsg' then
        -- RSG add item
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.AddItem(itemName, amount)
            end
        end
    elseif Framework.Type == 'vorp' then
        -- VORP add item
        return exports[Config.FrameworkSettings.VORP.inventoryResource]:addItem(source, itemName, amount)
    end
    
    return false
end

--[[
    Remove item from player inventory
    Server-side only
]]
function Framework.RemoveItem(source, itemName, amount)
    if not IsDuplicityVersion() then
        return false
    end
    
    amount = amount or 1
    
    if Framework.Type == 'lxr' then
        -- LXR remove item
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.RemoveItem(itemName, amount)
            end
        end
    elseif Framework.Type == 'rsg' then
        -- RSG remove item
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                return Player.Functions.RemoveItem(itemName, amount)
            end
        end
    elseif Framework.Type == 'vorp' then
        -- VORP remove item
        return exports[Config.FrameworkSettings.VORP.inventoryResource]:subItem(source, itemName, amount)
    end
    
    return false
end

--[[
    Check if player can carry item
    Server-side only
]]
function Framework.CanCarryItem(source, itemName, amount)
    if not IsDuplicityVersion() then
        return false
    end
    
    amount = amount or 1
    
    if Framework.Type == 'lxr' then
        -- LXR inventory space check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                -- Implement based on LXR inventory system
                return true -- Placeholder
            end
        end
    elseif Framework.Type == 'rsg' then
        -- RSG inventory space check
        if Framework.Object and Framework.Object.Functions then
            local Player = Framework.Object.Functions.GetPlayer(source)
            if Player then
                -- Implement based on RSG inventory system
                return true -- Placeholder
            end
        end
    elseif Framework.Type == 'vorp' then
        -- VORP inventory space check
        return exports[Config.FrameworkSettings.VORP.inventoryResource]:canCarryItem(source, itemName, amount)
    end
    
    return true -- Default to true for standalone
end

--[[
    Close player inventory
    Server-side only
]]
function Framework.CloseInventory(source)
    if not IsDuplicityVersion() then
        return
    end
    
    if Framework.Type == 'vorp' then
        exports[Config.FrameworkSettings.VORP.inventoryResource]:closeInventory(source)
    end
    -- Other frameworks handle inventory closing client-side
end

--[[
    Register usable item
    Server-side only
]]
function Framework.RegisterUsableItem(itemName, callback)
    if not IsDuplicityVersion() then
        return
    end
    
    if Framework.Type == 'lxr' then
        -- LXR usable item registration
        if Framework.Object and Framework.Object.Functions then
            Framework.Object.Functions.CreateUseableItem(itemName, callback)
        end
    elseif Framework.Type == 'rsg' then
        -- RSG usable item registration
        if Framework.Object and Framework.Object.Functions then
            Framework.Object.Functions.CreateUseableItem(itemName, callback)
        end
    elseif Framework.Type == 'vorp' then
        -- VORP usable item registration
        exports[Config.FrameworkSettings.VORP.inventoryResource]:registerUsableItem(itemName, callback)
    end
end

-- ███████████████████████████████████████████████████████████████████████████████████████████████
-- █████████████████████████████ EXPORT FRAMEWORK OBJECT ████████████████████████████████████████
-- ███████████████████████████████████████████████████████████████████████████████████████████████

-- Make Framework object available to other scripts
_G.WolvesFramework = Framework

if Config.Debug then
    print("^3[Wolves Scopes]^7 Framework adapter loaded successfully")
end
