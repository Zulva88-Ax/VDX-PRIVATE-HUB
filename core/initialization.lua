-- VDX PRIVATE HUB | Core initialization
local BASE = "https://raw.githubusercontent.com/Zulva88-Ax/VDX-PRIVATE-HUB/main"

local function loadModule(path)
    local source = game:HttpGet(BASE .. "/" .. path)
    assert(type(source) == "string" and #source > 0, "Empty module: " .. path)
    local chunk, err = loadstring(source)
    assert(chunk, "Compile error in " .. path .. ": " .. tostring(err))
    return chunk()
end

local config = loadModule("core/config.lua")
local startMain = loadModule("modules/main.lua")
local startVisuals = loadModule("modules/visuals.lua")
local startUtility = loadModule("modules/utility.lua")

assert(type(startMain) == "function", "main module must return a function")
assert(type(startVisuals) == "function", "visuals module must return a function")
assert(type(startUtility) == "function", "utility module must return a function")

startMain(config)
startVisuals(config)
startUtility(config)
