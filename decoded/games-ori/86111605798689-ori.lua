-- Script khusus untuk "Star Fishing"

return function(Window)
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Client = Players.LocalPlayer
    
    local Connections = {}
    local AutoFishEnabled = false

    local function GetRoot(Character) 
        return Character and Character:FindFirstChild('HumanoidRootPart') 
    end
    
    local function GetHumanoid(Character) 
        return Character and Character:FindFirstChild('Humanoid') 
    end

    local function CastLogic()
        local Character = Client.Character
        local Humanoid = GetHumanoid(Character)
        local Root = GetRoot(Character)
        
        if not Root then return end

        local Rod = Character:FindFirstChild('Rod')
        if not Rod then return end

        local FarmType = {Root:GetPivot().Position + Vector3.new(0, 5, 0), Root:GetPivot().LookVector}
        
        local CastArguments = {
            Humanoid,
            FarmType[1],
            FarmType[2],
            Rod.Model.Nodes.RodTip.Attachment
        }

        local CastEvent = ReplicatedStorage.Events.Global.Cast
        CastEvent:FireServer(table.unpack(CastArguments))

        local WithdrawBobber = ReplicatedStorage.Events.Global.WithdrawBobber
        WithdrawBobber:FireServer(Humanoid)
    end

    local GameTab = Window:CreateTab("Star Fishing", 4483362458) 

    GameTab:CreateSection("🎣 Auto Farming")
    GameTab:CreateParagraph({
        Title = "PENTING!",
        Content = "Kamu harus memegang/meng-equip alat pancing (Rod) di tangan sebelum menyalakan Auto Fish."
    })

    GameTab:CreateToggle({
        Name = "Auto Fish (Instant Reel/Confirm)",
        CurrentValue = false,
        Flag = "AutoFishToggle",
        Callback = function(Value)
            AutoFishEnabled = Value
            
            if Value then
                local ClientRecieveItems = ReplicatedStorage.Events.Global.ClientRecieveItems
                local conn = ClientRecieveItems.OnClientEvent:Connect(function(...)
                    local Data = {...}
                    local Info = Data[4] or {}
                    local TimingTbl = Data[6] or {}

                    for Index, StarData in pairs(Info) do
                        local Id = StarData['id']
                        if Id then
                            task.wait(TimingTbl[Index] or 3)
                            local ClientItemConfirm = ReplicatedStorage.Events.Global.ClientItemConfirm
                            ClientItemConfirm:FireServer(Id)
                        end
                    end
                end)
                table.insert(Connections, conn)

                task.spawn(function()
                    while AutoFishEnabled and task.wait() do
                        CastLogic()
                    end
                end)
            else
                for _, conn in ipairs(Connections) do
                    if conn then conn:Disconnect() end
                end
                table.clear(Connections)
            end
        end
    })
end