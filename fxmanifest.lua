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
║   🐺 Weapon Scope System - FXManifest                                                        ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   DESCRIPTION:                                                                                ║
║   Advanced weapon scope attachment system with multi-framework support.                      ║
║   Allows players to dynamically attach and remove scopes to weapons via                      ║
║   commands or inventory items with realistic animations and validation.                      ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   SERVER INFORMATION:                                                                         ║
║   Name:          The Land of Wolves 🐺                                                       ║
║   Tagline:       Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!                         ║
║   Description:   ისტორია ცოცხლდება აქ! (History Lives Here!)                                ║
║   Type:          Serious Hardcore Roleplay                                                    ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   VERSION:       2.0.0 (Land of Wolves Edition)                                              ║
║   PERFORMANCE:   Optimized | 0.00ms idle | 0.01ms active                                     ║
║   TAGS:          RedM, Weapons, Scopes, Multi-Framework, Hardcore RP                         ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   FRAMEWORK SUPPORT:                                                                          ║
║   ✓ LXR-Core     (Primary)   - Full support with native integration                         ║
║   ✓ RSG-Core     (Primary)   - Full support with native integration                         ║
║   ✓ VORP Core    (Supported) - Complete legacy support                                       ║
║   ✓ Standalone   (Basic)     - Command-only functionality                                    ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   CREDITS:                                                                                    ║
║   Original:      Zeus Script                                                                  ║
║   Converted by:  iBoss21 / The Lux Empire                                                    ║
║   Server:        wolves.land                                                                  ║
║   Discord:       discord.gg/CrKcWdfd3A                                                        ║
║   Store:         theluxempire.tebex.io                                                        ║
║                                                                                               ║
╠═══════════════════════════════════════════════════════════════════════════════════════════════╣
║                                                                                               ║
║   © 2024-2026 The Lux Empire | wolves.land                                                   ║
║   All Rights Reserved - Licensed for wolves.land use                                         ║
║                                                                                               ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

-- FiveM Metadata
fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources WILL become incompatible once RedM ships.'

-- Resource Information
name 'lxr-weapon-scopes'
author 'iBoss21 / The Lux Empire (Original: Zeus Script)'
description 'Advanced weapon scope system with multi-framework support for The Land of Wolves'
version '2.0.0'

-- Lua Version
lua54 'yes'

-- Shared Configuration
shared_scripts {
    'config.lua',
    'shared/framework.lua'
}

-- Client Scripts (Scope: Weapon component management, animations, UI notifications)
client_scripts {
    'client/main.lua'
}

-- Server Scripts (Scope: Item management, validation, anti-cheat, framework integration)
server_scripts {
    'server/main.lua'
}

-- Dependencies (Optional - Runtime detection used)
-- dependencies {
--     '/oxi_core', -- For LXR-Core
--     '/rsg-core', -- For RSG-Core
--     '/vorp_core' -- For VORP
-- }

-- Files
files {
    'README.md',
    'docs/**/*'
}