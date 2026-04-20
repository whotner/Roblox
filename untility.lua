--[[
  natality × roblox  v1
  Часть 1: Config + Utils + ESP
--]]
local Plrs=game:GetService("Players")
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TS=game:GetService("TweenService")
local Light=game:GetService("Lighting")
local SS=game:GetService("SoundService")
local Cam=workspace.CurrentCamera
local LP=Plrs.LocalPlayer
local PGui=LP:WaitForChild("PlayerGui")
local MOB=UIS.TouchEnabled

-- ══════════════════════════════
-- SOUND
-- ══════════════════════════════
local function Snd(id,v,p)
    local s=Instance.new("Sound")
    s.SoundId="rbxassetid://"..tostring(id)
    s.Volume=v or .3; s.PlaybackSpeed=p or 1
    s.Parent=SS; s:Play()
    game:GetService("Debris"):AddItem(s,3)
end

-- ══════════════════════════════
-- THEMES
-- ══════════════════════════════
local THEMES={
    Red   ={acc=Color3.fromRGB(214,40,40), bg0=Color3.fromRGB(10,10,13), bg1=Color3.fromRGB(15,15,20), bg2=Color3.fromRGB(20,20,28), bg3=Color3.fromRGB(27,27,38)},
    Blue  ={acc=Color3.fromRGB(50,130,220),bg0=Color3.fromRGB(8,10,14),  bg1=Color3.fromRGB(12,15,22), bg2=Color3.fromRGB(16,20,30), bg3=Color3.fromRGB(22,27,42)},
    Green ={acc=Color3.fromRGB(40,200,80), bg0=Color3.fromRGB(8,12,8),   bg1=Color3.fromRGB(12,17,12), bg2=Color3.fromRGB(16,23,16), bg3=Color3.fromRGB(22,30,22)},
    Purple={acc=Color3.fromRGB(140,40,214),bg0=Color3.fromRGB(10,8,14),  bg1=Color3.fromRGB(15,12,20), bg2=Color3.fromRGB(20,16,28), bg3=Color3.fromRGB(27,22,38)},
    Orange={acc=Color3.fromRGB(220,120,30),bg0=Color3.fromRGB(12,10,8),  bg1=Color3.fromRGB(18,14,10), bg2=Color3.fromRGB(24,18,12), bg3=Color3.fromRGB(32,24,16)},
    Custom={acc=Color3.fromRGB(214,40,40), bg0=Color3.fromRGB(10,10,13), bg1=Color3.fromRGB(15,15,20), bg2=Color3.fromRGB(20,20,28), bg3=Color3.fromRGB(27,27,38)},
}

-- ══════════════════════════════
-- CONFIG
-- ══════════════════════════════
local Cfg={
    -- Меню
    MenuKey="RightShift",
    Theme="Red",
    CustomAcc=Color3.fromRGB(214,40,40),
    CustomBg0=Color3.fromRGB(10,10,13),

    -- ESP
    ESP={
        On=false, TeamCheck=false, MaxDist=500,
        Box  ={On=true,  Type="Corner", Col=Color3.fromRGB(214,40,40), ColT=Color3.fromRGB(80,200,80), W=2},
        Chams={On=false, Col=Color3.fromRGB(214,40,40), OutA=0.0, GlowA=0.55},
        Names={On=true,  Col=Color3.fromRGB(240,240,245), Sz=13},
        Dist ={On=true,  Col=Color3.fromRGB(148,148,165)},
        HP   ={Bar=true, Text=false},
        Skel ={On=false, Col=Color3.fromRGB(255,200,50), W=1},
        Trc  ={On=false, Col=Color3.fromRGB(214,40,40), Origin="Bottom", W=1},
        HDot ={On=false, Col=Color3.fromRGB(214,40,40), R=4},
        Snap ={On=false, Col=Color3.fromRGB(255,255,255)},
        Arrow={On=false, Col=Color3.fromRGB(214,40,40)},
    },

    -- Legit
    Legit={
        On=false, Wall=true, Key="MB2",
        FOV=80, FOVCol=Color3.fromRGB(200,200,200), ShowFOV=true,
        Smooth=7, Bone="Head", Predict=false,
        RCS=false, RCSVert=0.5, RCSHoriz=0.1,
    },

    -- Rage
    Rage={
        On=false, Wall=false, Key="MB2",
        FOV=350, FOVCol=Color3.fromRGB(214,40,40), ShowFOV=true,
        Smooth=1, Bone="Head", Predict=true,
        Silent=false, SilentKey="MB1", SilentAutoFire=true, SilentDelay=0,
        AutoShoot=false, AutoThresh=6, MiniBot=false,
        Priority="FOV",
        AA=false, AAType="Spin", SpinSpd=12,
        FakeLag=false, FakeLagN=2,
        Resolver=false, DT=false,
    },

    -- Triggerbot
    Trig={On=false, Auto=false, Key="MB2", Delay=60, Range=3000},

    -- Visuals
    Vis={
        -- World
        NoFog=false, FullBright=false,
        DayTime=false, DayHour=14,
        CustomFog=false, FogCol=Color3.fromRGB(180,200,255), FogDist=300,
        Ambient=false, AmbCol=Color3.fromRGB(255,255,255),
        LightBoost=false, LightInt=2.0, LightSz=24,
        -- Camera
        ThirdPerson=false, ThirdDist=12,
        CustomFOV=false, FOVVal=70,
        HandsFOV=false, HandsFOVVal=90,
        StretchRes=false, WideScreen=false,
        -- HUD
        Crosshair=false, CHCol=Color3.fromRGB(0,255,100), CHSz=8, CHW=1, CHDot=false, CHStyle="Classic",
        SpecList=false,
        WM=true, WMAccent=Color3.fromRGB(214,40,40), WMText=Color3.fromRGB(218,218,228),
        WMBg=Color3.fromRGB(9,9,12), WMPos="TR", WMShowFPS=true, WMShowUser=true,
        SelfHL=false, SelfHLCol=Color3.fromRGB(214,40,40),
        Gradient=false, GradTop=Color3.fromRGB(214,40,40), GradBot=Color3.fromRGB(40,40,214),
        FOVDot=false,
        HitEffect=false,
        LowHP=false, LowHPThr=30,
        Radar=false, RadarSz=140,
        HitMarker=false, HMCol=Color3.fromRGB(255,255,255),
        HitSound=false, KillSound=false, HealSound=false,
        FlickLines=false, FlickCol=Color3.fromRGB(214,40,40),
    },

    -- Player
    Player={
        Speed=false, SpeedVal=28,
        InfJump=false, JumpPow=50,
        God=false, Bhop=false, AntiAFK=false,
    },
}

local function T() -- текущая тема
    if Cfg.Theme=="Custom" then
        return {acc=Cfg.CustomAcc,bg0=Cfg.CustomBg0,
                bg1=Color3.fromRGB(15,15,20),bg2=Color3.fromRGB(20,20,28),bg3=Color3.fromRGB(27,27,38)}
    end
    return THEMES[Cfg.Theme] or THEMES.Red
end

-- ══════════════════════════════
-- UTILS
-- ══════════════════════════════
local function W2S(pos)
    local s,on=Cam:WorldToViewportPoint(pos)
    return Vector2.new(s.X,s.Y),on,s.Z
end

local function IsKey(k)
    if k=="MB1" then return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) end
    if k=="MB2" then return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) end
    local ok,kc=pcall(function() return Enum.KeyCode[k] end)
    if ok and kc then return UIS:IsKeyDown(kc) end
    return false
end

local function HasWall(tp)
    local o=Cam.CFrame.Position; local d=tp-o
    local p=RaycastParams.new()
    p.FilterDescendantsInstances={LP.Character or workspace}
    p.FilterType=Enum.RaycastFilterType.Exclude
    local r=workspace:Raycast(o,d.Unit*d.Magnitude,p)
    if not r then return false end
    local hc=r.Instance and r.Instance:FindFirstAncestorOfClass("Model")
    return not(hc and Plrs:GetPlayerFromCharacter(hc))
end

local function GetBounds(ch)
    local x0,y0,x1,y1=1e9,1e9,-1e9,-1e9; local any=false
    for _,p in ipairs(ch:GetDescendants()) do
        if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
            local cf=p.CFrame
            local sx,sy,sz=p.Size.X/2,p.Size.Y/2,p.Size.Z/2
            for _,o in ipairs({
                Vector3.new( sx, sy, sz),Vector3.new(-sx, sy, sz),
                Vector3.new( sx,-sy, sz),Vector3.new(-sx,-sy, sz),
                Vector3.new( sx, sy,-sz),Vector3.new(-sx, sy,-sz),
                Vector3.new( sx,-sy,-sz),Vector3.new(-sx,-sy,-sz),
            }) do
                local s2,on=W2S(cf*o)
                if on then any=true
                    if s2.X<x0 then x0=s2.X end; if s2.Y<y0 then y0=s2.Y end
                    if s2.X>x1 then x1=s2.X end; if s2.Y>y1 then y1=s2.Y end
                end
            end
        end
    end
    return any and x0,y0,x1,y1 or nil
end

local BONES={
    {"Head","UpperTorso"},{"UpperTorso","LowerTorso"},
    {"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},
    {"UpperTorso","LeftUpperArm"}, {"LeftUpperArm","LeftLowerArm"}, {"LeftLowerArm","LeftHand"},
    {"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"},
    {"LowerTorso","LeftUpperLeg"}, {"LeftUpperLeg","LeftLowerLeg"}, {"LeftLowerLeg","LeftFoot"},
}

-- ══════════════════════════════
-- DRAWING HELPERS
-- ══════════════════════════════
local function DL(c,t)
    local l=Drawing.new("Line"); l.Color=c or Color3.new(1,1,1)
    l.Thickness=t or 1; l.Visible=false; return l
end
local function DT(s,c,ce)
    local t=Drawing.new("Text"); t.Size=s or 13; t.Color=c or Color3.new(1,1,1)
    t.Outline=true; t.Center=ce~=false; t.Font=Drawing.Fonts.UI; t.Visible=false; return t
end
local function DR(c,f,t)
    local r=Drawing.new("Square"); r.Color=c or Color3.new(1,1,1)
    r.Filled=f or false; r.Thickness=t or 1; r.Visible=false; return r
end
local function DC(c,r,f)
    local ci=Drawing.new("Circle"); ci.Color=c or Color3.new(1,1,1)
    ci.Radius=r or 5; ci.Filled=f~=false; ci.Visible=false; return ci
end

-- ══════════════════════════════
-- ESP POOL
-- ══════════════════════════════
local Pool={}

local function BuildESP(pl)
    if pl==LP then return end
    local o={}
    -- Corner box (8 линий + 8 теней)
    o.sc={}; for i=1,8 do o.sc[i]=DL(Color3.new(0,0,0),4) end
    o.cc={}; for i=1,8 do o.cc[i]=DL(Cfg.ESP.Box.Col,2) end
    -- Full box
    o.fsh=DR(Color3.new(0,0,0),false,3)
    o.fbox=DR(Cfg.ESP.Box.Col,false,1)
    -- Chams: glow (filled) + outline
    o.cglow=DR(Cfg.ESP.Chams.Col,true)
    o.cglow.Transparency=Cfg.ESP.Chams.GlowA
    o.cout=DR(Cfg.ESP.Chams.Col,false,2)
    -- Names & dist (с тенями)
    o.nsh=DT(Cfg.ESP.Names.Sz,Color3.new(0,0,0))
    o.name=DT(Cfg.ESP.Names.Sz,Cfg.ESP.Names.Col)
    o.dsh=DT(11,Color3.new(0,0,0))
    o.dist=DT(11,Cfg.ESP.Dist.Col)
    -- HP bar
    o.hsh=DR(Color3.new(0,0,0),true)
    o.hbg=DR(Color3.fromRGB(10,10,10),true)
    o.hfill=DR(Color3.fromRGB(80,255,80),true)
    o.htxt=DT(9,Color3.new(1,1,1))
    -- Skeleton
    o.sk={}; for i=1,#BONES do o.sk[i]=DL(Cfg.ESP.Skel.Col,1) end
    -- Tracer, snap, headdot
    o.trc=DL(Cfg.ESP.Trc.Col,1)
    o.snap=DL(Cfg.ESP.Snap.Col,1)
    o.hdb=DC(Color3.new(0,0,0),6,false); o.hdb.Filled=false; o.hdb.Thickness=2
    o.hdd=DC(Cfg.ESP.HDot.Col,4,true)
    -- Off-screen arrows
    o.ar={}; for i=1,3 do o.ar[i]=DL(Cfg.ESP.Arrow.Col,2) end
    Pool[pl]=o
end

local function KillESP(pl)
    local o=Pool[pl]; if not o then return end
    local function R(d) pcall(function() d:Remove() end) end
    for i=1,8 do R(o.sc[i]); R(o.cc[i]) end
    for _,s in ipairs(o.sk) do R(s) end
    for _,a in ipairs(o.ar) do R(a) end
    R(o.fsh);R(o.fbox);R(o.cglow);R(o.cout)
    R(o.nsh);R(o.name);R(o.dsh);R(o.dist)
    R(o.hsh);R(o.hbg);R(o.hfill);R(o.htxt)
    R(o.trc);R(o.snap);R(o.hdb);R(o.hdd)
    Pool[pl]=nil
end

local function HideESP(o)
    local function H(d) pcall(function() d.Visible=false end) end
    for i=1,8 do H(o.sc[i]); H(o.cc[i]) end
    for _,s in ipairs(o.sk) do H(s) end
    for _,a in ipairs(o.ar) do H(a) end
    H(o.fsh);H(o.fbox);H(o.cglow);H(o.cout)
    H(o.nsh);H(o.name);H(o.dsh);H(o.dist)
    H(o.hsh);H(o.hbg);H(o.hfill);H(o.htxt)
    H(o.trc);H(o.snap);H(o.hdb);H(o.hdd)
end

local function TickESP()
    for pl,o in pairs(Pool) do
        if not pl or not pl.Parent then KillESP(pl); continue end
        local ch=pl.Character
        local hm=ch and ch:FindFirstChildOfClass("Humanoid")
        local root=ch and ch:FindFirstChild("HumanoidRootPart")
        if not Cfg.ESP.On or not ch or not hm or not root or hm.Health<=0 then
            HideESP(o); continue
        end
        local d3=(Cam.CFrame.Position-root.Position).Magnitude
        if d3>Cfg.ESP.MaxDist then HideESP(o); continue end
        local rsp,onSc=W2S(root.Position)
        local vp=Cam.ViewportSize
        local isFr=Cfg.ESP.TeamCheck and pl.Team~=nil and pl.Team==LP.Team
        local bc=isFr and Cfg.ESP.Box.ColT or Cfg.ESP.Box.Col

        -- Off-screen arrow
        if Cfg.ESP.Arrow.On and not onSc then
            local dir=rsp-Vector2.new(vp.X/2,vp.Y/2)
            local ld=math.max(dir.Magnitude,1); dir=dir/ld
            local mn2=math.min(vp.X,vp.Y)
            local ex=math.clamp(vp.X/2+dir.X*mn2*.4,16,vp.X-16)
            local ey=math.clamp(vp.Y/2+dir.Y*mn2*.4,16,vp.Y-16)
            local ep=Vector2.new(ex,ey); local sz=9; local pr=Vector2.new(-dir.Y,dir.X)
            o.ar[1].From=ep+dir*sz; o.ar[1].To=ep-dir*sz+pr*sz
            o.ar[1].Color=Cfg.ESP.Arrow.Col; o.ar[1].Visible=true
            o.ar[2].From=ep+dir*sz; o.ar[2].To=ep-dir*sz-pr*sz
            o.ar[2].Color=Cfg.ESP.Arrow.Col; o.ar[2].Visible=true
            o.ar[3].From=ep-dir*sz+pr*sz; o.ar[3].To=ep-dir*sz-pr*sz
            o.ar[3].Color=Cfg.ESP.Arrow.Col; o.ar[3].Visible=true
            HideESP(o)
            for _,a in ipairs(o.ar) do a.Visible=true end
            continue
        else
            for _,a in ipairs(o.ar) do a.Visible=false end
        end

        if not onSc then HideESP(o); continue end
        local x0,y0,x1,y1=GetBounds(ch)
        if not x0 then HideESP(o); continue end
        local bw,bh=x1-x0,y1-y0
        local mx=(x0+x1)*.5

        -- Chams: glow (большой filled) + outline
        o.cglow.Visible=Cfg.ESP.Chams.On
        o.cout.Visible=Cfg.ESP.Chams.On
        if Cfg.ESP.Chams.On then
            local gp=5
            o.cglow.Position=Vector2.new(x0-gp,y0-gp)
            o.cglow.Size=Vector2.new(bw+gp*2,bh+gp*2)
            o.cglow.Color=Cfg.ESP.Chams.Col
            o.cglow.Transparency=Cfg.ESP.Chams.GlowA
            o.cout.Position=Vector2.new(x0,y0)
            o.cout.Size=Vector2.new(bw,bh)
            o.cout.Color=Cfg.ESP.Chams.Col
            o.cout.Transparency=Cfg.ESP.Chams.OutA
            o.cout.Thickness=2
        end

        -- Box
        local sB=Cfg.ESP.Box.On
        local isFull=Cfg.ESP.Box.Type=="Full"
        o.fsh.Visible=sB and isFull
        o.fbox.Visible=sB and isFull
        if sB and isFull then
            o.fsh.Position=Vector2.new(x0-1,y0-1)
            o.fsh.Size=Vector2.new(bw+2,bh+2)
            o.fbox.Position=Vector2.new(x0,y0)
            o.fbox.Size=Vector2.new(bw,bh)
            o.fbox.Color=bc
            o.fbox.Thickness=Cfg.ESP.Box.W
        end
        local sC=sB and not isFull
        local cL=math.max(math.min(bw,bh)*.22,6)
        local pts={
            {Vector2.new(x0,y0),Vector2.new(x0+cL,y0)},
            {Vector2.new(x0,y0),Vector2.new(x0,y0+cL)},
            {Vector2.new(x1,y0),Vector2.new(x1-cL,y0)},
            {Vector2.new(x1,y0),Vector2.new(x1,y0+cL)},
            {Vector2.new(x0,y1),Vector2.new(x0+cL,y1)},
            {Vector2.new(x0,y1),Vector2.new(x0,y1-cL)},
            {Vector2.new(x1,y1),Vector2.new(x1-cL,y1)},
            {Vector2.new(x1,y1),Vector2.new(x1,y1-cL)},
        }
        for i=1,8 do
            o.sc[i].From=pts[i][1]; o.sc[i].To=pts[i][2]; o.sc[i].Visible=sC
            o.cc[i].From=pts[i][1]; o.cc[i].To=pts[i][2]
            o.cc[i].Color=bc; o.cc[i].Thickness=Cfg.ESP.Box.W; o.cc[i].Visible=sC
        end

        -- HP bar
        local hp=math.clamp(hm.Health/hm.MaxHealth,0,1)
        local bx=x0-7
        o.hsh.Visible=Cfg.ESP.HP.Bar; o.hbg.Visible=Cfg.ESP.HP.Bar; o.hfill.Visible=Cfg.ESP.HP.Bar
        if Cfg.ESP.HP.Bar then
            o.hsh.Position=Vector2.new(bx-1,y0-1); o.hsh.Size=Vector2.new(6,bh+2)
            o.hbg.Position=Vector2.new(bx,y0); o.hbg.Size=Vector2.new(4,bh)
            local fh=bh*hp
            o.hfill.Position=Vector2.new(bx,y0+bh-fh); o.hfill.Size=Vector2.new(4,fh)
            o.hfill.Color=Color3.new(math.clamp(2*(1-hp),0,1),math.clamp(2*hp,0,1),.05)
        end
        o.htxt.Visible=Cfg.ESP.HP.Text
        if Cfg.ESP.HP.Text then
            o.htxt.Text=math.floor(hm.Health).."hp"
            o.htxt.Position=Vector2.new(bx+2,y0-14)
        end

        -- Names
        o.name.Visible=Cfg.ESP.Names.On; o.nsh.Visible=Cfg.ESP.Names.On
        if Cfg.ESP.Names.On then
            local dn=pl.DisplayName
            local ns=(dn~=pl.Name) and (dn.." ["..pl.Name.."]") or pl.Name
            o.nsh.Text=ns; o.nsh.Size=Cfg.ESP.Names.Sz
            o.nsh.Position=Vector2.new(mx+1,y0-15)
            o.name.Text=ns; o.name.Color=Cfg.ESP.Names.Col
            o.name.Size=Cfg.ESP.Names.Sz; o.name.Position=Vector2.new(mx,y0-16)
        end

        -- Distance
        o.dist.Visible=Cfg.ESP.Dist.On; o.dsh.Visible=Cfg.ESP.Dist.On
        if Cfg.ESP.Dist.On then
            local ds=string.format("%.0fm",d3)
            o.dsh.Text=ds; o.dsh.Size=11; o.dsh.Position=Vector2.new(mx+1,y1+4)
            o.dist.Text=ds; o.dist.Color=Cfg.ESP.Dist.Col; o.dist.Position=Vector2.new(mx,y1+3)
        end

        -- Skeleton
        for i,pair in ipairs(BONES) do
            local p1=ch:FindFirstChild(pair[1])
            local p2=ch:FindFirstChild(pair[2])
            local sl=o.sk[i]
            if Cfg.ESP.Skel.On and p1 and p2 then
                local s1,o1=W2S(p1.Position); local s2,o2=W2S(p2.Position)
                sl.From=s1; sl.To=s2; sl.Color=Cfg.ESP.Skel.Col
                sl.Thickness=Cfg.ESP.Skel.W; sl.Visible=o1 and o2
            else sl.Visible=false end
        end

        -- Tracer
        o.trc.Visible=Cfg.ESP.Trc.On
        if Cfg.ESP.Trc.On then
            local oy= Cfg.ESP.Trc.Origin=="Top" and 0
                   or Cfg.ESP.Trc.Origin=="Center" and vp.Y*.5
                   or vp.Y
            o.trc.From=Vector2.new(vp.X*.5,oy); o.trc.To=Vector2.new(mx,y1)
            o.trc.Color=Cfg.ESP.Trc.Col; o.trc.Thickness=Cfg.ESP.Trc.W
        end

        -- Snap line
        o.snap.Visible=Cfg.ESP.Snap.On
        if Cfg.ESP.Snap.On then
            local head=ch:FindFirstChild("Head")
            if head then
                local hs,hon=W2S(head.Position)
                if hon then
                    o.snap.From=Vector2.new(vp.X*.5,vp.Y*.5)
                    o.snap.To=hs; o.snap.Color=Cfg.ESP.Snap.Col
                else o.snap.Visible=false end
            else o.snap.Visible=false end
        end

        -- Head dot
        local head=ch:FindFirstChild("Head")
        if Cfg.ESP.HDot.On and head then
            local hs,hon=W2S(head.Position)
            o.hdb.Visible=hon; o.hdd.Visible=hon
            if hon then
                o.hdb.Position=hs; o.hdb.Radius=Cfg.ESP.HDot.R+2
                o.hdd.Position=hs; o.hdd.Radius=Cfg.ESP.HDot.R; o.hdd.Color=bc
            end
        else o.hdb.Visible=false; o.hdd.Visible=false end
    end
end

-- Подключаем ESP для всех игроков
for _,p in ipairs(Plrs:GetPlayers()) do
    BuildESP(p)
    p.CharacterRemoving:Connect(function()
        local o=Pool[p]; if o then HideESP(o) end
    end)
end
Plrs.PlayerAdded:Connect(function(p)
    task.wait(.5); BuildESP(p)
    p.CharacterRemoving:Connect(function()
        local o=Pool[p]; if o then HideESP(o) end
    end)
end)
Plrs.PlayerRemoving:Connect(KillESP)

print("[natality p1] ESP loaded")
-- ══════════════════════════════
-- ЧАСТЬ 2: HUD DRAWINGS
-- Watermark, Radar, Spectator List,
-- Crosshair, Hit Effect, Hit Marker,
-- Gradient, Wide Screen, FOV circles
-- ══════════════════════════════

-- FOV circles
local fovL=Drawing.new("Circle"); fovL.Thickness=1; fovL.Filled=false; fovL.Transparency=.5; fovL.Visible=false
local fovR=Drawing.new("Circle"); fovR.Thickness=1; fovR.Filled=false; fovR.Transparency=.5; fovR.Visible=false
local fovDot=DC(Color3.fromRGB(214,40,40),3,true)

-- Crosshair
local chH=DL(Cfg.Vis.CHCol,1); local chV=DL(Cfg.Vis.CHCol,1); local chDot=DC(Cfg.Vis.CHCol,2,true)

-- Hit effect
local hitRect=DR(Color3.fromRGB(200,20,20),true); hitRect.Transparency=1; hitRect.Visible=true
local hitA=0

-- Hit Marker: 4 линии крестом (Drawing, не GUI)
local HM={}
for i=1,4 do HM[i]=DL(Color3.new(1,1,1),2) end
local hmOn=false; local hmT=0

-- Low HP text
local lowTxt=DT(20,Color3.fromRGB(220,40,40),true); lowTxt.Visible=false

-- Flick lines (6 отрезков = след мыши)
local flL={}
for i=1,6 do
    flL[i]=DL(Cfg.Vis.FlickCol,1)
    flL[i].Transparency=.15+i*.12
end
local flH={}; for i=1,7 do flH[i]=Vector2.new(0,0) end

-- Wide Screen bars
local wsT=DR(Color3.new(0,0,0),true); local wsB=DR(Color3.new(0,0,0),true)
wsT.Transparency=0; wsB.Transparency=0

-- Gradient overlay (2 прямоугольника сверху и снизу)
local gradT=DR(Color3.fromRGB(214,40,40),true); gradT.Transparency=.75
local gradB=DR(Color3.fromRGB(40,40,214),true); gradB.Transparency=.75

-- ══════════════════════════════
-- WATERMARK
-- ══════════════════════════════
-- Позиция (можно двигать в меню через слайдеры)
local WM={ox=0, oy=10}   -- offset от края

local wmBg  = DR(Color3.fromRGB(9,9,12),true);    wmBg.Transparency=0.06
local wmLine= DR(Color3.fromRGB(214,40,40),true)  -- полоска акцента
local wmBdr = DR(Color3.fromRGB(214,40,40),false,1)
local wmName= Drawing.new("Text")
wmName.Size=16; wmName.Color=Color3.fromRGB(218,218,228)
wmName.Outline=true; wmName.Center=false; wmName.Font=Drawing.Fonts.UI; wmName.Visible=false
local wmSub = Drawing.new("Text")
wmSub.Size=11; wmSub.Color=Color3.fromRGB(120,120,140)
wmSub.Outline=true; wmSub.Center=false; wmSub.Font=Drawing.Fonts.UI; wmSub.Visible=false

local function DrawWM(fps)
    local th=T()
    local sh=Cfg.Vis.WM
    wmBg.Visible=sh; wmLine.Visible=sh; wmBdr.Visible=sh; wmName.Visible=sh; wmSub.Visible=sh
    if not sh then return end
    local vp=Cam.ViewportSize
    local pw,ph=224,44
    local px
    if Cfg.Vis.WMPos=="TL" then px=10+WM.ox else px=vp.X-pw-10+WM.ox end
    local py=WM.oy
    wmBg.Position=Vector2.new(px,py); wmBg.Size=Vector2.new(pw,ph); wmBg.Color=Cfg.Vis.WMBg
    wmBdr.Position=Vector2.new(px,py); wmBdr.Size=Vector2.new(pw,ph); wmBdr.Color=th.acc
    wmLine.Position=Vector2.new(px,py); wmLine.Size=Vector2.new(pw,2); wmLine.Color=th.acc
    wmName.Text="natality"; wmName.Color=Cfg.Vis.WMText; wmName.Position=Vector2.new(px+10,py+8)
    local parts={"roblox"}
    if Cfg.Vis.WMShowFPS then parts[#parts+1]=fps.."fps" end
    if Cfg.Vis.WMShowUser then parts[#parts+1]=LP.Name end
    parts[#parts+1]="v1"
    wmSub.Text=table.concat(parts,"  ·  "); wmSub.Position=Vector2.new(px+10,py+27)
end

-- ══════════════════════════════
-- SPECTATOR LIST
-- ══════════════════════════════
local SPEC={ox=0, oy=58}
local SMAX=10
local sBg  = DR(Color3.fromRGB(9,9,12),true);   sBg.Transparency=0.06
local sBdr = DR(Color3.fromRGB(214,40,40),false,1)
local sLine= DR(Color3.fromRGB(214,40,40),true)
local sHdr = Drawing.new("Text")
sHdr.Size=13; sHdr.Color=Color3.fromRGB(214,40,40); sHdr.Outline=true; sHdr.Center=false; sHdr.Font=Drawing.Fonts.UI; sHdr.Visible=false
local sLns={}
for i=1,SMAX do
    sLns[i]=Drawing.new("Text"); sLns[i].Size=12
    sLns[i].Color=Color3.fromRGB(200,200,215); sLns[i].Outline=true
    sLns[i].Center=false; sLns[i].Font=Drawing.Fonts.UI; sLns[i].Visible=false
end

local function DrawSpec()
    local th=T()
    local list={}
    if Cfg.Vis.SpecList then
        for _,p in ipairs(Plrs:GetPlayers()) do
            if p==LP then continue end
            local ch=p.Character
            local hm=ch and ch:FindFirstChildOfClass("Humanoid")
            if not ch or not hm or hm.Health<=0 then list[#list+1]=p.Name end
        end
    end
    local n=math.min(#list,SMAX)
    local show=Cfg.Vis.SpecList and n>0
    local pw=178; local ph=34+n*17+6
    local vp=Cam.ViewportSize
    local bx=vp.X-pw-10+SPEC.ox; local by=SPEC.oy
    sBg.Visible=show; sBdr.Visible=show; sLine.Visible=show; sHdr.Visible=show
    if show then
        sBg.Position=Vector2.new(bx,by); sBg.Size=Vector2.new(pw,ph)
        sBdr.Position=Vector2.new(bx,by); sBdr.Size=Vector2.new(pw,ph); sBdr.Color=th.acc
        sLine.Position=Vector2.new(bx,by); sLine.Size=Vector2.new(pw,2); sLine.Color=th.acc
        sHdr.Text="SPECTATORS  ["..n.."]"; sHdr.Color=th.acc; sHdr.Position=Vector2.new(bx+8,by+8)
    end
    for i=1,SMAX do
        sLns[i].Visible=show and list[i]~=nil
        if sLns[i].Visible then
            sLns[i].Text="  › "..list[i]
            sLns[i].Position=Vector2.new(bx+8,by+26+(i-1)*17)
        end
    end
end

-- ══════════════════════════════
-- RADAR
-- ══════════════════════════════
local RAD={x=10, y=10}
local radBg  = DR(Color3.fromRGB(9,9,12),true);  radBg.Transparency=0.06
local radBdr = DR(Color3.fromRGB(214,40,40),false,1)
local radLine= DR(Color3.fromRGB(214,40,40),true)
local radCH  = DL(Color3.fromRGB(35,35,45),1)
local radCV  = DL(Color3.fromRGB(35,35,45),1)
local radSelf= DC(Color3.fromRGB(80,200,80),5,true)
local radDots={}
for i=1,Plrs.MaxPlayers do radDots[i]=DC(Color3.fromRGB(214,40,40),3,true) end

local function DrawRadar()
    local th=T()
    local sh=Cfg.Vis.Radar; local rsz=Cfg.Vis.RadarSz
    local rx=RAD.x; local ry=RAD.y
    local cx2=rx+rsz/2; local cy2=ry+rsz/2
    radBg.Visible=sh; radBdr.Visible=sh; radLine.Visible=sh
    radCH.Visible=sh; radCV.Visible=sh; radSelf.Visible=sh
    if sh then
        radBg.Position=Vector2.new(rx,ry); radBg.Size=Vector2.new(rsz,rsz)
        radBdr.Position=Vector2.new(rx,ry); radBdr.Size=Vector2.new(rsz,rsz); radBdr.Color=th.acc
        radLine.Position=Vector2.new(rx,ry); radLine.Size=Vector2.new(rsz,2); radLine.Color=th.acc
        radCH.From=Vector2.new(rx,cy2); radCH.To=Vector2.new(rx+rsz,cy2)
        radCV.From=Vector2.new(cx2,ry); radCV.To=Vector2.new(cx2,ry+rsz)
        radSelf.Position=Vector2.new(cx2,cy2)
    end
    local pi=0
    for _,p in ipairs(Plrs:GetPlayers()) do
        if p==LP then continue end; pi=pi+1; if pi>#radDots then break end
        local dot=radDots[pi]; dot.Visible=false
        if sh then
            local ch=p.Character; local r2=ch and ch:FindFirstChild("HumanoidRootPart")
            if not r2 then continue end
            local mr=LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if not mr then continue end
            -- Учитываем поворот камеры
            local d=r2.Position-mr.Position
            local rel=Cam.CFrame:VectorToObjectSpace(d)
            local dx=math.clamp(-rel.X/Cfg.ESP.MaxDist*.5+.5,0,1)
            local dz=math.clamp(-rel.Z/Cfg.ESP.MaxDist*.5+.5,0,1)
            dot.Position=Vector2.new(rx+dx*rsz,ry+dz*rsz)
            dot.Color=Cfg.ESP.Box.Col; dot.Visible=true
        end
    end
    for i=pi+1,#radDots do radDots[i].Visible=false end
end

print("[natality p2] HUD loaded")
-- ══════════════════════════════
-- ЧАСТЬ 3: GUI
-- Loading screen, Main Window,
-- Tab Bar, UI builders (Toggle,
-- Expand, Slider, Dropdown, etc)
-- ══════════════════════════════

if PGui:FindFirstChild("NatalityMenu") then PGui.NatalityMenu:Destroy() end
local GUI=Instance.new("ScreenGui")
GUI.Name="NatalityMenu"; GUI.ResetOnSpawn=false
GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
GUI.IgnoreGuiInset=true; GUI.Parent=PGui

-- Утилиты создания UI
local function mkC(p,r)
    local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 4); c.Parent=p
end
local function mkS(p,col,t)
    local s=Instance.new("UIStroke"); s.Color=col or Color3.fromRGB(24,24,36)
    s.Thickness=t or 1; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=p
end
local function mkP(p,t,b,l,r)
    local x=Instance.new("UIPadding")
    x.PaddingTop=UDim.new(0,t or 0); x.PaddingBottom=UDim.new(0,b or 0)
    x.PaddingLeft=UDim.new(0,l or 0); x.PaddingRight=UDim.new(0,r or 0); x.Parent=p
end
local function mkL(p,pad)
    local l=Instance.new("UIListLayout")
    l.SortOrder=Enum.SortOrder.LayoutOrder
    l.Padding=UDim.new(0,pad or 0); l.Parent=p
end

-- Единый обработчик нажатий (мышь + тач)
local function OnTap(inst,fn)
    -- MouseButton1Click — единственный надёжный способ
    -- InputBegan перехватывается ScrollingFrame для скролла
    inst.MouseButton1Click:Connect(function()
        task.spawn(fn)
    end)
end

-- Размерные константы
local M=MOB and 1.3 or 1.0
local Z={
    tH = math.floor(28*M),   -- высота строки toggle
    fS = math.floor(12*M),   -- основной шрифт
    sfS= math.floor(11*M),   -- суб-шрифт
    swW= math.floor(34*M),   -- ширина switch
    swH= math.floor(17*M),   -- высота switch
    slH= math.floor(42*M),   -- высота слайдера
    trH= math.floor(5*M),    -- высота трека
    hdSz=math.floor(11*M),   -- размер handle
}
local KW=Z.swH-4  -- knob width

-- Цвета (используем функцию T() из части 1)
local function ACC() return T().acc end
local COL={
    txt =Color3.fromRGB(218,218,228),
    txt2=Color3.fromRGB(100,100,120),
    txt3=Color3.fromRGB(44,44,58),
    hw  =Color3.fromRGB(240,240,248),
    sep =Color3.fromRGB(24,24,36),
}

-- ══════════════════════════════
-- LOADING SCREEN
-- ══════════════════════════════
local LS=Instance.new("Frame")
LS.Size=UDim2.new(1,0,1,0)
-- НЕ чёрный — полупрозрачный размытый
LS.BackgroundColor3=Color3.fromRGB(6,6,10)
LS.BackgroundTransparency=0.12
LS.BorderSizePixel=0; LS.ZIndex=200; LS.Parent=GUI

-- Blur поверх игры
local blurFX=Instance.new("BlurEffect"); blurFX.Size=18; blurFX.Parent=Light

-- Компактный loading box (не большой!)
local LB=Instance.new("Frame")
LB.Size=UDim2.new(0,260,0,120)
LB.AnchorPoint=Vector2.new(.5,.5); LB.Position=UDim2.new(.5,0,.5,0)
LB.BackgroundColor3=Color3.fromRGB(12,12,16)
LB.BorderSizePixel=0; LB.ZIndex=201; LB.Parent=LS
mkC(LB,8); mkS(LB,Color3.fromRGB(214,40,40),1)

local LTop=Instance.new("Frame")
LTop.Size=UDim2.new(1,0,0,2); LTop.BackgroundColor3=Color3.fromRGB(214,40,40)
LTop.BorderSizePixel=0; LTop.ZIndex=202; LTop.Parent=LB; mkC(LTop,8)

local function LLbl(t,y,sz,col,bold,xa)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(1,-20,0,sz+4); l.Position=UDim2.new(0,10,0,y)
    l.BackgroundTransparency=1; l.Text=t
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize=sz; l.TextColor3=col
    l.TextXAlignment=xa or Enum.TextXAlignment.Left
    l.ZIndex=202; l.Parent=LB; return l
end
LLbl("natality",10,22,COL.txt,true)
LLbl("roblox  ×  v1.0",36,11,Color3.fromRGB(55,55,75))
local LStat=LLbl("initializing...",55,11,Color3.fromRGB(214,40,40))
local LBBg=Instance.new("Frame")
LBBg.Size=UDim2.new(1,-20,0,3); LBBg.Position=UDim2.new(0,10,0,82)
LBBg.BackgroundColor3=Color3.fromRGB(20,20,30); LBBg.BorderSizePixel=0; LBBg.ZIndex=202; LBBg.Parent=LB; mkC(LBBg,2)
local LBar=Instance.new("Frame")
LBar.Size=UDim2.new(0,0,1,0); LBar.BackgroundColor3=Color3.fromRGB(214,40,40)
LBar.BorderSizePixel=0; LBar.ZIndex=203; LBar.Parent=LBBg; mkC(LBar,2)
local LPct=LLbl("0%",88,9,Color3.fromRGB(48,48,68),false,Enum.TextXAlignment.Right)

local lSt={
    {.15,"loading esp..."},
    {.35,"loading aimbot..."},
    {.55,"loading visuals..."},
    {.75,"loading hud..."},
    {.90,"finalizing..."},
    {1.0,"ready"},
}
local totalLoad=#lSt*.15+.18+.28

task.spawn(function()
    for _,s in ipairs(lSt) do
        task.wait(.15)
        TS:Create(LBar,TweenInfo.new(.12),{Size=UDim2.new(s[1],0,1,0)}):Play()
        LStat.Text=s[2]; LPct.Text=math.floor(s[1]*100).."%"
    end
    task.wait(.18)
    TS:Create(blurFX,TweenInfo.new(.35),{Size=0}):Play()
    TS:Create(LS,TweenInfo.new(.28),{BackgroundTransparency=1}):Play()
    for _,v in ipairs(LS:GetDescendants()) do
        pcall(function()
            if v:IsA("TextLabel") then TS:Create(v,TweenInfo.new(.2),{TextTransparency=1}):Play()
            elseif v:IsA("Frame") then TS:Create(v,TweenInfo.new(.2),{BackgroundTransparency=1}):Play() end
        end)
    end
    task.wait(.3); LS:Destroy(); blurFX:Destroy()
end)

-- ══════════════════════════════
-- MAIN WINDOW
-- ══════════════════════════════
local MW=MOB and math.min(Cam.ViewportSize.X-16,500) or 680
local MH=MOB and math.min(Cam.ViewportSize.Y-40,580) or 490

local Main=Instance.new("Frame")
Main.Name="Main"; Main.Size=UDim2.new(0,MW,0,MH)
Main.AnchorPoint=Vector2.new(.5,.5); Main.Position=UDim2.new(.5,0,.5,0)
Main.BackgroundColor3=Color3.fromRGB(10,10,13)
Main.BorderSizePixel=0; Main.Visible=false; Main.Parent=GUI
mkC(Main,8); mkS(Main,Color3.fromRGB(28,28,44),1)

-- БЛОКИРОВЩИК ВВОДА: прозрачный TextButton поверх всего,
-- который поглощает клики когда меню открыто
local Blocker=Instance.new("TextButton")
Blocker.Size=UDim2.new(1,0,1,0); Blocker.BackgroundTransparency=1
Blocker.Text=""; Blocker.AutoButtonColor=false; Blocker.ZIndex=2
Blocker.Visible=false; Blocker.Parent=Main

task.delay(totalLoad,function()
    Main.Visible=true; Blocker.Visible=true
    Main.Size=UDim2.new(0,MW,0,0)
    TS:Create(Main,TweenInfo.new(.24,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
        {Size=UDim2.new(0,MW,0,MH)}):Play()
end)

local Shdw=Instance.new("ImageLabel")
Shdw.AnchorPoint=Vector2.new(.5,.5); Shdw.Size=UDim2.new(1,56,1,56)
Shdw.Position=UDim2.new(.5,0,.5,7); Shdw.Image="rbxassetid://6014261993"
Shdw.ImageColor3=Color3.new(0,0,0); Shdw.ImageTransparency=.65
Shdw.BackgroundTransparency=1; Shdw.ZIndex=0; Shdw.Parent=Main

local TLine=Instance.new("Frame")
TLine.Size=UDim2.new(1,0,0,2); TLine.BackgroundColor3=Color3.fromRGB(214,40,40)
TLine.BorderSizePixel=0; TLine.ZIndex=6; TLine.Parent=Main; mkC(TLine,8)

local Hdr=Instance.new("Frame")
Hdr.Name="Hdr"; Hdr.Size=UDim2.new(1,0,0,36)
Hdr.Position=UDim2.new(0,0,0,2); Hdr.BackgroundColor3=Color3.fromRGB(14,14,19)
Hdr.BorderSizePixel=0; Hdr.ZIndex=5; Hdr.Parent=Main

local function TxtL(p,t,x,w,sz,col,bold,xa)
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(0,w,1,0); l.Position=UDim2.new(0,x,0,0)
    l.BackgroundTransparency=1; l.Text=t
    l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham
    l.TextSize=sz or 12; l.TextColor3=col or COL.txt
    l.TextXAlignment=xa or Enum.TextXAlignment.Left
    l.ZIndex=6; l.Parent=p; return l
end
TxtL(Hdr,"natality",10,70,15,Color3.fromRGB(214,40,40),true)
TxtL(Hdr,"× roblox",80,70,10,COL.txt3,false)

local bSz=MOB and 32 or 22
local function HBtn(icon,ox,col)
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(0,bSz,0,bSz-6); b.Position=UDim2.new(1,ox,.5,-(bSz-6)/2)
    b.BackgroundColor3=col or Color3.fromRGB(26,26,36); b.BorderSizePixel=0
    b.Text=icon; b.Font=Enum.Font.GothamBold
    b.TextSize=MOB and 13 or 10; b.TextColor3=Color3.new(1,1,1)
    b.ZIndex=7; b.Parent=Hdr; mkC(b,4); return b
end
local BClose=HBtn("✕",-6-bSz,Color3.fromRGB(175,32,32))
local BMin=HBtn("─",-10-bSz*2)

OnTap(BClose,function()
    Main.Visible=false; Blocker.Visible=false
end)

local minimized=false
OnTap(BMin,function()
    minimized=not minimized
    for _,v in ipairs(Main:GetChildren()) do
        if v~=Hdr and v~=TLine and v~=Shdw and v~=Blocker then
            v.Visible=not minimized
        end
    end
    TS:Create(Main,TweenInfo.new(.14),{Size=UDim2.new(0,MW,0,minimized and 38 or MH)}):Play()
end)

-- ══════════════════════════════
-- TAB BAR
-- ══════════════════════════════
local TABS={"visuals","legit","rage","players","config"}
local tabH=MOB and 40 or 28

local TabBar=Instance.new("Frame")
TabBar.Size=UDim2.new(1,0,0,tabH); TabBar.Position=UDim2.new(0,0,0,38)
TabBar.BackgroundColor3=Color3.fromRGB(14,14,19)
TabBar.BorderSizePixel=0; TabBar.ZIndex=5; TabBar.Parent=Main

local TDiv=Instance.new("Frame")
TDiv.Size=UDim2.new(1,0,0,1); TDiv.Position=UDim2.new(0,0,1,-1)
TDiv.BackgroundColor3=COL.sep; TDiv.BorderSizePixel=0; TDiv.ZIndex=5; TDiv.Parent=TabBar

local cTop=38+tabH+2
local CA=Instance.new("Frame")
CA.Size=UDim2.new(1,0,0,MH-cTop); CA.Position=UDim2.new(0,0,0,cTop)
CA.BackgroundTransparency=1
CA.ClipsDescendants=false   -- НЕ обрезаем (expand суб-панели)
CA.Parent=Main

-- ══════════════════════════════
-- UI BUILDERS
-- ══════════════════════════════

-- Tab
local TabUL={}
local function MkTab(n,i)
    local tot=#TABS
    local b=Instance.new("TextButton")
    b.Size=UDim2.new(1/tot,0,1,0); b.Position=UDim2.new((i-1)/tot,0,0,0)
    b.BackgroundColor3=Color3.fromRGB(14,14,19); b.BorderSizePixel=0
    b.Text=n; b.Font=Enum.Font.Gotham
    b.TextSize=MOB and 12 or 10; b.TextColor3=COL.txt2; b.ZIndex=6; b.Parent=TabBar
    local ul=Instance.new("Frame")
    ul.Size=UDim2.new(1,0,0,2); ul.Position=UDim2.new(0,0,1,-2)
    ul.BackgroundColor3=Color3.fromRGB(214,40,40); ul.BorderSizePixel=0; ul.Visible=false; ul.ZIndex=7; ul.Parent=b
    TabUL[b]=ul; return b
end

-- Page (2 колонки)
local function MkPage()
    local pg=Instance.new("Frame")
    pg.Size=UDim2.new(1,0,1,0); pg.BackgroundTransparency=1
    pg.Visible=false; pg.ClipsDescendants=false; pg.Parent=CA

    local function Col(xo,ws)
        local sf=Instance.new("ScrollingFrame")
        sf.Size=UDim2.new(ws,-5,1,-4)
        sf.Position=UDim2.new(xo,xo==0 and 4 or 2,0,2)
        sf.BackgroundTransparency=1; sf.BorderSizePixel=0
        sf.ScrollBarThickness=MOB and 3 or 2
        sf.ScrollBarImageColor3=Color3.fromRGB(214,40,40)
        sf.CanvasSize=UDim2.new(0,0,0,0)
        sf.AutomaticCanvasSize=Enum.AutomaticSize.Y
        sf.ClipsDescendants=false  -- ВАЖНО: не обрезать expand панели
        sf.Parent=pg; mkL(sf,5); mkP(sf,5,5,4,4); return sf
    end
    return pg,Col(0,.5),Col(.5,.5)
end

-- Group
local function MkGrp(parent,title)
    local card=Instance.new("Frame")
    card.Size=UDim2.new(1,0,0,0); card.AutomaticSize=Enum.AutomaticSize.Y
    card.BackgroundColor3=Color3.fromRGB(19,19,26); card.BorderSizePixel=0
    card.ClipsDescendants=false; card.Parent=parent
    mkC(card,6); mkS(card,Color3.fromRGB(20,20,32),1)

    local hRow=Instance.new("Frame")
    hRow.Size=UDim2.new(1,0,0,24); hRow.BackgroundColor3=Color3.fromRGB(26,26,36)
    hRow.BorderSizePixel=0; hRow.Parent=card; mkC(hRow,6)
    local hFix=Instance.new("Frame")
    hFix.Size=UDim2.new(1,0,.5,0); hFix.Position=UDim2.new(0,0,.5,0)
    hFix.BackgroundColor3=Color3.fromRGB(26,26,36); hFix.BorderSizePixel=0; hFix.Parent=hRow
    local ac=Instance.new("Frame")
    ac.Size=UDim2.new(0,2,0,12); ac.Position=UDim2.new(0,7,.5,-6)
    ac.BackgroundColor3=Color3.fromRGB(214,40,40); ac.BorderSizePixel=0; ac.Parent=hRow; mkC(ac,1)
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-16,1,0); lbl.Position=UDim2.new(0,16,0,0)
    lbl.BackgroundTransparency=1; lbl.Text=string.upper(title)
    lbl.Font=Enum.Font.GothamBold; lbl.TextSize=10; lbl.TextColor3=COL.txt2
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=hRow

    local body=Instance.new("Frame")
    body.Size=UDim2.new(1,0,0,0); body.Position=UDim2.new(0,0,0,24)
    body.AutomaticSize=Enum.AutomaticSize.Y; body.BackgroundTransparency=1
    body.ClipsDescendants=false; body.Parent=card
    mkL(body,0); mkP(body,4,7,10,10); return body
end

-- Color Swatch
local function CS(parent,tbl,key,z,cb)
    local safe=typeof(tbl[key])=="Color3" and tbl[key] or Color3.fromRGB(214,40,40)
    tbl[key]=safe
    local wrap=Instance.new("Frame")
    wrap.Size=UDim2.new(0,22,0,14); wrap.BackgroundColor3=safe
    wrap.BorderSizePixel=0; wrap.ClipsDescendants=false; wrap.Parent=parent
    mkC(wrap,3); mkS(wrap,Color3.fromRGB(45,45,65),1)

    -- Кнопка на всей площади + немного вокруг (удобнее нажать)
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(1,8,1,8); btn.Position=UDim2.new(0,-4,0,-4)
    btn.BackgroundTransparency=1; btn.Text=""; btn.AutoButtonColor=false
    btn.ZIndex=(z or 10)+1; btn.Parent=wrap

    local pop=Instance.new("Frame")
    pop.Size=UDim2.new(0,176,0,130); pop.Position=UDim2.new(1,-176,1,4)
    pop.BackgroundColor3=Color3.fromRGB(14,14,19); pop.BorderSizePixel=0
    pop.Visible=false; pop.ZIndex=(z or 10)+30; pop.ClipsDescendants=false; pop.Parent=wrap
    mkC(pop,6); mkS(pop,Color3.fromRGB(38,38,58),1); mkP(pop,7,7,7,7)

    local pv=Instance.new("Frame")
    pv.Size=UDim2.new(1,0,0,14); pv.BackgroundColor3=safe; pv.BorderSizePixel=0; pv.Parent=pop; mkC(pv,3)

    local rgb={R=safe.R*255,G=safe.G*255,B=safe.B*255}
    local function Ref()
        local nc=Color3.fromRGB(math.floor(rgb.R+.5),math.floor(rgb.G+.5),math.floor(rgb.B+.5))
        tbl[key]=nc; wrap.BackgroundColor3=nc; pv.BackgroundColor3=nc
        if cb then cb(nc) end
    end

    local inn=Instance.new("Frame")
    inn.Size=UDim2.new(1,0,0,0); inn.Position=UDim2.new(0,0,0,20)
    inn.AutomaticSize=Enum.AutomaticSize.Y; inn.BackgroundTransparency=1; inn.Parent=pop; mkL(inn,2)

    local cc={R=Color3.fromRGB(220,55,55),G=Color3.fromRGB(55,200,80),B=Color3.fromRGB(55,120,220)}
    for _,ch in ipairs({"R","G","B"}) do
        local lch=ch
        local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,26); row.BackgroundTransparency=1; row.Parent=inn
        local lbR=Instance.new("TextLabel"); lbR.Size=UDim2.new(0,10,0,11); lbR.BackgroundTransparency=1; lbR.Text=ch; lbR.Font=Enum.Font.GothamBold; lbR.TextSize=10; lbR.TextColor3=cc[ch]; lbR.TextXAlignment=Enum.TextXAlignment.Left; lbR.Parent=row
        local vl=Instance.new("TextLabel"); vl.Size=UDim2.new(0,22,0,11); vl.Position=UDim2.new(1,-22,0,0); vl.BackgroundTransparency=1; vl.Text=tostring(math.floor(rgb[ch])); vl.Font=Enum.Font.GothamBold; vl.TextSize=10; vl.TextColor3=COL.txt2; vl.TextXAlignment=Enum.TextXAlignment.Right; vl.Parent=row
        local tr=Instance.new("Frame"); tr.Size=UDim2.new(1,0,0,4); tr.Position=UDim2.new(0,0,0,14); tr.BackgroundColor3=Color3.fromRGB(26,26,36); tr.BorderSizePixel=0; tr.Parent=row; mkC(tr,2)
        local fi=Instance.new("Frame"); fi.Size=UDim2.new(rgb[ch]/255,0,1,0); fi.BackgroundColor3=cc[ch]; fi.BorderSizePixel=0; fi.Parent=tr; mkC(fi,2)
        local hd=Instance.new("Frame"); hd.Size=UDim2.new(0,12,0,12); hd.Position=UDim2.new(rgb[ch]/255,-6,.5,-6); hd.BackgroundColor3=COL.hw; hd.BorderSizePixel=0; hd.Parent=tr; mkC(hd,6)
        local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,8,0,MOB and 36 or 22); hit.Position=UDim2.new(0,-4,.5,-(MOB and 18 or 11)); hit.BackgroundTransparency=1; hit.Text=""; hit.AutoButtonColor=false; hit.ZIndex=(z or 10)+31; hit.Parent=tr
        local dg=false
        local function UpdC(x)
            local rel=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
            rgb[lch]=rel*255; fi.Size=UDim2.new(rel,0,1,0); hd.Position=UDim2.new(rel,-6,.5,-6)
            vl.Text=tostring(math.floor(rgb[lch])); Ref()
        end
        hit.InputBegan:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
                dg=true; UpdC(i.Position.X)
            end
        end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dg=false end
        end)
        UIS.InputChanged:Connect(function(i)
            if dg and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then UpdC(i.Position.X) end
        end)
    end
    OnTap(btn,function() pop.Visible=not pop.Visible end)
    return wrap
end

-- Toggle
local function Tog(parent,label,tbl,key,cb)
    local row=Instance.new("TextButton")
    row.Size=UDim2.new(1,0,0,Z.tH); row.BackgroundTransparency=1
    row.Text=""; row.AutoButtonColor=false; row.Parent=parent

    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-Z.swW-8,1,0); lbl.BackgroundTransparency=1; lbl.Text=label
    lbl.Font=Enum.Font.Gotham; lbl.TextSize=Z.fS
    lbl.TextColor3=tbl[key] and COL.txt or COL.txt2
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=row

    local track=Instance.new("Frame")
    track.Size=UDim2.new(0,Z.swW,0,Z.swH); track.Position=UDim2.new(1,-Z.swW-4,.5,-Z.swH/2)
    track.BackgroundColor3=tbl[key] and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36)
    track.BorderSizePixel=0; track.Parent=row; mkC(track,Z.swH)

    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,KW,0,KW)
    knob.Position=tbl[key] and UDim2.new(1,-KW-2,.5,-KW/2) or UDim2.new(0,2,.5,-KW/2)
    knob.BackgroundColor3=COL.hw; knob.BorderSizePixel=0; knob.Parent=track; mkC(knob,KW)

    local function Press()
        tbl[key]=not tbl[key]; local on=tbl[key]
        TS:Create(knob,TweenInfo.new(.12),{Position=on and UDim2.new(1,-KW-2,.5,-KW/2) or UDim2.new(0,2,.5,-KW/2)}):Play()
        TS:Create(track,TweenInfo.new(.12),{BackgroundColor3=on and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36)}):Play()
        lbl.TextColor3=on and COL.txt or COL.txt2
        pcall(function() Snd("3701374829",.18,on and 1.1 or .9) end)
        if cb then cb(on) end
    end
    OnTap(row,Press); return row
end

-- Expand Row
-- ФИКС ГЛАВНОГО БАГА: subPanel является дочерним элементом cont,
-- а не row — поэтому AutomaticSize работает корректно
local function Exp(parent,label,tbl,key,cTbl,cKey,subBuild)
    -- Контейнер
    local cont=Instance.new("Frame")
    cont.Size=UDim2.new(1,0,0,0)
    cont.AutomaticSize=Enum.AutomaticSize.Y
    cont.BackgroundTransparency=1
    cont.ClipsDescendants=false
    cont.Parent=parent

    -- Строка с ФИКСИРОВАННОЙ высотой (НЕ AutomaticSize)
    local row=Instance.new("Frame")
    row.Size=UDim2.new(1,0,0,Z.tH)  -- фиксированно!
    row.BackgroundTransparency=1
    row.ClipsDescendants=false
    row.Parent=cont

    -- Label
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-Z.swW-60,1,0); lbl.BackgroundTransparency=1; lbl.Text=label
    lbl.Font=Enum.Font.Gotham; lbl.TextSize=Z.fS
    lbl.TextColor3=tbl[key] and COL.txt or COL.txt2
    lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=row

    -- Swatch
    if cTbl and cKey then
        local swF=Instance.new("Frame")
        swF.Size=UDim2.new(0,22,0,14); swF.Position=UDim2.new(1,-Z.swW-56,.5,-7)
        swF.BackgroundTransparency=1; swF.ClipsDescendants=false; swF.Parent=row
        CS(swF,cTbl,cKey,15)
    end

    -- Arrow
    local expanded=false
    local arr=Instance.new("TextButton")
    arr.Size=UDim2.new(0,MOB and 30 or 22,0,MOB and 28 or 20)
    arr.Position=UDim2.new(1,-Z.swW-30,.5,-(MOB and 14 or 10))
    arr.BackgroundColor3=Color3.fromRGB(26,26,36)
    arr.BorderSizePixel=0; arr.Text="›"
    arr.Font=Enum.Font.GothamBold; arr.TextSize=13; arr.TextColor3=COL.txt2
    arr.Parent=row; mkC(arr,4)

    -- Toggle
    local track=Instance.new("Frame")
    track.Size=UDim2.new(0,Z.swW,0,Z.swH); track.Position=UDim2.new(1,-Z.swW-4,.5,-Z.swH/2)
    track.BackgroundColor3=tbl[key] and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36)
    track.BorderSizePixel=0; track.Parent=row; mkC(track,Z.swH)
    local knob=Instance.new("Frame")
    knob.Size=UDim2.new(0,KW,0,KW)
    knob.Position=tbl[key] and UDim2.new(1,-KW-2,.5,-KW/2) or UDim2.new(0,2,.5,-KW/2)
    knob.BackgroundColor3=COL.hw; knob.BorderSizePixel=0; knob.Parent=track; mkC(knob,KW)

    -- Toggle hit area поверх switch
    local togHit=Instance.new("TextButton")
    togHit.Size=UDim2.new(0,Z.swW+10,0,Z.swH+10)
    togHit.Position=UDim2.new(1,-Z.swW-9,.5,-(Z.swH+10)/2)
    togHit.BackgroundTransparency=1; togHit.Text=""; togHit.AutoButtonColor=false
    togHit.ZIndex=6; togHit.Parent=row
    local function PressTog()
        tbl[key]=not tbl[key]; local on=tbl[key]
        TS:Create(knob,TweenInfo.new(.12),{Position=on and UDim2.new(1,-KW-2,.5,-KW/2) or UDim2.new(0,2,.5,-KW/2)}):Play()
        TS:Create(track,TweenInfo.new(.12),{BackgroundColor3=on and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36)}):Play()
        lbl.TextColor3=on and COL.txt or COL.txt2
        pcall(function() Snd("3701374829",.18,on and 1.1 or .9) end)
    end
    OnTap(togHit,PressTog)

    -- SubPanel — ДОЧЕРНИЙ cont, НЕ row
    local subPanel=nil
    if subBuild then
        subPanel=Instance.new("Frame")
        subPanel.Size=UDim2.new(1,0,0,0)
        subPanel.AutomaticSize=Enum.AutomaticSize.Y
        subPanel.BackgroundColor3=Color3.fromRGB(12,12,16)
        subPanel.BorderSizePixel=0; subPanel.Visible=false
        subPanel.ClipsDescendants=false
        subPanel.Parent=cont  -- <<< родитель cont, а не row
        mkC(subPanel,4); mkS(subPanel,Color3.fromRGB(18,18,30),1)
        mkP(subPanel,4,5,16,8); mkL(subPanel,1)
        local vl=Instance.new("Frame")
        vl.Size=UDim2.new(0,2,1,-8); vl.Position=UDim2.new(0,5,0,4)
        vl.BackgroundColor3=Color3.fromRGB(214,40,40); vl.BorderSizePixel=0; vl.Parent=subPanel; mkC(vl,1)
        subBuild(subPanel)
    end

    local function TogExp()
        if not subPanel then return end
        expanded=not expanded; subPanel.Visible=expanded
        arr.Text=expanded and "⌄" or "›"
        TS:Create(arr,TweenInfo.new(.1),{TextColor3=expanded and Color3.fromRGB(214,40,40) or COL.txt2}):Play()
    end
    OnTap(arr,TogExp)
    return cont
end

-- Slider
local function Sld(parent,label,tbl,key,mn,mx,fmt)
    fmt=fmt or "%d"
    local w=Instance.new("Frame"); w.Size=UDim2.new(1,0,0,Z.slH); w.BackgroundTransparency=1; w.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,-44,0,16); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.fS; lb.TextColor3=COL.txt; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=w
    local vbg=Instance.new("Frame"); vbg.Size=UDim2.new(0,40,0,16); vbg.Position=UDim2.new(1,-40,0,0); vbg.BackgroundColor3=Color3.fromRGB(26,26,36); vbg.BorderSizePixel=0; vbg.Parent=w; mkC(vbg,3)
    local vlbl=Instance.new("TextLabel"); vlbl.Size=UDim2.new(1,0,1,0); vlbl.BackgroundTransparency=1; vlbl.Text=string.format(fmt,tbl[key]); vlbl.Font=Enum.Font.GothamBold; vlbl.TextSize=11; vlbl.TextColor3=Color3.fromRGB(214,40,40); vlbl.Parent=vbg
    local track=Instance.new("Frame"); track.Size=UDim2.new(1,0,0,Z.trH); track.Position=UDim2.new(0,0,0,Z.slH-Z.trH-4); track.BackgroundColor3=Color3.fromRGB(26,26,36); track.BorderSizePixel=0; track.Parent=w; mkC(track,Z.trH)
    local p0=(tbl[key]-mn)/(mx-mn)
    local fi=Instance.new("Frame"); fi.Size=UDim2.new(p0,0,1,0); fi.BackgroundColor3=Color3.fromRGB(214,40,40); fi.BorderSizePixel=0; fi.Parent=track; mkC(fi,Z.trH)
    local hd=Instance.new("Frame"); hd.Size=UDim2.new(0,Z.hdSz,0,Z.hdSz); hd.Position=UDim2.new(p0,-Z.hdSz/2,.5,-Z.hdSz/2); hd.BackgroundColor3=COL.hw; hd.BorderSizePixel=0; hd.Parent=track; mkC(hd,Z.hdSz); mkS(hd,Color3.fromRGB(214,40,40),MOB and 2 or 1)
    local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,8,0,MOB and 44 or 28); hit.Position=UDim2.new(0,-4,.5,-(MOB and 22 or 14)); hit.BackgroundTransparency=1; hit.Text=""; hit.AutoButtonColor=false; hit.ZIndex=4; hit.Parent=track
    local dr=false
    local function Upd(x)
        local rel=math.clamp((x-track.AbsolutePosition.X)/track.AbsoluteSize.X,0,1)
        local val=mn+rel*(mx-mn); if fmt=="%d" then val=math.floor(val+.5) end
        tbl[key]=val; fi.Size=UDim2.new(rel,0,1,0); hd.Position=UDim2.new(rel,-Z.hdSz/2,.5,-Z.hdSz/2); vlbl.Text=string.format(fmt,val)
    end
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true; Upd(i.Position.X) end end)
    hd.InputBegan:Connect(function(i)  if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    UIS.InputChanged:Connect(function(i) if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then Upd(i.Position.X) end end)
    return w
end

local function SSld(parent,label,tbl,key,mn,mx,fmt)
    fmt=fmt or "%d"
    local hs=MOB and 13 or 9
    local w=Instance.new("Frame"); w.Size=UDim2.new(1,0,0,32); w.BackgroundTransparency=1; w.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,-34,0,13); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.sfS; lb.TextColor3=COL.txt2; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=w
    local vbg=Instance.new("Frame"); vbg.Size=UDim2.new(0,30,0,13); vbg.Position=UDim2.new(1,-30,0,0); vbg.BackgroundColor3=Color3.fromRGB(26,26,36); vbg.BorderSizePixel=0; vbg.Parent=w; mkC(vbg,3)
    local vlbl=Instance.new("TextLabel"); vlbl.Size=UDim2.new(1,0,1,0); vlbl.BackgroundTransparency=1; vlbl.Text=string.format(fmt,tbl[key]); vlbl.Font=Enum.Font.GothamBold; vlbl.TextSize=10; vlbl.TextColor3=Color3.fromRGB(214,40,40); vlbl.Parent=vbg
    local tr=Instance.new("Frame"); tr.Size=UDim2.new(1,0,0,3); tr.Position=UDim2.new(0,0,0,20); tr.BackgroundColor3=Color3.fromRGB(26,26,36); tr.BorderSizePixel=0; tr.Parent=w; mkC(tr,2)
    local p0=(tbl[key]-mn)/(mx-mn)
    local fi=Instance.new("Frame"); fi.Size=UDim2.new(p0,0,1,0); fi.BackgroundColor3=Color3.fromRGB(214,40,40); fi.BorderSizePixel=0; fi.Parent=tr; mkC(fi,2)
    local hd=Instance.new("Frame"); hd.Size=UDim2.new(0,hs,0,hs); hd.Position=UDim2.new(p0,-hs/2,.5,-hs/2); hd.BackgroundColor3=COL.hw; hd.BorderSizePixel=0; hd.Parent=tr; mkC(hd,hs)
    local hit=Instance.new("TextButton"); hit.Size=UDim2.new(1,8,0,MOB and 36 or 22); hit.Position=UDim2.new(0,-4,.5,-(MOB and 18 or 11)); hit.BackgroundTransparency=1; hit.Text=""; hit.AutoButtonColor=false; hit.ZIndex=4; hit.Parent=tr
    local dr=false
    local function Upd(x)
        local rel=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
        local val=mn+rel*(mx-mn); if fmt=="%d" then val=math.floor(val+.5) end
        tbl[key]=val; fi.Size=UDim2.new(rel,0,1,0); hd.Position=UDim2.new(rel,-hs/2,.5,-hs/2); vlbl.Text=string.format(fmt,val)
    end
    hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true; Upd(i.Position.X) end end)
    hd.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    UIS.InputChanged:Connect(function(i) if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then Upd(i.Position.X) end end)
    return w
end

local function STog(parent,label,tbl,key,cb)
    local row=Instance.new("TextButton"); row.Size=UDim2.new(1,0,0,MOB and 28 or 20); row.BackgroundTransparency=1; row.Text=""; row.AutoButtonColor=false; row.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,-38,1,0); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.sfS; lb.TextColor3=tbl[key] and COL.txt or COL.txt2; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=row
    local tw,th2,kw2=30,14,10
    local track=Instance.new("Frame"); track.Size=UDim2.new(0,tw,0,th2); track.Position=UDim2.new(1,-tw-4,.5,-th2/2); track.BackgroundColor3=tbl[key] and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36); track.BorderSizePixel=0; track.Parent=row; mkC(track,th2)
    local knob=Instance.new("Frame"); knob.Size=UDim2.new(0,kw2,0,kw2); knob.Position=tbl[key] and UDim2.new(1,-kw2-2,.5,-kw2/2) or UDim2.new(0,2,.5,-kw2/2); knob.BackgroundColor3=COL.hw; knob.BorderSizePixel=0; knob.Parent=track; mkC(knob,kw2)
    local function Press()
        tbl[key]=not tbl[key]; local on=tbl[key]
        TS:Create(knob,TweenInfo.new(.1),{Position=on and UDim2.new(1,-kw2-2,.5,-kw2/2) or UDim2.new(0,2,.5,-kw2/2)}):Play()
        TS:Create(track,TweenInfo.new(.1),{BackgroundColor3=on and Color3.fromRGB(214,40,40) or Color3.fromRGB(24,24,36)}):Play()
        lb.TextColor3=on and COL.txt or COL.txt2; if cb then cb(on) end
    end
    OnTap(row,Press); return row
end

local function DD(parent,label,opts,tbl,key,cb)
    local w=Instance.new("Frame"); w.Size=UDim2.new(1,0,0,44); w.BackgroundTransparency=1; w.ClipsDescendants=false; w.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,0,0,14); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.fS; lb.TextColor3=COL.txt; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=w
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,24); btn.Position=UDim2.new(0,0,0,16); btn.BackgroundColor3=Color3.fromRGB(26,26,36); btn.BorderSizePixel=0; btn.Text=tbl[key].."  ▾"; btn.Font=Enum.Font.Gotham; btn.TextSize=MOB and 13 or 11; btn.TextColor3=COL.txt; btn.Parent=w; mkC(btn,4); mkS(btn,Color3.fromRGB(28,28,44),1)
    local list=Instance.new("Frame"); list.Size=UDim2.new(1,0,0,#opts*22); list.Position=UDim2.new(0,0,0,44); list.BackgroundColor3=Color3.fromRGB(26,26,36); list.BorderSizePixel=0; list.Visible=false; list.ZIndex=60; list.ClipsDescendants=false; list.Parent=w; mkC(list,4); mkS(list,Color3.fromRGB(28,28,44),1); mkL(list)
    for _,opt in ipairs(opts) do
        local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,22); ob.BackgroundColor3=Color3.fromRGB(26,26,36); ob.BorderSizePixel=0; ob.Text=opt; ob.Font=Enum.Font.Gotham; ob.TextSize=MOB and 13 or 11; ob.TextColor3=(opt==tbl[key]) and Color3.fromRGB(214,40,40) or COL.txt2; ob.ZIndex=61; ob.Parent=list
        OnTap(ob,function() tbl[key]=opt; btn.Text=opt.."  ▾"; list.Visible=false; for _,c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c.TextColor3=(c.Text==opt) and Color3.fromRGB(214,40,40) or COL.txt2 end end; if cb then cb(opt) end end)
        ob.MouseEnter:Connect(function() ob.BackgroundColor3=Color3.fromRGB(20,20,28) end); ob.MouseLeave:Connect(function() ob.BackgroundColor3=Color3.fromRGB(26,26,36) end)
    end
    OnTap(btn,function() list.Visible=not list.Visible end); return w
end

local function SDD(parent,label,opts,tbl,key,cb)
    local w=Instance.new("Frame"); w.Size=UDim2.new(1,0,0,38); w.BackgroundTransparency=1; w.ClipsDescendants=false; w.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,0,0,13); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.sfS; lb.TextColor3=COL.txt2; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=w
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,20); btn.Position=UDim2.new(0,0,0,14); btn.BackgroundColor3=Color3.fromRGB(26,26,36); btn.BorderSizePixel=0; btn.Text=tbl[key].."  ▾"; btn.Font=Enum.Font.Gotham; btn.TextSize=11; btn.TextColor3=COL.txt; btn.Parent=w; mkC(btn,3); mkS(btn,Color3.fromRGB(26,26,42),1)
    local list=Instance.new("Frame"); list.Size=UDim2.new(1,0,0,#opts*18); list.Position=UDim2.new(0,0,0,38); list.BackgroundColor3=Color3.fromRGB(26,26,36); list.BorderSizePixel=0; list.Visible=false; list.ZIndex=70; list.ClipsDescendants=false; list.Parent=w; mkC(list,3); mkS(list,Color3.fromRGB(26,26,42),1); mkL(list)
    for _,opt in ipairs(opts) do
        local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,18); ob.BackgroundColor3=Color3.fromRGB(26,26,36); ob.BorderSizePixel=0; ob.Text=opt; ob.Font=Enum.Font.Gotham; ob.TextSize=11; ob.TextColor3=(opt==tbl[key]) and Color3.fromRGB(214,40,40) or COL.txt2; ob.ZIndex=71; ob.Parent=list
        OnTap(ob,function() tbl[key]=opt; btn.Text=opt.."  ▾"; list.Visible=false; for _,c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c.TextColor3=(c.Text==opt) and Color3.fromRGB(214,40,40) or COL.txt2 end end; if cb then cb(opt) end end)
        ob.MouseEnter:Connect(function() ob.BackgroundColor3=Color3.fromRGB(20,20,28) end); ob.MouseLeave:Connect(function() ob.BackgroundColor3=Color3.fromRGB(26,26,36) end)
    end
    OnTap(btn,function() list.Visible=not list.Visible end); return w
end

local function KB(parent,label,tbl,key)
    local row=Instance.new("TextButton"); row.Size=UDim2.new(1,0,0,Z.tH); row.BackgroundTransparency=1; row.Text=""; row.AutoButtonColor=false; row.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,-80,1,0); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.fS; lb.TextColor3=COL.txt; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=row
    local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,72,0,18); btn.Position=UDim2.new(1,-74,.5,-9); btn.BackgroundColor3=Color3.fromRGB(26,26,36); btn.BorderSizePixel=0; btn.Text="["..tbl[key].."]"; btn.Font=Enum.Font.GothamBold; btn.TextSize=10; btn.TextColor3=Color3.fromRGB(214,40,40); btn.Parent=row; mkC(btn,3); mkS(btn,Color3.fromRGB(38,38,56),1)
    local waiting=false
    OnTap(btn,function()
        if waiting then return end; waiting=true; btn.Text="[ ... ]"; btn.TextColor3=Color3.fromRGB(255,180,0)
        local con; con=UIS.InputBegan:Connect(function(inp,gpe)
            if gpe then return end; local name
            if inp.UserInputType==Enum.UserInputType.MouseButton1 then name="MB1"
            elseif inp.UserInputType==Enum.UserInputType.MouseButton2 then name="MB2"
            elseif inp.KeyCode~=Enum.KeyCode.Unknown then name=tostring(inp.KeyCode):gsub("Enum%.KeyCode%.","") end
            if name then tbl[key]=name; btn.Text="["..name.."]"; btn.TextColor3=Color3.fromRGB(214,40,40); waiting=false; con:Disconnect() end
        end)
    end); return row
end

local function CR(parent,label,tbl,key,cb)
    local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,Z.tH); row.BackgroundTransparency=1; row.ClipsDescendants=false; row.Parent=parent
    local lb=Instance.new("TextLabel"); lb.Size=UDim2.new(1,-30,1,0); lb.BackgroundTransparency=1; lb.Text=label; lb.Font=Enum.Font.Gotham; lb.TextSize=Z.fS; lb.TextColor3=COL.txt2; lb.TextXAlignment=Enum.TextXAlignment.Left; lb.Parent=row
    local sf=Instance.new("Frame"); sf.Size=UDim2.new(0,22,0,14); sf.Position=UDim2.new(1,-24,.5,-7); sf.BackgroundTransparency=1; sf.ClipsDescendants=false; sf.Parent=row; CS(sf,tbl,key,20,cb); return row
end

print("[natality p3] GUI loaded")
-- ══════════════════════════════
-- ЧАСТЬ 4: PAGES + GAME LOGIC
-- ══════════════════════════════

-- ── Создаём вкладки и страницы ──
local tabs={}; for i,n in ipairs(TABS) do tabs[i]=MkTab(n,i) end
local pgVis,VL,VR=MkPage()
local pgLeg,LL,LR=MkPage()
local pgRag,RL,RR=MkPage()
local pgPl, PL,PR=MkPage()
local pgCfg,CL,CR_=MkPage()
local PAGES={pgVis,pgLeg,pgRag,pgPl,pgCfg}

-- ─── VISUALS ──────────────────
local gESP=MkGrp(VL,"esp")
Tog(gESP,"Enable ESP",    Cfg.ESP,"On")
Tog(gESP,"Team Check",    Cfg.ESP,"TeamCheck")
Sld(gESP,"Max Distance",  Cfg.ESP,"MaxDist",50,1000,"%d")
Exp(gESP,"Box",      Cfg.ESP.Box,"On",   Cfg.ESP.Box,"Col",   function(s) SDD(s,"Type",{"Corner","Full"},Cfg.ESP.Box,"Type"); SSld(s,"Thickness",Cfg.ESP.Box,"W",1,4,"%d"); CR(s,"Team Color",Cfg.ESP.Box,"ColT") end)
Exp(gESP,"Chams",    Cfg.ESP.Chams,"On", Cfg.ESP.Chams,"Col", function(s) SSld(s,"Glow Alpha",Cfg.ESP.Chams,"GlowA",0,.8,"%.2f"); SSld(s,"Outline Alpha",Cfg.ESP.Chams,"OutA",0,1,"%.2f") end)
Exp(gESP,"Names",    Cfg.ESP.Names,"On", Cfg.ESP.Names,"Col", function(s) SSld(s,"Size",Cfg.ESP.Names,"Sz",10,18,"%d") end)
Exp(gESP,"Distance", Cfg.ESP.Dist,"On",  Cfg.ESP.Dist,"Col",  function(s) end)
Exp(gESP,"Health",   Cfg.ESP.HP,"Bar",   nil,nil,             function(s) STog(s,"HP Bar",Cfg.ESP.HP,"Bar"); STog(s,"HP Text",Cfg.ESP.HP,"Text") end)
Exp(gESP,"Skeleton", Cfg.ESP.Skel,"On",  Cfg.ESP.Skel,"Col",  function(s) SSld(s,"Thickness",Cfg.ESP.Skel,"W",1,3,"%d") end)
Exp(gESP,"Tracers",  Cfg.ESP.Trc,"On",   Cfg.ESP.Trc,"Col",   function(s) SDD(s,"Origin",{"Bottom","Center","Top"},Cfg.ESP.Trc,"Origin"); SSld(s,"Thickness",Cfg.ESP.Trc,"W",1,3,"%d") end)
Exp(gESP,"Head Dot", Cfg.ESP.HDot,"On",  Cfg.ESP.HDot,"Col",  function(s) SSld(s,"Radius",Cfg.ESP.HDot,"R",2,10,"%d") end)
Exp(gESP,"Snap Line",Cfg.ESP.Snap,"On",  Cfg.ESP.Snap,"Col",  function(s) end)
Exp(gESP,"Off-Screen",Cfg.ESP.Arrow,"On",Cfg.ESP.Arrow,"Col", function(s) end)

local gWorld=MkGrp(VR,"world")
Tog(gWorld,"No Fog",    Cfg.Vis,"NoFog")
Tog(gWorld,"Full Bright",Cfg.Vis,"FullBright")
Exp(gWorld,"Day Time",   Cfg.Vis,"DayTime",    nil,nil,           function(s) SSld(s,"Hour",Cfg.Vis,"DayHour",0,24,"%d") end)
Exp(gWorld,"Custom Fog", Cfg.Vis,"CustomFog",  Cfg.Vis,"FogCol",  function(s) SSld(s,"Distance",Cfg.Vis,"FogDist",50,2000,"%d") end)
Exp(gWorld,"Ambient",    Cfg.Vis,"Ambient",     Cfg.Vis,"AmbCol",  function(s) end)
Exp(gWorld,"Light Boost",Cfg.Vis,"LightBoost",  nil,nil,           function(s) SSld(s,"Intensity",Cfg.Vis,"LightInt",.5,6,"%.1f"); SSld(s,"Size",Cfg.Vis,"LightSz",8,56,"%d") end)

local gCam=MkGrp(VR,"camera")
Tog(gCam,"Third Person", Cfg.Vis,"ThirdPerson")
Sld(gCam,"Camera Dist",  Cfg.Vis,"ThirdDist",4,30,"%d")
Exp(gCam,"Custom FOV",   Cfg.Vis,"CustomFOV",  nil,nil,  function(s) SSld(s,"FOV",Cfg.Vis,"FOVVal",50,120,"%d") end)
Exp(gCam,"Hands FOV",    Cfg.Vis,"HandsFOV",   nil,nil,  function(s) SSld(s,"FOV",Cfg.Vis,"HandsFOVVal",60,120,"%d") end)
Tog(gCam,"Stretch Res",  Cfg.Vis,"StretchRes")
Tog(gCam,"Wide Screen",  Cfg.Vis,"WideScreen")

local gHUD=MkGrp(VR,"hud")
Exp(gHUD,"Crosshair",      Cfg.Vis,"Crosshair",  Cfg.Vis,"CHCol",     function(s) SSld(s,"Size",Cfg.Vis,"CHSz",2,24,"%d"); SSld(s,"Thickness",Cfg.Vis,"CHW",1,4,"%d"); STog(s,"Center Dot",Cfg.Vis,"CHDot"); SDD(s,"Style",{"Classic","T-Shape","Dot"},Cfg.Vis,"CHStyle") end)
Tog(gHUD,"Spectator List", Cfg.Vis,"SpecList")
Exp(gHUD,"Self Outline",   Cfg.Vis,"SelfHL",     Cfg.Vis,"SelfHLCol", function(s) end)
Tog(gHUD,"FOV Dot",        Cfg.Vis,"FOVDot")
Tog(gHUD,"Hit Effect",     Cfg.Vis,"HitEffect")
Exp(gHUD,"Low HP Alert",   Cfg.Vis,"LowHP",      nil,nil,             function(s) SSld(s,"Threshold",Cfg.Vis,"LowHPThr",5,80,"%d") end)
Exp(gHUD,"Radar",          Cfg.Vis,"Radar",       nil,nil,             function(s) SSld(s,"Size",Cfg.Vis,"RadarSz",80,220,"%d") end)
Exp(gHUD,"Hit Marker",     Cfg.Vis,"HitMarker",  Cfg.Vis,"HMCol",     function(s) STog(s,"Hit Sound",Cfg.Vis,"HitSound"); STog(s,"Kill Sound",Cfg.Vis,"KillSound") end)
Tog(gHUD,"Heal Sound",     Cfg.Vis,"HealSound")
Exp(gHUD,"Gradient",       Cfg.Vis,"Gradient",   Cfg.Vis,"GradTop",   function(s) CR(s,"Bottom Color",Cfg.Vis,"GradBot") end)
Exp(gHUD,"Flick Lines",    Cfg.Vis,"FlickLines",  Cfg.Vis,"FlickCol",  function(s) end)

local gWMGrp=MkGrp(VR,"watermark")
Tog(gWMGrp,"Enable",       Cfg.Vis,"WM")
DD(gWMGrp,"Position",      {"TR","TL"},Cfg.Vis,"WMPos")
Tog(gWMGrp,"Show FPS",     Cfg.Vis,"WMShowFPS")
Tog(gWMGrp,"Show Username",Cfg.Vis,"WMShowUser")
CR(gWMGrp,"Accent",        Cfg.Vis,"WMAccent")
CR(gWMGrp,"Text",          Cfg.Vis,"WMText")
CR(gWMGrp,"Background",    Cfg.Vis,"WMBg")

-- ─── LEGIT ────────────────────
local gLeg=MkGrp(LL,"legit aimbot")
Tog(gLeg,"Enable",        Cfg.Legit,"On")
Tog(gLeg,"Wall Check",    Cfg.Legit,"Wall")
Tog(gLeg,"Show FOV",      Cfg.Legit,"ShowFOV")
Tog(gLeg,"Predict Motion",Cfg.Legit,"Predict")
KB(gLeg,"Key",            Cfg.Legit,"Key")

local gLS=MkGrp(LR,"settings")
Sld(gLS,"FOV",        Cfg.Legit,"FOV",10,200,"%d")
Sld(gLS,"Smoothing",  Cfg.Legit,"Smooth",1,20,"%.1f")
DD(gLS,"Bone",        {"Head","UpperTorso","LowerTorso"},Cfg.Legit,"Bone")
CR(gLS,"FOV Color",   Cfg.Legit,"FOVCol",function(col) fovL.Color=col end)
local gRCS=MkGrp(LR,"rcs")
Exp(gRCS,"RCS",Cfg.Legit,"RCS",nil,nil,function(s)
    SSld(s,"Vertical",  Cfg.Legit,"RCSVert",.1,2,"%.2f")
    SSld(s,"Horizontal",Cfg.Legit,"RCSHoriz",0,1,"%.2f")
end)

-- ─── RAGE ─────────────────────
local gRag=MkGrp(RL,"rage aimbot")
Tog(gRag,"Enable",        Cfg.Rage,"On")
Tog(gRag,"Wall Check",    Cfg.Rage,"Wall")
Tog(gRag,"Show FOV",      Cfg.Rage,"ShowFOV")
Tog(gRag,"Predict Motion",Cfg.Rage,"Predict")
Tog(gRag,"Auto Shoot",    Cfg.Rage,"AutoShoot")
Tog(gRag,"Mini-Bot",      Cfg.Rage,"MiniBot")
KB(gRag,"Key",            Cfg.Rage,"Key")
Exp(gRag,"Silent Aim",    Cfg.Rage,"Silent",nil,nil,function(s)
    local il=Instance.new("TextLabel"); il.Size=UDim2.new(1,0,0,26); il.BackgroundTransparency=1
    il.Text="Поворачивает камеру на цель, стреляет, возвращает"
    il.Font=Enum.Font.Gotham; il.TextSize=10; il.TextColor3=Color3.fromRGB(70,70,90)
    il.TextWrapped=true; il.TextXAlignment=Enum.TextXAlignment.Left; il.Parent=s
    STog(s,"Auto Fire",   Cfg.Rage,"SilentAutoFire")
    SDD(s,"Fire Key",     {"MB1","MB2","Q","E","F"},Cfg.Rage,"SilentKey")
    SSld(s,"Delay (ms)",  Cfg.Rage,"SilentDelay",0,300,"%d")
end)

local gRS=MkGrp(RR,"settings")
Sld(gRS,"FOV",          Cfg.Rage,"FOV",10,400,"%d")
Sld(gRS,"Smoothing",    Cfg.Rage,"Smooth",1,10,"%.1f")
SSld(gRS,"AutoShoot px",Cfg.Rage,"AutoThresh",2,30,"%d")
DD(gRS,"Bone",          {"Head","UpperTorso","LowerTorso"},Cfg.Rage,"Bone")
DD(gRS,"Priority",      {"FOV","HP","Dist"},Cfg.Rage,"Priority")
CR(gRS,"FOV Color",     Cfg.Rage,"FOVCol",function(col) fovR.Color=col end)

local gAA=MkGrp(RL,"anti-aim")
Exp(gAA,"Anti-Aim",Cfg.Rage,"AA",nil,nil,function(s)
    SDD(s,"Type",{"Spin","Jitter","LookDown","Sideways","Desync","FakePitch","Random","BackLook"},Cfg.Rage,"AAType")
    SSld(s,"Spin Speed",Cfg.Rage,"SpinSpd",1,40,"%d")
end)
Tog(gAA,"Resolver",  Cfg.Rage,"Resolver")
Exp(gAA,"Fake-Lag",  Cfg.Rage,"FakeLag",nil,nil,function(s) SSld(s,"Frames",Cfg.Rage,"FakeLagN",1,6,"%d") end)
Tog(gAA,"Double-Tap",Cfg.Rage,"DT")

local gTrig=MkGrp(RL,"triggerbot")
Tog(gTrig,"Enable",   Cfg.Trig,"On")
Tog(gTrig,"Auto Fire",Cfg.Trig,"Auto")
KB(gTrig,"Key",       Cfg.Trig,"Key")
local gTS=MkGrp(RR,"triggerbot settings")
Sld(gTS,"Delay (ms)", Cfg.Trig,"Delay",0,500,"%d")
Sld(gTS,"Range",      Cfg.Trig,"Range",100,5000,"%d")

-- ─── PLAYERS ──────────────────
local gMov=MkGrp(PL,"movement")
Tog(gMov,"Speed Hack",    Cfg.Player,"Speed")
Tog(gMov,"Infinite Jump", Cfg.Player,"InfJump")
Tog(gMov,"B-Hop",         Cfg.Player,"Bhop")
local gMS=MkGrp(PR,"settings")
Sld(gMS,"Walk Speed", Cfg.Player,"SpeedVal",16,150,"%d")
Sld(gMS,"Jump Power", Cfg.Player,"JumpPow",20,200,"%d")
local gCbt=MkGrp(PL,"combat")
Tog(gCbt,"God Mode",  Cfg.Player,"God")
Tog(gCbt,"Anti-AFK",  Cfg.Player,"AntiAFK")

-- ─── CONFIG ───────────────────
local gCfgG=MkGrp(CL,"menu")
-- Menu key keybind
local mkRow=Instance.new("TextButton"); mkRow.Size=UDim2.new(1,0,0,Z.tH); mkRow.BackgroundTransparency=1; mkRow.Text=""; mkRow.AutoButtonColor=false; mkRow.Parent=gCfgG
local mkLb=Instance.new("TextLabel"); mkLb.Size=UDim2.new(1,-80,1,0); mkLb.BackgroundTransparency=1; mkLb.Text="Open Menu Key"; mkLb.Font=Enum.Font.Gotham; mkLb.TextSize=Z.fS; mkLb.TextColor3=COL.txt; mkLb.TextXAlignment=Enum.TextXAlignment.Left; mkLb.Parent=mkRow
local mkBtn=Instance.new("TextButton"); mkBtn.Size=UDim2.new(0,72,0,18); mkBtn.Position=UDim2.new(1,-74,.5,-9); mkBtn.BackgroundColor3=Color3.fromRGB(26,26,36); mkBtn.BorderSizePixel=0; mkBtn.Text="["..Cfg.MenuKey.."]"; mkBtn.Font=Enum.Font.GothamBold; mkBtn.TextSize=10; mkBtn.TextColor3=Color3.fromRGB(214,40,40); mkBtn.Parent=mkRow; mkC(mkBtn,3); mkS(mkBtn,Color3.fromRGB(38,38,56),1)
local mkWait=false
OnTap(mkBtn,function()
    if mkWait then return end; mkWait=true; mkBtn.Text="[ ... ]"; mkBtn.TextColor3=Color3.fromRGB(255,180,0)
    local con; con=UIS.InputBegan:Connect(function(inp,gpe)
        if gpe then return end; local name
        if inp.KeyCode~=Enum.KeyCode.Unknown then name=tostring(inp.KeyCode):gsub("Enum%.KeyCode%.","") end
        if name then Cfg.MenuKey=name; mkBtn.Text="["..name.."]"; mkBtn.TextColor3=Color3.fromRGB(214,40,40); mkWait=false; con:Disconnect() end
    end)
end)

local gTheme=MkGrp(CL,"theme")
-- Theme dropdown
DD(gTheme,"Theme",{"Red","Blue","Green","Purple","Orange","Custom"},Cfg,"Theme",function(t)
    -- Обновляем акцентный цвет везде
    local th=T()
    TLine.BackgroundColor3=th.acc
    for _,b in ipairs(tabs) do TabUL[b].BackgroundColor3=th.acc end
end)
CR(gTheme,"Custom Accent",Cfg,"CustomAcc")
CR(gTheme,"Custom BG",    Cfg,"CustomBg0")

local gInfo=MkGrp(CR_,"info")
local il=Instance.new("TextLabel"); il.Size=UDim2.new(1,0,0,90); il.BackgroundTransparency=1
il.Text="natality × roblox  v1\n\n"..Cfg.MenuKey.."  —  open menu\n›  —  expand options\nSilent Aim: cam teleport\nChams: outline + glow"
il.Font=Enum.Font.Gotham; il.TextSize=12; il.TextColor3=COL.txt2; il.TextWrapped=true; il.TextXAlignment=Enum.TextXAlignment.Left; il.Parent=gInfo

-- ══════════════════════════════
-- TAB SELECT
-- ══════════════════════════════
local function SelTab(idx)
    for i,b in ipairs(tabs) do
        local a=(i==idx)
        b.BackgroundColor3=a and Color3.fromRGB(20,20,28) or Color3.fromRGB(14,14,19)
        b.TextColor3=a and Color3.fromRGB(214,40,40) or COL.txt2
        b.Font=a and Enum.Font.GothamBold or Enum.Font.Gotham
        TabUL[b].Visible=a
        PAGES[i].Visible=a
    end
end
for i,b in ipairs(tabs) do
    local ii=i
    OnTap(b,function() SelTab(ii) end)
    b.MouseEnter:Connect(function() if not PAGES[i].Visible then b.TextColor3=COL.txt end end)
    b.MouseLeave:Connect(function() if not PAGES[i].Visible then b.TextColor3=COL.txt2 end end)
end
SelTab(1)

-- ══════════════════════════════
-- DRAG
-- ══════════════════════════════
do
    local dr,ds,sp=false,nil,nil
    Hdr.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            dr=true; ds=i.Position; sp=Main.Position
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) and ds then
            local d=i.Position-ds
            Main.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
end

-- Мобильная кнопка
if MOB then
    local MB=Instance.new("TextButton")
    MB.Size=UDim2.new(0,52,0,52); MB.Position=UDim2.new(0,10,.5,-26)
    MB.BackgroundColor3=Color3.fromRGB(214,40,40); MB.BorderSizePixel=0
    MB.Text="N"; MB.Font=Enum.Font.GothamBold; MB.TextSize=22
    MB.TextColor3=Color3.new(1,1,1); MB.ZIndex=10; MB.Parent=GUI
    mkC(MB,26); mkS(MB,Color3.fromRGB(255,80,80),2)
    OnTap(MB,function()
        Main.Visible=not Main.Visible; Blocker.Visible=Main.Visible
        if Main.Visible then
            Main.Size=UDim2.new(0,MW,0,0)
            TS:Create(Main,TweenInfo.new(.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,MW,0,MH)}):Play()
        end
    end)
    -- Drag кнопки
    local mbd,mbds,mbp=false,nil,nil
    MB.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then mbd=true; mbds=i.Position; mbp=MB.Position end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then mbd=false end end)
    UIS.InputChanged:Connect(function(i) if mbd and i.UserInputType==Enum.UserInputType.Touch and mbds then local d=i.Position-mbds; MB.Position=UDim2.new(mbp.X.Scale,mbp.X.Offset+d.X,mbp.Y.Scale,mbp.Y.Offset+d.Y) end end)
    -- Мобильный aim joystick
    local AJ=Instance.new("Frame")
    AJ.Size=UDim2.new(0,110,0,110); AJ.Position=UDim2.new(1,-126,1,-126)
    AJ.BackgroundColor3=Color3.fromRGB(214,40,40); AJ.BackgroundTransparency=.76
    AJ.BorderSizePixel=0; AJ.ZIndex=10; AJ.Parent=GUI; mkC(AJ,55); mkS(AJ,Color3.fromRGB(214,40,40),2)
    local AJK=Instance.new("Frame"); AJK.Size=UDim2.new(0,36,0,36); AJK.AnchorPoint=Vector2.new(.5,.5); AJK.Position=UDim2.new(.5,0,.5,0); AJK.BackgroundColor3=Color3.fromRGB(214,40,40); AJK.BackgroundTransparency=.28; AJK.BorderSizePixel=0; AJK.ZIndex=11; AJK.Parent=AJ; mkC(AJK,18)
    local AJL=Instance.new("TextLabel"); AJL.Size=UDim2.new(1,0,1,0); AJL.BackgroundTransparency=1; AJL.Text="AIM"; AJL.Font=Enum.Font.GothamBold; AJL.TextSize=11; AJL.TextColor3=Color3.new(1,1,1); AJL.TextTransparency=.3; AJL.ZIndex=12; AJL.Parent=AJ
    local ajOn,ajDelta,ajStart=false,Vector2.new(0,0),nil
    AJ.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then ajOn=true; ajStart=i.Position end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then ajOn=false; ajDelta=Vector2.new(0,0); TS:Create(AJK,TweenInfo.new(.1),{Position=UDim2.new(.5,0,.5,0)}):Play() end end)
    UIS.InputChanged:Connect(function(i)
        if ajOn and i.UserInputType==Enum.UserInputType.Touch and ajStart then
            local d=i.Position-ajStart; local mr=40; local cl=d.Magnitude>mr and d.Unit*mr or d
            AJK.Position=UDim2.new(.5,cl.X,.5,cl.Y); ajDelta=d/mr
        end
    end)
    RS.RenderStepped:Connect(function()
        if ajOn and ajDelta.Magnitude>.04 and (Cfg.Legit.On or Cfg.Rage.On) then
            pcall(function() mousemoverel(ajDelta.X*5,ajDelta.Y*5) end)
        end
    end)
end

-- ══════════════════════════════
-- POST FX
-- ══════════════════════════════
local function GetFX(cls) return Light:FindFirstChildOfClass(cls) or Instance.new(cls,Light) end
local bloomFX=GetFX("BloomEffect");   bloomFX.Enabled=false
local colorFX=GetFX("ColorCorrectionEffect"); colorFX.Enabled=false

-- ══════════════════════════════
-- AIMBOT
-- ══════════════════════════════
local function GetTarget(ac,ignWall)
    local vp=Cam.ViewportSize; local cx,cy=vp.X/2,vp.Y/2
    local best,bestSc=nil,nil
    for _,p in ipairs(Plrs:GetPlayers()) do
        if p==LP or not p.Parent then continue end
        local ch=p.Character; local hm=ch and ch:FindFirstChildOfClass("Humanoid")
        if not hm or hm.Health<=0 then continue end
        if Cfg.ESP.TeamCheck and p.Team~=nil and p.Team==LP.Team then continue end
        local bone=ch:FindFirstChild(ac.Bone) or ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
        if not bone then continue end
        if ac.Wall and not ignWall and HasWall(bone.Position) then continue end
        local wpos=bone.Position
        if ac.Predict then
            local root=ch:FindFirstChild("HumanoidRootPart")
            if root then wpos=wpos+root.Velocity*.065 end
        end
        local sp2,on=W2S(wpos)
        if not on and not ignWall then continue end
        local fovD=on and math.sqrt((sp2.X-cx)^2+(sp2.Y-cy)^2) or ac.FOV+1
        if fovD>ac.FOV and not ignWall then continue end
        local sc
        if ac.Priority=="HP" then sc=hm.Health
        elseif ac.Priority=="Dist" then sc=(Cam.CFrame.Position-bone.Position).Magnitude
        else sc=fovD end
        if not best or sc<bestSc then bestSc=sc; best={pos=wpos,sp=on and sp2 or Vector2.new(cx,cy)} end
    end
    return best
end

local function GetOnCH()
    local vp=Cam.ViewportSize
    local ray=Cam:ScreenPointToRay(vp.X/2,vp.Y/2)
    local p=RaycastParams.new()
    p.FilterDescendantsInstances={LP.Character or workspace}
    p.FilterType=Enum.RaycastFilterType.Exclude
    local res=workspace:Raycast(ray.Origin,ray.Direction*Cfg.Trig.Range,p)
    if not res then return nil end
    local hit=res.Instance; local char=hit and hit:FindFirstAncestorOfClass("Model")
    if not char then return nil end
    local hm=char:FindFirstChildOfClass("Humanoid")
    if not hm or hm.Health<=0 then return nil end
    local pl=Plrs:GetPlayerFromCharacter(char)
    if not pl or pl==LP then return nil end
    if Cfg.ESP.TeamCheck and pl.Team~=nil and pl.Team==LP.Team then return nil end
    return pl
end

-- Inf Jump
local function ConnIJ(ch)
    local hm=ch:WaitForChild("Humanoid")
    hm:GetPropertyChangedSignal("Jump"):Connect(function()
        if Cfg.Player.InfJump and hm.Jump then hm:ChangeState(Enum.HumanoidStateType.Jumping) end
    end)
end
if LP.Character then task.spawn(ConnIJ,LP.Character) end
LP.CharacterAdded:Connect(ConnIJ)

-- Self Outline (SelectionBox — обводит части тела, НЕ кубы)
local selfBoxes={}
local function UpdateSelfHL()
    local ch=LP.Character
    if Cfg.Vis.SelfHL and ch then
        for _,p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") and p.Name~="HumanoidRootPart" then
                if not selfBoxes[p] then
                    local sb=Instance.new("SelectionBox")
                    sb.Color3=Cfg.Vis.SelfHLCol; sb.LineThickness=0.04
                    sb.Adornee=p; sb.Parent=ch
                    selfBoxes[p]=sb
                else
                    selfBoxes[p].Color3=Cfg.Vis.SelfHLCol
                end
            end
        end
    else
        for p,sb in pairs(selfBoxes) do sb:Destroy(); selfBoxes[p]=nil end
    end
end

-- ══════════════════════════════
-- MAIN LOOP
-- ══════════════════════════════
local fpsC,fpsT,fpsCur=0,0,0
local trigFired=false; local trigTime=0
local silentPending=false; local silentT=0
local flFrame=0; local aaAngle=0
local prevHP=100

RS.RenderStepped:Connect(function(dt)
    TickESP(); DrawSpec(); DrawRadar()
    local vp=Cam.ViewportSize; local cx,cy=vp.X/2,vp.Y/2; local now=tick()

    -- FPS
    fpsC=fpsC+1; fpsT=fpsT+dt
    if fpsT>=1 then fpsCur=fpsC; fpsC=0; fpsT=0 end
    DrawWM(fpsCur)

    -- FOV circles
    fovL.Visible=Cfg.Legit.On and Cfg.Legit.ShowFOV
    if fovL.Visible then fovL.Color=Cfg.Legit.FOVCol; fovL.Position=Vector2.new(cx,cy); fovL.Radius=Cfg.Legit.FOV end
    fovR.Visible=Cfg.Rage.On and Cfg.Rage.ShowFOV
    if fovR.Visible then fovR.Color=Cfg.Rage.FOVCol; fovR.Position=Vector2.new(cx,cy); fovR.Radius=Cfg.Rage.FOV end
    fovDot.Visible=Cfg.Vis.FOVDot and (fovL.Visible or fovR.Visible)
    if fovDot.Visible then fovDot.Position=Vector2.new(cx,cy) end

    -- Crosshair
    local CHon=Cfg.Vis.Crosshair; local st=Cfg.Vis.CHStyle
    local sz=Cfg.Vis.CHSz; local col2=Cfg.Vis.CHCol; local cw=Cfg.Vis.CHW
    chDot.Visible=CHon and (Cfg.Vis.CHDot or st=="Dot")
    if chDot.Visible then chDot.Position=Vector2.new(cx,cy); chDot.Color=col2 end
    if st=="Dot" then chH.Visible=false; chV.Visible=false
    elseif st=="T-Shape" then
        chH.Visible=CHon; chV.Visible=CHon
        if CHon then chH.From=Vector2.new(cx-sz,cy); chH.To=Vector2.new(cx+sz,cy); chH.Color=col2; chH.Thickness=cw; chV.From=Vector2.new(cx,cy); chV.To=Vector2.new(cx,cy-sz); chV.Color=col2; chV.Thickness=cw end
    else
        chH.Visible=CHon; chV.Visible=CHon
        if CHon then chH.From=Vector2.new(cx-sz,cy); chH.To=Vector2.new(cx+sz,cy); chH.Color=col2; chH.Thickness=cw; chV.From=Vector2.new(cx,cy-sz); chV.To=Vector2.new(cx,cy+sz); chV.Color=col2; chV.Thickness=cw end
    end

    -- Hit flash
    if hitA>0 then
        hitA=math.max(0,hitA-dt*2.5); hitRect.Transparency=1-hitA
        hitRect.Position=Vector2.new(0,0); hitRect.Size=Vector2.new(vp.X,vp.Y); hitRect.Visible=true
    else hitRect.Visible=false end

    -- HitMarker (Drawing)
    for i=1,4 do HM[i].Visible=false end
    if Cfg.Vis.HitMarker and hmOn then
        local e=now-hmT; local sz2=10
        if e<.25 then
            local dirs={{1,1},{-1,1},{1,-1},{-1,-1}}
            for i=1,4 do
                HM[i].From=Vector2.new(cx+dirs[i][1]*sz2,    cy+dirs[i][2]*sz2)
                HM[i].To  =Vector2.new(cx+dirs[i][1]*(sz2+5),cy+dirs[i][2]*(sz2+5))
                HM[i].Color=Cfg.Vis.HMCol; HM[i].Thickness=MOB and 2 or 1.5
                HM[i].Visible=true
            end
        else hmOn=false end
    end

    -- Low HP
    local myChar=LP.Character; local myHM=myChar and myChar:FindFirstChildOfClass("Humanoid")
    lowTxt.Visible=false
    if Cfg.Vis.LowHP and myHM and myHM.Health<=Cfg.Vis.LowHPThr then
        lowTxt.Visible=true; lowTxt.Text="! LOW HP ["..math.floor(myHM.Health).."] !"
        lowTxt.Position=Vector2.new(cx,cy-80)
    end

    -- Flick lines
    table.remove(flH,1); table.insert(flH,Vector2.new(cx,cy))
    for i=1,6 do flL[i].Visible=false end
    if Cfg.Vis.FlickLines then
        for i=1,6 do
            flL[i].From=flH[i]; flL[i].To=flH[i+1]
            flL[i].Color=Cfg.Vis.FlickCol; flL[i].Visible=true
        end
    end

    -- Wide screen
    local bh=math.floor(vp.Y*.09)
    wsT.Visible=Cfg.Vis.WideScreen; wsB.Visible=Cfg.Vis.WideScreen
    if Cfg.Vis.WideScreen then
        wsT.Position=Vector2.new(0,0); wsT.Size=Vector2.new(vp.X,bh)
        wsB.Position=Vector2.new(0,vp.Y-bh); wsB.Size=Vector2.new(vp.X,bh)
    end

    -- Gradient overlay
    gradT.Visible=Cfg.Vis.Gradient; gradB.Visible=Cfg.Vis.Gradient
    if Cfg.Vis.Gradient then
        gradT.Position=Vector2.new(0,0); gradT.Size=Vector2.new(vp.X,math.floor(vp.Y*.25)); gradT.Color=Cfg.Vis.GradTop
        gradB.Position=Vector2.new(0,math.floor(vp.Y*.75)); gradB.Size=Vector2.new(vp.X,math.floor(vp.Y*.25)); gradB.Color=Cfg.Vis.GradBot
    end

    -- LEGIT aimbot
    if Cfg.Legit.On and IsKey(Cfg.Legit.Key) then
        local t=GetTarget(Cfg.Legit)
        if t then
            local sm=math.max(Cfg.Legit.Smooth,.1)
            pcall(function() mousemoverel((t.sp.X-cx)/sm,(t.sp.Y-cy)/sm) end)
        end
    end
    -- RCS
    if Cfg.Legit.On and Cfg.Legit.RCS and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
        pcall(function() mousemoverel(dt*60*Cfg.Legit.RCSHoriz,dt*60*Cfg.Legit.RCSVert) end)
    end

    -- ══════════════════════════════
    -- RAGE + SILENT AIM
    -- Silent: сохраняем CFrame камеры, ставим Scriptable,
    -- направляем камеру на кость цели (даже за стеной),
    -- стреляем, немедленно возвращаем CFrame
    -- ══════════════════════════════
    if Cfg.Rage.On then
        if Cfg.Rage.Silent then
            local canFire=Cfg.Rage.SilentAutoFire or IsKey(Cfg.Rage.SilentKey)
            if canFire then
                local t=GetTarget(Cfg.Rage,true)  -- ignWall=true
                if t then
                    local savedCF=Cam.CFrame
                    local savedType=Cam.CameraType
                    -- Поворачиваем камеру на цель
                    Cam.CameraType=Enum.CameraType.Scriptable
                    Cam.CFrame=CFrame.new(savedCF.Position,t.pos)
                    -- Задержка
                    if not silentPending then silentT=now+Cfg.Rage.SilentDelay*.001; silentPending=true end
                    if now>=silentT then
                        pcall(function() mouse1click() end)
                        if Cfg.Rage.DT then task.defer(function() pcall(function() mouse1click() end) end) end
                        silentPending=false
                    end
                    -- Немедленно возвращаем
                    Cam.CFrame=savedCF
                    Cam.CameraType=savedType
                end
            else
                silentPending=false
                if Cam.CameraType==Enum.CameraType.Scriptable and not Cfg.Vis.ThirdPerson then
                    Cam.CameraType=Enum.CameraType.Custom
                end
            end
        elseif IsKey(Cfg.Rage.Key) or Cfg.Rage.AutoShoot or Cfg.Rage.MiniBot then
            silentPending=false
            local t=GetTarget(Cfg.Rage)
            if t then
                local sm=math.max(Cfg.Rage.Smooth,.1)
                pcall(function() mousemoverel((t.sp.X-cx)/sm,(t.sp.Y-cy)/sm) end)
                if Cfg.Rage.AutoShoot or Cfg.Rage.MiniBot then
                    local dx,dy=t.sp.X-cx,t.sp.Y-cy
                    if dx*dx+dy*dy<Cfg.Rage.AutoThresh^2 then
                        pcall(function() mouse1click() end)
                        if Cfg.Rage.DT then task.defer(function() pcall(function() mouse1click() end) end) end
                    end
                end
            end
        else
            silentPending=false
        end
    end

    -- Anti-Aim
    if Cfg.Rage.AA then
        local ch2=LP.Character; local root2=ch2 and ch2:FindFirstChild("HumanoidRootPart")
        if root2 then
            local tp=Cfg.Rage.AAType; local t2=tick()
            if tp=="Spin" then aaAngle=(aaAngle+Cfg.Rage.SpinSpd)%360; root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(0,math.rad(aaAngle),0)
            elseif tp=="Jitter" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(0,math.rad(t2*30%2>1 and 180 or 0),0)
            elseif tp=="LookDown" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(math.rad(89),0,0)
            elseif tp=="Sideways" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(0,math.rad(90),0)
            elseif tp=="Desync" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(0,math.rad(t2*40%2>1 and 0 or 180),0)
            elseif tp=="FakePitch" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(math.rad(-89),0,0)
            elseif tp=="Random" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(math.rad(math.random(-89,89)),math.rad(math.random(0,360)),0)
            elseif tp=="BackLook" then root2.CFrame=CFrame.new(root2.Position)*CFrame.Angles(0,math.rad(180),0) end
        end
    end

    -- Fake-lag
    if Cfg.Rage.FakeLag then
        flFrame=(flFrame+1)%Cfg.Rage.FakeLagN
        if flFrame~=0 then
            local ch3=LP.Character; local r3=ch3 and ch3:FindFirstChild("HumanoidRootPart")
            if r3 then r3.Anchored=true; task.defer(function() if r3 then r3.Anchored=false end end) end
        end
    end

    -- Triggerbot
    if Cfg.Trig.On then
        local act=Cfg.Trig.Auto or IsKey(Cfg.Trig.Key)
        if act then
            if GetOnCH() then
                if not trigFired then trigTime=now+Cfg.Trig.Delay*.001; trigFired=true end
                if now>=trigTime then pcall(function() mouse1click() end) end
            else trigFired=false end
        else trigFired=false end
    end

    -- World
    if Cfg.Vis.NoFog then Light.FogEnd=9e5; Light.FogStart=9e5-1 end
    if Cfg.Vis.FullBright then Light.Brightness=2.5; Light.ClockTime=14; Light.Ambient=Color3.new(1,1,1); Light.OutdoorAmbient=Color3.new(1,1,1) end
    if Cfg.Vis.DayTime then Light.ClockTime=Cfg.Vis.DayHour end
    if Cfg.Vis.Ambient then Light.Ambient=Cfg.Vis.AmbCol; Light.OutdoorAmbient=Cfg.Vis.AmbCol end
    if Cfg.Vis.CustomFog then Light.FogEnd=Cfg.Vis.FogDist; Light.FogStart=Cfg.Vis.FogDist*.08; Light.FogColor=Cfg.Vis.FogCol end

    -- Light Boost
    bloomFX.Enabled=Cfg.Vis.LightBoost
    if Cfg.Vis.LightBoost then bloomFX.Intensity=Cfg.Vis.LightInt; bloomFX.Size=Cfg.Vis.LightSz end

    -- Third Person (со свободной камерой)
    if Cfg.Vis.ThirdPerson then
        local ch4=LP.Character; if ch4 then
            local r=ch4:FindFirstChild("HumanoidRootPart")
            if r and not Cfg.Rage.Silent then
                -- Не переопределяем в режиме Scriptable от silent
                Cam.CameraType=Enum.CameraType.Custom
            end
        end
        -- Просто увеличиваем расстояние камеры — не Scriptable,
        -- чтобы игрок мог сам вращать
        Cam.CameraMaxZoomDistance=Cfg.Vis.ThirdDist
        Cam.CameraMinZoomDistance=Cfg.Vis.ThirdDist
    else
        Cam.CameraMaxZoomDistance=400
        Cam.CameraMinZoomDistance=0.5
    end

    -- Custom FOV
    if Cfg.Vis.CustomFOV then Cam.FieldOfView=Cfg.Vis.FOVVal
    else Cam.FieldOfView=70 end

    -- Stretch Res
    if Cfg.Vis.StretchRes then
        -- Растягиваем через AspectRatio — меняет пропорции
        local existing=Cam:FindFirstChildOfClass("Camera") -- нет такого
        -- Единственный способ в Roblox: менять ViewportSize нельзя,
        -- но можно через PostEffect ColorCorrection + CFrame
        -- Простой вариант: squish через FieldOfView
        Cam.FieldOfView=Cfg.Vis.CustomFOV and Cfg.Vis.FOVVal or 70
    end

    -- Self Outline
    UpdateSelfHL()

    -- Player
    local ch7=LP.Character; local hm7=ch7 and ch7:FindFirstChildOfClass("Humanoid")
    if hm7 then
        hm7.WalkSpeed=Cfg.Player.Speed and Cfg.Player.SpeedVal or 16
        hm7.JumpPower=Cfg.Player.InfJump and Cfg.Player.JumpPow or 50
        if Cfg.Player.God then hm7.Health=hm7.MaxHealth end
        if Cfg.Player.Bhop and UIS:IsKeyDown(Enum.KeyCode.Space) then
            hm7:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    -- Сброс функций при выключении (чтобы возвращалось)
    if not Cfg.Vis.NoFog then end -- fog восстанавливается сам
    if not Cfg.Vis.FullBright and not Cfg.Vis.DayTime and not Cfg.Vis.Ambient then
        -- Ничего не сбрасываем в loop — сбрасываем через callback в Tog
    end
end)

-- Сброс настроек при выключении
-- (callbacks при toggle)
local function ResetLighting()
    Light.FogEnd=100000; Light.FogStart=0
    Light.Brightness=1; Light.ClockTime=12
    Light.Ambient=Color3.fromRGB(127,127,127)
    Light.OutdoorAmbient=Color3.fromRGB(127,127,127)
end

-- Hit effects
local function ConnHit(char)
    local hm=char:WaitForChild("Humanoid"); prevHP=hm.Health
    hm.HealthChanged:Connect(function(hp)
        if hp<prevHP then
            if Cfg.Vis.HitEffect then hitA=.5 end
            if Cfg.Vis.HitMarker then hmOn=true; hmT=tick() end
            if Cfg.Vis.HitSound then pcall(function() Snd("3691004927",.4,1.2) end) end
            if hp<=0 and Cfg.Vis.KillSound then pcall(function() Snd("3691004927",.6,.7) end) end
        elseif hp>prevHP and Cfg.Vis.HealSound then
            pcall(function() Snd("5992330088",.4,1.1) end)
        end
        prevHP=hp
    end)
end
if LP.Character then task.spawn(ConnHit,LP.Character) end
LP.CharacterAdded:Connect(ConnHit)

-- ══════════════════════════════
-- MENU KEY TOGGLE
-- ══════════════════════════════
UIS.InputBegan:Connect(function(inp,gpe)
    if gpe then return end
    local name=inp.KeyCode~=Enum.KeyCode.Unknown and tostring(inp.KeyCode):gsub("Enum%.KeyCode%.","") or nil
    if name and name==Cfg.MenuKey then
        Main.Visible=not Main.Visible
        Blocker.Visible=Main.Visible
        if Main.Visible then
            Main.Size=UDim2.new(0,MW,0,0)
            TS:Create(Main,TweenInfo.new(.22,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                {Size=UDim2.new(0,MW,0,MH)}):Play()
        end
    end
end)

print("[natality v1] fully loaded | "..Cfg.MenuKey.."=menu")
