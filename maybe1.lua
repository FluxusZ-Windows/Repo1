-- [ Services ] --
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- [ Function(s) ] --

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
            local tweenInfo = TweenInfo.new(
                distance / _G["Player Tween Speed"],
                Enum.EasingStyle.Linear
            )

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
            if hrp then
                hrp.CFrame = root.CFrame
            end
        end)
    end)
end)

-- [ SimulationRadius ] --
task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        pcall(function()
            if setscriptable then
                setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
            end
            if sethiddenproperty then
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end
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

-- [ WindUI Notify ] --
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

    -- [ Top Bar ] --
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },

    -- [ User ] --
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

    -- [ Watermark ] --
    Watermark = {
        Enabled = true,
        Text = Config.DiscordLink,
        Opacity = 0.25,
        Position = "bottom-right",
        Size = 12,
        Padding = 12,
        Offset = Vector2.new(0, 0),
    },

    -- [ Open Button ] --
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

-- [ Window Settings ] --
Window:SetToggleKey(Enum.KeyCode.M)

-- [ Colors ] --
local Red    = Color3.fromHex("#EF4F1D")
local Orange = Color3.fromHex("#ECA201")
local Yellow = Color3.fromHex("#F5E642")
local Green  = Color3.fromHex("#10C550")
local Cyan   = Color3.fromHex("#00BFFF")
local Blue   = Color3.fromHex("#257AF7")
local Purple = Color3.fromHex("#7775F2")

local Pink  = Color3.fromHex("#ffc0cb")
local Brown = Color3.fromHex("#806063")

-- [ Home Tab ] --
local HomeTab = Window:Tab({
    Title = "Home",
    Desc = "Home Tab",

    Icon = "solar:home-2-bold",
    IconColor = Pink,
    IconShape = "Square",

    Locked = false,
    ShowTabTitle = false,
    Border = true,
})

-- [ Home Multi Section ] --
local HomeMultiSection = HomeTab:MultiSection({
    Title = "Home",
    Desc = "Home Multi Section",
    Icon = "solar:home-2-bold",
    Box = true,
    BoxBorder = true,
    Opened = true,
})

-- [ Info Tab ] --
local InfoTab = HomeMultiSection:Tab({
    Title = "Info",
    Desc = "Information",
    Icon = "solar:info-circle-bold",
    Selected = true,
})

-- [ Discord Server ] --
local DiscordServerSection = InfoTab:Section({
    Title = "Discord Server",
    Desc = "Info about future upds & much more!",
    Icon = "solar:chat-round-dots-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

-- [ Banner ] --
local configUrl = "https://gitlab.com/Dev-MeowHub/scripts/-/raw/main/Config/Banner.json"
local success, response = pcall(function()
    return game:HttpGet(configUrl)
end)
local banner = nil
if success then
    local config = HttpService:JSONDecode(response)
    banner = config.banner
end

-- [ Discord Server ] --
do
    local InviteCode = "CSrgXpuYTF"

    local function GetDiscordInviteData(code)
        local url = "https://discord.com/api/v10/invites/" .. code .. "?with_counts=true"
        local success, response = pcall(function()
            return game:HttpGet(url)
        end)
        if not success then return nil, response end
        local decoded
        success, decoded = pcall(function()
            return HttpService:JSONDecode(response)
        end)
        if not success then return nil, decoded end
        return decoded
    end

    local Response, Error = GetDiscordInviteData(InviteCode)

    if Response and Response.guild then
        local DiscordServerParagraph = DiscordServerSection:Paragraph({
            Title = tostring(Response.guild.name),
            Desc =
                ' <font color="#52525b">•</font> Members: ' .. tostring(Response.approximate_member_count) ..
                '\n <font color="#16a34a">•</font> Online: ' .. tostring(Response.approximate_presence_count),
            Image = not RunService:IsStudio()
                and ("https://cdn.discordapp.com/icons/" .. Response.guild.id .. "/" .. Response.guild.icon .. ".png?size=1024")
                or nil,
            Thumbnail = (banner and (banner:sub(1,4) == "http" or banner:sub(1,13) == "rbxassetid://"))
                and banner
                or nil,
            ImageSize = 48,
            Buttons = {
                {
                    Title = "Copy Invite Link",
                    Icon = "solar:link-bold",
                    Callback = function()
                        if setclipboard then
                            setclipboard(Config.DiscordLink)
                            WindUI:Notify({
                                Title = Config.MeowHubName,
                                Content = "Invite link copied to clipboard!",
                                Icon = "solar:link-bold",
                                Duration = 5,
                            })
                        end
                    end
                },
                {
                    Title = "Refresh",
                    Icon = "solar:refresh-bold",
                    Callback = function()
                        local Updated = GetDiscordInviteData(InviteCode)
                        if Updated and Updated.guild then
                            DiscordServerParagraph:SetDesc(
                                ' <font color="#52525b">•</font> Members: ' .. tostring(Updated.approximate_member_count) ..
                                '\n <font color="#16a34a">•</font> Online: ' .. tostring(Updated.approximate_presence_count)
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

-- [ Credits ] --
local CreditsSection = InfoTab:Section({
    Title = "Credits",
    Desc = "Resources used and their authors",
    Icon = "solar:heart-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

-- CreatorNovaAxis - Meow Hub
CreditsSection:Paragraph({
    Title = "CreatorNovaAxis - Meow Hub",
    Desc = "Creator of Meow Hub",
    Buttons = {
        {
            Title = "Copy Invite Link (Discord Server)",
            Icon = "solar:link-bold",
            Callback = function()
                setclipboard(Config.DiscordLink)
                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "solar:link-bold",
                    Duration = 5,
                })
            end
        },
    }
})

-- Orialdev - WindUI Boreal
CreditsSection:Paragraph({
    Title = "orialdev - WindUI Boreal (Fork of WindUI)",
    Desc = "WindUI Boreal UI Library (Fork of WindUI)",
    Buttons = {
        {
            Title = "Copy link to author (Github)",
            Icon = "solar:link-bold",
            Callback = function()
                setclipboard("https://github.com/orialdev")
                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "solar:link-bold",
                    Duration = 5,
                })
            end
        },
    }
})

-- Footagesus - WindUI
CreditsSection:Paragraph({
    Title = "Footagesus - WindUI",
    Desc = "WindUI UI Library",
    Buttons = {
        {
            Title = "Copy link to author (Github)",
            Icon = "solar:link-bold",
            Callback = function()
                setclipboard("https://github.com/footagesus")
                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "solar:link-bold",
                    Duration = 5,
                })
            end
        },
    }
})

-- [ Settings Tab ] --
local SettingsTab = HomeMultiSection:Tab({
    Title = "Settings",
    Desc = "Customizable UI Window",
    Icon = "solar:settings-bold",
    Selected = false,
})

-- [ Settings ] --
local SettingsSection = SettingsTab:Section({
    Title = "Settings",
    Desc = "Customizable UI Window",
    Icon = "solar:settings-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

-- [ Set Background Image (Input) ] --
SettingsSection:Input({
    Title = "Set Background Image",
    Desc = "Enter your rbxassetid",
    Icon = "solar:gallery-bold",
    Type = "Textarea",
    Placeholder = "Enter rbxassetid",
    Locked = false,
    Callback = function(text)
        -- SetBackgroundImage не поддерживается в WindUI-Boreal
        WindUI:Notify({
            Title = Config.MeowHubName,
            Content = "Background image not supported in this build",
            Icon = "solar:info-circle-bold",
            Duration = 3,
        })
    end
})

-- [ Background Image Transparency (Slider) ] --
SettingsSection:Slider({
    Title = "Background Image Transparency",
    Value = { Min = 0, Max = 1, Default = 0.45 },
    Step = 0.1,
    Callback = function(value)
        -- SetBackgroundImageTransparency не поддерживается в WindUI-Boreal
    end
})

-- [ Keybind (Toggle UI) ] --
SettingsSection:Keybind({
    Title = "Keybind (Toggle UI)",
    Desc = "Keybind to open UI",
    Value = "M",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

-- [ Enable Transparency (Toggle) ] --
SettingsSection:Toggle({
    Title = "Enable Transparency",
    Icon = "solar:mirror-bold",
    Callback = function(state)
        -- ToggleTransparency не поддерживается в WindUI-Boreal
    end
})

-- [ Enable Resizable (Toggle) ] --
SettingsSection:Toggle({
    Title = "Enable Resizable",
    Icon = "solar:scaling-bold",
    Value = true,
    Callback = function(state)
        -- IsResizable не поддерживается в WindUI-Boreal
    end
})

-- [ Choose Theme (Dropdown) ] --
SettingsSection:Dropdown({
    Title = "Choose Theme",
    Desc = "Choose a theme for the UI",
    Icon = "solar:pallete-2-bold",
    Values = {
        "Dark",
        "Light",
        "Rose",
        "Plant",
        "Red",
        "Indigo",
        "Sky",
        "Violet",
        "Amber",
        "Emerald",
        "Midnight",
        "Crimson",
        "MonkaiPro",
        "CottonCandy",
        "Mellowsi",
    },
    Value = "Dark",
    Callback = function(selected)
        WindUI:SetTheme(selected)
    end
})

-- [ Shop Tab ] --
local ShopTab = Window:Tab({
    Title = "Shop",
    Desc = "Shop Tab",

    Icon = "solar:bag-4-bold",
    IconColor = Pink,
    IconShape = "Square",

    Locked = false,
    ShowTabTitle = false,
    Border = true,
})

-- [ Fighting Styles Section ] --
local FightingStylesSection = ShopTab:Section({
    Title = "Fighting Styles",
    Desc = "You can buy Fighting Styles",
    Icon = "solar:fire-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

local DarkStepParagraph = FightingStylesSection:Paragraph({
    Title = "Dark Step",
    Desc = "$150,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/1/11/DarkStepA.png/revision/latest?cb=20230429200337&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyBlackLeg")
            end
        }
    }
})

local ElectroParagraph = FightingStylesSection:Paragraph({
    Title = "Electro",
    Desc = "$500,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/3/36/ElectricA.png/revision/latest?cb=20221018092049&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectro")
            end
        }
    }
})

local WaterKungFuParagraph = FightingStylesSection:Paragraph({
    Title = "Water Kung Fu",
    Desc = "$750,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/b/b0/WaterKungFuA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyWaterKungFu")
            end
        }
    }
})

local DragonClawParagraph = FightingStylesSection:Paragraph({
    Title = "Dragon Claw",
    Desc = "F'1,500",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/8/8e/DragonClawA.png/revision/latest?cb=20221018092047&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1")
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            end
        }
    }
})

local SuperhumanParagraph = FightingStylesSection:Paragraph({
    Title = "Superhuman",
    Desc = "$3,000,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/c/cf/SuperhumanA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySuperhuman")
            end
        }
    }
})

local DeathStepParagraph = FightingStylesSection:Paragraph({
    Title = "Death Step",
    Desc = "$5,000,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/7/7a/DeathStepA.png/revision/latest?cb=20221018092046&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDeathStep")
            end
        }
    }
})

local SharkmanKarateParagraph = FightingStylesSection:Paragraph({
    Title = "Sharkman Karate",
    Desc = "$2,500,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/d/d8/SharkmanKarateA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate", true)
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySharkmanKarate")
            end
        }
    }
})

local ElectricClawParagraph = FightingStylesSection:Paragraph({
    Title = "Electric Claw",
    Desc = "$3,000,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/6/60/ElectricClawA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyElectricClaw")
            end
        }
    }
})

local DragonTalonParagraph = FightingStylesSection:Paragraph({
    Title = "Dragon Talon",
    Desc = "$3,000,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/5/57/DragonTalonA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyDragonTalon")
            end
        }
    }
})

local GodHumanParagraph = FightingStylesSection:Paragraph({
    Title = "God Human",
    Desc = "$5,000,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/9/9f/GodhumanA.png/revision/latest?cb=20221018092050&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuyGodhuman")
            end
        }
    }
})

local SanguineArtParagraph = FightingStylesSection:Paragraph({
    Title = "Sanguine Art",
    Desc = "$5,000,000\nF'5,000",
    Image = "https://static.wikia.nocookie.net/blox-fruits/images/8/8b/SanguineArtA.png/revision/latest?cb=20231025181048&path-prefix=ru",
    ImageSize = 65,
    Buttons = {
        {
            Title = "Buy",
            Icon = "solar:dollar-minimalistic-bold",
            Callback = function()
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySanguineArt", true)
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("BuySanguineArt")
            end
        }
    }
})

-- [ Teleport Tab ] --
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Desc = "Teleport Tab",

    Icon = "solar:map-point-bold",
    IconColor = Pink,
    IconShape = "Square",

    Locked = false,
    ShowTabTitle = false,
    Border = true,
})

-- [ Sea Travel Section ] --
local SeaTravelSection = TeleportTab:Section({
    Title = "Sea Travel",
    Desc = "Teleport Section",
    Icon = "solar:ship-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

SeaTravelSection:Button({
    Title = "Teleport To First Sea",
    Callback = function()
        (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelMain")
    end
})
SeaTravelSection:Button({
    Title = "Teleport To Second Sea",
    Callback = function()
        (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelDressrosa")
    end
})
SeaTravelSection:Button({
    Title = "Teleport To Third Sea",
    Callback = function()
        (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("TravelZou")
    end
})

-- [ Teleport Section ] --
local TeleportSection = TeleportTab:Section({
    Title = "Teleport",
    Desc = "Fast teleport to islands & NPCs",
    Icon = "solar:map-point-bold",
    IconColor = Pink,
    TextSize = 19,
    TextXAlignment = "Left",
    Box = false,
    BoxBorder = true,
    Opened = true,
    FontWeight = Enum.FontWeight.SemiBold,
    DescFontWeight = Enum.FontWeight.Medium,
    TextTransparency = 0.05,
    DescTextTransparency = 0.4,
})

PlayerTweenSpeedSlider = TeleportSection:Slider({
    Title = "Player Tween Speed",
    Step = 1,
    Value = {
        Min = 10,
        Max = 325,
        Default = _G["Player Tween Speed"]
    },
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

-- [ WindUI Notify ] --
WindUI:Notify({
    Title = Config.MeowHubName,
    Content = "Loaded Successfully!",
    Icon = "solar:check-circle-bold",
    Duration = 3,
})
