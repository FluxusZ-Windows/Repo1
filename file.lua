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
    Icon = "loader",
    Duration = 3.5,
})

task.wait(3)

-- [ Window ] --
local Window = WindUI:CreateWindow({
    Title = Config.MeowHubName,
    Author = "by CreatorNovaAxis • " .. Config.DiscordLink,
    Icon = Config.MeowIcon,

    Folder = "MeowHub",
    Size = UDim2.fromOffset(620, 250), -- width, height

    Transparent = false,
    Resizable = true,
    ModernLayout = true,
    BottomDragBarEnabled = true,

    -- [ Top Bar ] --
    Topbar = {
        Height = 44,
        ButtonsType = "Mac", -- Default or Mac
    },

    -- [ User ] --
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = Config.MeowHubName,
                Content = "Hi " .. game.Players.LocalPlayer.Name .. "!",
                Icon = "user",
                Duration = 5,
            })
        end,
    },

    -- [ Watermark ] --
    Watermark = {
        Enabled = true,
        Text = Config.DiscordLink,
        Opacity = 0.25,
        Position = "bottom-right", -- top-left/top-center/top-right/center/.../bottom-right
        Size = 12,
        Padding = 12,
        Offset = Vector2.new(0, 0),
        -- Color = Color3.fromRGB(255, 255, 255), -- optional
        -- RichText = false, -- optional
    },
    
    -- [ Open Button ] --
    OpenButton = {
        Title = Config.MeowHubName, -- can be changed
        CornerRadius = UDim.new(1,0), -- fully rounded
        StrokeThickness = 3, -- removing outline
        Enabled = true, -- enable or disable openbutton
        Draggable = true,
        OnlyMobile = false,
        Scale = 1.0,
        
        Color = ColorSequence.new( -- gradient
            Color3.fromHex("#ffc0cb"), 
            Color3.fromHex("#806063")
        )
    },
})

-- [ Window Settings ] --
Window:SetIconSize(32) -- default is 20
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
    Desc = "Home Tab", -- optional

    Icon = "house",
    IconColor = Pink, -- Color3.fromRGB(255, 100, 100)  custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    -- IconThemed = true, -- use theme colors. optional

    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

-- [ Home Multi Section ] --
local HomeMultiSection = HomeTab:MultiSection({
    Title = "Home",
    Desc = "Home Multi Section",
    Icon = "house",
    Box = true,
    BoxBorder = true,
    Opened = true,
})

-- [ Info Tab ] --
local InfoTab = HomeMultiSection:Tab({
    Title = "Info",
    Desc = "Information",
    Icon = "info",
    Selected = true,
})

-- [ Discord Server ] --
local DiscordServerSection = InfoTab:Section({
    Title = "Discord Server",
    Desc = "Info about future upds & much more!", -- optional
    Icon = "message-square-more", -- lucide icon or "rbxassetid://". optional
    IconColor = Pink, -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Left", -- "Left", "Center", "Right". optional
    Box = false, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = true, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0.05, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
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
                    Icon = "link",
                    Callback = function()
                        if setclipboard then
                            -- [ Copy Invite Link ] --
                            setclipboard(Config.DiscordLink)

                            -- [ WindUI Notify ] --
                            WindUI:Notify({
                                Title = Config.MeowHubName,
                                Content = "Invite link copied to clipboard!",
                                Icon = "link",
                                Duration = 5,
                            })
                        end
                    end
                },
                {
                    Title = "Refresh",
                    Icon = "refresh-ccw",
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
    Desc = "Resources used and their authors", -- optional
    Icon = "heart", -- lucide icon or "rbxassetid://". optional
    IconColor = Pink, -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Left", -- "Left", "Center", "Right". optional
    Box = false, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = true, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0.05, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
})

-- CreatorNovaAxis - Meow Hub
CreditsSection:Paragraph({
    Title = "CreatorNovaAxis - Meow Hub",
    Desc = "Creator of Meow Hub",

    Buttons = {
        {
            Title = "Copy Invite Link (Discord Server)",
            Icon = "link",
            Callback = function()
                setclipboard(Config.DiscordLink)

                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "link",
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
            Icon = "link",
            Callback = function()
                setclipboard("https://github.com/orialdev")

                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "link",
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
            Icon = "link",
            Callback = function()
                setclipboard("https://github.com/footagesus")

                WindUI:Notify({
                    Title = Config.MeowHubName,
                    Content = "Link copied to clipboard!",
                    Icon = "link",
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
    Icon = "settings",
    Selected = false,
})

-- [ Settings ] --
local SettingsSection = SettingsTab:Section({
    Title = "Settings",
    Desc = "Customizable UI Window", -- optional
    Icon = "settings", -- lucide icon or "rbxassetid://". optional
    IconColor = Pink, -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Left", -- "Left", "Center", "Right". optional
    Box = false, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = true, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0.05, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
})

-- [ Set Background Image (Input) ] --
SettingsSection:Input({
    Title = "Set Background Image",
    Desc = "Enter your rbxassetid",
    Icon = "image", -- Icon
    Type = "Textarea", -- "Default" or "Textarea". optional
    Placeholder = "Enter rbxassetid",
    Locked = false,
    -- Flag = "Settings_BackgroundID", -- For config tipaaaaa
    Callback = function(text)
        -- [ Check ] --
        local assetId = text
        if tonumber(text) then
            assetId = "rbxassetid://" .. text
        end

        -- [ WindUI SetBackgroundImage ] --
        Window:SetBackgroundImage(assetId)
    end
})

-- [ Background Image Transparency (Slider) ] --
SettingsSection:Slider({
    Title = "Background Image Transparency",
    Value = { Min = 0, Max = 1, Default = 0.45 },
    Step = 0.1, -- decimal steps
    Callback = function(value)
        Window:SetBackgroundImageTransparency(value) -- from 0  to 1
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
    Icon = "square-dashed",
    Callback = function(state)
        Window:ToggleTransparency(state)
    end
})

-- [ Enable Resizable (Toggle) ] --
SettingsSection:Toggle({
    Title = "Enable Resizable",
    Icon = "scaling",
    Value = true,
    Callback = function(state)
        Window:IsResizable(state)
    end
})

-- [ Choose Theme (Dropdown) ] --
SettingsSection:Dropdown({
    Title = "Choose Theme",
    Desc = "Choose a theme for the UI",
    Icon = "palette",
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

-- [ Teleport Tab ] --
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Desc = "Teleport Tab", -- optional

    Icon = "map-pin",
    IconColor = Pink, -- Color3.fromRGB(255, 100, 100)  custom icon color. optional
    IconShape = "Square", -- "Square" or "Circle". optional
    -- IconThemed = true, -- use theme colors. optional

    Locked = false, -- disable tab interaction. optional
    ShowTabTitle = false, -- show title inside tab. optional
    Border = true, -- add border around tab. optional
})

-- [ Sea Travel Section ] --
local SeaTravelSection = TeleportTab:Section({
    Title = "Sea Travel",
    Desc = "Teleport Section", -- optional
    Icon = "waves", -- lucide icon or "rbxassetid://". optional
    IconColor = Pink, -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Left", -- "Left", "Center", "Right". optional
    Box = false, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = true, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0.05, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
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
    Desc = "Fast teleport to islands & NPCs", -- optional
    Icon = "map-pin", -- lucide icon or "rbxassetid://". optional
    IconColor = Pink, -- custom icon color. optional
    TextSize = 19, -- title text size. optional
    TextXAlignment = "Left", -- "Left", "Center", "Right". optional
    Box = false, -- show box around section. optional
    BoxBorder = true, -- show border on box. optional
    Opened = true, -- section expanded by default. optional
    FontWeight = Enum.FontWeight.SemiBold, -- title font weight. optional
    DescFontWeight = Enum.FontWeight.Medium, -- description font weight. optional
    TextTransparency = 0.05, -- title transparency. optional
    DescTextTransparency = 0.4, -- description transparency. optional
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
    -- Desc = "Teleport to the selected island",
    Icon = "map-pin",
    Callback = function()
        TweenPlayer(CFrame.new(-1475.71, 22.89, 370.25))
    end
})

-- [ WindUI Notify ] --
WindUI:Notify({
    Title = Config.MeowHubName,
    Content = "Loaded Successfully!",
    Icon = "circle-check",
    Duration = 3,
})
