local Params = {
    RepoURL = "https://raw.githubusercontent.com/luau/SynSaveInstance/main/",
    SSI = "saveinstance"
}

local synsaveinstance = loadstring(
    game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true),
    Params.SSI
)()

local container = Instance.new("Folder")
container.Name = "Animation_Export"

local seen = {}

local searchRoots = {
    game:GetService("ReplicatedStorage"),
    game:GetService("Workspace"),
    game:GetService("StarterPack"),
    game:GetService("StarterPlayer"),
    game:GetService("ServerStorage")
}

for _, root in ipairs(searchRoots) do
    if root then
        for _, desc in ipairs(root:GetDescendants()) do

            if desc:IsA("Animation") then

                local id = tostring(desc.AnimationId or "")

                if id == "" then id = "name:" .. desc.Name end

                if not seen[id] then
                    seen[id] = true
                    local ok, clone = pcall(function() return desc:Clone() end)
                    if ok and clone then
                        clone.Parent = container
                    end
                end
            end
        end
    end
end

local CustomOptions = {
    mode = "optimized",
    Object = container,
    IsModel = true,
    noscripts = true,          
    SaveBytecode = false,
    DecompileJobless = false,
    scriptcache = true,
    timeout = 20,
    FilePath = "AnimationDump"
}

synsaveinstance(CustomOptions)