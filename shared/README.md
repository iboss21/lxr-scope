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
║   🐺 Shared Scripts - The Land of Wolves                                                     ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# Shared Scripts

This directory contains shared scripts that run on both client and server for the Wolves Weapon Scope System.

## 📁 Files

### `framework.lua`
**Framework Adapter Layer** - Provides unified API across all supported frameworks:
- Automatic framework detection
- Framework initialization
- Unified API functions
- Cross-framework compatibility

## 🎯 Purpose

The framework adapter serves as a **translation layer** between the scope system and various RedM frameworks, allowing the same codebase to work seamlessly across:

- **LXR-Core** (Primary)
- **RSG-Core** (Primary)
- **VORP Core** (Supported/Legacy)
- **Standalone** (Basic)

## 🔧 Key Components

### Framework Detection
```lua
Framework.Type     -- Detected framework: 'lxr', 'rsg', 'vorp', 'standalone'
Framework.Object   -- Framework core object (if applicable)
Framework.Ready    -- Initialization status boolean
```

### Detection Priority
1. LXR-Core (if `lxr-core` resource started)
2. RSG-Core (if `rsg-core` resource started)
3. VORP Core (if `vorp_core` resource started)
4. Standalone (fallback)

### Initialization
The adapter automatically:
- Detects available frameworks via `GetResourceState()`
- Loads framework core object via exports
- Waits for framework readiness
- Sets `Framework.Ready = true` when complete

## 📚 Unified API

The adapter provides consistent functions regardless of framework:

### Notifications
```lua
Framework.Notify(source, message, type, duration)
-- Works on: LXR, RSG, VORP, Standalone
-- Automatically routes to correct notification system
```

### Permissions (Server-Side)
```lua
Framework.HasPermission(source, permission)
-- Checks player permissions across frameworks
```

### Inventory (Server-Side)
```lua
Framework.GetItemCount(source, itemName)
Framework.AddItem(source, itemName, amount)
Framework.RemoveItem(source, itemName, amount)
Framework.CanCarryItem(source, itemName, amount)
Framework.CloseInventory(source)
```

### Item Registration (Server-Side)
```lua
Framework.RegisterUsableItem(itemName, callback)
-- Registers usable items across frameworks
```

## 🔄 Framework-Specific Handling

### LXR-Core
```lua
-- Export-based initialization
Framework.Object = exports['lxr-core']:GetCoreObject()

-- Events
Config.FrameworkSettings.LXR.events = {
    playerLoaded = 'LXR:Client:OnPlayerLoaded',
    notify = 'lxr-core:client:notification:send',
}
```

### RSG-Core
```lua
-- Export-based initialization
Framework.Object = exports['rsg-core']:GetCoreObject()

-- Events
Config.FrameworkSettings.RSG.events = {
    playerLoaded = 'RSGCore:Client:OnPlayerLoaded',
    notify = 'RSGCore:Client:Notify',
}
```

### VORP Core
```lua
-- Export-based initialization
Framework.Object = exports['vorp_core']:GetCore()

-- Events
Config.FrameworkSettings.VORP.events = {
    playerLoaded = 'vorp:SelectedCharacter',
}

-- Inventory via vorp_inventory
exports['vorp_inventory']:addItem(...)
```

### Standalone
```lua
-- No framework object needed
-- Falls back to native functions and chat messages
```

## 🎮 Usage in Scripts

### Client Example
```lua
-- Notification (works on any framework)
Framework.Notify(source, "Scope attached!", "success")

-- Wait for framework ready
while not Framework.Ready do
    Wait(100)
end
```

### Server Example
```lua
-- Get item count (works on any framework)
local count = Framework.GetItemCount(source, "scopeshortwinchester")

-- Add item (works on any framework)
Framework.AddItem(source, "scopeshortwinchester", 1)

-- Register usable item (works on any framework)
Framework.RegisterUsableItem("scopeshortwinchester", function(data)
    -- Handle item use
end)
```

## 🔧 Configuration

Framework settings are in `config.lua`:

```lua
Config.Framework = 'auto' -- or 'lxr', 'rsg', 'vorp', 'standalone'

Config.FrameworkSettings = {
    LXR = { enabled = true, resourceName = 'lxr-core', ... },
    RSG = { enabled = true, resourceName = 'rsg-core', ... },
    VORP = { enabled = true, resourceName = 'vorp_core', ... },
    Standalone = { enabled = true, commandsOnly = true },
}
```

## 🚀 Benefits

### For Developers
- **Write once, run anywhere** - Single codebase for all frameworks
- **Easy maintenance** - Changes in one place
- **Clear abstraction** - Framework details hidden
- **Type safety** - Consistent function signatures

### For Server Owners
- **Easy migration** - Switch frameworks without code changes
- **Future-proof** - New frameworks easy to add
- **Tested** - Works across multiple environments
- **Documented** - Clear integration points

## 📊 Performance

- **Minimal overhead** - Direct function calls after init
- **One-time detection** - Cached framework type
- **No polling** - Event-driven architecture
- **Efficient exports** - Framework objects cached

## 🔍 Debugging

Enable `Config.Debug = true` to see:
- Framework detection results
- Initialization status
- API function calls
- Framework-specific routing

Example output:
```
[Wolves Scopes] Framework detected: rsg
[Wolves Scopes] RSG-Core initialized
[Wolves Scopes] Framework adapter loaded successfully
```

## 📚 Documentation

For more information, see:
- [Main Documentation](../README.md)
- [Framework Integration Guide](../docs/frameworks.md)
- [API Reference](../docs/events.md)
- [Configuration Guide](../docs/configuration.md)

---

**© 2024-2026 The Lux Empire | wolves.land**  
*Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!*
