--[[ 預設介面配置 輸入/uiconfig載入 ]]--

local UIcfg = function()
--以下這些設置的巨集應用為 /run SetCVar("cvar", "值") 或/console cvar 值
--要還原預設值為 /run SetCVar("cvar",GetCVarDefault("cvar")) 
--#為遊戲中無選項的設置
--*為遊戲預設值

--[[ 系統 ]]

	--啟用UI縮放，0關
	SetCVar("useUiScale", 0)
	--若上項設為1則此處設置縮放比
	--SetCVar("uiScale", 0.8)
	--啟用進階戰鬥紀錄
	SetCVar("advancedCombatLogging", 1)	 
	
	--#截圖品質(慎改，10最高)
	SetCVar("screenshotQuality", 10)
	--#截圖格式
	--SetCVar("screenshotFormat", "tga")
	--#反和諧
	--SetCVar("overrideArchive", 0)
	--#全螢幕泛光
	SetCVar("ffxGlow", 0)	
	--#*顯示LUA錯誤，0關
	SetCVar("scriptErrors", 1)

	--#*裝備對比，0關
	SetCVar("alwaysCompareItems", 0) 
	--#*進階提示，1開
	SetCVar("UberTooltips", 1)
	--#仇恨百分比
	--SetCVar("threatShowNumeric", 1)
	
	--#使用進階命令，其實無法寫入插件裡，這很危險！
	--SetCVar("AllowDangerousScripts", 1)
	--#框體不顯示即將到來的治療
	SetCVar("predictedHealth", 0)	

--[[ 其他待確認 ]]

	--SetCVar("removeChatDelay", 0)	
	--SetCVar("petStatusText", 0)
	--SetCVar("partyStatusText", 0)
	--SetCVar("targetStatusText", 1)
	--SetCVar("alternateResourceText", 1)
	
--[[ 控制 ]]

	--鎖定目標，1關
	SetCVar("deselectOnClick", 1)
	--*自動解除飛行座騎，0關
	SetCVar("autoDismountFlying", 0) 
	--#自動解除座騎，1開
	SetCVar("autoDismount", 1)
	--自動清除暫離，0關
	SetCVar("autoClearAFK", 0)
	--自動拾取，1開
	SetCVar("autoLootDefault", 1)
	--左鍵進行互動，0關
	SetCVar("interactOnLeftClick", 0)
	--拾取框跟隨滑鼠，1開
	SetCVar("lootUnderMouse", 1)
	
	--#自動打開拾取紀錄，0關
	SetCVar("autoOpenLootHistory", 0)
	--#顯示背包剩餘空間，0關
	SetCVar("displayFreeBagSlots", 0)
	
--[[ 戰鬥 ]]

	--目標的目標，1開
	SetCVar("showTargetOfTarget", 1)
	--*低生命力時不要閃動螢幕，0閃動
	SetCVar("doNotFlashLowHealthWarning", 0)
	--*喪失控制警告，1開
	SetCVar("lossOfControl", 1)
	--*自己的戰鬥文字捲動  
	SetCVar("enableFloatingCombatText", 1)  
	--顯示法術警示的透明程度(默認0.65，0關1最大)
	SetCVar("spellActivationOverlayOpacity", 0.5)
	--*專注施法鍵
	--*自我施法鍵
	--自動自我施法，0關
	SetCVar("autoSelfCast", 0) 
	
	--#施法條於名條/目標
	
	--#協助(/assist)時開啟攻擊，0關
	SetCVar("assistAttack", 0)
	--#切換目標後停止自動攻擊，0關
	SetCVar("stopAutoAttackOnTargetChange", 0)
	--#浮動戰鬥文字逗點，1是有逗點
	SetCVar("breakUpLargeNumbers", 0) 
	--#顯示目標所有的增減益效果，而非只顯示自己的，1開 
	SetCVar("noBuffDebuffFilterOnTarget", 1) 
	
--[[ 浮動戰鬥文字 ]]

	--#浮動戰鬥文字的運動方式，1往上2往下3弧形
	--SetCVar("floatingCombatTextFloatMode", 1)
	--#浮動戰鬥文字的運動方式，0為傳統垂直往上，1為7.0新的運動方式
	SetCVar("floatingCombatTextCombatDamageDirectionalScale", 0)
	--對目標傷害
	SetCVar("floatingCombatTextCombatDamage", 0)  
	--對目標治療
	SetCVar("floatingCombatTextCombatHealing", 0) 

	--以下設定默認都是關閉，要更改設定必需先開啟「自己的戰鬥文字捲動」才能生效
	
	--寵物對目標傷害
	--SetCVar("floatingCombatTextPetMeleeDamage", 0)
	--SetCVar("floatingCombatTextPetSpellDamage", 0)
	
	--對目標上盾
	--SetCVar("floatingCombatTextCombatHealingAbsorbTarget", 0)
	--得盾/護甲提示
	--SetCVar("floatingCombatTextCombatHealingAbsorbSelf", 0)

	--*閃招
	--SetCVar("floatingCombatTextDodgeParryMiss", 0)
	--*傷害減免	
	--SetCVar("floatingCombatTextDamageReduction", 0)
	--周期性傷害
	--SetCVar("floatingCombatTextCombatLogPeriodicSpells", 0)
	--*法術警示
	--SetCVar("floatingCombatTextReactives", 1)
	--他人的控場效果(例如 誘補(xxxx-xxxx))
	--SetCVar("floatingCombatTextSpellMechanics", 1)
	--*聲望變化
	--SetCVar("floatingCombatTextRepChanges", 0)
	--*友方治療者名稱
	SetCVar("floatingCombatTextFriendlyHealers", 1)
	--*進入離開戰鬥
	--SetCVar("floatingCombatTextCombatState", 0)
	--*低MP/低HP，預設1開
	--SetCVar("floatingCombatTextLowManaHealth", 0)  
	--*連擊點
	--SetCVar("floatingCombatTextComboPoints", 0)
	--*能量獲得
	--SetCVar("floatingCombatTextEnergyGains", 0)
	--*周期性能量	
	--SetCVar("floatingCombatTextPeriodicEnergyGains", 0)
	--*榮譽擊殺
	--SetCVar("floatingCombatTextHonorGains", 0)
	--*光環
	--SetCVar("floatingCombatTextAuras", 0)
	
--[[ 顯示 ]]

	--顯著標示，0關
	SetCVar("Outline", 3)
	--團隊醒目標示，圓圈和外框
	SetCVar("findYourselfMode", 1)
	--狀態文字 "NUMERIC", "PERCENT" or "BOTH"
	SetCVar("statusTextDisplay","BOTH") 
	 --對話泡泡	
	--旋轉小地圖，0關
	SetCVar("rotateMinimap", 0)
	--隱藏冒險指南提示(地圖)
	SetCVar("hideAdventureJournalAlerts", 0)
	--教學說明
	SetCVar("showTutorials", 0)
	--#新內容(這並沒有什麼鳥用)
	--SetCVar("showNPETutorials", 0)
	
	--#只在滑鼠移過時顯示數字
	--SetCVar("statusText", 0)
	--#移動時大地圖半透明，1開 
	SetCVar("mapFade", 1)
	--#*接任務後自動追蹤直到完成
	SetCVar("autoQuestWatch", 1)
	--#當你達到一個任務目標時會自動觀察任務5分鐘
	--SetCVar("autoQuestProgress", 1)	
	
--[[ 社交 ]]

	--不當言詞過濾器，0關
	SetCVar("profanityFilter", 0)
	--*濫發訊息過濾器	
	SetCVar("spamFilter", 1)
	--公會成員上下線提示
	SetCVar("guildMemberNotify", 1)
	--*阻止交易，0關
	SetCVar("BlockTrades", 0)
	--阻止公會邀請	
	--*封鎖對話頻道邀請	
	SetCVar("blockChannelInvites", 0)
	--對其他人只顯示角色成就	
	
	--*聊天方式 "im"是以即時通訊方式，"classic"是傳統模式
	SetCVar("chatStyle", "classic")
	--對話時間標記
	SetCVar("showTimestamps", "|cff64C2F5%H:%M:%S|r ") 
	--*新的密語 "inline" "popout_and_inline" "popout"
	SetCVar("whisperMode", "inline")
	--*線上好友
	SetCVar("showToastOnline", 1)
	--*離線好友
	SetCVar("showToastOffline", 1)
	--*公告更新
	SetCVar("showToastBroadcast",0)
	--*好友邀請
	SetCVar("showToastFriendRequest",1)
	--顯示通知視窗
	SetCVar("showToastWindow",0)
	
	--#啟用聊天框鼠標滾輪滑動 現在默認開啟
	--SetCVar("chatMouseScroll", 1)
	--#顯示公會離線成員，0關
	SetCVar("guildShowOffline", 0) 
	
--[[ 快捷列 ]]

	--啟用快捷列	

	--*鎖定，1開
	SetCVar("lockActionBars", 1) 
	--拖曳快捷鍵
	
	--*總是顯示，0關
	SetCVar("alwaysShowActionBars", 0)
	--冷卻計時，0關
	SetCVar("countdownForCooldowns", 0)
	
	--#顯示經驗值數值，1開，0是滑鼠移過顯示
	SetCVar("xpBarText", 1)
	--#技能隊列，開了才能用自定延遲
	--SetCVar("reducedLagTolerance", 1)
	--#自定延遲值，0~400
	--SetCVar("maxSpellStartRecoveryOffset", 100)
	--#按下按鍵時施放技能，1開
	SetCVar("ActionButtonUseKeyDown", 1)
	--#切換技能時觸發保險，1開
	SetCVar("secureAbilityToggle", 1)	 
	
--[[ 名稱 ]]

	--*我的名稱
	SetCVar("UnitNameOwn", 0)
	--*小動物名稱，0關
	SetCVar("UnitNameNonCombatCreatureName", 0)
	
	--npc名稱，1顯示所有，若使用此項則下面都為0
	SetCVar("UnitNameNPC", 1)
	--顯示任務npc，預設只啟用這項
	--SetCVar("UnitNameFriendlySpecialNPCName", 1)
	--顯示可互動NPC名稱
	--SetCVar("UnitNameInteractiveNPC", 1)
	--顯示敵方NPC名稱
	--SetCVar("UnitNameHostleNPC", 1)	
	--*友方玩家
	SetCVar("UnitNameFriendlyPlayerName", 1)
	--*友方僕從，一選項有三個cvar
	SetCVar("UnitNameFriendlyPetName", 1)
	SetCVar("UnitNameFriendlyGuardianName", 1)
	SetCVar("UnitNameFriendlyTotemName", 0)
	--*敵方玩家
	SetCVar("UnitNameEnemyPlayerName", 1)
	--*敵方僕從，一選項有三個cvar
	SetCVar("UnitNameEnemyPetName", 1)
	SetCVar("UnitNameEnemyGuardianName", 1)
	SetCVar("UnitNameEnemyTotemName", 1) 

	--#公會頭銜
	SetCVar("UnitNameGuildTitle", 0)
	--#公會名稱，1開
	--SetCVar("UnitNamePlayerGuild", 1)
	--#姓名板職業顏色
	SetCVar("ShowClassColorInNameplate", 1) 
	
--[[ 單位名條 ]]

	--顯示個人資源
	SetCVar("nameplateShowSelf", 0)
	--顯示目標的特殊資源：智障翻譯，正確的是"在目標姓名板上顯示你的副資源"，不勾選就顯示在畫面中下方的個人資源上)
	SetCVar("nameplateResourceOnTarget", 1)
	--大型名條，預設是1，預設大型名條是1.39寬2.7高
	SetCVar("NamePlateHorizontalScale", 1)
	SetCVar("NamePlateVerticalScale", 3)
	--*總是顯示名條
	SetCVar("nameplateShowAll", 0)
	--*警示目標轉移
	SetCVar("ShowNamePlateLoseAggroFlash", 1)
	--名條排列，1是垂直堆疊
	SetCVar("nameplateMotion", 1)
	--友方單位(shift+v) -僕從
	SetCVar("nameplateShowFriendlyMinions", 0)
	SetCVar("nameplateShowFriendlyPets", 0)
	SetCVar("nameplateShowFriendlyGuardians", 0)
	SetCVar("nameplateShowFriendlyTotems", 0)
	--敵方單位(v) -僕從
	SetCVar("nameplateShowEnemyMinions", 1)
	SetCVar("nameplateShowEnemyPets", 1)
	SetCVar("nameplateShowEnemyGuardians", 1)
	SetCVar("nameplateShowEnemyTotems", 1)
	--*敵方單位(v) -次要
	SetCVar("nameplateShowEnemyMinus", 1)
	
	--#顯示名條的最遠距離，legion默認是60，以前是40
	SetCVar("nameplateMaxDistance", 40)
	--#不讓距離內螢幕外的名條貼邊，預設(0.8,1)
	--SetCVar("nameplateOtherTopInset", -1) 
	--SetCVar("nameplateOtherBottomInset", -1)
	--#隱藏個人資源上醜陋的使用閃光動畫效果
	SetCVar("showSpenderFeedback", 0)

--[[ 鏡頭 ]]

	--水體碰撞
	
	--最遠距離，最大2.6
	SetCVar("CameraDistanceMaxFactor", 2.6)
	--鏡頭跟隨模式，0-永不調整，可選0,1,2,3,4--(1是只調整水平面)
	SetCVar("cameraSmoothStyle", 0)
	
	--#當鏡頭在地上時讓你自由旋轉視角，0關(這是啥?)
	SetCVar("cameraPivot", 0)
	--#鏡頭跟隨地形，爬坡時往上，下坡時往下
	--SetCVar("cameraTerrainTilt", 0)
	
--[[ 滑鼠 ]]

--[[ 協助工具 ]] 

	--*色盲模式，0關
	SetCVar("colorblindMode", 0)
	
--[[ 單位框架 ]]

	--設定無效
	--使用團隊風格的隊伍框架
	--SetCVar("useCompactPartyFrames", 1)
	--隊伍排列
	--SetCVar("raidOptionKeepGroupsTogether", 1)
	--顯示能量條
	--SetCVar("raidFramesDisplayPowerBars", 1)
	--顯示獲得仇恨
	--SetCVar("raidFramesDisplayAggroHighlight", 1)
	--顯示職業顏色
	--SetCVar("raidFramesDisplayClassColor", 1)	
	--顯示寵物
	--SetCVar("raidOptionDisplayPets", 0)
	--顯示主坦與主助攻
	--SetCVar("raidOptionDisplayMainTankAndAssist", 0)
	--顯示邊框
	--SetCVar("raidOptionShowBorders", 0)
	--只顯示可驅散
	--SetCVar("raidFramesDisplayOnlyDispellableDebuffs", 0)
	--HP值
	--SetCVar("raidFramesHealthText", none)
	--大小
	--SetCVar("raidFramesHeight", 45)
	--SetCVar("raidFramesWidth", 90)

--[[ 頻道設定 ]]
	--重置
	FCF_ResetChatWindows()
	ChatFrame_RemoveAllChannels(ChatFrame1)
	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	FCF_OpenNewWindow(RAID)
	ChatFrame_RemoveAllChannels(ChatFrame3)
	ChatFrame_RemoveAllMessageGroups(ChatFrame3)
	FCF_OpenNewWindow(TRADE)
	ChatFrame_RemoveAllChannels(ChatFrame4)
	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	FCF_OpenNewWindow(WHISPER)
	ChatFrame_RemoveAllChannels(ChatFrame5)
	ChatFrame_RemoveAllMessageGroups(ChatFrame5)
	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)
		FCF_SetWindowName(ChatFrame1, GENERAL)
		FCF_SetWindowName(ChatFrame3, "LFW")
		FCF_SetWindowName(ChatFrame4, "TFW")
		FCF_SetWindowName(ChatFrame5, "MSG")
	end
	--全區
	ChatFrame_AddChannel(ChatFrame1, "綜合")
	ChatFrame_AddChannel(ChatFrame4, "交易")
	ChatFrame_AddChannel(ChatFrame4, "本地防務")
	ChatFrame_AddChannel(ChatFrame3, "尋求組隊")
	--對話
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")		
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame1, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame1, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame1, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_WHISPER")	
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame1, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT")
	ChatFrame_AddMessageGroup(ChatFrame1, "INSTANCE_CHAT_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_CONVERSATION")
	--戰鬥
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame1, "SKILL")
	ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame1, "CURRENCY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONEY")
	--戰場
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame1, "BG_NEUTRAL")
	--其他
	ChatFrame_AddMessageGroup(ChatFrame1, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame1, "CHANNEL")
	ChatFrame_AddMessageGroup(ChatFrame1, "TARGETICONS")
	ChatFrame_AddMessageGroup(ChatFrame1, "BN_INLINE_TOAST_ALERT")
	ChatFrame_AddMessageGroup(ChatFrame1, "PET_BATTLE_INFO")
	--怪物
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONSTER_BOSS_WHISPER")	
		
	ChatFrame_AddMessageGroup(ChatFrame4, "COMBAT_XP_GAIN")
	
	ChatFrame_AddMessageGroup(ChatFrame1, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame1, "DND")
	
	ChatFrame_AddMessageGroup(ChatFrame5, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame5, "BN_WHISPER")	
	ChatFrame_AddMessageGroup(ChatFrame5, "BN_CONVERSATION")
	ChatFrame_AddMessageGroup(ChatFrame5, "BN_INLINE_TOAST_ALERT")
	ChatFrame_AddMessageGroup(ChatFrame5, "SYSTEM")
	ChatFrame_AddMessageGroup(ChatFrame5, "IGNORED")
	
--[[ 職業染色 ]]
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "GUILD_OFFICER")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")  
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
--[[ 頻道染色 ]]
	ChangeChatColor("CHANNEL1", 255/255, 192/255, 192/255) --1綜合(預設顏色)
	ChangeChatColor("CHANNEL2", 255/255, 130/255, 130/255) --2交易
	ChangeChatColor("CHANNEL3", 255/255, 192/255, 192/255) --3本地防務
	ChangeChatColor("CHANNEL4", 150/255, 255/255, 185/255) --4組隊(淺綠色)
	ChangeChatColor("CHANNEL5", 255/255, 255/255 ,150/255) --5私人頻道(米黃色)
	ChangeChatColor("CHANNEL6", 180/255, 200/255 ,200/255) --7私人頻道(藍灰色)
	ChangeChatColor("CHANNEL7", 195/255, 180/255 ,225/255) --8私人頻道(淡紫色)
	ChangeChatColor("CHANNEL8", 150/255, 200/255 ,150/255) --8私人頻道(綠色)
	ReloadUI()
end

StaticPopupDialogs.SET_UI = {
		text = "載入預設的介面設定，查看EKcore/Setui",
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept =  function() UIcfg() ReloadUI() end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = true,
		preferredIndex = 5,
}
SLASH_SETUI1 = "/setui"
SLASH_SETUI2 = "/SETUI"
SlashCmdList["SETUI"] = function()
		StaticPopup_Show("SET_UI")
end
	
--[[ 協助選項 ]]
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_LOGIN" then
			print("|cff00ffffEKE|rmini:V7.0.20160809，輸入/uihelp查看指令，/qc查看每日每周任務")
	end
end)

SlashCmdList["UIHELP"] = function() 
	print("重載界面/rl；切換天賦/s#；小地圖右鍵開啟微型選單") 
	print("小地圖中鍵追蹤選單，右鍵微型選單，滾輪放大，alt滾輪地圖放大") 
	print("版本更新請記得重置設定：/console cvar_default")
	print("準備確認/rc；職責檢查/cr")
	print("解散隊伍/rd；離開隊伍/lg；離開pvp地圖/lbg")
	print("小隊團隊切換：/rtp /ptr")
	print("重置副本/dgr；傳送副本/dgt")
	print("自動套用介面設定：/setui")
	print("自動套用BW或DBM設定：/setbw或/setdbm")
	print("切換副本模式/5n /5h /5m /10n /10h /25n /25h /nm /hm /mm")
end
SLASH_UIHELP1 = "/uihelp"
SLASH_UIHELP2 = "/UIHELP"
