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
║   🐺 Weapon Scope System - The Land of Wolves Edition                                        ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# 🐺 Wolves Weapon Scope System

**Version:** 2.0.0 (Land of Wolves Edition)  
**Original:** Zeus Script  
**Converted by:** iBoss21 / The Lux Empire  
**Server:** [The Land of Wolves](https://www.wolves.land) 🐺

---

## 📋 Description

Advanced weapon scope attachment system with multi-framework support. Allows players to dynamically attach and remove scopes to weapons via commands or inventory items with realistic animations, comprehensive validation, and anti-cheat protection.

**Perfect for:** Serious Hardcore Roleplay servers requiring realistic weapon modification systems.

---

## ✨ Features

### Core Features
- ✅ **Multi-Framework Support** - Auto-detects and supports LXR-Core, RSG-Core, VORP, and Standalone
- ✅ **Dynamic Scope System** - Attach/remove scopes to 16+ different weapons
- ✅ **Realistic Animations** - Configurable attachment/removal animations
- ✅ **Item-Based System** - Use inventory items to attach scopes
- ✅ **Tool Requirements** - Optional requirement for specialized tools
- ✅ **Admin Commands** - Administrative scope management commands

### Advanced Features
- ✅ **Framework Adapter Layer** - Unified API across all frameworks
- ✅ **Security & Anti-Cheat** - Server-side validation and cooldown systems
- ✅ **Resource Name Protection** - Prevents misconfiguration issues
- ✅ **Comprehensive Logging** - Debug and suspicious activity tracking
- ✅ **Performance Optimized** - 0.00ms idle, 0.01ms active
- ✅ **Fully Configurable** - Everything adjustable via config.lua

### Framework Support
| Framework | Status | Features |
|-----------|--------|----------|
| **LXR-Core** | ✅ Primary | Full support with native integration |
| **RSG-Core** | ✅ Primary | Full support with native integration |
| **VORP Core** | ✅ Supported | Complete legacy functionality |
| **Standalone** | ✅ Basic | Command-only mode |

---

## 📦 Installation

### 1. Download & Extract
```bash
# Download the resource
# Extract to your resources folder
# Rename to: lxr-weapon-scopes (IMPORTANT!)
```

### 2. Database Setup (Framework Users Only)
```bash
# For VORP users only:
# Run Extra/scopeitems.sql in your database
# This adds scope items to your items table
```

### 3. Server Configuration
```cfg
# Add to your server.cfg
ensure lxr-weapon-scopes
```

### 4. Framework Configuration (Optional)
```lua
# Edit config.lua
Config.Framework = 'auto'  -- Will auto-detect
# Or specify: 'lxr', 'rsg', 'vorp', 'standalone'
```

---

## 🎮 Usage

### For Players

#### With Items (LXR/RSG/VORP)
1. Obtain a scope item from shop/crafting
2. Equip the weapon you want to modify
3. Use the scope item from your inventory
4. (Optional) Use screwdriver to remove scope

#### With Commands (Standalone)
```
/addscope     - Attach scope to equipped weapon
/removescope  - Remove scope from equipped weapon
```

### For Admins
```
/adminscopeadd    - Force attach scope (any framework)
/adminscoperemove - Force remove scope (any framework)
```

---

## 🛠️ Configuration

All settings are in `config.lua`. Key sections include:

- **Server Information** - Branding and server details
- **Framework Settings** - Auto-detection and framework-specific settings
- **General Settings** - Feature toggles
- **Item Settings** - Scope and tool item names
- **Weapon Components** - Weapon-to-scope mappings
- **Notifications** - Notification messages and types
- **Security** - Anti-abuse and validation settings
- **Performance** - Optimization settings
- **Debug** - Development debugging

See [Configuration Guide](/docs/configuration.md) for detailed information.

---

## 📚 Documentation

- [Overview](/docs/overview.md) - System overview and architecture
- [Installation](/docs/installation.md) - Detailed installation guide
- [Configuration](/docs/configuration.md) - Complete configuration reference
- [Frameworks](/docs/frameworks.md) - Framework integration details
- [Events](/docs/events.md) - Event and API reference
- [Security](/docs/security.md) - Security features and best practices
- [Performance](/docs/performance.md) - Performance optimization guide
- [Screenshots](/docs/screenshots.md) - Visual documentation

---

## 🔒 Security Features

- ✅ Server-side validation for all scope operations
- ✅ Cooldown system to prevent spam/abuse
- ✅ Item existence validation
- ✅ Suspicious activity logging
- ✅ Admin action logging
- ✅ Resource name protection

---

## 🚀 Performance

- **Idle:** 0.00ms
- **Active:** 0.01ms
- **Optimizations:** Native function caching, minimal tick usage
- **Network:** Minimal event traffic

---

## 🆘 Support

### Server Information
- **Website:** https://www.wolves.land
- **Discord:** https://discord.gg/CrKcWdfd3A
- **Store:** https://theluxempire.tebex.io
- **GitHub:** https://github.com/iBoss21

### Need Help?
1. Check the [Documentation](/docs/)
2. Join our [Discord](https://discord.gg/CrKcWdfd3A)
3. Open an issue on GitHub

---

## 📄 License

© 2024-2026 The Lux Empire | wolves.land  
All Rights Reserved - Licensed for wolves.land use

**Original Script:** Zeus Script  
**Converted by:** iBoss21 / The Lux Empire

---

## 🏷️ Tags

`RedM` `Georgian` `SeriousRP` `Whitelist` `Economy` `RPG` `Weapons` `Scopes` `Multi-Framework` `LXR-Core` `RSG-Core` `VORP`

---

```
╔═══════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                               ║
║   Made with 🐺 by The Lux Empire for The Land of Wolves                                      ║
║   Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```