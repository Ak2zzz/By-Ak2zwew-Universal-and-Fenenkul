-- Chargement de Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Création de la fenêtre principale
local Window = Rayfield:CreateWindow({
    Name = "Ak2zwew Universal | By Kriss Moris",  -- Nouveau nom
    LoadingTitle = "Chargement du menu...🍿",
    LoadingSubtitle = "By Ak2zwew",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil, -- Utilise le nom par défaut
        FileName = "Ak2zwewUniversalConfig"
    },
    Discord = {
        Enabled = false,
        Invite = "", -- Ton lien d'invitation Discord si applicable
        RememberJoins = true
    },
    KeySystem = true, -- Désactive le système de clé
    KeySettings = {
        Title = "Ak2zwew clé",
        Subtitle = "Tu veux la Clé ?",
        Note = "Sah ?",
        FileName = "exemplehubkey",
        SaveKey = false,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/nEJi9cnj"}
    }
})

-- Création de l'onglet principal
local MainTab = Window:CreateTab("All 🟢", nil)

-- Variables globales
local FlyEnabled = false
local NoClipEnabled = false
local Speed = 16 -- Vitesse par défaut
local JumpPower = 50 -- Puissance du saut par défaut
local XRayEnabled = false -- Ajout de la variable pour savoir si X-Ray est activé

-- Fonction pour activer le Fly en utilisant le script externe
local function activateFly()
    loadstring(game:HttpGet('https://pastebin.com/raw/XXrCXGYm'))()  -- Remplace l'URL par celle de ton script Fly
end

-- Fonction pour activer le NoClip
local function activateNoClip()
    local Host = game.Players.LocalPlayer
    local RunService = game:GetService('RunService')
    local ContextActionService = game:GetService('ContextActionService')

    local Noclip = true
    local NoclipKey = 'X' -- Touche de NoClip

    RunService.RenderStepped:Connect(function()
        if Noclip then
            for _, v in pairs(Host.Character:GetDescendants()) do
                if v:IsA('BasePart') and v.CanCollide then
                    v.CanCollide = false
                end
            end
        else
            for _, v in pairs(Host.Character:GetDescendants()) do
                if v:IsA('BasePart') and not v.CanCollide then
                    v.CanCollide = true
                end
            end
        end
    end)

    local function Noclipping(ActionName, Properties)
        if ActionName == 'Noclip' then
            if not Properties or Properties == Enum.UserInputState.Begin then
                Noclip = not Noclip
                game:GetService('StarterGui'):SetCore('SendNotification', {
                    Title = "Noclip",
                    Text = "Noclip is now " .. tostring(Noclip),
                })
            end
        end
    end

    ContextActionService:BindAction('Noclip', Noclipping, true, Enum.KeyCode[NoclipKey])
end

-- Fonction pour activer le BTools (Builder Tools)
local function activateBTools()
    local Host = game:GetService('Players').LocalPlayer

    local Drag = Instance.new('HopperBin')
    Drag.BinType = 1
    Drag.Parent = Host.Backpack

    local Clone = Instance.new('HopperBin')
    Clone.BinType = 3
    Clone.Parent = Host.Backpack

    local Hammer = Instance.new('HopperBin')
    Hammer.BinType = 4
    Hammer.Parent = Host.Backpack
end

-- Fonction pour activer le Inf Yield
local function activateInfYield()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

-- Fonction pour activer X-Ray (voir à travers les murs)
local function enableXRay()
    -- Parcours toutes les parties du jeu et rend toutes les parties transparentes
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") then
            -- Modifier la transparence et le canCollide pour passer à travers les murs
            object.LocalTransparencyModifier = 0.2  -- 0 = invisible, 1 = visible
            object.CanCollide = true  -- Active la collision avec les parties
        end
    end

    -- Afficher un message pour confirmer que le X-Ray a été activé
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = "X-Ray Activé",
        Text = "Vous pouvez maintenant voir à travers les murs.",
        Duration = 3
    })
end

-- Fonction pour désactiver X-Ray
local function disableXRay()
    -- Restaure la transparence et la collision des parties
    for _, object in pairs(workspace:GetDescendants()) do
        if object:IsA("BasePart") then
            object.LocalTransparencyModifier = 0  -- Remet la transparence normale
            object.CanCollide = true  -- Réactive la collision
        end
    end

    -- Afficher un message pour confirmer que le X-Ray a été désactivé
    game:GetService('StarterGui'):SetCore('SendNotification', {
        Title = "X-Ray Désactivé",
        Text = "Les murs sont maintenant visibles.",
        Duration = 3
    })
end

-- Fonction pour l'ESP
local function createESP(player)
    local humanoid = player.Character:WaitForChild("Humanoid")
    local nameTag = Instance.new("BillboardGui")
    nameTag.Adornee = player.Character.Head
    nameTag.Size = UDim2.new(0, 100, 0, 50)
    nameTag.StudsOffset = Vector3.new(0, 3, 0)
    nameTag.Parent = player.Character.Head

    -- Création du texte pour afficher le pseudo
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = player.Name
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texte blanc par défaut
    nameLabel.TextStrokeTransparency = 0.8 -- Un léger contour
    nameLabel.TextSize = 20
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.Parent = nameTag

    -- Applique un glow autour du nom
    nameLabel.TextStrokeTransparency = 0.5  -- Un glow plus visible

    -- Ajouter la couleur de l'équipe (si elle existe)
    local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 255, 255) -- Blanc si aucune équipe

    nameLabel.TextColor3 = teamColor  -- Modifier la couleur du texte en fonction de l'équipe
end

-- Fonction d'affichage de l'ESP sur tous les joueurs
local function updateESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            createESP(player)  -- Crée l'ESP pour chaque joueur
        end
    end
end

-- Mise à jour de l'ESP en continu
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        updateESP()
    end)
end)

-- Création des boutons du menu
MainTab:CreateButton({
    Name = "Activer/Désactiver Fly",
    Callback = function()
        activateFly()  -- Cela va charger le script de vol à partir de l'URL
    end
})

MainTab:CreateButton({
    Name = "Activer/Désactiver NoClip",
    Callback = function()
        NoClipEnabled = not NoClipEnabled
        if NoClipEnabled then
            activateNoClip()
        else
            -- Code pour désactiver NoClip
            -- Nous ne faisons pas de désactivation explicite, il suffit de désactiver l'action en utilisant la touche X
        end
    end
})

MainTab:CreateButton({
    Name = "Activer BTools",
    Callback = function()
        activateBTools()
    end
})

MainTab:CreateButton({
    Name = "Activer Inf Yield",
    Callback = function()
        activateInfYield()
    end
})

-- Ajouter un bouton pour activer/désactiver X-Ray
MainTab:CreateButton({
    Name = "Activer/Désactiver X-Ray",
    Callback = function()
        if XRayEnabled then
            disableXRay()
        else
            enableXRay()
        end
        XRayEnabled = not XRayEnabled  -- Inverse l'état X-Ray
    end
})

MainTab:CreateSlider({
    Name = "Vitesse",
    Range = {16, 100},
    Increment = 5,
    Suffix = "SPD",
    CurrentValue = 16,
    Callback = function(Value)
        Speed = Value
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Speed
    end
})

MainTab:CreateSlider({
    Name = "Puissance du saut",
    Range = {50, 200},
    Increment = 10,
    Suffix = "JP",
    CurrentValue = 50,
    Callback = function(Value)
        JumpPower = Value
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = JumpPower
    end
})

-- Notification
Rayfield:Notify({
    Title = "Script chargé",
    Content = "Ak2zwew Universal | By ??? est maintenant chargé.",
    Duration = 5,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "OK",
            Callback = function()
                print("Notification fermée.")
            end
        },
    },
})