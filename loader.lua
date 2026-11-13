-- VDX PRIVATE HUB | Loader v1.0
local BASE = "https://raw.githubusercontent.com/Zulva88-Ax/VDX-PRIVATE-HUB/main"
local ok, err = pcall(function()
    local source = game:HttpGet(BASE .. "/core/initialization.lua")
    assert(type(source) == "string" and #source > 0, "Empty VDX bootstrap")
    local chunk, compileError = loadstring(source)
    assert(chunk, compileError)
    chunk()
end)
if not ok then warn("[VDX] Load failed: " .. tostring(err)) else print("[VDX] Loader complete") end
