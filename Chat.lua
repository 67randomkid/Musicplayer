-- Đảm bảo UI không bị trùng lặp khi chạy lại script
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("CustomChatExecutorUI") then
    CoreGui.CustomChatExecutorUI:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomChatExecutorUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 1. Tạo Nút Tròn Bật/Tắt (Toggle Button) - Có thể kéo thả
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleButton.Position = UDim2.new(0.03, 0, 0.45, 0)
ToggleButton.Size = UDim2.new(0, 45, 0, 45)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "💬"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 22

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = ToggleButton

-- 2. Tạo Khung Chat Chính (Main Frame) - Căn giữa màn hình
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 240)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 12)
UICornerFrame.Parent = MainFrame

-- 3. Mở rộng vùng kéo (DragBar) to hơn, dễ bấm và vuốt hơn ở cạnh trên
local DragBar = Instance.new("Frame")
DragBar.Name = "DragBar"
DragBar.Parent = MainFrame
DragBar.BackgroundTransparency = 1 -- Trong suốt nhưng bắt cảm ứng tốt toàn bộ phần trên
DragBar.Size = UDim2.new(1, 0, 0, 35)

-- Vẽ thêm một vạch nhỏ trực quan để nhận diện chỗ cầm kéo
local DragIndicator = Instance.new("Frame")
DragIndicator.Name = "DragIndicator"
DragIndicator.Parent = DragBar
DragIndicator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
DragIndicator.BorderSizePixel = 0
DragIndicator.Position = UDim2.new(0.5, -25, 0, 8)
DragIndicator.Size = UDim2.new(0, 50, 0, 5)

local UICornerBar = Instance.new("UICorner")
UICornerBar.CornerRadius = UDim.new(1, 0)
UICornerBar.Parent = DragIndicator

-- 4. Khung nhập văn bản ở đáy MainFrame
local InputBox = Instance.new("TextBox")
InputBox.Name = "InputBox"
InputBox.Parent = MainFrame
InputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InputBox.Position = UDim2.new(0, 10, 1, -40)
InputBox.Size = UDim2.new(1, -55, 0, 32)
InputBox.Font = Enum.Font.SourceSans
InputBox.PlaceholderText = "Nhập tin nhắn..."
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 14
InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.ClearTextOnFocus = false -- Giữ nguyên chữ khi bấm lại vào ô chat

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 6)
UICornerInput.Parent = InputBox

-- 5. Tạo Nút Gửi (Send Button) kiểu Roblox nằm cạnh ô nhập chat
local SendButton = Instance.new("TextButton")
SendButton.Name = "SendButton"
SendButton.Parent = MainFrame
SendButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
SendButton.Position = UDim2.new(1, -40, 1, -40)
SendButton.Size = UDim2.new(0, 30, 0, 32)
SendButton.Font = Enum.Font.SourceSansBold
SendButton.Text = "➤"
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.TextSize = 16

local UICornerSend = Instance.new("UICorner")
UICornerSend.CornerRadius = UDim.new(0, 6)
UICornerSend.Parent = SendButton

-- 6. Khung hiển thị tin nhắn (Chat Log)
local MessageScroll = Instance.new("ScrollingFrame")
MessageScroll.Name = "MessageScroll"
MessageScroll.Parent = MainFrame
MessageScroll.Active = true
MessageScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MessageScroll.BackgroundTransparency = 1
MessageScroll.Position = UDim2.new(0, 10, 0, 35)
MessageScroll.Size = UDim2.new(1, -20, 1, -80)
MessageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
MessageScroll.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MessageScroll
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- 7. Xử lý logic Đóng / Mở UI
local isOpen = false
local isDraggingBtn = false

ToggleButton.MouseButton1Click:Connect(function()
    if not isDraggingBtn then
        isOpen = not isOpen
        MainFrame.Visible = isOpen
    end
end)

-- 8. Hàm xử lý gửi tin nhắn chung
local function SendMessage()
    if InputBox.Text ~= "" then
        local text = InputBox.Text
        InputBox.Text = ""
        
        local NewMsg = Instance.new("TextLabel")
        NewMsg.Parent = MessageScroll
        NewMsg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        NewMsg.BackgroundTransparency = 0.5
        NewMsg.Size = UDim2.new(1, 0, 0, 25)
        NewMsg.Font = Enum.Font.SourceSans
        NewMsg.Text = " Bạn: " .. text
        NewMsg.TextColor3 = Color3.fromRGB(255, 255, 255)
        NewMsg.TextSize = 14
        NewMsg.TextXAlignment = Enum.TextXAlignment.Left
        
        local CornerMsg = Instance.new("UICorner")
        CornerMsg.CornerRadius = UDim.new(0, 4)
        CornerMsg.Parent = NewMsg
        
        MessageScroll.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
        MessageScroll.CanvasPosition = Vector2.new(0, MessageScroll.CanvasSize.Y)
    end
end

SendButton.MouseButton1Click:Connect(SendMessage)

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        SendMessage()
    end
end)

-- 9. Hàm kéo thả mượt mà cho Nút Tròn và Thanh Kéo Khung Chat
local UserInputService = game:GetService("UserInputService")

local function MakeDraggable(obj, isButton)
    local dragging, dragInput, dragStart, startPos
    local totalMove = 0

    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Parent == MainFrame and MainFrame.Position or obj.Position
            totalMove = 0
            if isButton then isDraggingBtn = false end
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    obj.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            totalMove = math.abs(delta.X) + math.abs(delta.Y)
            
            if totalMove > 5 and isButton then
                isDraggingBtn = true
            end
            
            local target = obj.Parent == MainFrame and MainFrame or obj
            target.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

MakeDraggable(ToggleButton, true)
MakeDraggable(DragBar, false) -- Giờ đây toàn bộ khu vực phía trên đã rộng rãi để kéo
