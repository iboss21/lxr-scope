```
╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                               ║
║     ██╗    ██╗ ██████╗ ██╗    ██╗   ██╗███████╗███████╗    ███████╗ ██████╗ ██████╗ ██████╗ ███████╗     ║
║     ██║    ██║██╔═══██╗██║    ██║   ██║██╔════╝██╔════╝    ██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝     ║
║     ██║ █╗ ██║██║   ██║██║    ██║   ██║█████╗  ███████╗    ███████╗██║     ██║   ██║██████╔╝█████╗       ║
║     ██║███╗██║██║   ██║██║    ╚██╗ ██╔╝██╔══╝  ╚════██║    ╚════██║██║     ██║   ██║██╔═══╝ ██╔══╝       ║
║     ╚███╔███╔╝╚██████╔╝███████╗╚████╔╝ ███████╗███████║    ███████║╚██████╗╚██████╔╝██║     ███████╗     ║
║      ╚══╝╚══╝  ╚═════╝ ╚══════╝ ╚═══╝  ╚══════╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚══════╝     ║
║                                                                                               ║
║   🐺 Framework Integration Guide                                                             ║
║   Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# 🔌 Framework Integration Guide

Detailed integration guide for each supported framework.

---

## 📊 Framework Support Matrix

| Framework | Support Level | Item System | Inventory | Notifications | Auto-Detect |
|-----------|--------------|-------------|-----------|---------------|-------------|
| **LXR-Core** | 🟢 Primary | ✅ Full | ✅ Native | ✅ Native | ✅ Yes |
| **RSG-Core** | 🟢 Primary | ✅ Full | ✅ Native | ✅ Native | ✅ Yes |
| **VORP Core** | 🟡 Legacy | ✅ Full | ✅ Native | ✅ Native | ✅ Yes |
| **Standalone** | 🔵 Basic | ❌ N/A | ❌ N/A | ⚠️ Basic | ✅ Yes |

🟢 Primary = Full support with active development  
🟡 Legacy = Complete support, maintenance mode  
🔵 Basic = Limited functionality, command-only

---

## 🎯 LXR-Core Integration

### Overview

**LXR-Core** is a primary framework with full native integration and the latest features.

### Architecture

```
Player Uses Scope Item
         ↓
lxr-inventory triggers item:use
         ↓
Wolves Scope System receives event
         ↓
Validates via LXR-Core export
         ↓
Removes item via LXR-Core inventory
         ↓
Attaches scope component
         ↓
Sends notification via LXR-Core
```

### Configuration

```lua
Config.Framework = 'lxr' -- or 'auto'

Config.FrameworkSettings.LXR = {
    enabled = true,
    resourceName = 'lxr-core',
    exportName = 'lxr-core',
    events = {
        playerLoaded = 'LXR:Client:OnPlayerLoaded',
        playerUnload = 'LXR:Client:OnPlayerUnload',
        notify = 'lxr-core:client:notification:send',
    },
    useExports = true,
}
```

### Item Configuration

Add scope items to LXR-Core:

```lua
-- In lxr-core/shared/items.lua

-- Short scopes
["scopeshortwinchester"] = {
    label = "Short Winchester Scope",
    weight = 250,
    stack = true,
    close = true,
    description = "A short range scope for Winchester repeaters",
    client = {
        image = "scopeshortwinchester.png",
    }
},

-- Medium scopes
["scopemediumvarmint"] = {
    label = "Medium Varmint Scope",
    weight = 300,
    stack = true,
    close = true,
    description = "A medium range scope for varmint rifles",
    client = {
        image = "scopemediumvarmint.png",
    }
},

-- Long scopes
["scopelongcarcano"] = {
    label = "Long Carcano Scope",
    weight = 350,
    stack = true,
    close = true,
    description = "A long range scope for Carcano rifles",
    client = {
        image = "scopelongcarcano.png",
    }
},

-- Tool
["screwdriver"] = {
    label = "Screwdriver",
    weight = 150,
    stack = false,
    close = true,
    description = "Used for attaching and removing weapon scopes",
    client = {
        image = "screwdriver.png",
    }
},
```

### Shop Integration

```lua
-- In your shop resource (e.g., lxr-shops)
Config.Shops = {
    gunsmith = {
        label = "Gunsmith",
        coords = vector3(-281.33, 780.91, 119.5),
        blip = {sprite = 1, color = 1},
        categories = {
            {
                label = "Weapon Accessories",
                items = {
                    {name = "scopeshortwinchester", price = 25, amount = 10},
                    {name = "scopeshorthenry", price = 25, amount = 10},
                    {name = "scopemediumvarmint", price = 35, amount = 10},
                    {name = "scopelongcarcano", price = 50, amount = 5},
                    {name = "screwdriver", price = 5, amount = 50},
                }
            }
        }
    }
}
```

### API Usage

```lua
-- Client-side
-- Get LXR-Core object
local LXRCore = exports['lxr-core']:GetCoreObject()

-- Get player data
local PlayerData = LXRCore.Functions.GetPlayerData()

-- Server-side
-- Get player object
local Player = LXRCore.Functions.GetPlayer(source)

-- Remove item
Player.Functions.RemoveItem('scopeshortwinchester', 1)

-- Add item
Player.Functions.AddItem('scopeshortwinchester', 1)
```

### Testing

```lua
-- Give test items
/giveitem [id] scopeshortwinchester 1
/giveitem [id] screwdriver 1

-- Test attachment
1. Equip Winchester repeater
2. Use scope item from inventory
3. Verify scope attaches
```

---

## 🎯 RSG-Core Integration

### Overview

**RSG-Core** is a primary framework with full support and modern RedM features.

### Configuration

```lua
Config.Framework = 'rsg' -- or 'auto'

Config.FrameworkSettings.RSG = {
    enabled = true,
    resourceName = 'rsg-core',
    exportName = 'rsg-core',
    events = {
        playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
        playerUnload = 'RSGCore:Client:OnPlayerUnload',
        notify = 'RSGCore:Client:Notify',
    },
    useExports = true,
}
```

### Item Configuration

Add items to RSG-Core:

```lua
-- In rsg-core/shared/items.lua

-- Scope items
scopeshortwinchester = {
    name = "scopeshortwinchester",
    label = "Short Winchester Scope",
    weight = 250,
    type = "item",
    image = "scopeshortwinchester.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = "Short range scope for Winchester repeater"
},

scopemediumvarmint = {
    name = "scopemediumvarmint",
    label = "Medium Varmint Scope",
    weight = 300,
    type = "item",
    image = "scopemediumvarmint.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = "Medium range scope for varmint rifle"
},

-- Tool item
screwdriver = {
    name = "screwdriver",
    label = "Screwdriver",
    weight = 150,
    type = "item",
    image = "screwdriver.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = "Tool for weapon modifications"
},
```

### Inventory Images

Place images in `rsg-inventory/html/images/`:
- scopeshortwinchester.png
- scopeshorthenry.png
- scopemediumvarmint.png
- scopelongcarcano.png
- screwdriver.png

### Shop Configuration

```lua
-- In rsg-shops or similar
Config.Locations = {
    {
        name = "Valentine Gunsmith",
        coords = vector3(-281.33, 780.91, 119.5),
        items = {
            {item = "scopeshortwinchester", price = 25},
            {item = "scopemediumvarmint", price = 35},
            {item = "scopelongcarcano", price = 50},
            {item = "screwdriver", price = 5},
        }
    }
}
```

### API Usage

```lua
-- Client-side
local RSGCore = exports['rsg-core']:GetCoreObject()

-- Server-side
local Player = RSGCore.Functions.GetPlayer(source)
Player.Functions.RemoveItem('scopeshortwinchester', 1)
Player.Functions.AddItem('scopeshortwinchester', 1)
```

---

## 🎯 VORP Core Integration

### Overview

**VORP Core** is a legacy framework with complete support for backward compatibility.

### Configuration

```lua
Config.Framework = 'vorp' -- or 'auto'

Config.FrameworkSettings.VORP = {
    enabled = true,
    resourceName = 'vorp_core',
    inventoryResource = 'vorp_inventory',
    exportName = 'vorp_core',
    events = {
        playerLoaded = 'vorp:SelectedCharacter',
        playerUnload = 'vorp:PlayerForceRespawn',
    },
    useExports = true,
}
```

### Database Setup

**Required:** Run SQL script to add items.

```sql
-- Extra/scopeitems.sql
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
-- Short scopes
('scopeshortwinchester', 'Short Winchester Scope', 10, 1, 'item_standard', 1),
('scopeshorthenry', 'Short Henry Scope', 10, 1, 'item_standard', 1),
('scopeshortevans', 'Short Evans Scope', 10, 1, 'item_standard', 1),
('scopeshortcarbine', 'Short Carbine Scope', 10, 1, 'item_standard', 1),

-- Varmint scopes
('scopeshortvarmint', 'Short Varmint Scope', 10, 1, 'item_standard', 1),
('scopemediumvarmint', 'Medium Varmint Scope', 10, 1, 'item_standard', 1),

-- Bolt action scopes
('scopeshortboltaction', 'Short Bolt Action Scope', 10, 1, 'item_standard', 1),
('scopemediumboltaction', 'Medium Bolt Action Scope', 10, 1, 'item_standard', 1),

-- Springfield scopes
('scopeshortspringfield', 'Short Springfield Scope', 10, 1, 'item_standard', 1),
('scopemediumspringfield', 'Medium Springfield Scope', 10, 1, 'item_standard', 1),

-- Rolling block scopes
('scopeshortrollingblock', 'Short Rolling Block Scope', 10, 1, 'item_standard', 1),
('scopemediumrollingblock', 'Medium Rolling Block Scope', 10, 1, 'item_standard', 1),
('scopelongrollingblock', 'Long Rolling Block Scope', 10, 1, 'item_standard', 1),

-- Carcano scopes
('scopeshortcarcano', 'Short Carcano Scope', 10, 1, 'item_standard', 1),
('scopemediumcarcano', 'Medium Carcano Scope', 10, 1, 'item_standard', 1),
('scopelongcarcano', 'Long Carcano Scope', 10, 1, 'item_standard', 1),

-- Tool
('screwdriver', 'Screwdriver', 5, 1, 'item_standard', 1);
```

### Import SQL

```bash
# Method 1: Command line
mysql -u username -p database_name < Extra/scopeitems.sql

# Method 2: phpMyAdmin
# 1. Navigate to your database
# 2. Click "Import" tab
# 3. Select Extra/scopeitems.sql
# 4. Click "Go"
```

### Verify Installation

```sql
-- Check items exist
SELECT * FROM items WHERE item LIKE 'scope%';
SELECT * FROM items WHERE item = 'screwdriver';

-- Should return 16 scope items + 1 tool
```

### API Usage

```lua
-- Client-side
local VORPcore = exports.vorp_core:GetCore()

-- Server-side
local VorpInv = exports.vorp_inventory:vorp_inventoryApi()

-- Remove item
VorpInv.subItem(source, 'scopeshortwinchester', 1)

-- Add item
VorpInv.addItem(source, 'scopeshortwinchester', 1)
```

### Inventory Integration

The system automatically integrates with `vorp_inventory`. Items are useable directly from the inventory interface.

---

## 🎯 Standalone Integration

### Overview

**Standalone** mode provides basic command-only functionality without framework dependencies.

### Configuration

```lua
Config.Framework = 'standalone' -- or 'auto' with no frameworks

Config.FrameworkSettings.Standalone = {
    enabled = true,
    commandsOnly = true,
}

Config.General = {
    useItems = false,              -- No inventory system
    useCommands = true,            -- Commands only
    requireAttachTool = false,     -- No items available
    requireToolForRemoval = false,
}
```

### Available Commands

```
/addscope              - Attach scope to equipped weapon
/removescope           - Remove scope from equipped weapon
/adminscopeadd         - Admin: Force attach scope
/adminscoperemove      - Admin: Force remove scope
```

### Limitations

| Feature | Available | Alternative |
|---------|-----------|-------------|
| Item System | ❌ No | Use commands |
| Inventory Integration | ❌ No | N/A |
| Tool Requirements | ❌ No | Disabled by default |
| Notifications | ⚠️ Basic | Native game notifications |
| Animations | ✅ Yes | Full support |

### Use Cases

- Testing servers
- Development environments
- Servers without framework
- Quick prototyping
- Admin-only scope management

---

## 🔄 Framework Auto-Detection

### Detection Process

```lua
-- Priority order:
1. Check Config.Framework setting
2. If 'auto', detect available frameworks:
   a. Check for lxr-core resource
   b. Check for rsg-core resource
   c. Check for vorp_core resource
   d. Fallback to standalone
3. Load appropriate adapter
4. Initialize framework integration
```

### Detection Code

```lua
-- Simplified detection logic
function DetectFramework()
    if Config.Framework ~= 'auto' then
        return Config.Framework
    end
    
    if GetResourceState('lxr-core') == 'started' then
        return 'lxr'
    elseif GetResourceState('rsg-core') == 'started' then
        return 'rsg'
    elseif GetResourceState('vorp_core') == 'started' then
        return 'vorp'
    else
        return 'standalone'
    end
end
```

### Verification

Check server console on resource start:

```
[lxr-weapon-scopes] Framework detected: LXR-Core
[lxr-weapon-scopes] Loading LXR-Core adapter...
[lxr-weapon-scopes] Framework integration complete
```

### Troubleshooting Detection

```lua
-- Force specific framework if auto-detection fails
Config.Framework = 'lxr'  -- Force LXR-Core

-- Verify resource names match
Config.FrameworkSettings.LXR.resourceName = 'lxr-core'
Config.FrameworkSettings.RSG.resourceName = 'rsg-core'
Config.FrameworkSettings.VORP.resourceName = 'vorp_core'

-- Check load order in server.cfg
ensure lxr-core
ensure lxr-weapon-scopes  -- Must load AFTER framework
```

---

## 🔧 Framework Adapter API

### Unified Interface

The system provides a unified API across all frameworks:

```lua
-- Notification
Framework.Notify(source, message, type, duration)

-- Item management
Framework.HasItem(source, item, amount)
Framework.RemoveItem(source, item, amount)
Framework.AddItem(source, item, amount)

-- Player data
Framework.GetPlayerData(source)
Framework.GetPlayerIdentifier(source)

-- Permission checks
Framework.HasPermission(source, permission)
```

### Implementation Example

```lua
-- LXR-Core implementation
if Framework.Type == 'lxr' then
    Framework.Notify = function(source, message, type, duration)
        TriggerClientEvent('lxr-core:client:notification:send', source, {
            text = message,
            type = type,
            duration = duration
        })
    end
end

-- RSG-Core implementation
if Framework.Type == 'rsg' then
    Framework.Notify = function(source, message, type, duration)
        TriggerClientEvent('RSGCore:Notify', source, message, type, duration)
    end
end

-- VORP implementation
if Framework.Type == 'vorp' then
    Framework.Notify = function(source, message, type)
        TriggerClientEvent('vorp:NotifyLeft', source, 
            'Weapon Scopes', message, 'generic_textures', 'tick', 4000)
    end
end
```

---

## 🎨 Custom Framework Integration

### Adding New Framework Support

1. **Define Framework Settings**

```lua
-- In config.lua
Config.FrameworkSettings.CustomFramework = {
    enabled = true,
    resourceName = 'custom-core',
    exportName = 'custom-core',
    events = {
        playerLoaded = 'CustomCore:PlayerLoaded',
        playerUnload = 'CustomCore:PlayerUnloaded',
        notify = 'CustomCore:Notify',
    },
    useExports = true,
}
```

2. **Create Framework Adapter**

```lua
-- In server/framework.lua
if Framework.Type == 'custom' then
    Framework.GetCoreObject = function()
        return exports['custom-core']:GetCoreObject()
    end
    
    Framework.GetPlayer = function(source)
        local Core = Framework.GetCoreObject()
        return Core.Functions.GetPlayer(source)
    end
    
    Framework.RemoveItem = function(source, item, amount)
        local Player = Framework.GetPlayer(source)
        return Player.Functions.RemoveItem(item, amount)
    end
    
    -- Implement other required functions...
end
```

3. **Update Detection Logic**

```lua
-- In shared/framework.lua
function DetectFramework()
    -- Add custom framework detection
    if GetResourceState('custom-core') == 'started' then
        return 'custom'
    end
    -- ... existing detection logic
end
```

4. **Test Integration**

```lua
-- Test all functions
Framework.Notify(source, "Test notification", "success")
Framework.HasItem(source, "testitem", 1)
Framework.RemoveItem(source, "testitem", 1)
```

---

## 📚 Framework Comparison

### Feature Comparison

| Feature | LXR-Core | RSG-Core | VORP | Standalone |
|---------|----------|----------|------|------------|
| **Item System** | ✅ Modern | ✅ Modern | ✅ Legacy | ❌ N/A |
| **Inventory UI** | ✅ Native | ✅ Native | ✅ Native | ❌ N/A |
| **Notifications** | ✅ Advanced | ✅ Modern | ✅ Classic | ⚠️ Basic |
| **Permission System** | ✅ Full | ✅ Full | ✅ Full | ⚠️ Basic |
| **Player Management** | ✅ Full | ✅ Full | ✅ Full | ❌ N/A |
| **Database Integration** | ✅ Automatic | ✅ Automatic | ⚠️ Manual | ❌ N/A |
| **Development Status** | 🟢 Active | 🟢 Active | 🟡 Maintenance | 🔵 Stable |

### Performance Comparison

| Framework | Resource Usage | Network Traffic | Database Queries |
|-----------|----------------|-----------------|------------------|
| **LXR-Core** | Low | Minimal | 0 per operation |
| **RSG-Core** | Low | Minimal | 0 per operation |
| **VORP** | Medium | Moderate | 0 per operation |
| **Standalone** | Minimal | Minimal | 0 |

---

## 🆘 Framework-Specific Troubleshooting

### LXR-Core Issues

```lua
-- Check LXR-Core is running
GetResourceState('lxr-core') -- Should return 'started'

-- Verify export access
local Core = exports['lxr-core']:GetCoreObject()
print(Core) -- Should not be nil

-- Check item definitions
-- Items must exist in lxr-core/shared/items.lua
```

### RSG-Core Issues

```lua
-- Verify RSG-Core loaded
GetResourceState('rsg-core') -- Should return 'started'

-- Check inventory resource
GetResourceState('rsg-inventory') -- Should be running

-- Verify item images exist
-- Check: rsg-inventory/html/images/
```

### VORP Issues

```sql
-- Verify database items
SELECT * FROM items WHERE item = 'scopeshortwinchester';
-- Should return item row

-- Check vorp_inventory
GetResourceState('vorp_inventory') -- Should be 'started'

-- Test item usage
/additem [id] scopeshortwinchester 1
```

### Standalone Issues

```lua
-- Verify standalone detected
-- Check console for: "Framework detected: Standalone"

-- Ensure items disabled
Config.General.useItems = false
Config.General.requireAttachTool = false

-- Test commands
/addscope -- Should work immediately
```

---

```
╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                               ║
║   Made with 🐺 by The Lux Empire for The Land of Wolves                                      ║
║   Georgian RP 🇬🇪 | ისტორია ცოცხლდება აქ! (History Lives Here!)                            ║
║                                                                                               ║
║   © 2024-2026 The Lux Empire | wolves.land                                                   ║
║   All Rights Reserved - Licensed for wolves.land use                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```
