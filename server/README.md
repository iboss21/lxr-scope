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
║   🐺 Server Scripts - The Land of Wolves                                                     ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# Server Scripts

This directory contains server-side scripts for the Wolves Weapon Scope System.

## 📁 Files

### `main.lua`
**Main server script** - Handles all server-side scope operations including:
- Item management and validation
- Security and anti-cheat protection
- Framework integration
- Admin command handling
- Logging and monitoring

## 🎯 Responsibilities

The server scripts are responsible for:

1. **Item Management**
   - Registering usable scope items
   - Adding/removing items from inventory
   - Validating inventory space
   - Handling tool requirements

2. **Security & Validation**
   - Server-side cooldown enforcement
   - Item existence validation
   - Player permission checking
   - Suspicious activity logging
   - Distance validation (anti-teleport)

3. **Framework Integration**
   - Item system integration (LXR/RSG/VORP)
   - Notification system routing
   - Permission system integration
   - Inventory API calls

4. **Administration**
   - Admin command handling
   - Admin action logging
   - Permission validation

## 🔧 Key Functions

### Item Management
```lua
HandleScopeItemUse(source, itemName, weaponType, scopeType)
ValidateScopeItem(itemName, weaponType)
HasRequiredTool(source)
```

### Security
```lua
IsOnCooldown(source, action)
SetCooldown(source, action)
LogSuspicious(source, reason)
```

### Inventory Operations
```lua
Framework.GetItemCount(source, itemName)
Framework.AddItem(source, itemName, amount)
Framework.RemoveItem(source, itemName, amount)
Framework.CanCarryItem(source, itemName, amount)
```

## 📡 Events Handled

### Client → Server
- `lxr-scopes:server:ScopeAttached` - Confirm attachment
- `lxr-scopes:server:ReturnScopeItem` - Return scope item

### Server → Client
- `lxr-scopes:client:AttachScope` - Trigger attachment
- `lxr-scopes:client:RemoveScope` - Trigger removal
- `lxr-scopes:client:AdminAttachScope` - Admin attach
- `lxr-scopes:client:AdminRemoveScope` - Admin remove

## 🔒 Security Features

### Anti-Cheat
- **Cooldown System** - Prevents rapid-fire abuse
- **Item Validation** - Verifies item exists in config
- **Inventory Checks** - Confirms player has items
- **Permission Checks** - Validates admin access
- **Activity Logging** - Tracks suspicious behavior

### Server Authority
All operations require server approval:
1. Client requests action
2. Server validates request
3. Server modifies inventory
4. Server triggers client effect
5. Server logs action

### Logging
```lua
-- Suspicious Activity
Player: PlayerName (license:xxx) | Reason: Failed to remove scope item

-- Admin Actions  
[ADMIN] PlayerName used admin add scope command
```

## 🚀 Performance

- **Minimal overhead** - Event-driven architecture
- **Efficient validation** - Early return on failure
- **Cached data** - Framework objects cached
- **Batch operations** - Multiple items registered at once

## 📊 Monitoring

### Debug Mode
Enable `Config.Debug = true` for detailed logging:
- Framework detection
- Item registration
- Scope operations
- Player actions
- Validation results

### Production Logging
- Suspicious activity (always logged if enabled)
- Admin actions (logged if enabled)
- Critical errors (always logged)

## 🛡️ Best Practices

1. **Never trust client data** - All validation server-side
2. **Log suspicious activity** - Track potential exploiters
3. **Use cooldowns** - Prevent spam and abuse
4. **Validate permissions** - Always check admin access
5. **Monitor logs** - Review suspicious activity regularly

## 📚 Documentation

For more information, see:
- [Main Documentation](../README.md)
- [Security Guide](../docs/security.md)
- [Events Reference](../docs/events.md)
- [Framework Integration](../docs/frameworks.md)

---

**© 2024-2026 The Lux Empire | wolves.land**  
*Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!*
