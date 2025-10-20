local Params = {
    RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
    SSI = "saveinstance"
}

local synsaveinstance = loadstring(
    game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true),
    Params.SSI
)()

local container = Instance.new("Folder")
container.Name = "GUI_Export"

local starter = Instance.new("Folder")
starter.Name = "StarterGui"
starter.Parent = container

for _, gui in ipairs(game:GetService("StarterGui"):GetChildren()) do
    local success, clone = pcall(function()
        return gui:Clone()
    end)
    if success and clone then
        clone.Parent = starter
    end
end

local CustomOptions = {
    mode = "optimized",
    Object = container,
    IsModel = true,
    noscripts = false,
    SaveBytecode = false,
    DecompileJobless = false,
    scriptcache = true,
    timeout = 20,
    FilePath = "GuiDump"
}

synsaveinstance(CustomOptions)
