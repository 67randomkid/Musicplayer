-- Script Nghe Nhạc Delta Executor (Đã giảm thời gian thông báo xuống 1 giây)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎵 Music Player GUI",
   LoadingTitle = "Music",
   LoadingSubtitle = "Random Kid",
   ConfigurationSaving = { Enabled = false }
})

-- Tạo các Tab giao diện
local MainTab = Window:CreateTab("Main", 4483362458)
local KhongBuongTab = Window:CreateTab("Không Buông", 4483362458)
local TimEmTab = Window:CreateTab("Tìm Em", 4483362458)
local MashupTab = Window:CreateTab("Mashup", 4483362458)
local CoCongMaiSacTab = Window:CreateTab("Có Công Mài Sắc", 4483362458)
local NhacTrungTab = Window:CreateTab("Nhạc Trung Remix", 4483362458)

-- Danh sách dữ liệu các bài hát theo Tab
local Playlists = {
    KhongBuong = {
        { Name = "🔊 KHONG//BUONG prod. HYZØ (Không Buông x Hoodtrap) [3:21]", Url = "https://files.catbox.moe/zjcbj5.mp3" },
        { Name = "🎹 [FREE] JERK DRILL TYPE BEAT - 'KHÔNG BUÔNG - Hngle ft. Ari' | Prod DAIFU [2:29]", Url = "https://files.catbox.moe/tth698.mp3" },
        { Name = "⚡ Hngle - KHÔNG BUÔNG ft. Ari | ( Jerk Drill Rmx ) Prod.Hades [3:29]", Url = "https://files.catbox.moe/wgxrqm.mp3" },
        { Name = "🎹 KHÔNG BUÔNG - Hngle ft. Ari | hoodtrap x pluggnb [2:58]", Url = "https://files.catbox.moe/twrr60.mp3" }
    },
    TimEm = {
        { Name = "🎹 [FREE] tìm em.wav - Hngle ft. Bảo Anh | Prod DAIFU - Drill Type Beat [3:29]", Url = "https://files.catbox.moe/gon9r1.mp3" },
        { Name = "🔥 TÌM EM | Hngle ft Bảo Anh remake HoodTrap [3:48]", Url = "https://files.catbox.moe/5vt8zh.mp3" },
        { Name = "⚡ TÌM EM - Hngle ft Bảo Anh - (HOODTRAP, JERK DRILL) | PROD BY LOWTERPER [3:56]", Url = "https://files.catbox.moe/6r3i5s.mp3" },
        { Name = "🎧 Tìm Em ( Zenzy Remix ) [4:10]", Url = "https://files.catbox.moe/g2qk7t.mp3" }
    },
    Mashup = {
        { Name = "🔥 TIM EM x XIN LOI VI DA XUAT HIEN (PROD. GAZ) - HNGLE x BAO ANH x VU DUY KHANH [5:11]", Url = "https://files.catbox.moe/sdt8of.mp3" },
        { Name = "🎧 NHAC VIET BEAT TAY #6 - GAZ [18:08]", Url = "https://files.catbox.moe/zeh200.mp3" },
        { Name = "🔥 Tìm Em X Túy Âm |Hoodtrap x Drill| [3:07]", Url = "https://files.catbox.moe/pzj4xw.mp3" }
    },
    CoCongMaiSac = {
        { Name = "🔮 Co Cong Mai Sac - Prod.Hades [2:35]", Url = "https://files.catbox.moe/xhew43.mp3" },
        { Name = "⚡ CÓ CÔNG MÀI \"SẮC\" (DRILL MIX) - NGÔ LAN HƯƠNG (XCV Beat) [3:08]", Url = "https://files.catbox.moe/2v8ts7.mp3" },
        { Name = "🔥 CO CONG MAI SAC - NGO LAN HUONG (PROD. GAZ) | JERK DRILL TYPE BEAT [3:12]", Url = "https://files.catbox.moe/ouxjsq.mp3" }
    },
    NhacTrung = {
        { Name = "🔥 Có Thể Hay Không (不可以) BroBear x Sea Lay Remix [4:45]", Url = "https://files.catbox.moe/qafdmm.mp3" },
        { Name = "🌊 海屿与你DJ (Crabbit) Biển, Đảo Và Em Remix - LKN x Zang Remix [4:49]", Url = "https://files.catbox.moe/qafdmm.mp3" }
    }
}

-- Khai báo quản lý nhạc & Playlist
local sound = game:GetService("SoundService"):FindFirstChild("DeltaMusicPlayer")
if not sound then
    sound = Instance.new("Sound")
    sound.Name = "DeltaMusicPlayer"
    sound.Volume = 2.5 -- 250%
    sound.Looped = false -- Mặc định tắt loop 1 bài để dùng auto-next
    sound.Parent = game:GetService("SoundService")
end

local inputUrl = ""
local currentLoadedSource = ""
local currentPlaylist = Playlists.KhongBuong
local currentIndex = 1
local autoNextEnabled = true

-- Hàm nạp và phát nhạc
local function playAudio(source, songName)
    if not source or source == "" then 
        Rayfield:Notify({Title = "⚠️ Lỗi Link", Content = "Vui lòng chọn bài hát hoặc dán link!", Duration = 1})
        return 
    end
    
    sound:Stop()
    currentLoadedSource = source
    
    if string.sub(source, 1, 4) == "http" then
        local getAsset = custom_asset or getcustomasset
        if not getAsset then
            Rayfield:Notify({Title = "❌ Lỗi Executor", Content = "Delta không hỗ trợ getcustomasset!", Duration = 1})
            return
        end

        Rayfield:Notify({Title = "⏳ Đang nạp bài...", Content = songName or "Vui lòng đợi...", Duration = 1})
        
        task.spawn(function()
            local fileName = "song_" .. tostring(os.time()) .. ".mp3"
            
            local success, response = pcall(function()
                return game:HttpGet(source, true)
            end)
            
            if success and response and #response > 10000 then
                writefile(fileName, response)
                sound.SoundId = getAsset(fileName)
                sound:Play()
                Rayfield:Notify({Title = "✅ Đang phát", Content = songName or "Phát nhạc thành công!", Duration = 1})
            else
                Rayfield:Notify({
                    Title = "❌ Lỗi nạp nhạc", 
                    Content = "Không tải được bài hát. Thử lại sau ít phút!",
                    Duration = 1
                })
            end
        end)
    else
        local id = string.match(source, "%d+")
        if id then
            sound.SoundId = "rbxassetid://" .. id
            sound:Play()
            Rayfield:Notify({Title = "✅ Đang phát", Content = "ID: " .. id, Duration = 1})
        end
    end
end

-- Hàm phát bài theo index trong Playlist hiện tại
local function playSongFromPlaylist(playlist, index)
    currentPlaylist = playlist
    currentIndex = index
    if currentIndex > #currentPlaylist then
        currentIndex = 1 -- Khi đến bài cuối cùng thì quay lại bài đầu tiên
    elseif currentIndex < 1 then
        currentIndex = #currentPlaylist
    end
    
    local song = currentPlaylist[currentIndex]
    if song then
        playAudio(song.Url, song.Name)
    end
end

-- Tự động chuyển bài khi kết thúc bài hát (Sound.Ended)
sound.Ended:Connect(function()
    if autoNextEnabled and not sound.Looped and currentPlaylist and #currentPlaylist > 0 then
        playSongFromPlaylist(currentPlaylist, currentIndex + 1)
    end
end)

---------------------------------------------------------
-- TAB 1: MAIN (Điều khiển)
---------------------------------------------------------

MainTab:CreateInput({
   Name = "URL Nhạc / Asset ID",
   PlaceholderText = "Dán link Direct MP3 hoặc Asset ID vào đây",
   RemoveTextOnFocus = false,
   Callback = function(Text)
      inputUrl = Text
   end,
})

MainTab:CreateButton({
   Name = "▶️ Phát bài mới (Từ ô nhập)",
   Callback = function()
      playAudio(inputUrl, "Bài hát từ URL nhập")
   end,
})

MainTab:CreateButton({
   Name = "⏭️ Bài tiếp theo (Next Song)",
   Callback = function()
      if currentPlaylist and #currentPlaylist > 0 then
          playSongFromPlaylist(currentPlaylist, currentIndex + 1)
      end
   end,
})

MainTab:CreateButton({
   Name = "⏮️ Bài trước đó (Previous Song)",
   Callback = function()
      if currentPlaylist and #currentPlaylist > 0 then
          playSongFromPlaylist(currentPlaylist, currentIndex - 1)
      end
   end,
})

MainTab:CreateButton({
   Name = "⏯️ Tiếp tục (Resume)",
   Callback = function()
      if sound.IsPaused then
          sound:Resume()
          Rayfield:Notify({Title = "▶️ Tiếp tục", Content = "Đang phát tiếp bài hát!", Duration = 1})
      elseif not sound.IsPlaying and currentLoadedSource ~= "" then
          sound:Play()
      end
   end,
})

MainTab:CreateButton({
   Name = "⏸️ Tạm dừng",
   Callback = function()
      if sound.IsPlaying then
          sound:Pause()
          Rayfield:Notify({Title = "⏸️ Tạm dừng", Content = "Đã tạm dừng bài hát.", Duration = 1})
      end
   end,
})

MainTab:CreateButton({
   Name = "⏹️ Dừng hẳn (Reset)",
   Callback = function()
      sound:Stop()
      currentLoadedSource = ""
      Rayfield:Notify({Title = "⏹️ Dừng hẳn", Content = "Đã reset bài hát về ban đầu.", Duration = 1})
   end,
})

-- Nút Bật/Tắt Tự Động Chuyển Bài (Auto-Next)
local autoNextBtn
autoNextBtn = MainTab:CreateButton({
   Name = autoNextEnabled and "🔄 Tự động chuyển bài (Auto-Next): BẬT" or "🔄 Tự động chuyển bài (Auto-Next): TẮT",
   Callback = function()
      autoNextEnabled = not autoNextEnabled
      if autoNextEnabled then
          autoNextBtn:Set("🔄 Tự động chuyển bài (Auto-Next): BẬT")
          Rayfield:Notify({Title = "🔄 Auto-Next", Content = "Đã BẬT tự động chuyển bài tiếp theo khi hết bài!", Duration = 1})
      else
          autoNextBtn:Set("🔄 Tự động chuyển bài (Auto-Next): TẮT")
          Rayfield:Notify({Title = "⏹️ Auto-Next", Content = "Đã TẮT tự động chuyển bài.", Duration = 1})
      end
   end,
})

-- Nút Chuyển đổi Vòng lặp 1 bài (Loop Play)
local loopButton
loopButton = MainTab:CreateButton({
   Name = sound.Looped and "🔁 Vòng lặp 1 bài: BẬT" or "🔁 Vòng lặp 1 bài: TẮT",
   Callback = function()
      sound.Looped = not sound.Looped
      if sound.Looped then
          loopButton:Set("🔁 Vòng lặp 1 bài: BẬT")
          Rayfield:Notify({Title = "🔁 Loop 1 bài", Content = "Đã BẬT lặp lại 1 bài vô hạn!", Duration = 1})
      else
          loopButton:Set("🔁 Vòng lặp 1 bài: TẮT")
          Rayfield:Notify({Title = "➡️ Loop 1 bài", Content = "Đã TẮT lặp lại 1 bài.", Duration = 1})
      end
   end,
})

-- Các Nút Tua Nhạc
MainTab:CreateButton({
   Name = "⏪ Tua lùi 10s",
   Callback = function()
      if sound.IsPlaying or sound.IsPaused then
          sound.TimePosition = math.max(0, sound.TimePosition - 10)
      end
   end,
})

MainTab:CreateButton({
   Name = "⏩ Tua tới 10s",
   Callback = function()
      if sound.IsPlaying or sound.IsPaused then
          sound.TimePosition = math.min(sound.TimeLength, sound.TimePosition + 10)
      end
   end,
})

-- Thanh Slider âm lượng
MainTab:CreateSlider({
   Name = "🔊 Âm lượng (Tối đa 500%)",
   Range = {0, 500},
   Increment = 10,
   CurrentValue = 250,
   Callback = function(Value)
      sound.Volume = Value / 100
   end,
})

MainTab:CreateLabel("⚠️ thời lượng video càng dài thì càng đợi lâu nhé ae=))")

---------------------------------------------------------
-- TAB 2: MỤC "KHÔNG BUÔNG"
---------------------------------------------------------
KhongBuongTab:CreateSection("🔥 Các Bản Remix / Remake Không Buông")
for i, song in ipairs(Playlists.KhongBuong) do
    KhongBuongTab:CreateButton({
        Name = song.Name,
        Callback = function()
            playSongFromPlaylist(Playlists.KhongBuong, i)
        end
    })
end

---------------------------------------------------------
-- TAB 3: MỤC "TÌM EM"
---------------------------------------------------------
TimEmTab:CreateSection("✨ Các Bản Remix / Remake Tìm Em")
for i, song in ipairs(Playlists.TimEm) do
    TimEmTab:CreateButton({
        Name = song.Name,
        Callback = function()
            playSongFromPlaylist(Playlists.TimEm, i)
        end
    })
end

---------------------------------------------------------
-- TAB 4: MỤC "MASHUP"
---------------------------------------------------------
MashupTab:CreateSection("🔀 Các Bản Mashup / Beat Tay")
for i, song in ipairs(Playlists.Mashup) do
    MashupTab:CreateButton({
        Name = song.Name,
        Callback = function()
            playSongFromPlaylist(Playlists.Mashup, i)
        end
    })
end

---------------------------------------------------------
-- TAB 5: MỤC "CÓ CÔNG MÀI SẮC"
---------------------------------------------------------
CoCongMaiSacTab:CreateSection("🔨 Các Bản Remix / Remake Có Công Mài Sắc")
for i, song in ipairs(Playlists.CoCongMaiSac) do
    CoCongMaiSacTab:CreateButton({
        Name = song.Name,
        Callback = function()
            playSongFromPlaylist(Playlists.CoCongMaiSac, i)
        end
    })
end

---------------------------------------------------------
-- TAB 6: MỤC "NHẠC TRUNG REMIX"
---------------------------------------------------------
NhacTrungTab:CreateSection("🇨🇳 Các Bản Nhạc Trung Remix")
for i, song in ipairs(Playlists.NhacTrung) do
    NhacTrungTab:CreateButton({
        Name = song.Name,
        Callback = function()
            playSongFromPlaylist(Playlists.NhacTrung, i)
        end
    })
end
