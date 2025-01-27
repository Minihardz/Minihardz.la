local speedFrame = Instance.new("Frame")
local toggleButton = Instance.new("TextButton")  -- ปุ่มปิดเปิดหน้าต่าง
local speedSlider = Instance.new("Frame")  -- สร้างกรอบสำหรับเลื่อนความเร็ว
local sliderButton = Instance.new("TextButton")  -- ปุ่มเลื่อน
local speedValueLabel = Instance.new("TextLabel")  -- แสดงค่าความเร็ว
local speedCheckButton = Instance.new("TextButton")  -- ปุ่มติ๊กเลือกเพิ่มความเร็ว
local isSpeedActive = false  -- สถานะการเพิ่มความเร็ว

-- สร้าง GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- สร้างกรอบ (Frame) สำหรับหน้าต่าง
speedFrame.Size = UDim2.new(0, 400, 0, 200)
speedFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
speedFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- สีพื้นหลังเหลือง
speedFrame.Visible = true -- ให้เริ่มต้นหน้าต่างเปิด
speedFrame.Parent = screenGui

-- สร้างปุ่มปิดเปิดหน้าต่าง
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0.5, -25, 0.5, -125)
toggleButton.Text = "ปิด"
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleButton.Parent = screenGui -- เปลี่ยนให้เป็น parent ของ screenGui เพื่อให้กดได้ง่ายขึ้น

-- สร้างปุ่มติ๊กเลือกเพิ่มความเร็ว
speedCheckButton.Size = UDim2.new(0, 100, 0, 50)
speedCheckButton.Position = UDim2.new(0.5, -50, 0.15, 0)
speedCheckButton.Text = "เพิ่มความเร็ว"
speedCheckButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
speedCheckButton.Parent = speedFrame

-- สร้างป้ายแสดงค่าความเร็ว
speedValueLabel.Size = UDim2.new(0, 100, 0, 50)
speedValueLabel.Position = UDim2.new(0.5, -50, 0.25, 0)
speedValueLabel.Text = "ความเร็ว: 0"
speedValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
speedValueLabel.Parent = speedFrame

-- สร้างกรอบสำหรับการเลื่อนความเร็ว
speedSlider.Size = UDim2.new(0, 300, 0, 20)
speedSlider.Position = UDim2.new(0.5, -150, 0.45, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
speedSlider.Parent = speedFrame

-- สร้างปุ่มสำหรับเลื่อน
sliderButton.Size = UDim2.new(0, 20, 0, 20)
sliderButton.Position = UDim2.new(0, 0, 0, 0)
sliderButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
sliderButton.Parent = speedSlider

-- ฟังก์ชันปิดและเปิดหน้าต่าง
local isWindowOpen = true  -- ใช้ในการตรวจสอบว่าเปิดหรือปิดอยู่
toggleButton.MouseButton1Click:Connect(function()
    if isWindowOpen then
        speedFrame.Visible = false  -- ปิดหน้าต่าง
        toggleButton.Text = "เปิด"  -- เปลี่ยนข้อความของปุ่ม
    else
        speedFrame.Visible = true  -- เปิดหน้าต่าง
        toggleButton.Text = "ปิด"  -- เปลี่ยนข้อความของปุ่ม
    end
    isWindowOpen = not isWindowOpen  -- สลับสถานะเปิด/ปิด
end)

-- ปรับความเร็วเมื่อเลื่อนปุ่ม
sliderButton.MouseDrag:Connect(function()
    local x = math.clamp(sliderButton.Position.X.Offset, 0, speedSlider.Size.X.Offset - sliderButton.Size.X.Offset)
    sliderButton.Position = UDim2.new(0, x, 0, 0)

    local speed = x / (speedSlider.Size.X.Offset - sliderButton.Size.X.Offset) * 100
    speedValueLabel.Text = "ความเร็ว: " .. math.floor(speed)
end)

-- เมื่อกดปุ่มเพิ่มความเร็ว
speedCheckButton.MouseButton1Click:Connect(function()
    isSpeedActive = not isSpeedActive  -- สลับสถานะเพิ่มความเร็ว

    if isSpeedActive then
        speedCheckButton.Text = "หยุดเพิ่มความเร็ว"
        -- ทำให้ตัวละครวิ่งเร็วขึ้น
        local speed = sliderButton.Position.X.Offset / (speedSlider.Size.X.Offset - sliderButton.Size.X.Offset) * 100
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 + speed  -- เพิ่มความเร็ว
    else
        speedCheckButton.Text = "เพิ่มความเร็ว"
        -- รีเซ็ตความเร็ว
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16  -- ค่าเริ่มต้น
    end
end)
