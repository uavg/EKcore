-- 重載介面
SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

-- 一鍵切天賦 
-- 其實不太需要了，除非把專精順序都背起來
-- 或者用GetSpecializationInfo() print出來第二個值是專精名字
-- /dump GetSpecializationInfo(數字)	
SlashCmdList["S1"] = function() 
	local specName = select(2, GetSpecializationInfo(1))
	SetSpecialization(1) 
	print("切換"..specName.."專精...") end
SLASH_S11 = "/s1"

SlashCmdList["S2"] = function() 
	local specName = select(2, GetSpecializationInfo(2))
	SetSpecialization(2) 
	print("切換"..specName.."專精...") end
SLASH_S21 = "/s2"

SlashCmdList["S3"] = function() 
	local specName = select(2, GetSpecializationInfo(3))
	SetSpecialization(3) 
	print("切換"..specName.."專精...") end
SLASH_S31 = "/s3"

SlashCmdList["S4"] = function() 
	local specName = select(2, GetSpecializationInfo(4))
	SetSpecialization(4) 
	print("切換"..specName.."專精...") end
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
SLASH_GM1 = "/gm"

-- 地城傳送
SlashCmdList["DGT"] = function()
	local inInstance, _ = IsInInstance()
	if inInstance then LFGTeleport(true)
	else LFGTeleport()
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