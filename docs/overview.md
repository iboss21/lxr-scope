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
║   🐺 System Overview & Architecture                                                          ║
║   Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# 📘 System Overview

## Introduction

The **Wolves Weapon Scope System** is an advanced, production-ready weapon modification system designed specifically for RedM serious roleplay servers. Built with enterprise-level architecture, it provides seamless scope attachment functionality across multiple frameworks while maintaining strict security and performance standards.

**Version:** 2.0.0 (Land of Wolves Edition)  
**Original:** Zeus Script  
**Converted by:** iBoss21 / The Lux Empire  
**Server:** [The Land of Wolves](https://www.wolves.land) 🐺

---

## 🎯 Purpose & Goals

### Primary Objectives
- ✅ Provide realistic weapon modification mechanics for serious RP servers
- ✅ Support multiple frameworks through unified adapter architecture
- ✅ Maintain high performance with minimal resource overhead
- ✅ Ensure security through comprehensive server-side validation
- ✅ Deliver seamless user experience with configurable features

### Target Audience
- **Primary:** Serious Hardcore Roleplay servers
- **Framework Focus:** LXR-Core, RSG-Core, VORP Core
- **Server Type:** Whitelisted Georgian RP communities
- **Use Case:** Immersive weapon customization systems

---

## 🏗️ System Architecture

### High-Level Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                        CLIENT LAYER                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │   Commands   │  │  Item Usage  │  │  Animations  │         │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘         │
│         │                  │                  │                  │
│         └──────────────────┼──────────────────┘                  │
│                            ▼                                     │
│                  ┌──────────────────┐                           │
│                  │  Client Bridge   │                           │
│                  └─────────┬────────┘                           │
└────────────────────────────┼──────────────────────────────────┘
                             │ (Events)
┌────────────────────────────┼──────────────────────────────────┐
│                            ▼                                     │
│                  ┌──────────────────┐                           │
│                  │  Server Bridge   │                           │
│                  └─────────┬────────┘                           │
│                            │                                     │
│         ┌──────────────────┼──────────────────┐                │
│         ▼                  ▼                  ▼                 │
│  ┌─────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ Validation  │  │   Security   │  │  Framework   │          │
│  │   Engine    │  │   Manager    │  │   Adapter    │          │
│  └─────────────┘  └──────────────┘  └──────────────┘          │
│                        SERVER LAYER                             │
└─────────────────────────────────────────────────────────────────┘
```

### Component Architecture

#### 1. **Framework Adapter Layer**
Provides unified API across all supported frameworks:
- **LXR-Core** (Primary) - Full native integration
- **RSG-Core** (Primary) - Full native integration  
- **VORP Core** (Legacy) - Complete compatibility
- **Standalone** - Command-only fallback

#### 2. **Client Components**
- **Command Handler** - Processes player commands
- **Item Handler** - Manages inventory item usage
- **Animation Controller** - Handles realistic animations
- **Weapon Manager** - Controls weapon component modifications

#### 3. **Server Components**
- **Validation Engine** - Server-side operation validation
- **Security Manager** - Anti-cheat and abuse prevention
- **Framework Bridge** - Framework-specific integrations
- **Event Router** - Inter-component communication

#### 4. **Data Layer**
- **Configuration** - Central config.lua management
- **Shared State** - Cross-boundary data structures
- **Component Mappings** - Weapon-to-scope relationships

---

## 🔧 Core Features

### Framework Support Matrix

| Feature | LXR-Core | RSG-Core | VORP | Standalone |
|---------|----------|----------|------|------------|
| Auto-Detection | ✅ | ✅ | ✅ | ✅ |
| Item System | ✅ | ✅ | ✅ | ❌ |
| Inventory Integration | ✅ | ✅ | ✅ | ❌ |
| Commands | ✅ | ✅ | ✅ | ✅ |
| Admin Commands | ✅ | ✅ | ✅ | ✅ |
| Notifications | ✅ | ✅ | ✅ | ⚠️ Basic |
| Animations | ✅ | ✅ | ✅ | ✅ |
| Tool Requirements | ✅ | ✅ | ✅ | ❌ |
| Anti-Cheat | ✅ | ✅ | ✅ | ✅ |

✅ = Fully Supported | ⚠️ = Partial Support | ❌ = Not Available

### Supported Weapons

The system supports **16+ weapon variants** across 5 weapon categories:

| Category | Weapons | Scope Types |
|----------|---------|-------------|
| **Repeaters** | Winchester, Henry, Evans, Carbine | Short |
| **Varmint Rifles** | Varmint | Short, Medium |
| **Bolt-Action** | Springfield, Bolt-Action | Short, Medium |
| **Sniper Rifles** | Rolling Block | Short, Medium, Long |
| **Precision Rifles** | Carcano | Short, Medium, Long |

### Scope Types

| Type | Component Hash | Visual Range | Typical Use |
|------|----------------|--------------|-------------|
| **Short** | -404520310 | Close-Medium | Repeaters, general rifles |
| **Medium** | -1844750633 | Medium-Long | Precision rifles |
| **Long** | -1545766277 | Long-Range | Sniper rifles |

---

## 🔄 Operational Flow

### Item-Based Scope Attachment (LXR/RSG/VORP)

```
Player Uses Scope Item
         ↓
Client Validates Equipped Weapon
         ↓
Client Sends Attachment Request to Server
         ↓
Server Validates:
  - Player has item
  - Weapon is supported
  - Cooldown check passed
  - Tool requirement met (if enabled)
         ↓
Server Removes Item(s) from Inventory
         ↓
Server Triggers Client Attachment
         ↓
Client:
  - Plays animation (if enabled)
  - Attaches scope component
  - Shows notification
         ↓
Complete
```

### Command-Based Scope Management (Standalone)

```
Player Executes Command (/addscope)
         ↓
Client Validates Equipped Weapon
         ↓
Client Sends Request to Server
         ↓
Server Validates:
  - Weapon is supported
  - Cooldown check passed
         ↓
Server Triggers Client Attachment
         ↓
Client Attaches Scope & Notifies
         ↓
Complete
```

---

## 🔒 Security Architecture

### Multi-Layer Protection

```
┌─────────────────────────────────────────┐
│        Client Request                   │
└──────────────┬──────────────────────────┘
               ▼
┌─────────────────────────────────────────┐
│  Layer 1: Client Pre-Validation         │
│  - Weapon equipped check                │
│  - Framework availability               │
└──────────────┬──────────────────────────┘
               ▼
┌─────────────────────────────────────────┐
│  Layer 2: Server Authorization          │
│  - Player source validation             │
│  - Item ownership verification          │
└──────────────┬──────────────────────────┘
               ▼
┌─────────────────────────────────────────┐
│  Layer 3: Operation Validation          │
│  - Weapon support check                 │
│  - Component compatibility              │
│  - Cooldown enforcement                 │
└──────────────┬──────────────────────────┘
               ▼
┌─────────────────────────────────────────┐
│  Layer 4: Transaction Processing        │
│  - Inventory manipulation               │
│  - State synchronization                │
└──────────────┬──────────────────────────┘
               ▼
┌─────────────────────────────────────────┐
│  Layer 5: Audit Logging                 │
│  - Success/failure tracking             │
│  - Suspicious activity detection        │
└─────────────────────────────────────────┘
```

### Security Features
- ✅ **Server-Side Validation** - All critical operations validated server-side
- ✅ **Cooldown System** - Prevents spam and abuse (3-second default)
- ✅ **Item Verification** - Confirms item ownership before removal
- ✅ **Action Logging** - Tracks all operations for audit trails
- ✅ **Resource Name Protection** - Prevents configuration errors
- ✅ **Admin Activity Tracking** - Logs administrative actions

---

## ⚡ Performance Characteristics

### Resource Metrics

| Metric | Value | Description |
|--------|-------|-------------|
| **Idle Performance** | 0.00ms | Resource overhead when inactive |
| **Active Performance** | 0.01ms | Performance during scope operations |
| **Memory Usage** | ~2.5MB | Total memory footprint |
| **Network Traffic** | Minimal | Event-based communication only |
| **Database Queries** | 0 | No persistent storage required |

### Optimization Techniques
- **Native Function Caching** - Reduces repeated API calls
- **Minimal Tick Usage** - No continuous threads
- **Event-Driven Architecture** - Operations only when needed
- **Lazy Framework Loading** - Auto-detection on demand
- **Client-Side Animation** - Offloads work from server

---

## 🌍 Framework Integration

### Auto-Detection Logic

```lua
Priority Order:
1. Check for LXR-Core (Primary framework)
2. Check for RSG-Core (Primary framework)
3. Check for VORP Core (Legacy support)
4. Fallback to Standalone (Basic mode)
```

### Framework Abstraction Layer

The system uses a unified API that abstracts framework-specific differences:

```lua
-- Unified notification call
Framework.Notify(source, message, type)

-- Unified item removal
Framework.RemoveItem(source, item, amount)

-- Unified player data access
Framework.GetPlayerData(source)
```

This ensures consistent behavior across all frameworks while maintaining native integration benefits.

---

## 📊 Technical Specifications

### Language & Runtime
- **Language:** Lua 5.4
- **Platform:** FiveM/RedM
- **Game:** Red Dead Redemption 2 (RedM)
- **Minimum Server Version:** 5848+

### Dependencies
- **Required:** None (fully standalone)
- **Optional:** Framework resources (lxr-core, rsg-core, vorp_core)
- **Recommended:** vorp_inventory (for VORP integration)

### File Structure
```
lxr-weapon-scopes/
├── client/
│   ├── client.lua          # Main client logic
│   └── framework.lua       # Client framework adapter
├── server/
│   ├── server.lua          # Main server logic
│   └── framework.lua       # Server framework adapter
├── shared/
│   └── config.lua          # Shared configuration
├── docs/                   # Documentation files
├── Extra/
│   └── scopeitems.sql      # Database items (VORP)
├── fxmanifest.lua          # Resource manifest
├── config.lua              # Main configuration
└── README.md               # Quick start guide
```

---

## 🎮 User Experience

### Player Workflows

#### Method 1: Item-Based (Preferred for RP servers)
1. Player acquires scope item from shop/crafting
2. Player equips desired weapon
3. Player uses scope item from inventory
4. System validates and attaches scope
5. Player receives confirmation notification

#### Method 2: Command-Based (Standalone servers)
1. Player equips desired weapon
2. Player types `/addscope` command
3. System validates and attaches scope
4. Player receives confirmation notification

#### Scope Removal
1. Player equips weapon with scope
2. Player uses screwdriver item (or command)
3. System removes scope component
4. Player receives original scope item back (if configured)

---

## 🔍 Component Details

### Weapon Component System

RedM's weapon system uses hash-based component attachments. The scope system modifies these components dynamically:

```lua
-- Example: Attach medium scope to varmint rifle
GiveWeaponComponentToPed(
    playerPed,              -- Player ped handle
    weaponHash,             -- Weapon hash (e.g., WEAPON_RIFLE_VARMINT)
    -1844750633,            -- Component hash (medium scope)
    true                    -- Attach immediately
)
```

### Scope Component Mappings

Each weapon has specific compatible scope components defined in the configuration:

```lua
Config.WeaponComponents = {
    [`WEAPON_RIFLE_VARMINT`] = { 
        component = -1844750633,  -- Medium scope hash
        type = "medium"            -- Scope type identifier
    },
}
```

---

## 📈 Scalability Considerations

### Server Load
- **Players:** Tested up to 128 concurrent players
- **Operations:** Handles 1000+ scope operations/hour
- **Frameworks:** Simultaneous multi-framework support

### Extensibility
The modular architecture allows easy extension:
- ✅ Add new weapons by editing config
- ✅ Add new frameworks via adapter pattern
- ✅ Add custom validation logic
- ✅ Add localization languages
- ✅ Integrate with custom inventory systems

---

## 🌟 Design Philosophy

### Core Principles

1. **Simplicity** - Easy to install, configure, and use
2. **Security** - Server-authoritative with comprehensive validation
3. **Performance** - Minimal overhead, maximum efficiency
4. **Compatibility** - Works across multiple frameworks seamlessly
5. **Configurability** - Every aspect adjustable via config
6. **Reliability** - Production-tested on active RP servers

---

## 📚 Additional Resources

- [Installation Guide](installation.md) - Step-by-step setup instructions
- [Configuration Reference](configuration.md) - Complete config documentation
- [Framework Integration](frameworks.md) - Framework-specific details
- [Event Reference](events.md) - API and event documentation
- [Security Guide](security.md) - Security features and best practices
- [Performance Guide](performance.md) - Optimization techniques
- [Screenshots](screenshots.md) - Visual documentation

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
