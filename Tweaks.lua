-- 強制載入CVAR，適用於無法正確套用的設定
--[[
CVAR = CreateFrame("Frame") 
CVAR:RegisterEvent("PLAYER_ENTERING_WORLD") 
CVAR:SetScript("OnEvent", function(self, event) 
	self:UnregisterEvent("PLAYER_ENTERING_WORLD") 
	SetCVar("cameraDistanceMaxFactor", 2.6) 
end)
]]--

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

--字體描邊.....還是算了不用
--[[
RaidWarningFrame.slot1:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
RaidWarningFrame.slot2:SetFont(STANDARD_TEXT_FONT, 32, "OUTLINE")
RaidBossEmoteFrame.slot1:SetFont(STANDARD_TEXT_FONT, 40, "OUTLINE")
RaidBossEmoteFrame.slot2:SetFont(STANDARD_TEXT_FONT, 40, "OUTLINE")
]]--

-- 關閉大地圖自身TOOLTIP
WorldMapPlayerUpper:EnableMouse(false)
WorldMapPlayerLower:EnableMouse(false)

-- 自動啟用快捷列(只在登入時生效，重載無效)
SetActionBarToggles(1, 1, 1, 1)

-- 反向清理背包
SetSortBagsRightToLeft(true)

-- 反向放置戰利品
--SetInsertItemsLeftToRight(true)

-- 脫戰後釋放記憶體
--[[local F = CreateFrame("Frame") 
F:RegisterEvent("PLAYER_REGEN_ENABLED") 
F:SetScript("OnEvent", function() _G.collectgarbage("collect") end)
]]--

-- 延伸版
--[[local eventcount = 0
local Garbage = CreateFrame("Frame")
Garbage:RegisterAllEvents()
Garbage:SetScript("OnEvent", function(self, event)
	eventcount = eventcount + 1

	if (InCombatLockdown() and eventcount > 25000) or (not InCombatLockdown() and eventcount > 10000) or event == "PLAYER_ENTERING_WORLD" then
		collectgarbage("collect")
		eventcount = 0
	end
end)]]--

-- 任務字體放大: 標題/描述/目標/內容
QuestTitleFont:SetFont(STANDARD_TEXT_FONT, 18)
QuestFont:SetFont(STANDARD_TEXT_FONT, 18)
QuestFontNormalSmall:SetFont(STANDARD_TEXT_FONT, 18)
QuestFontHighlight:SetFont(STANDARD_TEXT_FONT, 18)

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

-- 隱藏當每次打開大地圖時角色標記周圍的提示特效
local ping = WorldMapPing
ping:SetScript("OnShow", ping.Hide)

-- 重載介面
SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

-- 一鍵切天賦 
-- 其實不太需要了，除非把專精順序都背起來
-- 或者用GetSpecializationInfo() print出來第二個值是專精名字
SlashCmdList["S1"] = function() SetSpecialization(1) print("切換第一專精...") end
SLASH_S11 = "/s1"
SlashCmdList["S2"] = function() SetSpecialization(2) print("切換第二專精...") end
SLASH_S21 = "/s2"
SlashCmdList["S3"] = function() SetSpecialization(3) print("切換第三專精...") end
SLASH_S31 = "/s3"
SlashCmdList["S4"] = function() SetSpecialization(4) print("切換第四專精...") end
SLASH_S41 = "/s4"

-- 座騎的特殊動作
SlashCmdList["MOUNTSP"] = function() 
	if (GetUnitSpeed("player") == 0) then
		DoEmote("MOUNTSPECIAL")
	end
end
SLASH_MOUNTSP1 = "/ms"

-- 準備確認
SlashCmdList["READYCHECKSLASHRC"] = function() DoReadyCheck() end
SLASH_READYCHECKSLASHRC1 = "/rc"

-- 角色職責確認
SlashCmdList["CHECKROLE"] = function() InitiateRolePoll() end
SLASH_CHECKROLE1 = "/cr"

-- 離開隊伍
SlashCmdList["LG"] = function() LeaveParty() end
SLASH_LG1 = "/lg"

-- 重置副本
SlashCmdList["DGR"] = function() ResetInstances() end
SLASH_DGR1 = "/dgr"

-- GM
SlashCmdList["GM"] = function()	ToggleHelpFrame() end
SLASH_GM1 = "/gm";

-- 地城傳送
SlashCmdList["DGT"] = function()
	local inInstance, _ = IsInInstance()
	if inInstance then LFGTeleport(true);
	else LFGTeleport();
	end
end
SLASH_DGT1 = "/dgt"

--  輸入/bn直接發送通告 
function SlashCmdList.BN(msg, editbox)
  BNSetCustomMessage(msg)
end
SLASH_BN1 = "/bn"

-- 團隊轉小隊 /rtp
SlashCmdList["RAIDTOPARTY"] = function()
	if not IsInRaid() then
		print("不在團隊中")
	elseif GetNumGroupMembers() <= MEMBERS_PER_RAID_GROUP then
		ConvertToParty()
		print("轉換為小隊")
	else
		print("無法轉換")
	end
end
SLASH_RAIDTOPARTY1 = "/rtp"

-- 小隊轉團隊 /ptr
SlashCmdList["PARTYTORAID"] = function()
	if IsInRaid() then
		print("已在團隊中")
	elseif (IsInGroup() and not IsInRaid()) then
		ConvertToRaid()
		print("轉換為團隊")
	else
		print("不在隊伍中")
	end
end
SLASH_PARTYTORAID1 = "/ptr"

-- 解散隊伍
local GroupDisband = function()
	local pName = UnitName("player")
	if IsInRaid() then
	SendChatMessage("Disbanding group.正在解散隊伍。", "RAID")
		for i = 1, GetNumGroupMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= pName then
				UninviteUnit(name)
			end
		end
	else
		SendChatMessage("Disbanding group.正在解散隊伍。", "PARTY")
		for i = MAX_PARTY_MEMBERS, 1, -1 do
			if (UnitExists("party"..i)) then
				UninviteUnit(UnitName("party"..i))
			end
		end
	end
	LeaveParty()
end
StaticPopupDialogs["DISBAND_RAID"] = {
	text = "確定要解散隊伍？",
	button1 = YES,
	button2 = NO,
	OnAccept = GroupDisband,
	timeout = 0,
	whileDead = 1,}
SlashCmdList["GROUPDISBAND"] = function()
	StaticPopup_Show("DISBAND_RAID")
end
SLASH_GROUPDISBAND1 = "/rd"

-- 五人副本模式切換 
SlashCmdList["DGFIVE"] = function() SetDungeonDifficultyID(1) end
SLASH_DGFIVE1 = "/5n"
SlashCmdList["DGHERO"] = function() SetDungeonDifficultyID(2) end
SLASH_DGHERO1 = "/5h"
SlashCmdList["DGMYTH"] = function() SetDungeonDifficultyID(23) end
SLASH_DGMYTH1 = "/5m"

-- 舊團隊副本模式切換 
-- 存在問題
SlashCmdList["RAIDTENMAN"] = function() SetRaidDifficultyID(3) end
SLASH_RAIDTENMAN1 = "/10n"
SlashCmdList["RAIDTENHERO"] = function() SetRaidDifficultyID(5) end
SLASH_RAIDTENHERO1 = "/10h"
SlashCmdList["RAIDTFMAN"] = function() SetRaidDifficultyID(4) end
SLASH_RAIDTFMAN1 = "/25n"
SlashCmdList["RAIDTFHERO"] = function() SetRaidDifficultyID(6) end
SLASH_RAIDTFHERO1 = "/25h"

-- 團隊副本模式切換
SlashCmdList["FLEXNORMAL"] = function() SetRaidDifficultyID(14) end
SLASH_FLEXNORMAL1 = "/nm"
SlashCmdList["FLEXHERO"] = function() SetRaidDifficultyID(15) end
SLASH_FLEXHERO1 = "/hm"
SlashCmdList["MYTH"] = function() SetRaidDifficultyID(16) end
SLASH_MYTH1 = "/mm"

-- 離開pvp場地
SlashCmdList["BG"] = function()
	local _,bgtype = IsInInstance()
	if bgtype == "arena" or bgtype == "pvp" then
		if bgtype == "pvp" then 
			bgtype = "battleground"
		elseif bgtype == "arena" then 
			if (select(2, IsActiveBattlefieldArena())) then 
				bgtype = "rated arena match" 
			else 
				bgtype = "arena skirmish" 
			end
		end
		StaticPopupDialogs["LeaveBattleField"] = {
			text = "確定要離開戰場？", 
			button1 = "Yes", 
			button2 = "No",
			timeout = 0,
			whileDead = 1, 
			hideOnEscape = 1, 
			OnAccept = function() LeaveBattlefield() end,
			OnCancel = function() end,
		}
		StaticPopup_Show("LeaveBattleField")
	end
end
SLASH_BG1 = "/lbg"


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