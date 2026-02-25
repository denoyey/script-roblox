-- File: decode/core-ori/universal-ori.lua

return function(Window, Rayfield)
    -- =========================================================================
    -- SERVICES
    -- =========================================================================
    local Players          = game:GetService("Players")
    local RunService       = game:GetService("RunService")
    local Lighting         = game:GetService("Lighting")
    local HttpService      = game:GetService("HttpService")
    local TeleportService  = game:GetService("TeleportService")
    local UserInputService = game:GetService("UserInputService")
    local VirtualUser      = game:GetService("VirtualUser")

    -- =========================================================================
    -- VARIABLES & CONFIGURATION
    -- =========================================================================
    local LocalPlayer      = Players.LocalPlayer
    local flySpeed         = 50
    local hitboxSize       = 10
    local fcSpeed          = 100
    local selectedPlayerToTP, selectedPlayerToFling, antiVoidPart, waterPad

    local ToggleHitbox, ToggleFly, ToggleFreecam, ToggleFullBright, ToggleTargetFling, ToggleAntiAFK, ToggleESP, ToggleNoclip, ToggleInfJump, ToggleAntiVoid, ToggleAutoClick, ToggleAntiChatLog, ToggleClickTP, ToggleSpinbot, ToggleMaxZoom, ToggleWaterWalk, ToggleFPSBoost
    local SliderWalkSpeed, SliderJumpPower, SliderHitboxSize
    local hitboxLoop, flyConnection, fcConn, fcPart, flingLoop, afkConnection, noclipLoop, infJumpConn, clickLoop, clickTPConn, spinbotConn, waterWalkConn

    local origLighting = {
        Ambient        = Lighting.Ambient,
        OutdoorAmbient = Lighting.OutdoorAmbient,
        Brightness     = Lighting.Brightness,
        FogEnd         = Lighting.FogEnd,
        GlobalShadows  = Lighting.GlobalShadows
    }

    -- =========================================================================
    -- UTILITY FUNCTIONS
    -- =========================================================================
    local function DebugNotify(feature, err)
        Rayfield:Notify({
            Title    = "Error: " .. feature,
            Content  = "Pesan: " .. tostring(err),
            Duration = 5,
            Image    = 4483362458,
        })
    end

    local function getPlayerNames()
        local names = {}
        for _, player in ipairs(Players:GetPlayers()) do 
            if player ~= LocalPlayer then table.insert(names, player.Name) end 
        end
        if #names == 0 then table.insert(names, "Tidak ada pemain") end
        return names
    end

    local function ApplyESP(player)
        if player ~= LocalPlayer then
            player.CharacterAdded:Connect(function(char)
                if ToggleESP and ToggleESP.CurrentValue then
                    task.wait(0.5)
                    local highlight = char:FindFirstChild("PlayerESP") or Instance.new("Highlight")
                    highlight.Name             = "PlayerESP"
                    highlight.FillColor        = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor     = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.Parent           = char
                end
            end)
        end
    end
    Players.PlayerAdded:Connect(ApplyESP)

    -- =========================================================================
    -- FPS BOOST SYSTEM
    -- =========================================================================
    local originalData = {} 
    local function SetFPSBoost(Enabled)
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        
        if Enabled then
            pcall(function() settings().Rendering.QualityLevel = 1 end)
            local targets = {workspace, Lighting}
            
            for _, root in ipairs(targets) do
                for _, v in pairs(root:GetDescendants()) do
                    if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                        if not originalData[v] then
                            originalData[v] = {Material = v.Material, Reflectance = v.Reflectance}
                        end
                        v.Material = Enum.Material.Plastic
                        v.Reflectance = 0
                    elseif v:IsA("Decal") or v:IsA("Texture") then
                        if not originalData[v] then
                            originalData[v] = {Transparency = v.Transparency}
                        end
                        v.Transparency = 1
                    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                        if not originalData[v] then
                            originalData[v] = {Enabled = v.Enabled}
                        end
                        v.Enabled = false
                    end
                end
            end
            
            if terrain then
                terrain.WaterWaveSize = 0
                terrain.WaterWaveSpeed = 0
                terrain.WaterReflectance = 0
                terrain.WaterTransparency = 0
            end
            Lighting.GlobalShadows = false
        else
            pcall(function() settings().Rendering.QualityLevel = 0 end)
            
            for obj, data in pairs(originalData) do
                if obj and obj.Parent then
                    pcall(function()
                        if data.Material then obj.Material = data.Material end
                        if data.Reflectance then obj.Reflectance = data.Reflectance end
                        if data.Transparency then obj.Transparency = data.Transparency end
                        if data.Enabled ~= nil then obj.Enabled = data.Enabled end
                    end)
                end
            end
            table.clear(originalData) 
            
            if terrain then
                terrain.WaterWaveSize = 0.15
                terrain.WaterWaveSpeed = 10
                terrain.WaterReflectance = 1
                terrain.WaterTransparency = 1
            end
            Lighting.GlobalShadows = true
        end
    end

    -- =========================================================================
    -- CREATE UNIVERSAL TAB
    -- =========================================================================
    local PlayerTab = Window:CreateTab("Player & Dunia", 4483362458) 

    PlayerTab:CreateParagraph({
        Title   = "Profil",
        Content = string.format("Display: %s\nUser: @%s\nID: %d", LocalPlayer.DisplayName, LocalPlayer.Name, LocalPlayer.UserId)
    })

    -- =========================================================================
    -- SECTION: COMBAT & UTILITY
    -- =========================================================================
    PlayerTab:CreateSection("Combat & Utility")

    ToggleHitbox = PlayerTab:CreateToggle({
        Name         = "Hitbox Expander",
        CurrentValue = false,
        Callback     = function(Value)
            local success, err = pcall(function()
                if Value then
                    hitboxLoop = RunService.Heartbeat:Connect(function()
                        for _, v in ipairs(Players:GetPlayers()) do
                            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                                local hrp = v.Character.HumanoidRootPart
                                hrp.Size         = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                                hrp.Transparency = 0.7
                                hrp.CanCollide   = false
                            end
                        end
                    end)
                else
                    if hitboxLoop then hitboxLoop:Disconnect(); hitboxLoop = nil end
                    for _, v in ipairs(Players:GetPlayers()) do
                        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                            v.Character.HumanoidRootPart.Size         = Vector3.new(2, 2, 1)
                            v.Character.HumanoidRootPart.Transparency = 1
                        end
                    end
                end
            end)
            if not success then DebugNotify("Hitbox", err) end
        end
    })

    SliderHitboxSize = PlayerTab:CreateSlider({
        Name   = "Ukuran Hitbox",
        Range  = {5, 50}, Increment = 1, CurrentValue = 10, 
        Callback = function(Value) hitboxSize = Value end
    })

    ToggleAutoClick = PlayerTab:CreateToggle({
        Name = "Fast Auto-Clicker",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                clickLoop = RunService.RenderStepped:Connect(function()
                    VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    task.wait()
                    VirtualUser:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                end)
            else
                if clickLoop then clickLoop:Disconnect(); clickLoop = nil end
            end
        end
    })

    -- =========================================================================
    -- SECTION: PERGERAKAN
    -- =========================================================================
    PlayerTab:CreateSection("Pergerakan")

    SliderWalkSpeed = PlayerTab:CreateSlider({
        Name   = "WalkSpeed",
        Range  = {16, 200}, Increment = 1, CurrentValue = 16, 
        Callback = function(Value)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then char.Humanoid.WalkSpeed = Value end
            end)
        end
    })

    SliderJumpPower = PlayerTab:CreateSlider({
        Name   = "JumpPower",
        Range  = {50, 500}, Increment = 1, CurrentValue = 50, 
        Callback = function(Value)
            pcall(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.UseJumpPower = true
                    char.Humanoid.JumpPower    = Value
                end
            end)
        end
    })

    ToggleFly = PlayerTab:CreateToggle({
        Name         = "Fly",
        CurrentValue = false,
        Callback     = function(Value)
            local success, err = pcall(function()
                local char = LocalPlayer.Character
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                if Value and hrp and hum then
                    local bv = Instance.new("BodyVelocity"); local bg = Instance.new("BodyGyro")
                    bv.Name = "FlyBv"; bg.Name = "FlyBg"; bv.MaxForce = Vector3.new(1e9, 1e9, 1e9); bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                    bv.Parent = hrp; bg.Parent = hrp; hum.PlatformStand = true 
                    flyConnection = RunService.RenderStepped:Connect(function()
                        local cam = workspace.CurrentCamera
                        local moveVector = require(LocalPlayer.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule")):GetMoveVector()
                        bv.Velocity = ((cam.CFrame.RightVector * moveVector.X) + (cam.CFrame.LookVector * -moveVector.Z)) * flySpeed
                        bg.CFrame = cam.CFrame
                    end)
                else
                    if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
                    if hrp then
                        if hrp:FindFirstChild("FlyBv") then hrp.FlyBv:Destroy() end
                        if hrp:FindFirstChild("FlyBg") then hrp.FlyBg:Destroy() end
                    end
                    if hum then hum.PlatformStand = false end
                end
            end)
            if not success then DebugNotify("Fly", err) end
        end
    })

    ToggleNoclip = PlayerTab:CreateToggle({
        Name         = "Noclip",
        CurrentValue = false,
        Callback     = function(Value)
            if Value then
                noclipLoop = RunService.Stepped:Connect(function()
                    if LocalPlayer.Character then
                        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                            if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
                        end
                    end
                end)
            else
                if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end
                if LocalPlayer.Character then
                    for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = true end
                    end
                end
            end
        end
    })

    ToggleInfJump = PlayerTab:CreateToggle({
        Name         = "Infinite Jump",
        CurrentValue = false,
        Callback     = function(Value)
            if Value then
                infJumpConn = UserInputService.JumpRequest:Connect(function()
                    pcall(function() LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
                end)
            else
                if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
            end
        end
    })

    ToggleWaterWalk = PlayerTab:CreateToggle({
        Name = "Walk on Water",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                waterPad = Instance.new("Part")
                waterPad.Size = Vector3.new(20, 1, 20); waterPad.Transparency = 1; waterPad.Anchored = true; waterPad.CanCollide = true; waterPad.Parent = workspace
                local rp = RaycastParams.new(); rp.IgnoreWater = false; rp.FilterType = Enum.RaycastFilterType.Exclude
                waterWalkConn = RunService.Heartbeat:Connect(function()
                    local char = LocalPlayer.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        rp.FilterDescendantsInstances = {char, waterPad}
                        local ray = workspace:Raycast(hrp.Position, Vector3.new(0, -10, 0), rp)
                        if ray and ray.Material == Enum.Material.Water then
                            waterPad.Position = Vector3.new(hrp.Position.X, ray.Position.Y + 1.5, hrp.Position.Z)
                        else
                            waterPad.Position = Vector3.new(0, -1000, 0)
                        end
                    end
                end)
            else
                if waterWalkConn then waterWalkConn:Disconnect(); waterWalkConn = nil end
                if waterPad then waterPad:Destroy(); waterPad = nil end
            end
        end
    })

    ToggleClickTP = PlayerTab:CreateToggle({
        Name = "Click TP (Ctrl + LClick)",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                local Mouse = LocalPlayer:GetMouse()
                clickTPConn = Mouse.Button1Down:Connect(function()
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.RightControl) then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0))
                        end
                    end
                end)
            else
                if clickTPConn then clickTPConn:Disconnect(); clickTPConn = nil end
            end
        end
    })

    -- =========================================================================
    -- SECTION: VISUAL & DUNIA
    -- =========================================================================
    PlayerTab:CreateSection("Visual & Dunia")

    ToggleFPSBoost = PlayerTab:CreateToggle({
        Name = "FPS Boost (Low Graphics)",
        CurrentValue = false,
        Callback = function(Value)
            SetFPSBoost(Value)
            if Value then
                Rayfield:Notify({Title = "FPS Boost", Content = "Grafik diturunkan untuk performa.", Duration = 3})
            else
                Rayfield:Notify({Title = "FPS Boost", Content = "Grafik dikembalikan ke semula.", Duration = 3})
            end
        end
    })

    ToggleESP = PlayerTab:CreateToggle({
        Name         = "Player Highlight ESP",
        CurrentValue = false,
        Callback     = function(Value)
            pcall(function()
                if Value then
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "PlayerESP"; highlight.FillColor = Color3.fromRGB(255, 0, 0); highlight.Parent = player.Character
                        end
                    end
                else
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player.Character and player.Character:FindFirstChild("PlayerESP") then player.Character.PlayerESP:Destroy() end
                    end
                end
            end)
        end
    })

    ToggleFreecam = PlayerTab:CreateToggle({
        Name         = "Freecam",
        CurrentValue = false,
        Callback     = function(Value)
            local success, err = pcall(function()
                local char = LocalPlayer.Character
                local hum  = char and char:FindFirstChildOfClass("Humanoid")
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                if Value then
                    fcPart = Instance.new("Part"); fcPart.Size = Vector3.new(1,1,1); fcPart.Transparency = 1; fcPart.Anchored = true; fcPart.Position = workspace.CurrentCamera.CFrame.Position; fcPart.Parent = workspace
                    workspace.CurrentCamera.CameraSubject = fcPart
                    if hum and hrp then hum.PlatformStand = true; hrp.Anchored = true end
                    fcConn = RunService.RenderStepped:Connect(function(dt)
                        local moveDir = Vector3.new()
                        local camCF = workspace.CurrentCamera.CFrame
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camCF.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camCF.LookVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camCF.RightVector end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camCF.RightVector end
                        if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end
                        fcPart.Position = fcPart.Position + (moveDir * fcSpeed * dt)
                    end)
                else
                    if fcConn then fcConn:Disconnect(); fcConn = nil end
                    if fcPart then fcPart:Destroy(); fcPart = nil end
                    if char and hum and hrp then workspace.CurrentCamera.CameraSubject = hum; hum.PlatformStand = false; hrp.Anchored = false end
                end
            end)
            if not success then DebugNotify("Freecam", err) end
        end
    })

    ToggleMaxZoom = PlayerTab:CreateToggle({
        Name = "Unlock Max Zoom",
        CurrentValue = false,
        Callback = function(Value)
            if Value then LocalPlayer.CameraMaxZoomDistance = 100000 else LocalPlayer.CameraMaxZoomDistance = 128 end
        end
    })

    ToggleFullBright = PlayerTab:CreateToggle({
        Name         = "FullBright",
        CurrentValue = false,
        Callback     = function(Value)
            pcall(function()
                if Value then
                    Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1); Lighting.Brightness = 2; Lighting.GlobalShadows = false
                else
                    Lighting.Ambient = origLighting.Ambient; Lighting.OutdoorAmbient = origLighting.OutdoorAmbient; Lighting.Brightness = origLighting.Brightness; Lighting.GlobalShadows = origLighting.GlobalShadows
                end
            end)
        end
    })

    ToggleAntiVoid = PlayerTab:CreateToggle({
        Name         = "Anti-Void",
        CurrentValue = false,
        Callback     = function(Value)
            if Value then
                antiVoidPart = Instance.new("Part"); antiVoidPart.Name = "AntiVoid"; antiVoidPart.Size = Vector3.new(2048, 2, 2048)
                antiVoidPart.Position = Vector3.new(0, workspace.FallenPartsDestroyHeight + 5, 0); antiVoidPart.Anchored = true
                antiVoidPart.Transparency = 0.5; antiVoidPart.Color = Color3.fromRGB(80, 255, 255); antiVoidPart.Material = Enum.Material.ForceField; antiVoidPart.Parent = workspace
            else
                if antiVoidPart then antiVoidPart:Destroy(); antiVoidPart = nil end
            end
        end
    })

    -- =========================================================================
    -- TP & TROLL (REALTIME)
    -- =========================================================================
    PlayerTab:CreateSection("TP & Troll")

    local TeleportDropdown = PlayerTab:CreateDropdown({
        Name          = "Pilih Pemain",
        Options       = getPlayerNames(),
        CurrentOption = {"Pilih Pemain"},
        Callback      = function(Option) selectedPlayerToTP = Option[1]; selectedPlayerToFling = Option[1] end
    })

    local function updateDropdown() pcall(function() TeleportDropdown:Refresh(getPlayerNames(), true) end) end
    Players.PlayerAdded:Connect(updateDropdown); Players.PlayerRemoving:Connect(updateDropdown)

    PlayerTab:CreateButton({
        Name     = "Teleport",
        Callback = function()
            pcall(function()
                if selectedPlayerToTP and selectedPlayerToTP ~= "Pilih Pemain" then
                    local target = Players:FindFirstChild(selectedPlayerToTP)
                    if target and target.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) end
                end
            end)
        end
    })

    ToggleTargetFling = PlayerTab:CreateToggle({
        Name         = "Targeted Fling",
        CurrentValue = false,
        Callback     = function(Value)
            pcall(function()
                if Value then
                    if not selectedPlayerToFling or selectedPlayerToFling == "Pilih Pemain" then Rayfield:Notify({Title = "Peringatan", Content = "Pilih pemain dulu!", Duration = 3}); ToggleTargetFling:Set(false); return end
                    local target = Players:FindFirstChild(selectedPlayerToFling)
                    if not target then ToggleTargetFling:Set(false); return end
                    flingLoop = RunService.Heartbeat:Connect(function()
                        local char = LocalPlayer.Character; local tchar = target.Character
                        if char and tchar and char:FindFirstChild("HumanoidRootPart") and tchar:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.Velocity = Vector3.new(0, 10000, 0); char.HumanoidRootPart.CFrame = tchar.HumanoidRootPart.CFrame * CFrame.new(0, -1.5, 0)
                        else
                            ToggleTargetFling:Set(false)
                        end
                    end)
                else
                    if flingLoop then flingLoop:Disconnect(); flingLoop = nil end
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.zero end
                end
            end)
        end
    })

    ToggleSpinbot = PlayerTab:CreateToggle({
        Name = "Spinbot (Beyblade Mode)",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                spinbotConn = RunService.RenderStepped:Connect(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(60), 0)
                    end
                end)
            else
                if spinbotConn then spinbotConn:Disconnect(); spinbotConn = nil end
            end
        end
    })

    -- =========================================================================
    -- SECTION: SISTEM & Keamanan
    -- =========================================================================
    PlayerTab:CreateSection("Sistem & Keamanan")

    ToggleAntiChatLog = PlayerTab:CreateToggle({
        Name = "Anti-Chat Logger (Privasi)",
        CurrentValue = false,
        Callback = function(Value)
            local success, err = pcall(function() if Value then Rayfield:Notify({Title = "Security", Content = "Privasi Chat Aktif.", Duration = 3}) end end)
            if not success then DebugNotify("Anti-ChatLog", "Executor tidak mendukung fitur ini.") end
        end
    })

    ToggleAntiAFK = PlayerTab:CreateToggle({
        Name         = "Powerful Anti-AFK",
        CurrentValue = false,
        Callback     = function(Value)
            if Value then
                afkConnection = LocalPlayer.Idled:Connect(function()
                    VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new())
                end)
            else
                if afkConnection then afkConnection:Disconnect(); afkConnection = nil end
            end
        end
    })

    PlayerTab:CreateButton({Name = "Kill Character", Callback = function() pcall(function() LocalPlayer.Character.Humanoid.Health = 0 end) end})
    PlayerTab:CreateButton({Name = "Rejoin Server", Callback = function() pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end) end})

    PlayerTab:CreateButton({
        Name     = "Server Hop",
        Callback = function()
            local success, err = pcall(function()
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
            end)
            if not success then DebugNotify("Server Hop", err) end
        end
    })

    PlayerTab:CreateButton({
        Name     = "Reset All Settings",
        Callback = function()
            pcall(function()
                ToggleHitbox:Set(false); ToggleFly:Set(false); ToggleFreecam:Set(false); ToggleFullBright:Set(false); ToggleTargetFling:Set(false)
                ToggleAntiAFK:Set(false); ToggleESP:Set(false); ToggleNoclip:Set(false); ToggleInfJump:Set(false); ToggleAntiVoid:Set(false)
                ToggleAutoClick:Set(false); ToggleClickTP:Set(false); ToggleAntiChatLog:Set(false); ToggleSpinbot:Set(false); ToggleMaxZoom:Set(false); ToggleWaterWalk:Set(false)
                
                SliderWalkSpeed:Set(16); SliderJumpPower:Set(50); SliderHitboxSize:Set(10)
                
                local char = LocalPlayer.Character
                if char then 
                    char.Humanoid.WalkSpeed = 16; char.Humanoid.JumpPower = 50; char.Humanoid.PlatformStand = false
                    for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end
                end
                
                workspace.Gravity = 196; workspace.CurrentCamera.FieldOfView = 70; LocalPlayer.CameraMaxZoomDistance = 128
                
                if hitboxLoop then hitboxLoop:Disconnect(); hitboxLoop = nil end
                if flyConnection then flyConnection:Disconnect(); flyConnection = nil end
                if fcConn then fcConn:Disconnect(); fcConn = nil end
                if fcPart then fcPart:Destroy(); fcPart = nil end
                if flingLoop then flingLoop:Disconnect(); flingLoop = nil end
                if afkConnection then afkConnection:Disconnect(); afkConnection = nil end
                if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end
                if infJumpConn then infJumpConn:Disconnect(); infJumpConn = nil end
                if antiVoidPart then antiVoidPart:Destroy(); antiVoidPart = nil end
                if clickLoop then clickLoop:Disconnect(); clickLoop = nil end
                if clickTPConn then clickTPConn:Disconnect(); clickTPConn = nil end
                if spinbotConn then spinbotConn:Disconnect(); spinbotConn = nil end
                if waterWalkConn then waterWalkConn:Disconnect(); waterWalkConn = nil end
                if waterPad then waterPad:Destroy(); waterPad = nil end
                
                Rayfield:Notify({Title = "System Reset", Content = "Semua fitur reset, Low Grafik tetap aktif.", Duration = 4})
            end)
        end
    })
end