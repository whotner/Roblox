--[[
  natality × roblox — CLEAN VERSION
  Только ESP + Aimbot (Legit/Rage)
--]]

local Plrs = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Cam = workspace.CurrentCamera
local LP = Plrs.LocalPlayer
local PGui = LP:WaitForChild("PlayerGui")

-- ══════════════════════════════
-- CONFIG
-- ══════════════════════════════
local Cfg = {
    MenuKey = "RightShift",
    Theme = "Red",
    
    ESP = {
        On = false,
        TeamCheck = false,
        MaxDist = 500,
        Box = {On = true, Type = "Corner", Col = Color3.fromRGB(214, 40, 40), W = 2},
        Names = {On = true, Col = Color3.fromRGB(240, 240, 245), Sz = 13},
        Dist = {On = true, Col = Color3.fromRGB(148, 148, 165)},
        HP = {Bar = true, Text = false},
    },
    
    Legit = {
        On = false,
        Wall = true,
        Key = "MB2",
        FOV = 80,
        FOVCol = Color3.fromRGB(200, 200, 200),
        ShowFOV = true,
        Smooth = 7,
        Bone = "Head",
    },
    
    Rage = {
        On = false,
        Wall = false,
        Key = "MB2",
        FOV = 350,
        FOVCol = Color3.fromRGB(214, 40, 40),
        ShowFOV = true,
        Smooth = 1,
        Bone = "Head",
        AutoShoot = false,
        AutoThresh = 6,
    },
}

local THEMES = {
    Red = {acc = Color3.fromRGB(214, 40, 40), bg0 = Color3.fromRGB(10, 10, 13)},
    Blue = {acc = Color3.fromRGB(50, 130, 220), bg0 = Color3.fromRGB(8, 10, 14)},
    Green = {acc = Color3.fromRGB(40, 200, 80), bg0 = Color3.fromRGB(8, 12, 8)},
}

local function T()
    return THEMES[Cfg.Theme] or THEMES.Red
end

-- ══════════════════════════════
-- UTILS
-- ══════════════════════════════
local function W2S(pos)
    local s, on = Cam:WorldToViewportPoint(pos)
    return Vector2.new(s.X, s.Y), on, s.Z
end

local function IsKey(k)
    if k == "MB1" then return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end
    if k == "MB2" then return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end
    local ok, kc = pcall(function() return Enum.KeyCode[k] end)
    if ok and kc then return UIS:IsKeyDown(kc) end
    return false
end

local function HasWall(tp)
    local o = Cam.CFrame.Position
    local d = tp - o
    local p = RaycastParams.new()
    p.FilterDescendantsInstances = {LP.Character or workspace}
    p.FilterType = Enum.RaycastFilterType.Exclude
    local r = workspace:Raycast(o, d.Unit * d.Magnitude, p)
    if not r then return false end
    local hc = r.Instance and r.Instance:FindFirstAncestorOfClass("Model")
    return not(hc and Plrs:GetPlayerFromCharacter(hc))
end

local function GetBounds(ch)
    local x0, y0, x1, y1 = 1e9, 1e9, -1e9, -1e9
    local any = false
    for _, p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
            local cf = p.CFrame
            local sx, sy, sz = p.Size.X / 2, p.Size.Y / 2, p.Size.Z / 2
            for _, o in ipairs({
                Vector3.new(sx, sy, sz), Vector3.new(-sx, sy, sz),
                Vector3.new(sx, -sy, sz), Vector3.new(-sx, -sy, sz),
                Vector3.new(sx, sy, -sz), Vector3.new(-sx, sy, -sz),
                Vector3.new(sx, -sy, -sz), Vector3.new(-sx, -sy, -sz),
            }) do
                local s2, on = W2S(cf * o)
                if on then
                    any = true
                    if s2.X < x0 then x0 = s2.X end
                    if s2.Y < y0 then y0 = s2.Y end
                    if s2.X > x1 then x1 = s2.X end
                    if s2.Y > y1 then y1 = s2.Y end
                end
            end
        end
    end
    return any and x0, y0, x1, y1 or nil
end

-- ══════════════════════════════
-- DRAWING HELPERS
-- ══════════════════════════════
local function DL(c, t)
    local l = Drawing.new("Line")
    l.Color = c or Color3.new(1, 1, 1)
    l.Thickness = t or 1
    l.Visible = false
    return l
end

local function DT(s, c)
    local t = Drawing.new("Text")
    t.Size = s or 13
    t.Color = c or Color3.new(1, 1, 1)
    t.Outline = true
    t.Center = true
    t.Font = Drawing.Fonts.UI
    t.Visible = false
    return t
end

local function DR(c, f, t)
    local r = Drawing.new("Square")
    r.Color = c or Color3.new(1, 1, 1)
    r.Filled = f or false
    r.Thickness = t or 1
    r.Visible = false
    return r
end

-- ══════════════════════════════
-- ESP POOL
-- ══════════════════════════════
local Pool = {}

local function BuildESP(pl)
    if pl == LP then return end
    local o = {}
    
    -- Corner box
    o.cc = {}
    for i = 1, 8 do o.cc[i] = DL(Cfg.ESP.Box.Col, 2) end
    
    -- Names & Distance
    o.name = DT(Cfg.ESP.Names.Sz, Cfg.ESP.Names.Col)
    o.dist = DT(11, Cfg.ESP.Dist.Col)
    
    -- HP bar
    o.hbg = DR(Color3.fromRGB(10, 10, 10), true)
    o.hfill = DR(Color3.fromRGB(80, 255, 80), true)
    
    Pool[pl] = o
end

local function KillESP(pl)
    local o = Pool[pl]
    if not o then return end
    local function R(d)
        pcall(function() d:Remove() end)
    end
    for i = 1, 8 do R(o.cc[i]) end
    R(o.name)
    R(o.dist)
    R(o.hbg)
    R(o.hfill)
    Pool[pl] = nil
end

local function TickESP()
    for pl, o in pairs(Pool) do
        if not pl or not pl.Parent then
            KillESP(pl)
            continue
        end
        
        local ch = pl.Character
        local hm = ch and ch:FindFirstChildOfClass("Humanoid")
        local root = ch and ch:FindFirstChild("HumanoidRootPart")
        
        if not Cfg.ESP.On or not ch or not hm or not root or hm.Health <= 0 then
            for i = 1, 8 do o.cc[i].Visible = false end
            o.name.Visible = false
            o.dist.Visible = false
            o.hbg.Visible = false
            o.hfill.Visible = false
            continue
        end
        
        local d3 = (Cam.CFrame.Position - root.Position).Magnitude
        if d3 > Cfg.ESP.MaxDist then
            for i = 1, 8 do o.cc[i].Visible = false end
            o.name.Visible = false
            o.dist.Visible = false
            continue
        end
        
        local rsp, onSc = W2S(root.Position)
        local x0, y0, x1, y1 = GetBounds(ch)
        
        if not x0 or not onSc then
            for i = 1, 8 do o.cc[i].Visible = false end
            o.name.Visible = false
            o.dist.Visible = false
            continue
        end
        
        local bw, bh = x1 - x0, y1 - y0
        local mx = (x0 + x1) * 0.5
        
        -- Draw corner box
        local sC = Cfg.ESP.Box.On
        local cL = math.max(math.min(bw, bh) * 0.22, 6)
        local pts = {
            {Vector2.new(x0, y0), Vector2.new(x0 + cL, y0)},
            {Vector2.new(x0, y0), Vector2.new(x0, y0 + cL)},
            {Vector2.new(x1, y0), Vector2.new(x1 - cL, y0)},
            {Vector2.new(x1, y0), Vector2.new(x1, y0 + cL)},
            {Vector2.new(x0, y1), Vector2.new(x0 + cL, y1)},
            {Vector2.new(x0, y1), Vector2.new(x0, y1 - cL)},
            {Vector2.new(x1, y1), Vector2.new(x1 - cL, y1)},
            {Vector2.new(x1, y1), Vector2.new(x1, y1 - cL)},
        }
        
        for i = 1, 8 do
            o.cc[i].From = pts[i][1]
            o.cc[i].To = pts[i][2]
            o.cc[i].Color = Cfg.ESP.Box.Col
            o.cc[i].Thickness = Cfg.ESP.Box.W
            o.cc[i].Visible = sC
        end
        
        -- HP bar
        local hp = math.clamp(hm.Health / hm.MaxHealth, 0, 1)
        local bx = x0 - 7
        o.hbg.Visible = Cfg.ESP.HP.Bar
        o.hfill.Visible = Cfg.ESP.HP.Bar
        if Cfg.ESP.HP.Bar then
            o.hbg.Position = Vector2.new(bx, y0)
            o.hbg.Size = Vector2.new(4, bh)
            local fh = bh * hp
            o.hfill.Position = Vector2.new(bx, y0 + bh - fh)
            o.hfill.Size = Vector2.new(4, fh)
            o.hfill.Color = Color3.new(math.clamp(2 * (1 - hp), 0, 1), math.clamp(2 * hp, 0, 1), 0.05)
        end
        
        -- Names
        o.name.Visible = Cfg.ESP.Names.On
        if Cfg.ESP.Names.On then
            o.name.Text = pl.Name
            o.name.Color = Cfg.ESP.Names.Col
            o.name.Size = Cfg.ESP.Names.Sz
            o.name.Position = Vector2.new(mx, y0 - 16)
        end
        
        -- Distance
        o.dist.Visible = Cfg.ESP.Dist.On
        if Cfg.ESP.Dist.On then
            o.dist.Text = string.format("%.0fm", d3)
            o.dist.Color = Cfg.ESP.Dist.Col
            o.dist.Position = Vector2.new(mx, y1 + 3)
        end
    end
end

-- Подключаем ESP для всех игроков
for _, p in ipairs(Plrs:GetPlayers()) do
    BuildESP(p)
    p.CharacterRemoving:Connect(function()
        local o = Pool[p]
        if o then
            for i = 1, 8 do o.cc[i].Visible = false end
            o.name.Visible = false
            o.dist.Visible = false
        end
    end)
end

Plrs.PlayerAdded:Connect(function(p)
    task.wait(0.5)
    BuildESP(p)
    p.CharacterRemoving:Connect(function()
        local o = Pool[p]
        if o then
            for i = 1, 8 do o.cc[i].Visible = false end
            o.name.Visible = false
            o.dist.Visible = false
        end
    end)
end)

Plrs.PlayerRemoving:Connect(KillESP)

-- ══════════════════════════════
-- AIMBOT
-- ═══════��══════════════════════
local function GetTarget(ac)
    local vp = Cam.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    local best, bestSc = nil, nil
    
    for _, p in ipairs(Plrs:GetPlayers()) do
        if p == LP or not p.Parent then continue end
        
        local ch = p.Character
        local hm = ch and ch:FindFirstChildOfClass("Humanoid")
        
        if not hm or hm.Health <= 0 then continue end
        if Cfg.ESP.TeamCheck and p.Team ~= nil and p.Team == LP.Team then continue end
        
        local bone = ch:FindFirstChild(ac.Bone) or ch:FindFirstChild("Head")
        if not bone then continue end
        
        if ac.Wall and HasWall(bone.Position) then continue end
        
        local sp2, on = W2S(bone.Position)
        if not on then continue end
        
        local fovD = math.sqrt((sp2.X - cx) ^ 2 + (sp2.Y - cy) ^ 2)
        if fovD > ac.FOV then continue end
        
        if not best or fovD < bestSc then
            bestSc = fovD
            best = {pos = bone.Position, sp = sp2}
        end
    end
    
    return best
end

-- ══════════════════════════════
-- UI
-- ══════════════════════════════
local GUI = Instance.new("ScreenGui")
GUI.Name = "NatalityClean"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.Parent = PGui

local function mkC(p, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 4)
    c.Parent = p
end

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 400, 0, 350)
Main.Position = UDim2.new(0.5, -200, 0.5, -175)
Main.BackgroundColor3 = T().bg0
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = GUI
mkC(Main, 8)

-- Header
local Hdr = Instance.new("TextLabel")
Hdr.Size = UDim2.new(1, 0, 0, 30)
Hdr.BackgroundColor3 = T().acc
Hdr.TextColor3 = Color3.new(1, 1, 1)
Hdr.Text = "natality — clean"
Hdr.Font = Enum.Font.GothamBold
Hdr.TextSize = 16
Hdr.BorderSizePixel = 0
Hdr.Parent = Main
mkC(Hdr, 8)

-- Close button
local BClose = Instance.new("TextButton")
BClose.Size = UDim2.new(0, 24, 0, 24)
BClose.Position = UDim2.new(1, -28, 0, 3)
BClose.BackgroundColor3 = Color3.fromRGB(175, 32, 32)
BClose.Text = "✕"
BClose.TextColor3 = Color3.new(1, 1, 1)
BClose.Font = Enum.Font.GothamBold
BClose.BorderSizePixel = 0
BClose.Parent = Hdr
mkC(BClose, 4)

BClose.MouseButton1Click:Connect(function()
    Main.Visible = false
end)

-- Content
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -16, 1, -46)
Content.Position = UDim2.new(0, 8, 0, 38)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 2
Content.Parent = Main

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 8)
UIList.Parent = Content

local UIPad = Instance.new("UIPadding")
UIPad.PaddingLeft = UDim.new(0, 8)
UIPad.PaddingRight = UDim.new(0, 8)
UIPad.PaddingTop = UDim.new(0, 8)
UIPad.Parent = Content

-- UI helpers
local function MkTog(parent, label, tbl, key)
    local row = Instance.new("TextButton")
    row.Size = UDim2.new(1, 0, 0, 24)
    row.BackgroundTransparency = 1
    row.Text = ""
    row.Parent = parent
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -40, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 34, 0, 14)
    track.Position = UDim2.new(1, -38, 0.5, -7)
    track.BackgroundColor3 = tbl[key] and T().acc or Color3.fromRGB(24, 24, 36)
    track.Parent = row
    mkC(track, 7)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 10, 0, 10)
    knob.Position = tbl[key] and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = track
    mkC(knob, 5)
    
    row.MouseButton1Click:Connect(function()
        tbl[key] = not tbl[key]
        track.BackgroundColor3 = tbl[key] and T().acc or Color3.fromRGB(24, 24, 36)
        TS:Create(knob, TweenInfo.new(0.1), {
            Position = tbl[key] and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
        }):Play()
    end)
end

local function MkSld(parent, label, tbl, key, mn, mx)
    local w = Instance.new("Frame")
    w.Size = UDim2.new(1, 0, 0, 36)
    w.BackgroundTransparency = 1
    w.Parent = parent
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 14)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.Parent = w
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 4)
    track.Position = UDim2.new(0, 0, 0, 18)
    track.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
    track.Parent = w
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((tbl[key] - mn) / (mx - mn), 0, 1, 0)
    fill.BackgroundColor3 = T().acc
    fill.Parent = track
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 12, 0, 12)
    knob.Position = UDim2.new((tbl[key] - mn) / (mx - mn), -6, 0.5, -6)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.Parent = track
    mkC(knob, 6)
    
    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(0, 40, 0, 14)
    val.Position = UDim2.new(1, -40, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = tostring(math.floor(tbl[key]))
    val.Font = Enum.Font.GothamBold
    val.TextSize = 11
    val.TextColor3 = Color3.fromRGB(200, 200, 200)
    val.Parent = w
    
    local dragging = false
    track.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((inp.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
            local v = mn + rel * (mx - mn)
            tbl[key] = math.floor(v)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            knob.Position = UDim2.new(rel, -6, 0.5, -6)
            val.Text = tostring(tbl[key])
        end
    end)
end

-- Build UI
MkTog(Content, "ESP Enable", Cfg.ESP, "On")
MkTog(Content, "Team Check", Cfg.ESP, "TeamCheck")
MkSld(Content, "Max Distance", Cfg.ESP, "MaxDist", 50, 1000)
MkTog(Content, "Box", Cfg.ESP.Box, "On")
MkSld(Content, "Box Thickness", Cfg.ESP.Box, "W", 1, 4)
MkTog(Content, "Names", Cfg.ESP.Names, "On")
MkTog(Content, "Distance", Cfg.ESP.Dist, "On")
MkTog(Content, "HP Bar", Cfg.ESP.HP, "Bar")

MkTog(Content, "Legit Aimbot", Cfg.Legit, "On")
MkSld(Content, "Legit FOV", Cfg.Legit, "FOV", 10, 200)
MkSld(Content, "Legit Smooth", Cfg.Legit, "Smooth", 1, 20)

MkTog(Content, "Rage Aimbot", Cfg.Rage, "On")
MkSld(Content, "Rage FOV", Cfg.Rage, "FOV", 10, 400)
MkSld(Content, "Rage Smooth", Cfg.Rage, "Smooth", 1, 10)
MkTog(Content, "Auto Shoot", Cfg.Rage, "AutoShoot")

-- ══════════════════════════════
-- MAIN LOOP
-- ══════════════════════════════
RS.RenderStepped:Connect(function()
    TickESP()
    
    local vp = Cam.ViewportSize
    local cx, cy = vp.X / 2, vp.Y / 2
    
    -- Legit aimbot
    if Cfg.Legit.On and IsKey(Cfg.Legit.Key) then
        local t = GetTarget(Cfg.Legit)
        if t then
            local sm = math.max(Cfg.Legit.Smooth, 0.1)
            pcall(function()
                mousemoverel((t.sp.X - cx) / sm, (t.sp.Y - cy) / sm)
            end)
        end
    end
    
    -- Rage aimbot
    if Cfg.Rage.On then
        if IsKey(Cfg.Rage.Key) or Cfg.Rage.AutoShoot then
            local t = GetTarget(Cfg.Rage)
            if t then
                local sm = math.max(Cfg.Rage.Smooth, 0.1)
                pcall(function()
                    mousemoverel((t.sp.X - cx) / sm, (t.sp.Y - cy) / sm)
                end)
                
                if Cfg.Rage.AutoShoot then
                    local dx, dy = t.sp.X - cx, t.sp.Y - cy
                    if dx * dx + dy * dy < Cfg.Rage.AutoThresh ^ 2 then
                        pcall(function() mouse1click() end)
                    end
                end
            end
        end
    end
end)

-- ══════════════════════════════
-- MENU TOGGLE
-- ══════════════════════════════
UIS.InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    local name = inp.KeyCode ~= Enum.KeyCode.Unknown and
        tostring(inp.KeyCode):gsub("Enum%.KeyCode%.", "") or nil
    if name and name == Cfg.MenuKey then
        Main.Visible = not Main.Visible
    end
end)

print("[natality clean] loaded | " .. Cfg.MenuKey .. " = menu")
