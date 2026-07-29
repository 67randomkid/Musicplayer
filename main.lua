-- Script Nghe Nhạc Delta Executor (Đã cập nhật chuẩn thời lượng từ YouTube)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "🎵 Music Player GUI",
   LoadingTitle = "Đang tải Player...",
   LoadingSubtitle = "by Assistant",
   ConfigurationSaving = { Enabled = false }
})

-- Tạo các Tab giao diện
local MainTab = Window:CreateTab("Main", 4483362458)
local KhongBuongTab = Window:CreateTab("Không Buông", 4483362458)
local TimEmTab = Window:CreateTab("Tìm Em", 4483362458)
local MashupTab = Window:CreateTab("Mashup", 4483362458)

-- Tạo Sound Object trong SoundService
local sound = game:GetService("SoundService"):FindFirstChild("DeltaMusicPlayer")
if not sound then
    sound = Instance.new("Sound")
    sound.Name = "DeltaMusicPlayer"
    sound.Volume = 2.5 -- Mặc định 250%
    sound.Looped = true
    sound.Parent = game:GetService("SoundService")
end

local inputUrl = ""
local currentLoadedSource = ""

-- Hàm nạp và phát nhạc mới
local function playAudio(source)
    if source == "" then 
        Rayfield:Notify({Title = "⚠️ Lỗi Link", Content = "Vui lòng dán link MP3 hoặc Asset ID vào ô nhập!"})
        return 
    end
    
    sound:Stop()
    currentLoadedSource = source
    
    if string.sub(source, 1, 4) == "http" then
        local getAsset = custom_asset or getcustomasset
        if not getAsset then
            Rayfield:Notify({Title = "❌ Lỗi Executor", Content = "Delta không hỗ trợ getcustomasset!"})
            return
        end

        Rayfield:Notify({Title = "⏳ Đang nạp nhạc...", Content = "Vui lòng đợi vài giây..."})
        
        local fileName = "song_" .. tostring(os.time()) .. ".mp3"
        
        local success, response = pcall(function()
            return game:HttpGet(source)
        end)
        
        if success and #response > 100000 then
            writefile(fileName, response)
            sound.SoundId = getAsset(fileName)
            sound:Play()
            Rayfield:Notify({Title = "✅ Thành công", Content = "Đang phát bài hát!"})
        else
            Rayfield:Notify({
                Title = "❌ Lỗi nạp nhạc", 
                Content = "Link MP3 bị lỗi hoặc không tải được dữ liệu!",
                Duration = 5
            })
        end
    else
        local id = string.match(source, "%d+")
        if id then
            sound.SoundId = "rbxassetid://" .. id
            sound:Play()
            Rayfield:Notify({Title = "✅ Thành công", Content = "Đang phát ID: " .. id})
        else
            Rayfield:Notify({Title = "❌ Lỗi ID", Content = "Asset ID không hợp lệ!"})
        end
    end
end

---------------------------------------------------------
-- TAB 1: MAIN
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
      playAudio(inputUrl)
   end,
})

MainTab:CreateButton({
   Name = "⏯️ Tiếp tục (Resume)",
   Callback = function()
      if sound.IsPaused then
          sound:Resume()
          Rayfield:Notify({Title = "▶️ Tiếp tục", Content = "Đang phát tiếp bài hát!"})
      elseif not sound.IsPlaying and currentLoadedSource ~= "" then
          sound:Play()
          Rayfield:Notify({Title = "▶️ Phát lại", Content = "Phát lại bài hiện tại!"})
      else
          Rayfield:Notify({Title = "⚠️ Chưa có bài", Content = "Chưa có bài nào được nạp hoặc đang phát!"})
      end
   end,
})

MainTab:CreateButton({
   Name = "⏸️ Tạm dừng",
   Callback = function()
      if sound.IsPlaying then
          sound:Pause()
          Rayfield:Notify({Title = "⏸️ Tạm dừng", Content = "Đã tạm dừng bài hát."})
      end
   end,
})

MainTab:CreateButton({
   Name = "⏹️ Dừng hẳn (Reset)",
   Callback = function()
      sound:Stop()
      currentLoadedSource = ""
      Rayfield:Notify({Title = "⏹️ Dừng hẳn", Content = "Đã reset bài hát về ban đầu."})
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

-- Dòng ghi chú ở cuối Tab Main
MainTab:CreateLabel("⚠️ thời lượng video càng dài thì càng đợi lâu nhé ae=))")

---------------------------------------------------------
-- TAB 2: MỤC "KHÔNG BUÔNG"
---------------------------------------------------------

KhongBuongTab:CreateSection("🔥 Các Bản Remix / Remake Không Buông")

-- Bản 1: KHONG//BUONG prod. HYZØ (3:21)
local LINK_HYZO = "https://files.catbox.moe/zjcbj5.mp3"

KhongBuongTab:CreateButton({
   Name = "🔊 KHONG//BUONG prod. HYZØ (Không Buông x Hoodtrap) [3:21]",
   Callback = function()
      playAudio(LINK_HYZO)
   end,
})

-- Bản 2: Jerk Drill Type Beat Prod DAIFU (2:29)
local LINK_DAIFU = "https://files.catbox.moe/tth698.mp3"

KhongBuongTab:CreateButton({
   Name = "🎹 [FREE] JERK DRILL TYPE BEAT - 'KHÔNG BUÔNG - Hngle ft. Ari' | Prod DAIFU [2:29]",
   Callback = function()
      playAudio(LINK_DAIFU)
   end,
})

-- Bản 3: Jerk Drill Rmx Prod.Hades (3:29)
local LINK_JERK_DRILL = "https://files.catbox.moe/wgxrqm.mp3"

KhongBuongTab:CreateButton({
   Name = "⚡ Hngle - KHÔNG BUÔNG ft. Ari | ( Jerk Drill Rmx ) Prod.Hades [3:29]",
   Callback = function()
      playAudio(LINK_JERK_DRILL)
   end,
})

-- Bản 4: Hoodtrap x Pluggnb (2:58)
local LINK_HOODTRAP = "https://files.catbox.moe/twrr60.mp3"

KhongBuongTab:CreateButton({
   Name = "🎹 KHÔNG BUÔNG - Hngle ft. Ari | hoodtrap x pluggnb [2:58]",
   Callback = function()
      playAudio(LINK_HOODTRAP)
   end,
})

---------------------------------------------------------
-- TAB 3: MỤC "TÌM EM"
---------------------------------------------------------

TimEmTab:CreateSection("✨ Các Bản Remix / Remake Tìm Em")

-- Bản 1: Drill Type Beat Prod DAIFU (3:29)
local LINK_TIM_EM_DAIFU = "https://files.catbox.moe/gon9r1.mp3"

TimEmTab:CreateButton({
   Name = "🎹 [FREE] tìm em.wav - Hngle ft. Bảo Anh | Prod DAIFU - Drill Type Beat [3:29]",
   Callback = function()
      playAudio(LINK_TIM_EM_DAIFU)
   end,
})

-- Bản 2: Remake HoodTrap @THANGNGUYEN-18 (3:48)
local LINK_TIM_EM_HOODTRAP = "https://files.catbox.moe/5vt8zh.mp3"

TimEmTab:CreateButton({
   Name = "🔥 TÌM EM | Hngle ft Bảo Anh remake HoodTrap [3:48]",
   Callback = function()
      playAudio(LINK_TIM_EM_HOODTRAP)
   end,
})

-- Bản 3: Hoodtrap, Jerk Drill Prod LOWTERPER (3:56)
local LINK_TIM_EM_LOWTERPER = "https://files.catbox.moe/6r3i5s.mp3"

TimEmTab:CreateButton({
   Name = "⚡ TÌM EM - Hngle ft Bảo Anh - (HOODTRAP, JERK DRILL) | PROD BY LOWTERPER [3:56]",
   Callback = function()
      playAudio(LINK_TIM_EM_LOWTERPER)
   end,
})

-- Bản 4: Zenzy Remix (4:10)
local LINK_TIM_EM_ZENZY = "https://files.catbox.moe/g2qk7t.mp3"

TimEmTab:CreateButton({
   Name = "🎧 Tìm Em ( Zenzy Remix ) [4:10]",
   Callback = function()
      playAudio(LINK_TIM_EM_ZENZY)
   end,
})

---------------------------------------------------------
-- TAB 4: MỤC "MASHUP"
---------------------------------------------------------

MashupTab:CreateSection("🔀 Các Bản Mashup / Beat Tay")

-- Bản 1: NHAC VIET BEAT TAY #6 - GAZ (18:08)
local LINK_GAZ_BEATTAY = "https://files.catbox.moe/zeh200.mp3"

MashupTab:CreateButton({
   Name = "🎧 NHAC VIET BEAT TAY #6 - GAZ [18:08]",
   Callback = function()
      playAudio(LINK_GAZ_BEATTAY)
   end,
})

-- Bản 2: Tìm Em X Túy Âm (3:07)
local LINK_MASHUP_TUY_AM = "https://files.catbox.moe/pzj4xw.mp3"

MashupTab:CreateButton({
   Name = "🔥 Tìm Em X Túy Âm |Hoodtrap x Drill| [3:07]",
   Callback = function()
      playAudio(LINK_MASHUP_TUY_AM)
   end,
})
