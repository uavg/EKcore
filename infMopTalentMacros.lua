----------------------------------------------
-- infMopTalentMacros
----------------------------------------------

local EditMacro = EditMacro
local GetSpellInfo = GetSpellInfo
local GetTalentInfo = GetTalentInfo

local function OnEvent(self, event, ...)
	if InCombatLockdown() then return end
	for t=1, 7 do --tier
		for c=1, 3 do --column
			local _, name, texture, selected = GetTalentInfo(t, c, 1)
			local icon = "INV_Misc_QuestionMark"
			if texture and not GetSpellInfo(name) then
				icon = texture:lower():gsub("interface\\icons\\", "")
			end
			if selected then
				EditMacro("TIER_"..t, nil, icon, "#showtooltip\n/cast "..name)
			end
		end
	end
end

local infMopTalentMacros = CreateFrame("Frame")
infMopTalentMacros:RegisterEvent("PLAYER_TALENT_UPDATE")
infMopTalentMacros:SetScript("OnEvent", OnEvent)