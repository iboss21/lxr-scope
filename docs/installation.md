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
║   🐺 Installation Guide                                                                      ║
║   Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
```

# 📦 Installation Guide

Complete step-by-step installation guide for the Wolves Weapon Scope System.

---

## 📋 Prerequisites

### System Requirements

| Requirement | Minimum | Recommended |
|-------------|---------|-------------|
| **Server Build** | 5848+ | Latest stable |
| **RedM Version** | 1.0+ | Latest |
| **RAM** | 512MB | 1GB+ |
| **Framework** | None (optional) | LXR-Core/RSG-Core |

### Supported Frameworks

- ✅ **LXR-Core** (Primary) - Full feature support
- ✅ **RSG-Core** (Primary) - Full feature support
- ✅ **VORP Core** (Legacy) - Complete compatibility
- ✅ **Standalone** - Basic command-only mode

---

## 🚀 Quick Installation (5 Minutes)

### Step 1: Download & Extract

```bash
# 1. Download the resource from your source
# 2. Extract the archive
# 3. Rename the folder to: lxr-weapon-scopes
```

⚠️ **CRITICAL:** The resource **MUST** be named `lxr-weapon-scopes` or it will not function!

### Step 2: Move to Resources Folder

```bash
# Move to your server's resources directory
mv lxr-weapon-scopes /path/to/server/resources/
```

**Typical Locations:**
- Windows: `C:\FXServer\server-data\resources\`
- Linux: `/home/fxserver/server-data/resources/`

### Step 3: Configure server.cfg

Add to your `server.cfg` file:

```cfg
# Wolves Weapon Scope System
ensure lxr-weapon-scopes
```

**Load Order Recommendations:**

```cfg
# Load core framework first
ensure lxr-core          # or rsg-core, or vorp_core

# Then load inventory (if using VORP)
ensure vorp_inventory    # VORP only

# Then load scope system
ensure lxr-weapon-scopes

# Then other weapons/items scripts
```

### Step 4: Restart Server

```bash
# Stop server
# Start server
# or use: restart lxr-weapon-scopes
```

### Step 5: Verify Installation

Join your server and test:

```
/adminscopeadd    # Should work immediately
```

✅ **Installation Complete!**

---

## 🔧 Framework-Specific Installation

### LXR-Core Installation

#### 1. Basic Setup
```bash
# 1. Ensure LXR-Core is installed and running
# 2. Install lxr-weapon-scopes as per Quick Installation
# 3. No additional configuration needed!
```

#### 2. Add Scope Items to LXR-Core

Edit your LXR-Core items configuration:

```lua
-- In lxr-core/shared/items.lua (or equivalent)

-- Scope items
["scopeshortwinchester"] = {
    label = "Short Winchester Scope",
    weight = 250,
    stack = true,
    close = true,
    description = "A short range scope for Winchester repeaters"
},
["scopeshorthenry"] = {
    label = "Short Henry Scope", 
    weight = 250,
    stack = true,
    close = true,
    description = "A short range scope for Henry repeaters"
},
-- Add all other scope items...

-- Tool item
["screwdriver"] = {
    label = "Screwdriver",
    weight = 150,
    stack = false,
    close = true,
    description = "Used for attaching and removing weapon scopes"
},
```

#### 3. Configure Shops (Optional)

Add scope items to your gunsmith/general stores:

```lua
-- In your shop configuration
items = {
    { name = "scopeshortwinchester", price = 25, amount = 10 },
    { name = "screwdriver", price = 5, amount = 50 },
}
```

---

### RSG-Core Installation

#### 1. Basic Setup
```bash
# 1. Ensure RSG-Core is installed and running
# 2. Install lxr-weapon-scopes as per Quick Installation  
# 3. System will auto-detect RSG-Core
```

#### 2. Add Items to RSG-Core

Edit your RSG-Core items:

```lua
-- In rsg-core/shared/items.lua

-- Scope items for each weapon type
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

#### 3. Add Item Images (Optional)

Place scope item images in:
```
rsg-inventory/html/images/
```

---

### VORP Core Installation

#### 1. Basic Setup
```bash
# 1. Ensure VORP Core and vorp_inventory are running
# 2. Install lxr-weapon-scopes as per Quick Installation
```

#### 2. Run Database Script

Execute the provided SQL file:

```bash
# Method 1: phpMyAdmin/Adminer
# 1. Open your database manager
# 2. Select your server database
# 3. Import: Extra/scopeitems.sql
# 4. Execute the queries

# Method 2: Command Line
mysql -u username -p database_name < Extra/scopeitems.sql
```

**SQL Script Contents:**
```sql
-- Adds scope items and screwdriver to items table
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
('scopeshortwinchester', 'Short Winchester Scope', 10, 1, 'item_standard', 1),
('scopeshorthenry', 'Short Henry Scope', 10, 1, 'item_standard', 1),
-- ... (additional items)
('screwdriver', 'Screwdriver', 5, 1, 'item_standard', 1);
```

#### 3. Configure VORP Inventory

The system automatically integrates with vorp_inventory. No additional configuration needed.

#### 4. Verify Database Items

```sql
-- Check items were added correctly
SELECT * FROM items WHERE item LIKE 'scope%';
SELECT * FROM items WHERE item = 'screwdriver';
```

---

### Standalone Installation

#### 1. Basic Setup
```bash
# 1. Install lxr-weapon-scopes as per Quick Installation
# 2. System will auto-detect standalone mode
```

#### 2. Configure for Standalone

Edit `config.lua`:

```lua
-- Force standalone mode
Config.Framework = 'standalone'

-- Enable command usage
Config.General.useCommands = true

-- Disable item-based system
Config.General.useItems = false
Config.General.requireAttachTool = false
Config.General.requireToolForRemoval = false
```

#### 3. Usage in Standalone Mode

Players can use commands directly:
```
/addscope     - Attach scope to equipped weapon
/removescope  - Remove scope from equipped weapon
```

---

## ⚙️ Post-Installation Configuration

### 1. Framework Detection

The system auto-detects your framework. To verify:

```lua
-- Check server console on resource start
[lxr-weapon-scopes] Framework detected: LXR-Core
```

To force a specific framework:

```lua
-- In config.lua
Config.Framework = 'lxr'  -- Options: 'auto', 'lxr', 'rsg', 'vorp', 'standalone'
```

### 2. Resource Name Validation

The system enforces correct naming:

```lua
-- This will show if resource is incorrectly named:
╔═══════════════════════════════════════════════════════╗
║    🐺 RESOURCE NAME ERROR 🐺                          ║
║   This resource MUST be named: lxr-weapon-scopes      ║
╚═══════════════════════════════════════════════════════╝
```

**Fix:** Rename the resource folder to `lxr-weapon-scopes`

### 3. Permission Configuration

Configure admin access:

```lua
-- In config.lua
Config.General = {
    adminCommand = true,      -- Enable admin commands
    adminGroup = 'admin',     -- Permission group
}
```

### 4. Feature Toggles

Enable/disable features as needed:

```lua
Config.General = {
    useItems = true,              -- Item-based system
    useCommands = true,           -- Command-based system
    playAnimation = true,         -- Attachment animations
    requireAttachTool = true,     -- Require screwdriver
    requireToolForRemoval = true, -- Tool for removal
}
```

---

## 🧪 Testing Installation

### Basic Functionality Tests

#### Test 1: Admin Commands
```
1. Join server as admin
2. Equip a Winchester repeater
3. Type: /adminscopeadd
4. Verify scope appears on weapon
5. Type: /adminscoperemove
6. Verify scope is removed
```

#### Test 2: Item Usage (Framework Mode)
```
1. Give yourself a scope item: /giveitem [player] scopeshortwinchester 1
2. Give yourself screwdriver: /giveitem [player] screwdriver 1
3. Equip Winchester repeater
4. Use scope item from inventory
5. Verify scope attaches
6. Use screwdriver to remove
7. Verify scope is removed
```

#### Test 3: Framework Detection
```
1. Check server console for: "Framework detected: [NAME]"
2. Verify correct framework is detected
3. Test framework-specific features (notifications, inventory)
```

### Performance Testing

Monitor resource performance:

```
# In-game F8 console
resmon

# Look for lxr-weapon-scopes
# Should show: 0.00ms idle, 0.01ms active
```

---

## 🔍 Troubleshooting

### Common Installation Issues

#### Issue 1: Resource Not Starting

**Symptoms:**
- Resource fails to start
- Error messages in console

**Solutions:**
```bash
# Check resource name
# Must be: lxr-weapon-scopes (exact match)

# Check server.cfg
# Ensure: ensure lxr-weapon-scopes

# Check file permissions (Linux)
chmod -R 755 lxr-weapon-scopes/

# Restart server completely
```

#### Issue 2: Framework Not Detected

**Symptoms:**
- Wrong framework detected
- "Standalone mode" when framework exists

**Solutions:**
```lua
-- In config.lua, force framework:
Config.Framework = 'lxr'  -- or 'rsg', 'vorp'

-- Check framework resource is started BEFORE scopes:
ensure lxr-core
ensure lxr-weapon-scopes

-- Verify framework resource name matches:
Config.FrameworkSettings.LXR.resourceName = 'lxr-core'
```

#### Issue 3: Items Not Working

**Symptoms:**
- Scope items don't trigger
- No response when using items

**Solutions:**
```lua
-- VORP: Verify database items exist
SELECT * FROM items WHERE item LIKE 'scope%';

-- LXR/RSG: Verify items added to shared items
-- Check items.lua in framework folder

-- Check item names match exactly in config:
Config.Items.scopes = {
    WEAPON_REPEATER_WINCHESTER = "scopeshortwinchester", -- Must match item name
}

-- Verify item usage is enabled:
Config.General.useItems = true
```

#### Issue 4: Commands Not Working

**Symptoms:**
- Commands not registered
- "Command not found" errors

**Solutions:**
```lua
-- Verify commands enabled in config:
Config.General.useCommands = true

-- Check command names in config:
Config.Commands = {
    addScope = "addscope",
    removeScope = "removescope",
}

-- Ensure no command conflicts with other resources

-- Admin commands require permissions:
Config.General.adminGroup = 'admin'
```

#### Issue 5: Scope Not Appearing

**Symptoms:**
- Notification shows success
- Scope doesn't appear on weapon

**Solutions:**
```lua
-- Verify weapon is supported:
-- Check Config.WeaponComponents for your weapon hash

-- Test with known weapon:
-- Winchester Repeater should always work

-- Check weapon hash matches:
-- Use: /hash (if available) or check game files

-- Verify component hash is correct:
-- Short scope: -404520310
-- Medium scope: -1844750633  
-- Long scope: -1545766277
```

---

## 🔄 Updating from Previous Versions

### From Zeus Script (Original)

```bash
# 1. Backup your old configuration
cp zeus-scopes/config.lua zeus-scopes-backup/config.old

# 2. Remove old resource
rm -rf zeus-scopes/

# 3. Install new version as per Quick Installation

# 4. Migrate config settings:
# - Review config_old.lua for reference
# - Transfer custom settings to new config.lua
# - Update item names if changed

# 5. Update database items (VORP):
# - Run new scopeitems.sql
# - Remove old scope items if names changed

# 6. Restart server
```

### From Version 1.x

```bash
# 1. Backup config.lua
# 2. Replace all files with new version
# 3. Review new config options
# 4. Update item images if changed
# 5. Restart resource
restart lxr-weapon-scopes
```

---

## 📊 Installation Checklist

Use this checklist to verify complete installation:

### Pre-Installation
- [ ] Server meets minimum requirements (Build 5848+)
- [ ] Framework installed (if using LXR/RSG/VORP)
- [ ] Database access available (if using VORP)
- [ ] Backup existing configuration

### Installation
- [ ] Downloaded resource files
- [ ] Renamed folder to `lxr-weapon-scopes`
- [ ] Placed in resources directory
- [ ] Added to server.cfg with correct load order
- [ ] Ran database script (VORP only)
- [ ] Configured framework items (LXR/RSG)

### Configuration
- [ ] Reviewed config.lua
- [ ] Set framework detection mode
- [ ] Configured permissions
- [ ] Enabled desired features
- [ ] Set up item names
- [ ] Configured commands

### Testing
- [ ] Resource starts without errors
- [ ] Framework detected correctly
- [ ] Admin commands work
- [ ] Items trigger properly (if enabled)
- [ ] Scopes attach and remove correctly
- [ ] Notifications appear
- [ ] Animations play (if enabled)
- [ ] Performance is optimal (0.00ms idle)

### Documentation
- [ ] Read overview.md
- [ ] Reviewed configuration.md
- [ ] Understood framework integration
- [ ] Familiarized with events/API

---

## 🆘 Getting Help

### Support Resources

| Resource | Link | Purpose |
|----------|------|---------|
| **Documentation** | `/docs/` | Complete reference |
| **Discord** | [discord.gg/CrKcWdfd3A](https://discord.gg/CrKcWdfd3A) | Community support |
| **GitHub** | [github.com/iBoss21](https://github.com/iBoss21) | Issue tracking |
| **Website** | [wolves.land](https://www.wolves.land) | Server info |

### Before Requesting Support

1. ✅ Check console for error messages
2. ✅ Verify resource name is correct
3. ✅ Confirm framework is detected
4. ✅ Test with admin commands first
5. ✅ Review troubleshooting section
6. ✅ Check configuration against defaults

### Reporting Issues

When requesting support, provide:
- Server build version
- Framework and version
- Complete error messages
- Steps to reproduce issue
- Relevant config.lua sections
- Console output during problem

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
