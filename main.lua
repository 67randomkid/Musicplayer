-- =========================================================
-- SCRIPT NGHE NHẠC DELTA EXECUTOR (PRO EDITION + SYNCED LYRICS)
-- Features: Visualizer, Mini-Player, Sound Mode, Real-time Time Display & Karaoke Lyrics
-- =========================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎵 Music Player Pro",
   LoadingTitle = "Music Player",
   LoadingSubtitle = "Visualizer & Synced Karaoke Lyrics",
   ConfigurationSaving = { Enabled = false }
})

-- Tạo các Tab giao diện
local MainTab = Window:CreateTab("Main", 4483362458)
local SoundModeTab = Window:CreateTab("🎧 Sound Mode", 4483362458)
local VisualizerTab = Window:CreateTab("Visualizer & Theme", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-- Tab Playlists
local KhongBuongTab = Window:CreateTab("Không Buông", 4483362458)
local TimEmTab = Window:CreateTab("Tìm Em", 4483362458)
local MashupTab = Window:CreateTab("Mashup", 4483362458)
local CoCongMaiSacTab = Window:CreateTab("Có Công Mài Sắc", 4483362458)
local NhacTrungTab = Window:CreateTab("Nhạc Trung Remix", 4483362458)

-- Dữ liệu lời bài hát Karaoke Synced (LRC Format)
local LyricsDatabase = {
    KhongBuong = {
        { Time = 0, Text = "🎵 Bài hát: Không Buông" },
        { Time = 5, Text = "Anh đã cố giữ lấy những ký ức ngọt ngào..." },
        { Time = 12, Text = "Nhưng sao đôi tay em vội buông buông rời xa..." },
        { Time = 20, Text = "Cố quên một người từng là tất cả" },
        { Time = 28, Text = "Bao nhiêu yêu thương nay hóa thành mây mù..." },
        { Time = 36, Text = "Không buông tay anh ra, sao em vội quên mau..." },
        { Time = 45, Text = "Đêm dài trôi đi anh cô đơn trong góc tối..." },
        { Time = 55, Text = "🔥 [DROP BEAT HOODTRAP 808] 🔥" }
    },
    TimEm = {
        { Time = 0, Text = "🎵 Bài hát: Tìm Em" },
        { Time = 6, Text = "Tìm em giữa phố đông hoa đèn giăng khắp lối..." },
        { Time = 15, Text = "Nơi ta từng qua nay chỉ còn bóng dáng anh..." },
        { Time = 25, Text = "Lòng đau đớn khi em không còn bên cạnh..." },
        { Time = 34, Text = "Giọt nước mắt lăn dài trên bờ mi..." },
        { Time = 42, Text = "⚡ [BASS DROP] Tìm em trong từng giấc mơ..." }
    },
    Default = {
        { Time = 0, Text = "🎵 Đang phát nhạc..." },
        { Time = 3, Text = "✨ Chúc bạn nghe nhạc vui vẻ!" }
    }
}

-- Danh sách dữ liệu các bài hát
local Playlists = {
    KhongBuong = {
        { Name = "🔊 KHONG//BUONG prod. HYZØ (Không Buông x Hoodtrap) [3:21]", Url = "https://files.catbox.moe/zjcbj5.mp3", LyricsKey = "KhongBuong" },
        { Name = "🎹 [FREE] JERK DRILL TYPE BEAT - 'KHÔNG BUÔNG' | Prod DAIFU [2:29]", Url = "https://files.catbox.moe/tth698.mp3", LyricsKey = "KhongBuong" },
        { Name = "⚡ Hngle - KHÔNG BUÔNG ft. Ari | Prod.Hades [3:29]", Url = "https://files.catbox.moe/wgxrqm.mp3", LyricsKey = "KhongBuong" },
        { Name = "🎹 KHÔNG BUÔNG - Hngle ft. Ari | hoodtrap x pluggnb [2:58]", Url = "https://files.catbox.moe/twrr60.mp3", LyricsKey = "KhongBuong" }
    },
    TimEm = {
        { Name = "🎹 [FREE] tìm em.wav - Hngle ft. Bảo Anh | Prod DAIFU [3:29]", Url = "https://files.catbox.moe/gon9r1.mp3", LyricsKey = "TimEm" },
        { Name = "🔥 TÌM EM | Hngle ft Bảo Anh remake HoodTrap [3:48]", Url = "https://files.catbox.moe/5vt8zh.mp3", LyricsKey = "TimEm" },
        { Name = "⚡ TÌM EM - Hngle ft Bảo Anh | PROD BY LOWTERPER [3:56]", Url = "https://files.catbox.moe/6r3i5s.mp3", LyricsKey = "TimEm" },
        { Name = "🎧 Tìm Em ( Zenzy Remix ) [4:10]", Url = "https://files.catbox.moe/g2qk7t.mp3", LyricsKey = "TimEm" }
    },
    Mashup = {
        { Name = "🔥 TIM EM x XIN LOI VI DA XUAT HIEN - HNGLE x BAO ANH [5:11]", Url = "https://files.catbox.moe/sdt8of.mp3" },
        { Name = "🎧 NHAC VIET BEAT TAY #6 - GAZ [18:08]", Url = "https://files.catbox.moe/zeh200.mp3" },
        { Name = "🔥 Tìm Em X Túy Âm |Hoodtrap x Drill| [3:07]", Url = "https://files.catbox.moe/pzj4xw.mp3" }
    },
    CoCongMaiSac = {
        { Name = "🔮 Co Cong Mai Sac - Prod.Hades [2:35]", Url = "https://files.catbox.moe/xhew43.mp3" },
        { Name = "⚡ CÓ CÔNG MÀI \"SẮC\" (DRILL MIX) - NGÔ LAN HƯƠNG [3:08]", Url = "https://files.catbox.moe/2v8ts7.mp3" },
        { Name = "🔥 CO CONG MAI SAC - NGO LAN HUONG (PROD. GAZ) [3:12]", Url = "https://files.catbox.moe/ouxjsq.mp3" }
    },
    NhacTrung = {
        { Name = "🔥 Có Thể Hay Không (不可以) BroBear x Sea Lay Remix [4:45]", Url = "https://files.catbox.moe/qafdmm.mp3" },
        { Name = "🌊 海屿与你DJ Biển, Đảo Và Em Remix - LKN x Zang Remix [4:49]", Url = "https://files.catbox.moe/qafdmm.mp3" }
    }
}

-- Khai báo Sound Object & DSP Effects
local sound = game:GetService("SoundService"):FindFirstChild("DeltaMusicPlayer")
if not sound then
    sound = Instance.new("Sound")
    sound.Name = "DeltaMusicPlayer"
    sound.Volume = 1.2
    sound.Looped = false
    sound.Parent = game:GetService("SoundService")
end

local bassEq = sound:FindFirstChild("BassBoostEQ") or Instance.new("EqualizerSoundEffect", sound)
bassEq.Name = "BassBoostEQ"
bassEq.HighGain = 0; bassEq.MidGain = 0; bassEq.LowGain = 0; bassEq.Enabled = false

local reverbEffect = sound:FindFirstChild("PlayerReverb") or Instance.new("ReverbSoundEffect", sound)
reverbEffect.Name = "PlayerReverb"
reverbEffect.DecayTime = 3.5; reverbEffect.Density = 0.85; reverbEffect.WetLevel = -80; reverbEffect.Enabled = true

local pitchEffect = sound:FindFirstChild("PlayerPitch") or Instance.new("PitchShiftSoundEffect", sound)
pitchEffect.Name = "PlayerPitch"
pitchEffect.Octave = 1.0; pitchEffect.Enabled = true

local bassBoostEnabled = false
local bassBoostGain = 12

local inputUrl = ""
local currentLoadedSource = ""
local currentSongTitle = "Chưa phát nhạc"
local currentPlaylist = Playlists.KhongBuong
local currentIndex = 1
local autoNextEnabled = true
local currentLyricsData = LyricsDatabase.Default

local isUpdatingSlider = false

local function formatTime(seconds)
    if not seconds or seconds ~= seconds or seconds <= 0 then return "00:00" end
    local mins = math.floor(seconds / 60)
    local secs = math.floor(seconds % 60)
    return string.format("%02d:%02d", mins, secs)
end

---------------------------------------------------------
-- CẤU HÌNH VISUALIZER & THEME
---------------------------------------------------------
local visMode = "Scrolling Wave"
local themeMode = "Neon Cyan"
local particlesEnabled = true
local visualizerEnabled = true
local lyricsEnabled = true

local ThemeColors = {
    ["Neon Cyan"] = Color3.fromRGB(0, 240, 255),
    ["Cyberpunk Red"] = Color3.fromRGB(255, 40, 80),
    ["Purple Vaporwave"] = Color3.fromRGB(180, 70, 255),
    ["RGB Rainbow"] = Color3.fromRGB(0, 255, 255)
}

local function getCurrentThemeColor()
    if themeMode == "RGB Rainbow" then
        return Color3.fromHSV((tick() * 0.2) % 1, 0.9, 1)
    else
        return ThemeColors[themeMode] or Color3.fromRGB(0, 240, 255)
    end
end

---------------------------------------------------------
-- GUI MAIN VISUALIZER, LYRICS & MINI-PLAYER
---------------------------------------------------------
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

pcall(function() CoreGui:FindFirstChild("MusicPlayerGUI_Advanced"):Destroy() end)

local mainScreenGui = Instance.new("ScreenGui")
mainScreenGui.Name = "MusicPlayerGUI_Advanced"
mainScreenGui.ResetOnSpawn = false
pcall(function() mainScreenGui.Parent = CoreGui end)

-- Particle Container
local particleContainer = Instance.new("Frame")
particleContainer.Name = "ParticleContainer"
particleContainer.Size = UDim2.new(1, 0, 1, 0)
particleContainer.BackgroundTransparency = 1
particleContainer.Parent = mainScreenGui

local particles = {}
for i = 1, 20 do
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, math.random(4, 8), 0, math.random(4, 8))
    p.Position = UDim2.new(math.random(), 0, math.random(), 0)
    p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    p.BackgroundTransparency = 0.6
    p.BorderSizePixel = 0
    p.Parent = particleContainer
    Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
    table.insert(particles, { Object = p, BaseSize = p.Size.X.Offset, Vx = (math.random() - 0.5) * 0.001, Vy = (math.random() - 0.5) * 0.001 })
end

-- Visualizer Frame (170px)
local visFrame = Instance.new("Frame")
visFrame.Name = "VisualizerFrame"
visFrame.Size = UDim2.new(0, 220, 0, 110)
visFrame.Position = UDim2.new(0.5, -110, 0.05, 0)
visFrame.BackgroundTransparency = 1
visFrame.BorderSizePixel = 0
visFrame.Active = true
visFrame.Draggable = true
visFrame.Parent = mainScreenGui

Instance.new("UICorner", visFrame).CornerRadius = UDim.new(0, 10)
local visStroke = Instance.new("UIStroke", visFrame)
visStroke.Color = getCurrentThemeColor()
visStroke.Thickness = 1.5

local visTitle = Instance.new("TextLabel")
visTitle.Size = UDim2.new(1, -12, 0, 20)
visTitle.Position = UDim2.new(0, 8, 0, 4)
visTitle.BackgroundTransparency = 1
visTitle.Text = "🎵 VISUALIZER"
visTitle.TextColor3 = getCurrentThemeColor()
visTitle.TextSize = 10
visTitle.Font = Enum.Font.GothamBold
visTitle.TextXAlignment = Enum.TextXAlignment.Left
visTitle.Parent = visFrame

local waveContainer = Instance.new("Frame")
waveContainer.Size = UDim2.new(1, -16, 1, -30)
waveContainer.Position = UDim2.new(0, 8, 0, 24)
waveContainer.BackgroundTransparency = 1
waveContainer.ClipsDescendants = true
waveContainer.Parent = visFrame

local centerLine = Instance.new("Frame", waveContainer)
centerLine.Size = UDim2.new(1, 0, 0, 1)
centerLine.Position = UDim2.new(0, 0, 0.5, 0)
centerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
centerLine.BackgroundTransparency = 0.8

local numBars = 16
local history, bars = {}, {}
for i = 1, numBars do
    history[i] = 0
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1 / numBars, 0, 0, 2)
    bar.Position = UDim2.new((i - 1) / numBars, 0, 0.5, 0)
    bar.AnchorPoint = Vector2.new(0, 0.5)
    bar.BackgroundColor3 = getCurrentThemeColor()
    bar.BorderSizePixel = 0
    bar.Parent = waveContainer
    table.insert(bars, bar)
end

local circleCenter = Instance.new("Frame", waveContainer)
circleCenter.Size = UDim2.new(0, 32, 0, 32)
circleCenter.Position = UDim2.new(0.5, -16, 0.5, -16)
circleCenter.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
circleCenter.BackgroundTransparency = 0.3
circleCenter.Visible = false
Instance.new("UICorner", circleCenter).CornerRadius = UDim.new(1, 0)

local circleIcon = Instance.new("TextLabel", circleCenter)
circleIcon.Size = UDim2.new(1, 0, 1, 0)
circleIcon.BackgroundTransparency = 1
circleIcon.Text = "🎧"
circleIcon.TextSize = 16

---------------------------------------------------------
-- KHUNG HIỂN THỊ LỜI BÀI HÁT REAL-TIME (LYRICS FRAME)
---------------------------------------------------------
local lyricsFrame = Instance.new("Frame")
lyricsFrame.Name = "LyricsFrame"
lyricsFrame.Size = UDim2.new(0, 260, 0, 35)
lyricsFrame.Position = UDim2.new(0.5, -130, 0.20, 0)
lyricsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
lyricsFrame.BackgroundTransparency = 0.2
lyricsFrame.BorderSizePixel = 0
lyricsFrame.Active = true
lyricsFrame.Draggable = true
lyricsFrame.Visible = true
lyricsFrame.Parent = mainScreenGui

Instance.new("UICorner", lyricsFrame).CornerRadius = UDim.new(0, 8)
local lyricsStroke = Instance.new("UIStroke", lyricsFrame)
lyricsStroke.Color = getCurrentThemeColor()
lyricsStroke.Thickness = 1.2

local lyricsLabel = Instance.new("TextLabel")
lyricsLabel.Size = UDim2.new(1, -12, 1, 0)
lyricsLabel.Position = UDim2.new(0, 6, 0, 0)
lyricsLabel.BackgroundTransparency = 1
lyricsLabel.Text = "🎤 Lời bài hát sẽ hiển thị ở đây..."
lyricsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
lyricsLabel.TextSize = 12
lyricsLabel.Font = Enum.Font.GothamBold
lyricsLabel.TextWrapped = true
lyricsLabel.Parent = lyricsFrame

-- Mini Player Frame
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniPlayerFrame"
miniFrame.Size = UDim2.new(0, 260, 0, 45)
miniFrame.Position = UDim2.new(0.02, 0, 0.85, 0)
miniFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
miniFrame.Active = true
miniFrame.Draggable = true
miniFrame.Visible = false
miniFrame.Parent = mainScreenGui

Instance.new("UICorner", miniFrame).CornerRadius = UDim.new(0, 8)
local miniStroke = Instance.new("UIStroke", miniFrame)
miniStroke.Color = getCurrentThemeColor()

local miniTitle = Instance.new("TextLabel", miniFrame)
miniTitle.Size = UDim2.new(1, -85, 0, 20)
miniTitle.Position = UDim2.new(0, 10, 0, 4)
miniTitle.BackgroundTransparency = 1
miniTitle.Text = "🎵 Chưa phát nhạc"
miniTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
miniTitle.TextSize = 10
miniTitle.Font = Enum.Font.GothamBold
miniTitle.TextXAlignment = Enum.TextXAlignment.Left

local miniPlayBtn = Instance.new("TextButton", miniFrame)
miniPlayBtn.Size = UDim2.new(0, 22, 0, 22); miniPlayBtn.Position = UDim2.new(1, -70, 0.5, -11)
miniPlayBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40); miniPlayBtn.Text = "⏯️"; miniPlayBtn.TextSize = 10; miniPlayBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", miniPlayBtn).CornerRadius = UDim.new(0, 4)

local miniNextBtn = Instance.new("TextButton", miniFrame)
miniNextBtn.Size = UDim2.new(0, 22, 0, 22); miniNextBtn.Position = UDim2.new(1, -42, 0.5, -11)
miniNextBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40); miniNextBtn.Text = "⏭️"; miniNextBtn.TextSize = 10; miniNextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", miniNextBtn).CornerRadius = UDim.new(0, 4)

local miniExpandBtn = Instance.new("TextButton", miniFrame)
miniExpandBtn.Size = UDim2.new(0, 18, 0, 18); miniExpandBtn.Position = UDim2.new(1, -18, 0, 2)
miniExpandBtn.BackgroundTransparency = 1; miniExpandBtn.Text = "❌"; miniExpandBtn.TextSize = 8; miniExpandBtn.TextColor3 = Color3.fromRGB(200, 200, 200)

---------------------------------------------------------
-- RENDER LOOP (VISUALIZER & LYRICS SYNC)
---------------------------------------------------------
local lastUpdate = 0
RunService.RenderStepped:Connect(function()
    local themeColor = getCurrentThemeColor()
    visStroke.Color = themeColor
    lyricsStroke.Color = themeColor
    miniStroke.Color = themeColor
    visTitle.TextColor3 = themeColor
    
    local loudness = sound.PlaybackLoudness or 0
    local rawAmp = math.clamp(loudness / 320, 0, 1)
    
    -- Cập nhật Lời Bài Hát Real-time theo sound.TimePosition
    if sound.IsPlaying and lyricsEnabled and lyricsFrame.Visible then
        local pos = sound.TimePosition
        local currentLine = "🎤 ..."
        for i = #currentLyricsData, 1, -1 do
            if pos >= currentLyricsData[i].Time then
                currentLine = "🎤 " .. currentLyricsData[i].Text
                break
            end
        end
        lyricsLabel.Text = currentLine
    end
    
    if particlesEnabled and particleContainer.Visible then
        for _, pData in ipairs(particles) do
            local p = pData.Object
            p.Position = UDim2.new((p.Position.X.Scale + pData.Vx) % 1, 0, (p.Position.Y.Scale + pData.Vy) % 1, 0)
            if sound.IsPlaying and rawAmp > 0.65 then
                local scale = pData.BaseSize * (1 + rawAmp * 1.5)
                p.Size = UDim2.new(0, scale, 0, scale)
                p.BackgroundColor3 = themeColor
                p.BackgroundTransparency = 0.2
            else
                p.Size = UDim2.new(0, pData.BaseSize, 0, pData.BaseSize)
                p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                p.BackgroundTransparency = 0.6
            end
        end
    end
    
    if visualizerEnabled and visFrame.Visible then
        local now = tick()
        if visMode == "Scrolling Wave" then
            circleCenter.Visible = false
            centerLine.Visible = true
            if now - lastUpdate >= 0.035 then
                lastUpdate = now
                local h = 0
                if sound.IsPlaying and loudness > 5 then
                    if rawAmp > 0.65 then h = math.clamp(rawAmp * 32, 12, 30)
                    else h = math.clamp(rawAmp * 18 * (0.6 + ((math.noise(now * 15, 0, 0) + 1) / 2) * 0.4), 2, 16) end
                end
                table.remove(history, 1)
                table.insert(history, h)
            end
            for i = 1, numBars do
                local bar = bars[i]
                local h = history[i] or 0
                bar.Rotation = 0; bar.AnchorPoint = Vector2.new(0, 0.5)
                bar.Position = UDim2.new((i - 1) / numBars, 0, 0.5, 0)
                bar.Size = bar.Size:Lerp(UDim2.new(1 / numBars, 0, 0, math.max(h, 2)), 0.4)
                bar.BackgroundColor3 = (h >= 20) and Color3.fromRGB(255, 255, 255) or themeColor
            end
        elseif visMode == "Bar Spectrum" then
            circleCenter.Visible = false; centerLine.Visible = false
            for i = 1, numBars do
                local bar = bars[i]
                local h = 2
                if sound.IsPlaying and loudness > 5 then
                    h = math.clamp(rawAmp * 45 * (math.sin(now * 20 + i * 0.3) * 0.4 + 0.6), 2, 42)
                end
                bar.Rotation = 0; bar.AnchorPoint = Vector2.new(0, 1)
                bar.Position = UDim2.new((i - 1) / numBars, 0, 1, 0)
                bar.Size = bar.Size:Lerp(UDim2.new(1 / numBars - 0.003, 0, 0, h), 0.3)
                bar.BackgroundColor3 = (rawAmp > 0.75 and i > (numBars * 0.75)) and Color3.fromRGB(255, 80, 100) or themeColor
            end
        elseif visMode == "Radial Circle" then
            circleCenter.Visible = true; centerLine.Visible = false
            local centerPos = Vector2.new(waveContainer.AbsoluteSize.X / 2, waveContainer.AbsoluteSize.Y / 2)
            for i = 1, numBars do
                local bar = bars[i]
                local angle = (i / numBars) * math.pi * 2 + (now * 0.5)
                local h = 4
                if sound.IsPlaying and loudness > 5 then
                    h = math.clamp(rawAmp * 28 * (math.noise(now * 10, i * 0.2, 0) * 0.5 + 0.5), 4, 28)
                end
                local cos, sin = math.cos(angle), math.sin(angle)
                bar.AnchorPoint = Vector2.new(0.5, 0.5)
                bar.Position = UDim2.new(0, centerPos.X + cos * 20, 0, centerPos.Y + sin * 20)
                bar.Size = UDim2.new(0, 3, 0, h)
                bar.Rotation = math.deg(angle) + 90
                bar.BackgroundColor3 = themeColor
            end
        end
    end
end)

---------------------------------------------------------
-- XỬ LÝ PHÁT NHẠC & LOAD LYRICS
---------------------------------------------------------
local httpRequest = (syn and syn.request) or (http and http.request) or request or http_request

local function playAudio(source, songName, lyricsKey)
    if not source or source == "" then 
        Rayfield:Notify({Title = "⚠️ Lỗi Link", Content = "Vui lòng chọn bài hát hoặc dán link!", Duration = 1.5})
        return 
    end
    
    sound:Stop()
    currentLoadedSource = source
    currentSongTitle = songName or "Đang phát nhạc"
    miniTitle.Text = "🎵 " .. currentSongTitle
    
    -- Load dữ liệu Lời Bài Hát tương ứng
    currentLyricsData = (lyricsKey and LyricsDatabase[lyricsKey]) or LyricsDatabase.Default
    
    if string.sub(source, 1, 4) == "http" then
        local getAsset = custom_asset or getcustomasset
        if not getAsset then
            pcall(function() sound.SoundId = source; sound:Play() end)
            return
        end

        local cleanName = string.gsub(source, "%W", "")
        if #cleanName > 25 then cleanName = string.sub(cleanName, -25) end
        local fileName = "m_cache_" .. cleanName .. ".mp3"

        if isfile and isfile(fileName) then
            task.spawn(function()
                pcall(function() sound.SoundId = getAsset(fileName); sound:Play() end)
                Rayfield:Notify({Title = "⚡ Đang phát (Cache)", Content = currentSongTitle, Duration = 1.5})
            end)
            return
        end

        Rayfield:Notify({Title = "⏳ Đang nạp bài...", Content = "Đang tải file nhạc...", Duration = 2})
        
        task.spawn(function()
            local audioData = nil
            pcall(function() audioData = game:HttpGet(source, true) end)

            if (not audioData or #audioData < 5000) and httpRequest then
                pcall(function()
                    local res = httpRequest({ Url = source, Method = "GET" })
                    if res and res.Success and res.Body then audioData = res.Body end
                end)
            end
            
            if audioData and #audioData > 5000 then
                pcall(function()
                    writefile(fileName, audioData)
                    sound.SoundId = getAsset(fileName)
                    sound:Play()
                end)
                Rayfield:Notify({Title = "✅ Đang phát", Content = currentSongTitle, Duration = 1.5})
            else
                Rayfield:Notify({Title = "❌ Lỗi nạp nhạc", Content = "Tải file thất bại! Thử lại bài khác.", Duration = 2})
            end
        end)
    else
        local id = string.match(source, "%d+")
        if id then
            sound.SoundId = "rbxassetid://" .. id
            sound:Play()
            Rayfield:Notify({Title = "✅ Đang phát", Content = "ID: " .. id, Duration = 1.5})
        end
    end
end

local function playSongFromPlaylist(playlist, index)
    currentPlaylist = playlist
    currentIndex = index
    if currentIndex > #currentPlaylist then currentIndex = 1
    elseif currentIndex < 1 then currentIndex = #currentPlaylist end
    
    local song = currentPlaylist[currentIndex]
    if song then playAudio(song.Url, song.Name, song.LyricsKey) end
end

sound.Ended:Connect(function()
    if autoNextEnabled and not sound.Looped and currentPlaylist and #currentPlaylist > 0 then
        playSongFromPlaylist(currentPlaylist, currentIndex + 1)
    end
end)

miniPlayBtn.MouseButton1Click:Connect(function()
    if sound.IsPlaying then sound:Pause()
    elseif sound.IsPaused then sound:Resume() end
end)

miniNextBtn.MouseButton1Click:Connect(function()
    if currentPlaylist and #currentPlaylist > 0 then playSongFromPlaylist(currentPlaylist, currentIndex + 1) end
end)

miniExpandBtn.MouseButton1Click:Connect(function()
    miniFrame.Visible = false
    visFrame.Visible = visualizerEnabled
    lyricsFrame.Visible = lyricsEnabled
end)

---------------------------------------------------------
-- TAB 1: MAIN
---------------------------------------------------------
MainTab:CreateInput({
   Name = "URL Nhạc / Asset ID",
   PlaceholderText = "Dán link Direct MP3 hoặc Asset ID vào đây",
   RemoveTextOnFocus = false,
   Callback = function(Text) inputUrl = Text end,
})

MainTab:CreateButton({
   Name = "▶️ Phát bài mới (Từ ô nhập)",
   Callback = function() playAudio(inputUrl, "Bài hát từ URL nhập") end,
})

local TimeLabel = MainTab:CreateLabel("⏱️ Thời gian: 00:00 / 00:00")

local ProgressSlider = MainTab:CreateSlider({
   Name = "🎵 Tiến Trình Bài Hát (%)",
   Range = {0, 100},
   Increment = 1,
   CurrentValue = 0,
   Callback = function(Value)
      if isUpdatingSlider then return end
      if sound.IsPlaying and sound.TimeLength > 0 then
          sound.TimePosition = (Value / 100) * sound.TimeLength
      end
   end,
})

RunService.RenderStepped:Connect(function()
    if sound.IsPlaying and sound.TimeLength > 0 then
        local current = formatTime(sound.TimePosition)
        local total = formatTime(sound.TimeLength)
        TimeLabel:Set("⏱️ Thời gian: " .. current .. " / " .. total)
        
        local progressPercent = math.floor((sound.TimePosition / sound.TimeLength) * 100)
        isUpdatingSlider = true
        ProgressSlider:Set(progressPercent)
        isUpdatingSlider = false
    elseif not sound.IsPlaying and not sound.IsPaused then
        TimeLabel:Set("⏱️ Thời gian: 00:00 / 00:00")
    end
end)

-- Các nút Tua nhạc
MainTab:CreateButton({
   Name = "⏩ Tua tới 10 giây (+10s)",
   Callback = function()
      if sound.IsPlaying or sound.IsPaused then
          sound.TimePosition = math.clamp(sound.TimePosition + 10, 0, sound.TimeLength)
      end
   end,
})

MainTab:CreateButton({
   Name = "⏪ Tua lùi 10 giây (-10s)",
   Callback = function()
      if sound.IsPlaying or sound.IsPaused then
          sound.TimePosition = math.clamp(sound.TimePosition - 10, 0, sound.TimeLength)
      end
   end,
})

MainTab:CreateButton({
   Name = "📱 Thu gọn Mini-Player (Widget)",
   Callback = function()
      miniFrame.Visible = true
      visFrame.Visible = false
      lyricsFrame.Visible = false
      Rayfield:Notify({Title = "📱 Mini Player", Content = "Đã thu gọn thành Widget!", Duration = 1.5})
   end,
})

MainTab:CreateButton({
   Name = "⏭️ Bài tiếp theo (Next Song)",
   Callback = function()
      if currentPlaylist and #currentPlaylist > 0 then playSongFromPlaylist(currentPlaylist, currentIndex + 1) end
   end,
})

MainTab:CreateButton({
   Name = "⏮️ Bài trước đó (Previous Song)",
   Callback = function()
      if currentPlaylist and #currentPlaylist > 0 then playSongFromPlaylist(currentPlaylist, currentIndex - 1) end
   end,
})

MainTab:CreateButton({
   Name = "⏯️ Tiếp tục (Resume)",
   Callback = function()
      if sound.IsPaused then sound:Resume()
      elseif not sound.IsPlaying and currentLoadedSource ~= "" then sound:Play() end
   end,
})

MainTab:CreateButton({
   Name = "⏸️ Tạm dừng (Pause)",
   Callback = function() if sound.IsPlaying then sound:Pause() end end,
})

MainTab:CreateButton({
   Name = "⏹️ Dừng hẳn (Reset)",
   Callback = function() sound:Stop(); currentLoadedSource = "" end,
})

local autoNextBtn
autoNextBtn = MainTab:CreateButton({
   Name = autoNextEnabled and "🔄 Tự động chuyển bài (Auto-Next): BẬT" or "🔄 Tự động chuyển bài (Auto-Next): TẮT",
   Callback = function()
      autoNextEnabled = not autoNextEnabled
      autoNextBtn:Set(autoNextEnabled and "🔄 Tự động chuyển bài (Auto-Next): BẬT" or "🔄 Tự động chuyển bài (Auto-Next): TẮT")
   end,
})

local loopButton
loopButton = MainTab:CreateButton({
   Name = sound.Looped and "🔁 Vòng lặp 1 bài: BẬT" or "🔁 Vòng lặp 1 bài: TẮT",
   Callback = function()
      sound.Looped = not sound.Looped
      loopButton:Set(sound.Looped and "🔁 Vòng lặp 1 bài: BẬT" or "🔁 Vòng lặp 1 bài: TẮT")
   end,
})

MainTab:CreateSlider({
   Name = "🔊 Âm lượng",
   Range = {0, 500},
   Increment = 5,
   CurrentValue = 120,
   Callback = function(Value) sound.Volume = Value / 100 end,
})

---------------------------------------------------------
-- TAB 2: SOUND MODE
---------------------------------------------------------
SoundModeTab:CreateSection("⚡ Preset Nhanh (Preset Audio Modes)")

SoundModeTab:CreateButton({
   Name = "💿 Original Mode (Mặc Định)",
   Callback = function()
      sound.PlaybackSpeed = 1.0; reverbEffect.WetLevel = -80; pitchEffect.Octave = 1.0; bassEq.Enabled = false
   end,
})

SoundModeTab:CreateButton({
   Name = "🌧️ Slowed + Reverb (0.85x + Vang Chill)",
   Callback = function()
      sound.PlaybackSpeed = 0.85; reverbEffect.WetLevel = -6; pitchEffect.Octave = 1.0
   end,
})

SoundModeTab:CreateButton({
   Name = "🐿️ Nightcore Mode (1.25x Speed + High Pitch)",
   Callback = function()
      sound.PlaybackSpeed = 1.25; reverbEffect.WetLevel = -80; pitchEffect.Octave = 1.15
   end,
})

SoundModeTab:CreateButton({
   Name = "🔊 Hoodtrap 808 Boost (Ép Bass 808 Căng)",
   Callback = function()
      bassBoostEnabled = true; bassEq.Enabled = true; bassEq.LowGain = 14; bassEq.MidGain = -2
   end,
})

SoundModeTab:CreateSection("🎛️ Tùy Chỉnh Chi Tiết")

SoundModeTab:CreateSlider({
   Name = "⏩ Tốc độ phát (Playback Speed)",
   Range = {50, 150}, Increment = 1, CurrentValue = 100,
   Callback = function(Value) sound.PlaybackSpeed = Value / 100 end,
})

SoundModeTab:CreateSlider({
   Name = "🎶 Tần số Pitch (Tone Cao / Thấp)",
   Range = {50, 150}, Increment = 1, CurrentValue = 100,
   Callback = function(Value) pitchEffect.Octave = Value / 100 end,
})

SoundModeTab:CreateSlider({
   Name = "🌊 Độ vang Reverb (Wet Level)",
   Range = {-80, 0}, Increment = 2, CurrentValue = -80,
   Callback = function(Value) reverbEffect.WetLevel = Value end,
})

---------------------------------------------------------
-- TAB 3: VISUALIZER & THEMES CONFIG
---------------------------------------------------------
VisualizerTab:CreateSection("🎤 Cấu Hình Lời Bài Hát (Lyrics)")

VisualizerTab:CreateToggle({
   Name = "Hiển thị Khung Lời Bài Hát (Karaoke Lyrics)",
   CurrentValue = true,
   Callback = function(Value)
      lyricsEnabled = Value
      lyricsFrame.Visible = Value
   end,
})

VisualizerTab:CreateSection("🎛️ Tùy Chỉnh Visualizer & Color")

VisualizerTab:CreateDropdown({
   Name = "Chế Độ Sóng Âm",
   Options = {"Scrolling Wave", "Bar Spectrum", "Radial Circle"},
   CurrentOption = "Scrolling Wave",
   Callback = function(Option)
      local selectedOption = (type(Option) == "table" and Option[1]) or Option
      visMode = selectedOption
      visTitle.Text = "🎵 VISUALIZER: " .. string.upper(selectedOption)
   end,
})

VisualizerTab:CreateDropdown({
   Name = "Màu Theme Giao Diện",
   Options = {"Neon Cyan", "Cyberpunk Red", "Purple Vaporwave", "RGB Rainbow"},
   CurrentOption = "Neon Cyan",
   Callback = function(Option)
      local selectedOption = (type(Option) == "table" and Option[1]) or Option
      themeMode = selectedOption
   end,
})

VisualizerTab:CreateToggle({
   Name = "Hiệu ứng Hạt Beat Particles",
   CurrentValue = true,
   Callback = function(Value)
      particlesEnabled = Value
      particleContainer.Visible = Value
   end,
})

VisualizerTab:CreateToggle({
   Name = "Hiển thị Khung Visualizer Sóng Âm",
   CurrentValue = true,
   Callback = function(Value)
      visualizerEnabled = Value
      visFrame.Visible = Value
   end,
})

---------------------------------------------------------
-- TAB 4: MISC
---------------------------------------------------------
local bassBoostBtn
bassBoostBtn = MiscTab:CreateButton({
   Name = bassBoostEnabled and "⚡ Bass Boost: BẬT" or "⚡ Bass Boost: TẮT",
   Callback = function()
      bassBoostEnabled = not bassBoostEnabled
      bassEq.Enabled = bassBoostEnabled
      bassBoostBtn:Set(bassBoostEnabled and "⚡ Bass Boost: BẬT" or "⚡ Bass Boost: TẮT")
   end,
})

MiscTab:CreateSlider({
   Name = "🎚️ Mức Độ Bass Boost (0 dB - 24 dB)",
   Range = {0, 24}, Increment = 1, CurrentValue = 12,
   Callback = function(Value)
      bassBoostGain = Value
      if bassBoostEnabled then bassEq.LowGain = bassBoostGain end
   end,
})

---------------------------------------------------------
-- CÁC TAB DANH SÁCH BÀI HÁT
---------------------------------------------------------
KhongBuongTab:CreateSection("🔥 Các Bản Remix / Remake Không Buông")
for i, song in ipairs(Playlists.KhongBuong) do
    KhongBuongTab:CreateButton({ Name = song.Name, Callback = function() playSongFromPlaylist(Playlists.KhongBuong, i) end })
end

TimEmTab:CreateSection("✨ Các Bản Remix / Remake Tìm Em")
for i, song in ipairs(Playlists.TimEm) do
    TimEmTab:CreateButton({ Name = song.Name, Callback = function() playSongFromPlaylist(Playlists.TimEm, i) end })
end

MashupTab:CreateSection("🔀 Các Bản Mashup / Beat Tay")
for i, song in ipairs(Playlists.Mashup) do
    MashupTab:CreateButton({ Name = song.Name, Callback = function() playSongFromPlaylist(Playlists.Mashup, i) end })
end

CoCongMaiSacTab:CreateSection("🔨 Các Bản Remix / Remake Có Công Mài Sắc")
for i, song in ipairs(Playlists.CoCongMaiSac) do
    CoCongMaiSacTab:CreateButton({ Name = song.Name, Callback = function() playSongFromPlaylist(Playlists.CoCongMaiSac, i) end })
end

NhacTrungTab:CreateSection("🇨🇳 Các Bản Nhạc Trung Remix")
for i, song in ipairs(Playlists.NhacTrung) do
    NhacTrungTab:CreateButton({ Name = song.Name, Callback = function() playSongFromPlaylist(Playlists.NhacTrung, i) end })
end
