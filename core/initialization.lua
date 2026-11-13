local BASE = "https://raw.githubusercontent.com/Zulva88-Ax/VDX-PRIVATE-HUB/main"
local function loadModule(path)
    local source = game:HttpGet(BASE .. "/" .. path)
    assert(type(source) == "string" and #source > 0, "Empty module: " .. path)
    local chunk, err = loadstring(source)
    assert(chunk, "Compile error in " .. path .. ": " .. tostring(err))
    return chunk()
end
local config = loadModule("core/config.lua")
local start = loadModule("modules/main.lua")
assert(type(start) == "function", "main module must return a function")
start(config)
