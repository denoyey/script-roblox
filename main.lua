task.wait(2)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
if not Rayfield then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ToggleNoclip, ToggleFly, ToggleInfJump, ToggleAntiAFK, ToggleESP, ToggleZoom
local ToggleFullBright, ToggleAntiVoid
local ToggleTargetFling, ToggleClickTP, ToggleSpinbot, ToggleClickDelete
local ToggleHitbox, ToggleFreecam, ToggleWaterWalk
local SliderWalkSpeed, SliderJumpPower, SliderFlySpeed, SliderGravity, SliderFOV, SliderHitboxSize

local flySpeed = 50
local hitboxSize = 10
local fcSpeed = 100
local selectedPlayerToTP = nil
local selectedPlayerToFling = nil 
local antiVoidPart = nil

local origLighting = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}

local Window = Rayfield:CreateWindow({
    Name = "Script by xnoname008",
    LoadingTitle = "Memuat Menu",
    LoadingSubtitle = "Menyiapkan Fitur",
    ConfigurationSaving = { Enabled = false }
})

local PlayerTab = Window:CreateTab("Player & Dunia", 4483362458) 

PlayerTab:CreateParagraph({
    Title = "Profil",
    Content = string.format("Display: %s\nUser: @%s\nID: %d", LocalPlayer.DisplayName, LocalPlayer.Name, LocalPlayer.UserId)
})

PlayerTab:CreateSection("Combat")

local hitboxLoop
ToggleHitbox = PlayerTab:CreateToggle({
    Name = "Hitbox Expander",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            hitboxLoop = RunService.Heartbeat:Connect(function()
                for _, v in ipairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = v.Character.HumanoidRootPart
                        hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                        hrp.Transparency = 0.7
                        hrp.BrickColor = BrickColor.new("Cyan")
                        hrp.Material = Enum.Material.Neon
                        hrp.CanCollide = false
                    end
                end
            end)
        else
            if hitboxLoop then hitboxLoop:Disconnect(); hitboxLoop = nil end
            for _, v in ipairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = v.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                end
            end
        end
    end
})

SliderHitboxSize = PlayerTab:CreateSlider({
    Name = "Ukuran Hitbox",
    Range = {5, 50}, Increment = 1, CurrentValue = 10, 
    Callback = function(Value) hitboxSize = Value end
})

PlayerTab:CreateSection("Pergerakan")

SliderWalkSpeed = PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {0, 200}, Increment = 1, CurrentValue = 16, 
    Callback = function(Value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = Value end
    end
})

SliderJumpPower = PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {0, 250}, Increment = 1, CurrentValue = 50, 
    Callback = function(Value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = Value
        end
    end
})

local waterWalkConn
local waterPad
ToggleWaterWalk = PlayerTab:CreateToggle({
    Name = "Walk on Water",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            waterPad = Instance.new("Part")
            waterPad.Size = Vector3.new(10, 1, 10)
            waterPad.Transparency = 1
            waterPad.Anchored = true
            waterPad.CanCollide = true
            waterPad.Parent = workspace
            local rp = RaycastParams.new()
            rp.IgnoreWater = false
            rp.FilterType = Enum.RaycastFilterType.Exclude
            waterWalkConn = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    rp.FilterDescendantsInstances = {char, waterPad}
                    local ray = workspace:Raycast(hrp.Position, Vector3.new(0, -10, 0), rp)
                    if ray and ray.Material == Enum.Material.Water then
                        waterPad.Position = Vector3.new(hrp.Position.X, ray.Position.Y + 1.5, hrp.Position.Z)
                    else
                        waterPad.Position = Vector3.new(0, 99999, 0) 
                    end
                end
            end)
        else
            if waterWalkConn then waterWalkConn:Disconnect() waterWalkConn = nil end
            if waterPad then waterPad:Destroy() waterPad = nil end
        end
    end
})

local noclipConnection
ToggleNoclip = PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        if Value then
            noclipConnection = RunService.Stepped:Connect(function()
                if char then
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                    end
                end
            end)
        else
            if noclipConnection then noclipConnection:Disconnect(); noclipConnection = nil end
            if char then
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = true end
                end
            end
        end
    end
})

local flyConnection
ToggleFly = PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if Value then
            if hrp and hum then
                local bv = Instance.new("BodyVelocity"); local bg = Instance.new("BodyGyro")
                bv.Name = "FlyBv"; bg.Name = "FlyBg"
                bv.MaxForce = Vector3.new(1e9, 1e9, 1e9); bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                bv.Parent = hrp; bg.Parent = hrp; hum.PlatformStand = true 
                flyConnection = RunService.RenderStepped:Connect(function()
                    local cam = workspace.CurrentCamera
                    local controlModule = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
                    local moveVector = controlModule:GetMoveVector()
                    if moveVector.Magnitude > 0 then
                        local flyVec = (cam.CFrame.RightVector * moveVector.X) + (cam.CFrame.LookVector * -moveVector.Z)
                        bv.Velocity = flyVec * flySpeed
                    else
                        bv.Velocity = Vector3.zero
                    end
                    bg.CFrame = cam.CFrame
                end)
            end
        else
            if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
            if hrp then
                local bv = hrp:FindFirstChild("FlyBv"); local bg = hrp:FindFirstChild("FlyBg")
                if bv then bv:Destroy() end; if bg then bg:Destroy() end
            end
            if hum then hum.PlatformStand = false end
        end
    end
})

SliderFlySpeed = PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 300}, Increment = 5, CurrentValue = 50, 
    Callback = function(Value) flySpeed = Value end
})

local infJumpConnection
ToggleInfJump = PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        else
            if infJumpConnection then infJumpConnection:Disconnect(); infJumpConnection = nil end
        end
    end
})

PlayerTab:CreateSection("Visual")

local fcPart, fcConn
ToggleFreecam = PlayerTab:CreateToggle({
    Name = "Freecam",
    CurrentValue = false,
    Callback = function(Value)
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if Value then
            fcPart = Instance.new("Part")
            fcPart.Size = Vector3.new(1,1,1); fcPart.Transparency = 1; fcPart.CanCollide = false
            fcPart.Anchored = true; fcPart.Position = workspace.CurrentCamera.CFrame.Position
            fcPart.Parent = workspace
            workspace.CurrentCamera.CameraSubject = fcPart
            if hum and hrp then hum.PlatformStand = true; hrp.Anchored = true end
            fcConn = RunService.RenderStepped:Connect(function(dt)
                local moveDir = Vector3.new()
                local camCF = workspace.CurrentCamera.CFrame
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.E) then moveDir += camCF.UpVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Q) then moveDir -= camCF.UpVector end
                if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end
                fcPart.Position = fcPart.Position + (moveDir * fcSpeed * dt)
            end)
        else
            if fcConn then fcConn:Disconnect() fcConn = nil end
            if fcPart then fcPart:Destroy() fcPart = nil end
            if char and hum and hrp then
                workspace.CurrentCamera.CameraSubject = hum
                hum.PlatformStand = false; hrp.Anchored = false
            end
        end
    end
})

SliderGravity = PlayerTab:CreateSlider({
    Name = "Gravity",
    Range = {0, 500}, Increment = 1, CurrentValue = 196, 
    Callback = function(Value) workspace.Gravity = Value end
})

SliderFOV = PlayerTab:CreateSlider({
    Name = "FOV",
    Range = {70, 120}, Increment = 1, CurrentValue = 70, 
    Callback = function(Value) workspace.CurrentCamera.FieldOfView = Value end
})

ToggleFullBright = PlayerTab:CreateToggle({
    Name = "FullBright",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            Lighting.Brightness = 2; Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
        else
            Lighting.Ambient = origLighting.Ambient; Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
            Lighting.Brightness = origLighting.Brightness; Lighting.FogEnd = origLighting.FogEnd
            Lighting.GlobalShadows = origLighting.GlobalShadows
        end
    end
})

PlayerTab:CreateButton({
    Name = "FPS Boost",
    Callback = function()
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("SunRaysEffect") then
                v.Enabled = false
            end
        end
        for _, v in pairs(workspace:GetDescendants()) do
            pcall(function()
                if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                    v.Material = Enum.Material.SmoothPlastic; v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    if v.Name ~= "face" then v.Transparency = 1 end
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                    v.Enabled = false
                end
            end)
        end
    end
})

ToggleAntiVoid = PlayerTab:CreateToggle({
    Name = "Anti-Void",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            if not antiVoidPart then
                antiVoidPart = Instance.new("Part")
                antiVoidPart.Size = Vector3.new(2048, 5, 2048)
                antiVoidPart.Position = Vector3.new(0, workspace.FallenPartsDestroyHeight + 10, 0)
                antiVoidPart.Anchored = true; antiVoidPart.CanCollide = true; antiVoidPart.Transparency = 0.5
                antiVoidPart.Color = Color3.fromRGB(0, 255, 0); antiVoidPart.Material = Enum.Material.ForceField
                antiVoidPart.Parent = workspace
            end
        else
            if antiVoidPart then antiVoidPart:Destroy() antiVoidPart = nil end
        end
    end
})

local espHighlights = {}
ToggleESP = PlayerTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character; highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    table.insert(espHighlights, highlight)
                end
            end
        else
            for _, highlight in ipairs(espHighlights) do if highlight then highlight:Destroy() end end
            espHighlights = {}
        end
    end
})

PlayerTab:CreateSection("TP & Troll")

local function getPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then table.insert(names, player.Name) end
    end
    return names
end

local TeleportDropdown = PlayerTab:CreateDropdown({
    Name = "Pilih Pemain",
    Options = getPlayerNames(),
    CurrentOption = {"Pilih Pemain"},
    Callback = function(Option)
        selectedPlayerToTP = Option[1]
        selectedPlayerToFling = Option[1] 
    end
})

PlayerTab:CreateButton({
    Name = "Teleport",
    Callback = function()
        if selectedPlayerToTP and selectedPlayerToTP ~= "Pilih Pemain" then
            local target = Players:FindFirstChild(selectedPlayerToTP)
            local char = LocalPlayer.Character
            if target and target.Character and char then
                char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
            end
        end
    end
})

local clickTPConnection
ToggleClickTP = PlayerTab:CreateToggle({
    Name = "Click TP (Ctrl + Click)",
    CurrentValue = false,
    Callback = function(Value)
        local Mouse = LocalPlayer:GetMouse()
        if Value then
            clickTPConnection = Mouse.Button1Down:Connect(function()
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    local char = LocalPlayer.Character
                    if char and Mouse.Hit then char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0,3,0)) end
                end
            end)
        else
            if clickTPConnection then clickTPConnection:Disconnect() end
        end
    end
})

local flingLoop
ToggleTargetFling = PlayerTab:CreateToggle({
    Name = "Target Fling",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            local target = Players:FindFirstChild(selectedPlayerToFling)
            if not target then ToggleTargetFling:Set(false); return end
            flingLoop = RunService.Heartbeat:Connect(function()
                local char = LocalPlayer.Character
                local tchar = target.Character
                if char and tchar then
                    char.HumanoidRootPart.Velocity = Vector3.new(0, 10000, 0)
                    char.HumanoidRootPart.CFrame = tchar.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0)
                end
            end)
        else
            if flingLoop then flingLoop:Disconnect() end
        end
    end
})

PlayerTab:CreateSection("Sistem")

PlayerTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        if httprequest then
            local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
            local response = httprequest({Url = url, Method = "GET"})
            local body = HttpService:JSONDecode(response.Body)
            for _, v in ipairs(body.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, LocalPlayer)
                    break
                end
            end
        end
    end
})

PlayerTab:CreateButton({
    Name = "Reset All Settings [Tab Player & Dunia]",
    Callback = function()
        ToggleNoclip:Set(false); ToggleFly:Set(false); ToggleInfJump:Set(false)
        SliderWalkSpeed:Set(16); SliderJumpPower:Set(50)
        workspace.Gravity = 196
        Rayfield:Notify({Title = "Reset", Content = "Settingan kembali default.", Duration = 3})
    end
})