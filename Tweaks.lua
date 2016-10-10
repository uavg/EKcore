-- 強制載入CVAR，適用於無法正確套用的設定
CVAR = CreateFrame("Frame") 
CVAR:RegisterEvent("PLAYER_ENTERING_WORLD") 
CVAR:SetScript("OnEvent", function(self, event) 
	self:UnregisterEvent("PLAYER_ENTERING_WORLD") 
	-- 最遠視距(雖然hf從1.9上修到2.6但遊戲內會無法正確保存)
	SetCVar("cameraDistanceMaxFactor", 2.6) 
	-- 自動啟用快捷列(只在登入時生效，重載無效)
	SetActionBarToggles(1, 1, 1, 1)
	-- 關閉大地圖自身TOOLTIP
	WorldMapPlayerUpper:EnableMouse(false)
	WorldMapPlayerLower:EnableMouse(false)
	-- 反向清理背包
	SetSortBagsRightToLeft(true)
	-- 反向放置戰利品
	--SetInsertItemsLeftToRight(true)
	-- 任務字體放大: 標題/描述/目標/內容
	QuestTitleFont:SetFont(STANDARD_TEXT_FONT, 18)
	QuestFont:SetFont(STANDARD_TEXT_FONT, 18)
	QuestFontNormalSmall:SetFont(STANDARD_TEXT_FONT, 18)
	QuestFontHighlight:SetFont(STANDARD_TEXT_FONT, 18)
end)

-- 另一種寫法
--[[
local function defaultcvar() 
	SetCVar("cameraDistanceMaxFactor", 2.6)
end 

local frame = CreateFrame("FRAME", "defaultcvar")
	frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		local function eventHandler(self, event, ...) 
			defaultcvar() 
end 
frame:SetScript("OnEvent", eventHandler)
]]--

-- 禁用團隊框架
--[[
function EventFrame:PLAYER_ENTERING_WORLD()
if not Blizzard_CompactRaidFrames then LoadAddOn("Blizzard_CompactRaidFrames") end
CompactRaidFrameManager:UnregisterAllEvents()
CompactRaidFrameManager:Hide()
CompactRaidFrameContainer:UnregisterAllEvents()
CompactRaidFrameContainer:Hide()
EventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
end
]]--

-- 看動畫時開啟聲音，看完關掉
--[[
function Augmento.CINEMATIC_START(boolean)
   SetCVar('Sound_EnableMusic', 1)
   SetCVar('Sound_EnableAmbience', 1)
   SetCVar('Sound_EnableSFX', 1)
end

function Augmento.CINEMATIC_STOP()
   SetCVar('Sound_EnableMusic', 0)
   SetCVar('Sound_EnableAmbience', 1)
   SetCVar('Sound_EnableSFX', 1)
end
]]--

-- 團隊警告與首領表情的字體描邊
--[[
RaidWarningFrame.slot1:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
RaidWarningFrame.slot2:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
RaidBossEmoteFrame.slot1:SetFont(STANDARD_TEXT_FONT, 40, "OUTLINE")
RaidBossEmoteFrame.slot2:SetFont(STANDARD_TEXT_FONT, 40, "OUTLINE")
]]--

-- 脫戰後釋放記憶體
--[[
local F = CreateFrame("Frame") 
F:RegisterEvent("PLAYER_REGEN_ENABLED") 
F:SetScript("OnEvent", function() _G.collectgarbage("collect") end)
]]--

-- 延伸版，滿25000個事件清理記憶體
--[[
local eventcount = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1

	if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)]]--

-- 簡易防暫離：坐下時會抽出武器站起來
--[[
local F = CreateFrame("frame")
local T = 0
F:SetScript("OnUpdate",function() 
	local t=GetTime()
		if t-T>0 and GetSheathState()==1 then
		ToggleSheath()
		T=t
		end 
end)
]]--

-- 過濾未學會的
--C_ToyBox.SetUncollectedShown(false)
--C_MountJournal.SetCollectedFilterSetting(2)
--C_PetJournal.SetFilterChecked(2)
--C_Heirloom.GetUncollectedHeirloomFilter(2)
--C_TransmogCollection.SetUncollectedShown(false)

-- 過濾密語時的忙碌或暫離回復
--ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", function(msg) return true end)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", function(msg) return true end)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_NOTICE", function(msg) return true end)
ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", function(msg) return true end)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", function(msg) return true end)

-- 刪除物品時自動輸入delete給你確認
hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"],"OnShow",function(boxEditor)
boxEditor.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) end)

-- 隱藏當每次打開大地圖時角色標記周圍的提示特效
local ping = WorldMapPing
ping:SetScript("OnShow", ping.Hide)

-- 左鍵roll 右鍵舔
local roll = CreateFrame("Button", "rollMacro", UIParent, "SecureActionButtonTemplate")
roll:SetAttribute("type", "macro")
roll:SetAttribute("macrotext", "/roll")
roll:SetScript("OnMouseDown", function(self, button) 
      if InCombatLockdown() then return end
      --if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and button == "RightButton" then
	  --DoReadyCheck()
      if  button == "RightButton" then
	  DoEmote("lick", "target")
      end	  
   end)
roll:SetPoint("BOTTOM",UIParent,"BOTTOMLEFT", 25, 5)

roll:SetSize(25,25) -- 大小
roll.t = roll:CreateTexture()
roll.t:SetAllPoints()
roll.t:SetTexture("Interface\\Buttons\\UI-GroupLoot-Dice-Up")

-- 左鍵餓 右鍵吃
--[[local food = CreateFrame("Button", "food", UIParent, "SecureActionButtonTemplate")
food:SetScript("OnMouseDown", function(self, button) 
      if InCombatLockdown() then return end
	  if  button == "LeftButton" then
	  DoEmote("eat")
      end
      if  button == "RightButton" then
	  DoEmote("hungry", "target")
      end	  
   end)
food:SetPoint("BOTTOM",UIParent,"BOTTOMLEFT", 440, 5)

food:SetSize(25,25) -- 大小
food.t = food:CreateTexture()
food.t:SetAllPoints()
food.t:SetTexture("Interface\\Buttons\\UI-GroupLoot-Coin-Up")]]--