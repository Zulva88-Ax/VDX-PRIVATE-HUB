# VDX PRIVATE HUB

Modular Luau starter project for local interface and utility features.

## Loader
Paste the contents of `loader.lua` into a compatible Luau environment. The loader fetches `core/initialization.lua` from the `main` branch.

## Current modules

- **Main:** VDX panel, local camera FOV controls, FPS and ping readout. RightShift hides/shows the panel.
- **Visuals:** local crosshair. F6 toggles it, F7 changes size, F8 cycles color, F9 toggles movement-reactive spacing.
- **Utility:** local session HUD and local movement-speed readout. F10 toggles the HUD, F11 toggles speed display.

## Repository layout

- `loader.lua` — loader entry point
- `version.json` — version metadata
- `core/config.lua` — shared configuration
- `core/initialization.lua` — module bootstrap
- `modules/main.lua` — main panel
- `modules/visuals.lua` — local crosshair
- `modules/utility.lua` — local session HUD
- `modules/killer.lua`, `modules/survivor.lua` — reserved role module placeholders
- `assets/themes.lua` — theme definitions

## Compatibility and safety

This source has not been tested in Delta Executor. Executor APIs and Roblox client behavior can change; test cautiously in a private experience or one you control. Public repositories expose source code. Never commit credentials, cookies, tokens, or private keys.

This project intentionally does not implement aimbots, silent aim, opponent ESP/wall tracking, automated combat, exploit teleports, or other features that provide unfair advantages against other players in public matches. The Killer and Survivor files remain placeholders pending legitimate, non-competitive features.
