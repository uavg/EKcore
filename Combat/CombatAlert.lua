﻿local _, ns = ...
--如需要显示中文，请注意文件编码格式UTF-8
ns.setting = {
	EnableCombat = true,		--开启进入/脱离战斗提示
	EnableHealth = true,		--开启低血量报警提示
	EnableMana = true,			--开启低魔法报警提示
	EnableInterrupt = false,	--开启打断提示
	EnableExecute = true,		--开启斩杀提示
	OnlyShowBoss = false,		--仅显示Boss的斩杀提示
	AutoThreshold = true,		--根据职业自动判断斩杀阶段
	ExecuteThreshold = 0.2,	--斩杀阶段血量
}

ns.texts = {
	EnterCombat = {
		"LEEROOOOOOOOY JEEEENKIIIIIIIIIIINS!",
		},
	LeaveCombat = {
		"At least I have chicken.",
		},
	ExecutePhase = {
		"斬殺！",
		},
	Hplow = {
		"血量過低！",
		},
	Mplow = {
		"OOM!",
		},
}

ns.class = {
	["WARRIOR"] = { 0.2, 0.2, 0}, --每个职业每个天赋的斩杀阶段血量，统计可能不准确，0即为不显示，3个数字依次是3系天赋
	["DRUID"] = { 0, 0.25, 0.25,0},
	["PALADIN"] = { 0.2, 0.2, 0.35},
	["PRIEST"] = { 0, 0, 0.25},
	["DEATHKNIGHT"] = { 0, 0.35, 0},
	["WARLOCK"] = { 0.25, 0.25, 0.25},
	["ROGUE"] = { 0.35, 0, 0},
	["HUNTER"] = { 0.2, 0.2, 0.2},
	["MAGE"] = { 0.2, 0.35, 0.2},
	["SHAMAN"] = { 0, 0, 0},
	["MONK"] = { 0, 0, 0},
	["DEMONHUNTER"] = { 0, 0, 0},
}

local MyAddon = CreateFrame("Frame")
local imsg = CreateFrame("Frame", "CombatAlert")
imsg:SetSize(418, 72)
imsg:SetPoint("TOP", 0, -190)
imsg:Hide()
imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.bg:SetPoint('BOTTOM')
imsg.bg:SetSize(326, 103)
imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
imsg.bg:SetVertexColor(1, 1, 1, 0.6)

imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.lineTop:SetPoint("TOP")
imsg.lineTop:SetSize(418, 7)
imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
imsg.lineBottom:SetPoint("BOTTOM")
imsg.lineBottom:SetSize(418, 7)
imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
imsg.text:SetPoint("BOTTOM", 0, 12)
imsg.text:SetTextColor(1, 0.82, 0)
imsg.text:SetJustifyH("CENTER")

CombatAlert:SetScale(0.85)

local flag = 0
ExecuteThreshold =  ns.setting.ExecuteThreshold
local function ShowAlert(texts)
	CombatAlert.text:SetText(texts[math.random(1,table.getn(texts))])
	CombatAlert:Show()
end

local function ShowInterruptAlert(texts,name)
	CombatAlert.text:SetText("打断—"..texts.."—"..name)
	CombatAlert:Show()
end

if ns.setting.EnableCombat then
	MyAddon:RegisterEvent("PLAYER_REGEN_ENABLED")
	MyAddon:RegisterEvent("PLAYER_REGEN_DISABLED")
end
if ns.setting.EnableHealth then
	MyAddon:RegisterEvent("UNIT_HEALTH")
end
if ns.setting.EnableMana then
	MyAddon:RegisterEvent("UNIT_POWER")
end
if ns.setting.EnableExecute then
	MyAddon:RegisterEvent("UNIT_HEALTH")
	MyAddon:RegisterEvent("PLAYER_TARGET_CHANGED")
end
if ns.setting.AutoThreshold then
	MyAddon:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
	MyAddon:RegisterEvent("PLAYER_ENTERING_WORLD")
end
if ns.setting.EnableInterrupt then
	MyAddon:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

MyAddon:SetScript("OnEvent", function(self, event, _, subevent, _, _, sourceName, _, _, _, destName, _, _, _, _, _, spellID, spellName)
	if event == "UNIT_HEALTH" then
		if (UnitName("player") and (UnitHealth("player") / UnitHealthMax("player") < 0.35 and flag == 0 )) then
			ShowAlert(ns.texts.Hplow)
			flag = 1
		elseif (UnitName("target") and UnitCanAttack("player", "target") and not UnitIsDead("target") and ( UnitHealth("target")/UnitHealthMax("target") < ExecuteThreshold ) and flag == 0 ) then
			if ((ns.setting.OnlyShowBoss and UnitLevel("target")==-1) or ( not ns.setting.OnlyShowBoss)) then
				ShowAlert(ns.texts.ExecutePhase)
				flag = 1
			end
		end
	end
	if event == "PLAYER_REGEN_DISABLED" then
		ShowAlert(ns.texts.EnterCombat)
		flag = 0
	elseif event == "PLAYER_REGEN_ENABLED" then
		ShowAlert(ns.texts.LeaveCombat)
		flag = 0
	elseif event == "PLAYER_TARGET_CHANGED" then
		flag = 0
	elseif event == "PLAYER_ENTERING_WORLD" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
				ExecuteThreshold = ns.class[select(2, UnitClass("player"))][GetSpecialization() or 1]
	elseif event == "UNIT_POWER" then
		local t = {[0] = "法力"};
		if (UnitName("player") and (t[UnitPowerType("player")] and (UnitMana("player") / UnitManaMax("player") < 0.35)) and flag == 0 ) then
	  	ShowAlert(ns.texts.Mplow)
			flag = 1
		end
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" and subevent=="SPELL_INTERRUPT" and (sourceName == UnitName("player") or sourceName == UnitName("pet")) then
		ShowInterruptAlert(spellName,destName)
	end
end)

local timer = 0
imsg:SetScript("OnShow", function(self)
	timer = 0
	self:SetScript("OnUpdate", function(self, elasped)
		timer = timer + elasped
		if (timer<0.5) then self:SetAlpha(timer*2) end
		if (timer>1 and timer<1.5) then self:SetAlpha(1-(timer-1)*2) end
		if (timer>=1.5 ) then self:Hide() end
	end)
end)