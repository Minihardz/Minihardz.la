-- สร้าง GUI ที่จะมีสี่เหลี่ยมและปุ่มสำหรับเลือกผู้เล่นและเตะผู้เล่น
local playerListFrame = Instance.new("Frame")
local kickButton = Instance.new("TextButton")
local playerListDropdown = Instance.new("TextButton")
local playersList = {}  -- จะเก็บรายชื่อผู้เล่นที่อยู่ในเซิร์ฟเวอร์

-- สร้าง GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- สร้างกรอบ (Frame)
playerListFrame.Size = UDim2.new(0, 400, 0, 300)
playerListFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
playerListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- สีพื้นหลังเหลือง
playerListFrame.Parent = screenGui

-- สร้างปุ่มให้เลือกผู้เล่น
playerListDropdown.Size = UDim2.new(0, 200, 0, 50)
playerListDropdown.Position = UDim2.new(0.5, -100, 0.1, 0)
playerListDropdown.Text = "เลือกผู้เล่น"
playerListDropdown.Parent = playerListFrame

-- สร้างปุ่มเตะผู้เล่น
kickButton.Size = UDim2.new(0, 200, 0, 50)
kickButton.Position = UDim2.new(0.5, -100, 0.7, 0)
kickButton.Text = "เตะผู้เล่น"
kickButton.Parent = playerListFrame

-- ฟังก์ชันเตะผู้เล่น
function kickPlayer(playerName)
    local player = game.Players:FindFirstChild(playerName)
    if player then
        player:Kick("คุณถูกเตะออกจากเซิร์ฟเวอร์")
    else
        print("ไม่พบผู้เล่นที่ชื่อ " .. playerName)
    end
end

-- ฟังก์ชันสร้างรายชื่อผู้เล่น
function updatePlayerList()
    playersList = {}  -- เคลียร์รายชื่อก่อน
    for _, player in ipairs(game.Players:GetPlayers()) do
        table.insert(playersList, player.Name)
    end
end

-- สร้างฟังก์ชันในการเลือกผู้เล่นจากรายชื่อ
playerListDropdown.MouseButton1Click:Connect(function()
    updatePlayerList()

    -- สร้างหน้าต่างให้เลือกผู้เล่น
    local playerListFrame = Instance.new("Frame")
    playerListFrame.Size = UDim2.new(0, 200, 0, #playersList * 50)
    playerListFrame.Position = UDim2.new(0.5, -100, 0.2, 0)
    playerListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- สีขาว

    -- แสดงรายชื่อผู้เล่นในหน้าต่างใหม่
    for i, playerName in ipairs(playersList) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, 0, 0, 50)
        playerButton.Position = UDim2.new(0, 0, (i - 1) * 0.1, 0)
        playerButton.Text = playerName
        playerButton.Parent = playerListFrame

        -- เมื่อคลิกที่ชื่อผู้เล่นจะเซ็ตชื่อผู้เล่นที่เลือก
        playerButton.MouseButton1Click:Connect(function()
            -- เมื่อเลือกผู้เล่นแล้วจะใส่ชื่อผู้เล่นในปุ่ม
            playerListDropdown.Text = playerName
            playerListFrame:Destroy()  -- ปิดหน้าต่างเลือกผู้เล่น
        end)
    end

    playerListFrame.Parent = screenGui
end)

-- เมื่อคลิกปุ่มเตะผู้เล่นจะเตะผู้เล่นที่เลือก
kickButton.MouseButton1Click:Connect(function()
    local selectedPlayer = playerListDropdown.Text
    if selectedPlayer ~= "เลือกผู้เล่น" then
        kickPlayer(selectedPlayer)
    else
        print("กรุณาเลือกผู้เล่นก่อน")
    end
end)
