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
║   🐺 Client Scripts - The Land of Wolves                                                     ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# Client Scripts

This directory contains client-side scripts for the Wolves Weapon Scope System.

## 📁 Files

### `main.lua`
**Main client script** - Handles all client-side scope operations including:
- Weapon component attachment/removal
- Animation playback
- Player interaction processing
- Cooldown management
- Event handlers for server communication

## 🎯 Responsibilities

The client scripts are responsible for:

1. **Weapon Management**
   - Detecting currently equipped weapon
   - Checking for attached scope components
   - Attaching/removing scope components

2. **User Interface**
   - Playing attachment/removal animations
   - Displaying notifications via framework adapter
   - Handling command input (standalone mode)

3. **Security**
   - Client-side cooldown enforcement
   - Validation of weapon compatibility
   - Event coordination with server

4. **Performance**
   - Minimal tick usage
   - Efficient native function calls
   - Cached player ped references

## 🔧 Key Functions

### Scope Operations
```lua
AttachScope(weaponHash)    -- Attach scope to weapon
RemoveScope(weaponHash)    -- Remove scope from weapon
HasScopeAttached(weapon)   -- Check if scope is attached
GetCurrentWeapon()         -- Get equipped weapon hash
```

### Animation & UI
```lua
PlayScopeAnimation()       -- Play attachment animation
```

### Security
```lua
IsOnCooldown(action)       -- Check cooldown status
SetCooldown(action)        -- Set cooldown timer
```

## 📡 Events Handled

### Server → Client
- `lxr-scopes:client:AttachScope` - Attach scope after item use
- `lxr-scopes:client:RemoveScope` - Remove scope via tool
- `lxr-scopes:client:AdminAttachScope` - Admin force attach
- `lxr-scopes:client:AdminRemoveScope` - Admin force remove

### Client → Server
- `lxr-scopes:server:ScopeAttached` - Confirm attachment
- `lxr-scopes:server:ReturnScopeItem` - Return item on removal

## 🚀 Performance

- **Idle:** 0.00ms (no active threads)
- **Active:** 0.01ms (during operations)
- **Optimization:** Uses event-driven architecture, no constant loops

## 🔒 Security Features

- Client-side cooldown prevention
- Weapon compatibility validation
- Server confirmation required for all operations
- No direct inventory manipulation

## 📚 Documentation

For more information, see:
- [Main Documentation](../README.md)
- [Events Reference](../docs/events.md)
- [Framework Integration](../docs/frameworks.md)

---

**© 2024-2026 The Lux Empire | wolves.land**  
*Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!*
