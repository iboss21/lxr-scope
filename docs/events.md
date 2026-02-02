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
║   🐺 Events & API Reference                                                                  ║
║   Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# 📡 Events & API Reference

Complete reference for events, exports, and API functions.

---

## 📋 Table of Contents

- [Client Events](#-client-events)
- [Server Events](#-server-events)
- [Client Exports](#-client-exports)
- [Server Exports](#-server-exports)
- [Native Functions](#-native-functions)
- [Custom Triggers](#-custom-triggers)
- [Integration Examples](#-integration-examples)

---

## 📤 Client Events

### Scope Attachment Events

#### `lxr-weapon-scopes:client:attachScope`

Triggers scope attachment on client.

**Direction:** Server → Client

**Parameters:**
```lua
{
    weaponHash = number,    -- Weapon hash
    componentHash = number, -- Scope component hash
    scopeType = string,     -- Scope type ('short', 'medium', 'long')
    playAnimation = boolean -- Whether to play animation
}
```

**Example:**
```lua
-- Server triggers client to attach scope
TriggerClientEvent('lxr-weapon-scopes:client:attachScope', source, {
    weaponHash = GetHashKey('WEAPON_REPEATER_WINCHESTER'),
    componentHash = -404520310,
    scopeType = 'short',
    playAnimation = true
})
```

#### `lxr-weapon-scopes:client:removeScope`

Triggers scope removal on client.

**Direction:** Server → Client

**Parameters:**
```lua
{
    weaponHash = number,    -- Weapon hash
    componentHash = number, -- Scope component hash
    playAnimation = boolean -- Whether to play animation
}
```

**Example:**
```lua
-- Server triggers client to remove scope
TriggerClientEvent('lxr-weapon-scopes:client:removeScope', source, {
    weaponHash = GetHashKey('WEAPON_REPEATER_WINCHESTER'),
    componentHash = -404520310,
    playAnimation = true
})
```

### Item Usage Events

#### Framework-Specific Item Events

**LXR-Core:**
```lua
-- Item use trigger
RegisterNetEvent('lxr-core:client:UseItem', function(itemName)
    if itemName:match("^scope") then
        -- Scope item used
        TriggerServerEvent('lxr-weapon-scopes:server:attachScopeItem', itemName)
    elseif itemName == 'screwdriver' then
        -- Tool used
        TriggerServerEvent('lxr-weapon-scopes:server:removeScopeItem')
    end
end)
```

**RSG-Core:**
```lua
-- Item use trigger
RegisterNetEvent('RSGCore:Client:UseItem', function(itemName)
    -- Similar to LXR-Core
end)
```

**VORP:**
```lua
-- Item use trigger (handled by vorp_inventory)
exports.vorp_inventory:registerUsableItem('scopeshortwinchester', function(data)
    TriggerServerEvent('lxr-weapon-scopes:server:attachScopeItem', 'scopeshortwinchester')
end)
```

---

## 📥 Server Events

### Scope Operation Events

#### `lxr-weapon-scopes:server:attachScopeItem`

Handles scope attachment via item usage.

**Direction:** Client → Server

**Parameters:**
```lua
itemName = string -- Scope item name
```

**Example:**
```lua
-- Client sends attachment request
TriggerServerEvent('lxr-weapon-scopes:server:attachScopeItem', 'scopeshortwinchester')
```

**Server Handler:**
```lua
RegisterNetEvent('lxr-weapon-scopes:server:attachScopeItem', function(scopeItem)
    local source = source
    
    -- Validate player has item
    if not Framework.HasItem(source, scopeItem, 1) then
        return
    end
    
    -- Validate cooldown
    if not CheckCooldown(source) then
        return
    end
    
    -- Process attachment
    -- Remove item
    Framework.RemoveItem(source, scopeItem, 1)
    
    -- Trigger client attachment
    TriggerClientEvent('lxr-weapon-scopes:client:attachScope', source, data)
end)
```

#### `lxr-weapon-scopes:server:removeScopeItem`

Handles scope removal via tool usage.

**Direction:** Client → Server

**Parameters:** None

**Example:**
```lua
-- Client sends removal request
TriggerServerEvent('lxr-weapon-scopes:server:removeScopeItem')
```

#### `lxr-weapon-scopes:server:attachScopeCommand`

Handles scope attachment via command.

**Direction:** Client → Server

**Parameters:** None

**Example:**
```lua
-- Client sends command-based attachment
TriggerServerEvent('lxr-weapon-scopes:server:attachScopeCommand')
```

#### `lxr-weapon-scopes:server:removeScopeCommand`

Handles scope removal via command.

**Direction:** Client → Server

**Parameters:** None

---

## 🔌 Client Exports

### HasScope

Check if weapon has scope attached.

**Export Name:** `HasScope`

**Parameters:**
```lua
weaponHash = number -- Weapon hash to check
```

**Returns:**
```lua
boolean -- true if weapon has scope, false otherwise
```

**Example:**
```lua
-- Check if current weapon has scope
local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
local hasScope = exports['lxr-weapon-scopes']:HasScope(currentWeapon)

if hasScope then
    print("Weapon has scope attached")
else
    print("Weapon has no scope")
end
```

### GetEquippedWeapon

Get currently equipped weapon hash.

**Export Name:** `GetEquippedWeapon`

**Parameters:** None

**Returns:**
```lua
number -- Weapon hash, or nil if no weapon equipped
```

**Example:**
```lua
-- Get equipped weapon
local weapon = exports['lxr-weapon-scopes']:GetEquippedWeapon()

if weapon then
    print("Equipped weapon:", weapon)
else
    print("No weapon equipped")
end
```

### GetScopeInfo

Get scope information for a weapon.

**Export Name:** `GetScopeInfo`

**Parameters:**
```lua
weaponHash = number -- Weapon hash
```

**Returns:**
```lua
{
    component = number,  -- Component hash
    type = string,       -- Scope type
    itemName = string    -- Corresponding item name
} or nil if weapon doesn't support scopes
```

**Example:**
```lua
-- Get scope info for Winchester
local winchester = GetHashKey('WEAPON_REPEATER_WINCHESTER')
local scopeInfo = exports['lxr-weapon-scopes']:GetScopeInfo(winchester)

if scopeInfo then
    print("Component:", scopeInfo.component)
    print("Type:", scopeInfo.type)
    print("Item:", scopeInfo.itemName)
end
```

### IsWeaponSupported

Check if weapon supports scopes.

**Export Name:** `IsWeaponSupported`

**Parameters:**
```lua
weaponHash = number -- Weapon hash to check
```

**Returns:**
```lua
boolean -- true if weapon supports scopes
```

**Example:**
```lua
-- Check weapon support
local weapon = GetHashKey('WEAPON_PISTOL_VOLCANIC')
local supported = exports['lxr-weapon-scopes']:IsWeaponSupported(weapon)

if supported then
    print("This weapon supports scopes")
else
    print("This weapon does not support scopes")
end
```

---

## 🔌 Server Exports

### AttachScope

Programmatically attach scope to player's weapon.

**Export Name:** `AttachScope`

**Parameters:**
```lua
source = number,      -- Player server ID
weaponHash = number,  -- Weapon hash
removeItem = boolean  -- Whether to remove scope item (optional, default: true)
```

**Returns:**
```lua
boolean -- true if successful, false otherwise
```

**Example:**
```lua
-- Attach scope from another resource
local success = exports['lxr-weapon-scopes']:AttachScope(
    source, 
    GetHashKey('WEAPON_REPEATER_WINCHESTER'),
    false  -- Don't remove item
)

if success then
    print("Scope attached successfully")
else
    print("Failed to attach scope")
end
```

### RemoveScope

Programmatically remove scope from player's weapon.

**Export Name:** `RemoveScope`

**Parameters:**
```lua
source = number,     -- Player server ID
weaponHash = number, -- Weapon hash
returnItem = boolean -- Whether to return scope item (optional, default: true)
```

**Returns:**
```lua
boolean -- true if successful, false otherwise
```

**Example:**
```lua
-- Remove scope from another resource
local success = exports['lxr-weapon-scopes']:RemoveScope(
    source,
    GetHashKey('WEAPON_REPEATER_WINCHESTER'),
    true  -- Return item to player
)

if success then
    print("Scope removed successfully")
else
    print("Failed to remove scope")
end
```

### HasScopeItem

Check if player has a specific scope item.

**Export Name:** `HasScopeItem`

**Parameters:**
```lua
source = number,   -- Player server ID
itemName = string  -- Scope item name
```

**Returns:**
```lua
boolean -- true if player has item
```

**Example:**
```lua
-- Check if player has scope item
local hasItem = exports['lxr-weapon-scopes']:HasScopeItem(
    source,
    'scopeshortwinchester'
)

if hasItem then
    print("Player has Winchester scope")
end
```

### GetPlayerCooldown

Get player's remaining cooldown time.

**Export Name:** `GetPlayerCooldown`

**Parameters:**
```lua
source = number -- Player server ID
```

**Returns:**
```lua
number -- Remaining cooldown in milliseconds, or 0 if no cooldown
```

**Example:**
```lua
-- Check player cooldown
local cooldown = exports['lxr-weapon-scopes']:GetPlayerCooldown(source)

if cooldown > 0 then
    print("Player must wait " .. cooldown .. "ms")
else
    print("No cooldown active")
end
```

---

## 🎮 Native Functions

### Weapon Component Functions

#### GiveWeaponComponentToPed

Attach weapon component to ped.

**Native:** `GiveWeaponComponentToPed`

```lua
GiveWeaponComponentToPed(
    ped,           -- Ped handle
    weaponHash,    -- Weapon hash
    componentHash, -- Component hash
    bForceInHand   -- Force weapon in hand (true)
)
```

**Example:**
```lua
-- Attach short scope to Winchester
local ped = PlayerPedId()
local weapon = GetHashKey('WEAPON_REPEATER_WINCHESTER')
local component = -404520310

GiveWeaponComponentToPed(ped, weapon, component, true)
```

#### RemoveWeaponComponentFromPed

Remove weapon component from ped.

**Native:** `RemoveWeaponComponentFromPed`

```lua
RemoveWeaponComponentFromPed(
    ped,           -- Ped handle
    weaponHash,    -- Weapon hash
    componentHash  -- Component hash
)
```

**Example:**
```lua
-- Remove scope from Winchester
local ped = PlayerPedId()
local weapon = GetHashKey('WEAPON_REPEATER_WINCHESTER')
local component = -404520310

RemoveWeaponComponentFromPed(ped, weapon, component)
```

#### HasPedGotWeaponComponent

Check if ped has weapon component.

**Native:** `HasPedGotWeaponComponent`

```lua
local hasComponent = HasPedGotWeaponComponent(
    ped,           -- Ped handle
    weaponHash,    -- Weapon hash
    componentHash  -- Component hash
)
```

**Example:**
```lua
-- Check if weapon has scope
local ped = PlayerPedId()
local weapon = GetHashKey('WEAPON_REPEATER_WINCHESTER')
local component = -404520310

local hasScope = HasPedGotWeaponComponent(ped, weapon, component)
if hasScope then
    print("Scope is attached")
end
```

### Weapon Functions

#### GetCurrentPedWeapon

Get ped's currently equipped weapon.

**Native:** `GetCurrentPedWeapon`

```lua
local weaponHash = GetCurrentPedWeapon(
    ped,           -- Ped handle
    lastWeapon     -- Get last weapon (false for current)
)
```

**Example:**
```lua
-- Get player's current weapon
local ped = PlayerPedId()
local weapon = GetCurrentPedWeapon(ped, false)

print("Current weapon hash:", weapon)
```

#### SetCurrentPedWeapon

Set ped's current weapon.

**Native:** `SetCurrentPedWeapon`

```lua
SetCurrentPedWeapon(
    ped,           -- Ped handle
    weaponHash,    -- Weapon hash to equip
    bForceInHand   -- Force in hand (true)
)
```

**Example:**
```lua
-- Equip Winchester
local ped = PlayerPedId()
local weapon = GetHashKey('WEAPON_REPEATER_WINCHESTER')

SetCurrentPedWeapon(ped, weapon, true)
```

---

## 🎯 Custom Triggers

### Creating Custom Scope Attachment

```lua
-- Custom scope attachment with validation
RegisterCommand('customscope', function()
    local ped = PlayerPedId()
    local weapon = GetCurrentPedWeapon(ped, false)
    
    -- Check if weapon supports scopes
    local scopeInfo = exports['lxr-weapon-scopes']:GetScopeInfo(weapon)
    
    if not scopeInfo then
        print("This weapon doesn't support scopes")
        return
    end
    
    -- Check if already has scope
    if HasPedGotWeaponComponent(ped, weapon, scopeInfo.component) then
        print("Weapon already has a scope")
        return
    end
    
    -- Trigger server-side attachment
    TriggerServerEvent('custom:attachScope', weapon)
end)

-- Server-side handler
RegisterNetEvent('custom:attachScope', function(weaponHash)
    local source = source
    
    -- Your custom validation logic here
    -- ...
    
    -- Use export to attach scope
    exports['lxr-weapon-scopes']:AttachScope(source, weaponHash, false)
end)
```

### Integration with Crafting System

```lua
-- Server-side crafting integration
RegisterNetEvent('crafting:createScope', function(scopeType)
    local source = source
    
    -- Check player has materials
    local hasMaterials = CheckCraftingMaterials(source, scopeType)
    
    if not hasMaterials then
        return
    end
    
    -- Remove materials
    RemoveCraftingMaterials(source, scopeType)
    
    -- Determine scope item
    local scopeItem = 'scopeshort' .. scopeType
    
    -- Give scope item
    Framework.AddItem(source, scopeItem, 1)
    
    -- Notify player
    Framework.Notify(source, "Scope crafted successfully", "success")
end)
```

### Integration with Weapon Shop

```lua
-- Shop purchase handler
RegisterNetEvent('shop:purchaseScope', function(weaponType, scopeType)
    local source = source
    local price = Config.ScopePrices[scopeType]
    
    -- Check player money
    if not HasMoney(source, price) then
        Framework.Notify(source, "Insufficient funds", "error")
        return
    end
    
    -- Remove money
    RemoveMoney(source, price)
    
    -- Determine scope item
    local scopeItem = 'scope' .. scopeType .. weaponType
    
    -- Give scope
    Framework.AddItem(source, scopeItem, 1)
    
    -- Notify
    Framework.Notify(source, "Scope purchased", "success")
end)
```

---

## 📊 Event Flow Diagrams

### Item-Based Attachment Flow

```
Player                  Client                  Server                  Framework
  |                       |                       |                       |
  |-- Use Scope Item ---->|                       |                       |
  |                       |--- Validate Weapon -->|                       |
  |                       |                       |                       |
  |                       |-- Attachment Request->|                       |
  |                       |                       |--- Validate Item ---->|
  |                       |                       |<-- Item Confirmed ----|
  |                       |                       |                       |
  |                       |                       |--- Remove Item ------>|
  |                       |                       |<-- Item Removed ------|
  |                       |                       |                       |
  |                       |<- Attach Scope -------|                       |
  |                       |-- Play Animation ---->|                       |
  |                       |-- Attach Component -->|                       |
  |                       |-- Show Notification ->|                       |
  |<-- Scope Attached ----|                       |                       |
```

### Command-Based Attachment Flow

```
Player                  Client                  Server
  |                       |                       |
  |-- /addscope --------->|                       |
  |                       |--- Validate Weapon -->|
  |                       |                       |
  |                       |-- Command Request --->|
  |                       |                       |--- Validate Cooldown
  |                       |                       |--- Validate Support
  |                       |                       |
  |                       |<- Attach Scope -------|
  |                       |-- Attach Component -->|
  |<-- Scope Attached ----|                       |
```

---

## 🔨 Advanced API Usage

### Scope Management Class

```lua
-- Create a scope management wrapper
ScopeManager = {}

function ScopeManager:new()
    local obj = {
        playerScopes = {}
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function ScopeManager:attachScope(source, weaponHash)
    local success = exports['lxr-weapon-scopes']:AttachScope(source, weaponHash, true)
    
    if success then
        self.playerScopes[source] = self.playerScopes[source] or {}
        table.insert(self.playerScopes[source], weaponHash)
    end
    
    return success
end

function ScopeManager:removeScope(source, weaponHash)
    local success = exports['lxr-weapon-scopes']:RemoveScope(source, weaponHash, true)
    
    if success and self.playerScopes[source] then
        for i, weapon in ipairs(self.playerScopes[source]) do
            if weapon == weaponHash then
                table.remove(self.playerScopes[source], i)
                break
            end
        end
    end
    
    return success
end

function ScopeManager:getPlayerScopes(source)
    return self.playerScopes[source] or {}
end

-- Usage
local scopeMgr = ScopeManager:new()
scopeMgr:attachScope(source, GetHashKey('WEAPON_REPEATER_WINCHESTER'))
```

### Batch Scope Operations

```lua
-- Attach scopes to multiple weapons
function AttachScopesToAllWeapons(source)
    local supportedWeapons = {
        'WEAPON_REPEATER_WINCHESTER',
        'WEAPON_REPEATER_HENRY',
        'WEAPON_RIFLE_VARMINT',
        'WEAPON_SNIPERRIFLE_CARCANO',
    }
    
    local results = {}
    
    for _, weaponName in ipairs(supportedWeapons) do
        local weaponHash = GetHashKey(weaponName)
        local success = exports['lxr-weapon-scopes']:AttachScope(
            source, 
            weaponHash, 
            false  -- Don't remove items
        )
        
        results[weaponName] = success
    end
    
    return results
end
```

---

## 📚 Integration Examples

### Example 1: Weapon Rental System

```lua
-- Give player temporary weapon with scope
RegisterNetEvent('rental:giveWeapon', function(weaponType)
    local source = source
    local weaponHash = GetHashKey(weaponType)
    
    -- Give weapon
    GiveWeaponToPed(GetPlayerPed(source), weaponHash, 100, false, true)
    
    -- Attach scope
    Wait(100)
    exports['lxr-weapon-scopes']:AttachScope(source, weaponHash, false)
    
    -- Start rental timer
    StartRentalTimer(source, weaponHash)
end)
```

### Example 2: Achievement System

```lua
-- Track scope attachments for achievements
local playerScopeStats = {}

RegisterNetEvent('achievements:trackScopeAttachment', function()
    local source = source
    
    playerScopeStats[source] = (playerScopeStats[source] or 0) + 1
    
    -- Check for achievement
    if playerScopeStats[source] >= 10 then
        GiveAchievement(source, 'scope_master')
    end
end)
```

### Example 3: Repair System

```lua
-- Scope repair mechanic
RegisterNetEvent('repair:fixScope', function(weaponHash)
    local source = source
    
    -- Check weapon condition
    local condition = GetWeaponCondition(source, weaponHash)
    
    if condition < 50 then
        -- Remove damaged scope
        exports['lxr-weapon-scopes']:RemoveScope(source, weaponHash, false)
        
        -- Charge repair fee
        RemoveMoney(source, 10)
        
        -- Re-attach repaired scope
        Wait(2000)
        exports['lxr-weapon-scopes']:AttachScope(source, weaponHash, false)
    end
end)
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
