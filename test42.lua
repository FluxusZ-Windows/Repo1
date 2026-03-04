-- [ Services ] --
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local RS = game:GetService("ReplicatedStorage")

-- [ Tween Player Function ] --
_G["Player Tween Speed"] = 300

function TweenPlayer(pos)
    task.spawn(function()
        pcall(function()
            local player = game:GetService("Players").LocalPlayer
            local character = player.Character
            if not character then return end

            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart then return end

            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Sit then
                humanoid.Sit = false
            end

            if player:DistanceFromCharacter(pos.Position) <= 50 then
                humanoidRootPart.CFrame = pos
                local root = character:FindFirstChild("Root")
                if root then root:Destroy() end
                return
            end

            local root = character:FindFirstChild("Root")
            if not root then
                root = Instance.new("Part")
                root.Size = Vector3.new(1, 0.5, 1)
                root.Name = "Root"
                root.Anchored = true
                root.Transparency = 1
                root.CanCollide = false
                root.CFrame = humanoidRootPart.CFrame
                root.Parent = character
            end

            local distance = (humanoidRootPart.Position - pos.Position).Magnitude
            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(distance / _G["Player Tween Speed"], Enum.EasingStyle.Linear)
            local tween = tweenService:Create(root, tweenInfo, { CFrame = pos })
            tween:Play()
            tween.Completed:Wait()

            humanoidRootPart.CFrame = pos
            if character:FindFirstChild("Root") then
                character.Root:Destroy()
            end
        end)
    end)
end

-- [ Root sync ] --
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        pcall(function()
            local char = game.Players.LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("Root")
            if not root then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = root.CFrame end
        end)
    end)
end)

-- [ SimulationRadius ] --
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        pcall(function()
            if setscriptable then setscriptable(game.Players.LocalPlayer, "SimulationRadius", true) end
            if sethiddenproperty then sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge) end
        end)
    end)
end)

-- [ Configuration ] --
local Config = {
    MeowHubName = "Meow Hub",
    MeowIcon = "rbxassetid://132010063646173",
    DiscordLink = "Discord.gg/CSrgXpuYTF",
    LibraryUrl = "https://gitlab.com/Dev-MeowHub/scripts/-/raw/main/Libraries/UI/WindUI-Boreal.lua"
}

-- [ Load WindUI ] --
local WindUI = loadstring(game:HttpGet(Config.LibraryUrl))()

WindUI:Notify({
    Title = Config.MeowHubName,
    Content = "Loading...",
    Icon = "solar:loading-bold",
    Duration = 3.5,
})

task.wait(3)

-- [ Window ] --
local Window = WindUI:CreateWindow({
    Title = Config.MeowHubName,
    Author = "by CreatorNovaAxis • " .. Config.DiscordLink,
    Icon = Config.MeowIcon,
    Folder = "MeowHub",
    Size = UDim2.fromOffset(620, 250),
    Transparent = false,
    Resizable = true,
    ModernLayout = true,
    BottomDragBarEnabled = true,
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = Config.MeowHubName,
                Content = "Hi " .. game.Players.LocalPlayer.Name .. "!",
                Icon = "solar:user-bold",
                Duration = 5,
            })
        end,
    },
    Watermark = {
        Enabled = true,
        Text = Config.DiscordLink,
        Opacity = 0.25,
        Position = "bottom-right",
        Size = 12,
        Padding = 12,
        Offset = Vector2.new(0, 0),
    },
    OpenButton = {
        Title = Config.MeowHubName,
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 1.0,
        Color = ColorSequence.new(
            Color3.fromHex("#ffc0cb"),
            Color3.fromHex("#806063")
        )
    },
})

Window:SetToggleKey(Enum.KeyCode.M)

-- [ Colors ] --
local Pink = Color3.fromHex("#ffc0cb")

-- ============================================================
-- [ HOME TAB ]
-- ============================================================
local HomeTab = Window:Tab({
    Title = "Home",
    Icon = "solar:home-2-bold",
    IconColor = Pink,
    IconShape = "Square",
    ShowTabTitle = false,
    Border = true,
})

local HomeMultiSection = HomeTab:MultiSection({
    Title = "Home",
    Icon = "solar:home-2-bold",
    Box = true,
    BoxBorder = true,
    Opened = true,
})

-- [ Info Sub-Tab ] --
local InfoTab = HomeMultiSection:Tab({
    Title = "Info",
    Desc = "Information",
    Icon = "solar:info-circle-bold",
    Selected = true,
})

local DiscordServerSection = InfoTab:Section({
    Title = "Discord Server",
    Desc = "Info about future upds & much more!",
    Icon = "solar:chat-round-dots-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

-- [ Banner ] --
do
    local ok, res = pcall(function() return game:HttpGet("https://gitlab.com/Dev-MeowHub/scripts/-/raw/main/Config/Banner.json") end)
    local banner = nil
    if ok then
        local ok2, cfg = pcall(function() return HttpService:JSONDecode(res) end)
        if ok2 then banner = cfg.banner end
    end

    local function GetDiscordInviteData(code)
        local s, r = pcall(function() return game:HttpGet("https://discord.com/api/v10/invites/" .. code .. "?with_counts=true") end)
        if not s then return nil, r end
        local s2, d = pcall(function() return HttpService:JSONDecode(r) end)
        if not s2 then return nil, d end
        return d
    end

    local Response, Error = GetDiscordInviteData("CSrgXpuYTF")

    if Response and Response.guild then
        local DiscordParagraph = DiscordServerSection:Paragraph({
            Title = tostring(Response.guild.name),
            Desc = ' <font color="#52525b">•</font> Members: ' .. tostring(Response.approximate_member_count) ..
                   '\n <font color="#16a34a">•</font> Online: ' .. tostring(Response.approximate_presence_count),
            Image = not RunService:IsStudio() and ("https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024") or nil,
            Thumbnail = (banner and (banner:sub(1,4) == "http" or banner:sub(1,13) == "rbxassetid://")) and banner or nil,
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy Invite Link",
                    Icon = "solar:link-bold",
                    Callback = function()
                        if setclipboard then
                            setclipboard(Config.DiscordLink)
                            WindUI:Notify({ Title = Config.MeowHubName, Content = "Invite link copied!", Icon = "solar:link-bold", Duration = 5 })
                        end
                    end
                },
                {
                    Title = "Refresh",
                    Icon = "solar:refresh-bold",
                    Callback = function()
                        local U = GetDiscordInviteData("CSrgXpuYTF")
                        if U and U.guild then
                            DiscordParagraph:SetDesc(
                                ' <font color="#52525b">•</font> Members: ' .. tostring(U.approximate_member_count) ..
                                '\n <font color="#16a34a">•</font> Online: ' .. tostring(U.approximate_presence_count)
                            )
                        end
                    end
                }
            }
        })
    else
        DiscordServerSection:Paragraph({
            Title = "Failed to fetch Discord info",
            Desc = Error and tostring(Error) or "No data",
            Color = "Red",
        })
    end
end

local CreditsSection = InfoTab:Section({
    Title = "Credits",
    Desc = "Resources used and their authors",
    Icon = "solar:heart-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

CreditsSection:Paragraph({
    Title = "CreatorNovaAxis - Meow Hub", Desc = "Creator of Meow Hub",
    Buttons = {{ Title = "Copy Discord Link", Icon = "solar:link-bold", Callback = function()
        setclipboard(Config.DiscordLink)
        WindUI:Notify({ Title = Config.MeowHubName, Content = "Link copied!", Icon = "solar:link-bold", Duration = 5 })
    end }}
})
CreditsSection:Paragraph({
    Title = "orialdev - WindUI Boreal", Desc = "WindUI Boreal UI Library (Fork of WindUI)",
    Buttons = {{ Title = "Copy Github Link", Icon = "solar:link-bold", Callback = function()
        setclipboard("https://github.com/orialdev")
        WindUI:Notify({ Title = Config.MeowHubName, Content = "Link copied!", Icon = "solar:link-bold", Duration = 5 })
    end }}
})
CreditsSection:Paragraph({
    Title = "Footagesus - WindUI", Desc = "WindUI UI Library",
    Buttons = {{ Title = "Copy Github Link", Icon = "solar:link-bold", Callback = function()
        setclipboard("https://github.com/footagesus")
        WindUI:Notify({ Title = Config.MeowHubName, Content = "Link copied!", Icon = "solar:link-bold", Duration = 5 })
    end }}
})

-- [ Settings Sub-Tab ] --
local SettingsTab = HomeMultiSection:Tab({
    Title = "Settings",
    Desc = "Customizable UI Window",
    Icon = "solar:settings-bold",
    Selected = false,
})

local SettingsSection = SettingsTab:Section({
    Title = "Settings",
    Desc = "Customizable UI Window",
    Icon = "solar:settings-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

SettingsSection:Keybind({
    Title = "Keybind (Toggle UI)",
    Desc = "Keybind to open UI",
    Value = "M",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

SettingsSection:Dropdown({
    Title = "Choose Theme",
    Desc = "Choose a theme for the UI",
    Icon = "solar:pallete-2-bold",
    Values = { "Dark","Light","Rose","Plant","Red","Indigo","Sky","Violet","Amber","Emerald","Midnight","Crimson","MonkaiPro","CottonCandy","Mellowsi" },
    Value = "Dark",
    Callback = function(selected)
        WindUI:SetTheme(selected)
    end
})

-- ============================================================
-- [ SHOP TAB ]
-- ============================================================
local ShopTab = Window:Tab({
    Title = "Shop",
    Icon = "solar:bag-4-bold",
    IconColor = Pink,
    IconShape = "Square",
    ShowTabTitle = false,
    Border = true,
})

local FightingStylesSection = ShopTab:Section({
    Title = "Fighting Styles",
    Desc = "You can buy Fighting Styles",
    Icon = "solar:fire-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

local function BuyButton(remote, ...)
    local args = {...}
    return {
        Title = "Buy",
        Icon = "solar:dollar-minimalistic-bold",
        Callback = function()
            RS.Remotes.CommF_:InvokeServer(remote, table.unpack(args))
        end
    }
end

FightingStylesSection:Paragraph({ Title = "Dark Step",       Desc = "$150,000",             Image = "https://static.wikia.nocookie.net/blox-fruits/images/1/11/DarkStepA.png/revision/latest?cb=20230429200337&path-prefix=ru",      ImageSize = 65, Buttons = { BuyButton("BuyBlackLeg") } })
FightingStylesSection:Paragraph({ Title = "Electro",          Desc = "$500,000",             Image = "https://static.wikia.nocookie.net/blox-fruits/images/3/36/ElectricA.png/revision/latest?cb=20221018092049&path-prefix=ru",       ImageSize = 65, Buttons = { BuyButton("BuyElectro") } })
FightingStylesSection:Paragraph({ Title = "Water Kung Fu",    Desc = "$750,000",             Image = "https://static.wikia.nocookie.net/blox-fruits/images/b/b0/WaterKungFuA.png/revision/latest?cb=20221018092050&path-prefix=ru",    ImageSize = 65, Buttons = { BuyButton("BuyWaterKungFu") } })
FightingStylesSection:Paragraph({ Title = "Superhuman",       Desc = "$3,000,000",           Image = "https://static.wikia.nocookie.net/blox-fruits/images/c/cf/SuperhumanA.png/revision/latest?cb=20221018092050&path-prefix=ru",     ImageSize = 65, Buttons = { BuyButton("BuySuperhuman") } })
FightingStylesSection:Paragraph({ Title = "Death Step",       Desc = "$5,000,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/7/7a/DeathStepA.png/revision/latest?cb=20221018092046&path-prefix=ru",      ImageSize = 65, Buttons = { BuyButton("BuyDeathStep") } })
FightingStylesSection:Paragraph({ Title = "Sharkman Karate",  Desc = "$2,500,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/d/d8/SharkmanKarateA.png/revision/latest?cb=20221018092050&path-prefix=ru", ImageSize = 65, Buttons = {{ Title = "Buy", Icon = "solar:dollar-minimalistic-bold", Callback = function() RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate", true) RS.Remotes.CommF_:InvokeServer("BuySharkmanKarate") end }} })
FightingStylesSection:Paragraph({ Title = "Electric Claw",    Desc = "$3,000,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/6/60/ElectricClawA.png/revision/latest?cb=20221018092050&path-prefix=ru",  ImageSize = 65, Buttons = { BuyButton("BuyElectricClaw") } })
FightingStylesSection:Paragraph({ Title = "Dragon Talon",     Desc = "$3,000,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/5/57/DragonTalonA.png/revision/latest?cb=20221018092050&path-prefix=ru",   ImageSize = 65, Buttons = { BuyButton("BuyDragonTalon") } })
FightingStylesSection:Paragraph({ Title = "God Human",        Desc = "$5,000,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/9/9f/GodhumanA.png/revision/latest?cb=20221018092050&path-prefix=ru",      ImageSize = 65, Buttons = { BuyButton("BuyGodhuman") } })
FightingStylesSection:Paragraph({ Title = "Sanguine Art",     Desc = "$5,000,000 / F'5,000", Image = "https://static.wikia.nocookie.net/blox-fruits/images/8/8b/SanguineArtA.png/revision/latest?cb=20231025181048&path-prefix=ru",   ImageSize = 65, Buttons = {{ Title = "Buy", Icon = "solar:dollar-minimalistic-bold", Callback = function() RS.Remotes.CommF_:InvokeServer("BuySanguineArt", true) RS.Remotes.CommF_:InvokeServer("BuySanguineArt") end }} })

-- Dragon Claw отдельно (двойной invoke с разными аргументами)
FightingStylesSection:Paragraph({ Title = "Dragon Claw", Desc = "F'1,500", Image = "https://static.wikia.nocookie.net/blox-fruits/images/8/8e/DragonClawA.png/revision/latest?cb=20221018092047&path-prefix=ru", ImageSize = 65,
    Buttons = {{ Title = "Buy", Icon = "solar:dollar-minimalistic-bold", Callback = function()
        RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
    end }}
})

-- ============================================================
-- [ TELEPORT TAB ]
-- ============================================================
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "solar:map-point-bold",
    IconColor = Pink,
    IconShape = "Square",
    ShowTabTitle = false,
    Border = true,
})

local SeaTravelSection = TeleportTab:Section({
    Title = "Sea Travel",
    Desc = "Travel between seas",
    Icon = "solar:ship-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

SeaTravelSection:Button({ Title = "Teleport To First Sea",  Callback = function() RS.Remotes.CommF_:InvokeServer("TravelMain") end })
SeaTravelSection:Button({ Title = "Teleport To Second Sea", Callback = function() RS.Remotes.CommF_:InvokeServer("TravelDressrosa") end })
SeaTravelSection:Button({ Title = "Teleport To Third Sea",  Callback = function() RS.Remotes.CommF_:InvokeServer("TravelZou") end })

local TeleportSection = TeleportTab:Section({
    Title = "Teleport",
    Desc = "Fast teleport to islands & NPCs",
    Icon = "solar:map-point-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

TeleportSection:Slider({
    Title = "Player Tween Speed",
    Step = 1,
    Value = { Min = 10, Max = 325, Default = _G["Player Tween Speed"] },
    Callback = function(value)
        _G["Player Tween Speed"] = value
    end
})

TeleportSection:Button({
    Title = "Teleport",
    Icon = "solar:map-point-bold",
    Callback = function()
        TweenPlayer(CFrame.new(-1475.71, 22.89, 370.25))
    end
})

-- ============================================================
WindUI:Notify({
    Title = Config.MeowHubName,
    Content = "Loaded Successfully!",
    Icon = "solar:check-circle-bold",
    Duration = 3,
})
