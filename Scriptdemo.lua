repeat task.wait() until game:IsLoaded()
task.wait(1)

-- Intro
loadstring(game:HttpGet("https://raw.githubusercontent.com/newbie0z-lol/intro/refs/heads/main/Protected_5021807968980637.lua"))()
task.wait(9)

-- SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Load Fluent UI
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhTuanDzai-Hub/UIMenu/refs/heads/main/UiTuanAnhDzz"))()

-- Create Main Window
local Window = Fluent:CreateWindow({
    Title = "Rez Hub 💀 | Link Discord: https://discord.gg/J3pZMNdu",
    SubTitle = "by rez",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 320),
    MinimizeKey = Enum.KeyCode.F1
})

-- Tab --
local Tabs = {
    Info = Window:AddTab({ Title = "Tab Info", Icon = "info" }),
    Farming = Window:AddTab({ Title = "Tab Farming", Icon = "leaf" }),
    Setting = Window:AddTab({ Title = "Tab Setting", Icon = "settings" }),
    ChoiDo = Window:AddTab({ Title = "Tab Chơi Đồ", Icon = "rocket" }),
    Pvp = Window:AddTab({ Title = "Tab PvP", Icon = "sword" })
}


-- Tab Info
local function createLinkButton(tab, title, url)
    tab:AddButton({
        Title = title,
        Description = "Nhấn để sao chép link",
        Callback = function()
            setclipboard(url)
            Fluent:Notify({
                Title = "✅ Đã sao chép!",
                Content = title .. " đã được sao chép vào clipboard.",
                Duration = 3
            })
        end
    })
end

Tabs.Info:AddParagraph({
    Title = "⚠️ LƯU Ý",
    Content = "Nhấn phím F1 để ẩn / hiện giao diện Fluent UI.",
})

createLinkButton(Tabs.Info, "📎 Discord", "https://discord.gg/J3pZMNdu")
createLinkButton(Tabs.Info, "📎 Youtube", "https://www.youtube.com/@changbeomientay0")
createLinkButton(Tabs.Info, "📎 Tiktok", "https://www.tiktok.com/@nguyndiz")
createLinkButton(Tabs.Info, "📎 Donate", "https://create.roblox.com/dashboard/creations/experiences/6821163566/passes/1268730242/overview")

-- Tab Farming
local a = Tabs.Farming:AddButton({
	Title = "Chọn Vũ Khí",
	Description = "Vũ Khí Hiện Tại : None",
	Callback = function()
		local weaponButtons = {}
		
		for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			table.insert(weaponButtons, {
				Title = v.Name,
				Callback = function()
					AttackWeapon = v.Name
					print("Vũ khí đã chọn: " .. v.Name)
				end
			})
		end

		-- Thêm nút thoát
		table.insert(weaponButtons, {
			Title = "❌ Thoát",
			Callback = function()
				print("Đã thoát chọn vũ khí.")
			end
		})

		Window:Dialog({
			Title = "Chọn Vũ Khí",
			Content = "Chọn một vũ khí:",
			Buttons = weaponButtons
		})
	end
})

spawn(function()
	while wait(1) do
		if AttackWeapon then
			a:SetDesc("Vũ Khí Hiện Tại : " .. AttackWeapon)
		end
	end
end)


-- Toggle AutoFarm Giang Ho 1 & 2
local Toggle = Tabs.Farming:AddToggle("AutoGiangHo", {Title = "Auto Farm Quái", Default = AutoFarmGiangho })
Toggle:OnChanged(function(Value) AutoFarmGiangho = Value end)

local Toggle2 = Tabs.Farming:AddToggle("AutoGiangHo2", {
    Title = "Auto Farm Boss",
    Default = false
})

Toggle2:OnChanged(function(Value)
    AutoFarmGiangho2 = Value
    if Value then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/newbie0z-lol/bossprt/refs/heads/main/bossprotect.lua"))()
        end)
    end
end)


local UIS = game:GetService("UserInputService")
local RepStorage = game:GetService("ReplicatedStorage")
local KnitInventoryRE = RepStorage:WaitForChild("KnitPackages")["_Index"]["sleitnick_knit@1.7.0"].knit.Services.InventoryService.RE.updateInventory

-- Trang bị vũ khí
function EquipWeapon(ToolSe)
	if not _G.NotAutoEquip and ToolSe then
		local Backpack = game.Players.LocalPlayer.Backpack
		local Character = game.Players.LocalPlayer.Character
		local Tool = Backpack:FindFirstChild(ToolSe)
		if Tool then
			wait(0.1)
			Character.Humanoid:EquipTool(Tool)
		end
	end
end

function Prompt(proximityPrompt)
	task.wait(0.1)
	if proximityPrompt then
		pcall(function()
			proximityPrompt.Enabled = true
			proximityPrompt.HoldDuration = 0
			fireproximityprompt(proximityPrompt, 1, true)
		end)
	end
end

-- Mở túi đồ và lấy "băng gạc"
function UnInventoryWeaponSmart(WE)
	local player = game.Players.LocalPlayer
	local inventoryGUI = player:WaitForChild("PlayerGui"):WaitForChild("Inventory")
	local list = inventoryGUI.MainFrame.List

	-- Mở túi đồ thủ công
	UIS.InputBegan:Fire({KeyCode = Enum.KeyCode.Backquote})
	task.wait(0.5)

	-- Duyệt và tìm item cần
	if list:FindFirstChild(WE) then
		-- Gửi yêu cầu lấy ra
		KnitInventoryRE:FireServer("eue", WE)
	end
end

-- Farm quái
spawn(function()
	while task.wait() do
		if not AutoFarmGiangho or DisableALLautogiangho then continue end

		if (Vector3.new(871, 29, -1423) - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 5000 then
			for _, v in pairs(workspace.CityNPCs.NPCs:GetChildren()) do
				if not AutoFarmGiangho or DisableALLautogiangho then break end
				if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
					repeat task.wait()
						if not AutoFarmGiangho or DisableALLautogiangho then break end
						pcall(function()
							for _, drop in pairs(workspace.CityNPCs.Drop:GetChildren()) do
								local prompt = drop:FindFirstChildWhichIsA("ProximityPrompt")
								if prompt then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = drop.CFrame
									Prompt(prompt)
								end
							end

							local char = game.Players.LocalPlayer.Character
							local root = char:WaitForChild("HumanoidRootPart")

							if char.Humanoid.Health > 40 then
								root.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0) * CFrame.Angles(math.rad(-90), 0, 0)

								if not game.Players.LocalPlayer.Backpack:FindFirstChild(AttackWeapon)
								and not char:FindFirstChild(AttackWeapon) then
									UnInventoryWeaponSmart(AttackWeapon)
									task.wait(1)
								end

								EquipWeapon(AttackWeapon)
								game:GetService("VirtualUser"):CaptureController()
								game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
							else
								root.CFrame = CFrame.new(648.47052, 30.6516953, -349.042572)
								if game.Players.LocalPlayer.Backpack:FindFirstChild("băng gạc") then
									EquipWeapon("băng gạc")
								else
									UnInventoryWeaponSmart("băng gạc")
									task.wait(0.5)
								end
								game:GetService("VirtualUser"):CaptureController()
								game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
							end
						end)
					until not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or not AutoFarmGiangho or DisableALLautogiangho
				end
			end
		end
	end
end)

-- Giữ chuột tấn công liên tục
spawn(function()
	while task.wait() do
		if AutoFarmGiangho and not DisableALLautogiangho then
			game:GetService("VirtualUser"):CaptureController()
			game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
		end
	end
end)


-- Tab Fps --
local fpsLabel -- Để lưu label hiển thị FPS
local fpsConnection -- Kết nối cập nhật FPS

Tabs.Setting:AddToggle("ShowFPS", {
    Title = "🎯 Hiện FPS",
    Default = false,
    Callback = function(state)
        if state then
            -- Tạo FPS Label
            local gui = Instance.new("ScreenGui", game.CoreGui)
            gui.Name = "FPSDisplay"

            fpsLabel = Instance.new("TextLabel", gui)
            fpsLabel.Size = UDim2.new(0, 100, 0, 30)
            fpsLabel.Position = UDim2.new(1, -110, 0, 10)
            fpsLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            fpsLabel.TextColor3 = Color3.new(1, 1, 1)
            fpsLabel.TextSize = 18
            fpsLabel.Text = "FPS: ..."
            fpsLabel.BorderSizePixel = 0
            fpsLabel.BackgroundTransparency = 0.2
            fpsLabel.Font = Enum.Font.SourceSansBold

            -- Hàm cập nhật FPS
            local lastUpdate = tick()
            local frames = 0

            fpsConnection = game:GetService("RunService").RenderStepped:Connect(function()
                frames += 1
                local now = tick()
                if now - lastUpdate >= 1 then
                    local fps = math.floor(frames / (now - lastUpdate))
                    fpsLabel.Text = "FPS: " .. fps
                    lastUpdate = now
                    frames = 0
                end
            end)
        else
            if fpsConnection then
                fpsConnection:Disconnect()
                fpsConnection = nil
            end
            if fpsLabel then
                fpsLabel:Destroy()
                fpsLabel = nil
            end
            local oldGui = game.CoreGui:FindFirstChild("FPSDisplay")
            if oldGui then oldGui:Destroy() end
        end
    end
})


Tabs.Setting:AddButton({
    Title = "⚡ Tăng FPS",
    Description = "Giảm chất lượng đồ họa xuống mức thấp nhất",
    Callback = function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Fluent:Notify({
            Title = "⚡ FPS Boost!",
            Content = "Đã giảm chất lượng đồ họa xuống mức thấp nhất để tăng FPS.",
            Duration = 4
        })
    end
})

Tabs.Setting:AddButton({
    Title = "📶 Tối Ưu Ping",
    Description = "Ẩn hiệu ứng + giảm tải mạng client",
    Callback = function()
        -- Tắt Light và ParticleEmitter
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Light") or v:IsA("Trail") then
                v.Enabled = false
            end
        end

        -- Tắt Shadows và giảm chất lượng Terrain (nếu có)
        if workspace:FindFirstChildOfClass("Terrain") then
            workspace.Terrain.WaterWaveSize = 0
            workspace.Terrain.WaterReflectance = 0
        end

        settings().Rendering.ReloadAssets = true

        Fluent:Notify({
            Title = "📶 Ping Optimization",
            Content = "Đã ẩn hiệu ứng và giảm tải để tối ưu ping.",
            Duration = 4
        })
    end
})


-- Tab Chơi Đồ
Tabs.ChoiDo:AddButton({
    Title = "✈️ Bay Bay",
    Description = "Chạy script bay",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})

Tabs.ChoiDo:AddToggle("HitboxRucRo", {
    Title = "🌟 Hitbox",
    Default = false,
    Callback = function(state)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local char = p.Character
                if char then
                    for _, partName in ipairs({ "Head", "HumanoidRootPart", "Torso" }) do
                        local part = char:FindFirstChild(partName)
                        if part and part:IsA("BasePart") then
                            if state then
                                part.Size = Vector3.new(15, 15, 15)
                                part.Material = Enum.Material.SmoothPlastic
                                part.Color = Color3.fromRGB(255, 255, 255)
                                part.Transparency = 0.8
                                part.Anchored = false
                                part.CanCollide = false
                            else
                                part.Size = Vector3.new(2, 2, 1)
                                part.Material = Enum.Material.Plastic
                                part.Color = Color3.fromRGB(163, 162, 165)
                                part.Transparency = 0
                            end
                        end
                    end
                end
            end
        end
    end
})

local Lighting = game:GetService("Lighting")
local RainbowEffect = false
local RainbowBlur = nil
local RainbowColor = nil

Tabs.ChoiDo:AddToggle("ToggleRainbowEffect", {
    Title = "🌈 Ảo giác cầu vồng",
    Default = false,
    Description = "Hiệu ứng 7 sắc cầu vồng trên màn hình"
}):OnChanged(function(Value)
    RainbowEffect = Value

    if not Value then
        -- Xoá hiệu ứng nếu có
        if RainbowBlur then
            RainbowBlur:Destroy()
            RainbowBlur = nil
        end
        if RainbowColor then
            RainbowColor:Destroy()
            RainbowColor = nil
        end
    end
end)

-- Hiệu ứng đổi màu liên tục
task.spawn(function()
    local hue = 0
    while true do
        task.wait(0.1)

        if RainbowEffect then
            -- Tạo Blur nếu chưa có
            if not RainbowBlur then
                RainbowBlur = Instance.new("BlurEffect")
                RainbowBlur.Size = 8 -- hoặc 12 tuỳ bạn
                RainbowBlur.Name = "RainbowBlur"
                RainbowBlur.Parent = Lighting
            end

            -- Tạo ColorCorrection nếu chưa có
            if not RainbowColor then
                RainbowColor = Instance.new("ColorCorrectionEffect")
                RainbowColor.Name = "RainbowColor"
                RainbowColor.Saturation = 1
                RainbowColor.Contrast = 0.2
                RainbowColor.Parent = Lighting
            end

            -- Đổi màu cầu vồng liên tục
            hue = (hue + 3) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            RainbowColor.TintColor = color
        end
    end
end)

local Toggle3 = Tabs.Pvp:AddToggle("Script PvP", {
    Title = "Script PvP",
    Default = false 
})

Toggle3:OnChanged(function(Value)
    if Value then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/newbie0z-lol/ba-san-protect/refs/heads/main/pvpprotect.lua"))()
        end)
    end
end)

-- Tạo nút Toggle cho mobile
local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 120, 0, 40)
toggleBtn.Position = UDim2.new(1, -130, 1, -50)
toggleBtn.AnchorPoint = Vector2.new(0, 1)
toggleBtn.Text = "👁️ Toggle UI"
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
toggleBtn.Parent = playerGui

local corner = Instance.new("UICorner", toggleBtn)
corner.CornerRadius = UDim.new(0, 8)

-- Logic Toggle
toggleBtn.MouseButton1Click:Connect(function()
	Window.Instance.Visible = not Window.Instance.Visible
end)
