----------------------------------------------
-- infMopTalentMacros
----------------------------------------------

local function OnEvent(self, event, ...)
	if InCombatLockdown() then return end
	local spec = GetActiveSpecGroup()
	for t=1, 7 do --tier
		for c=1, 3 do --column
			local _, name, _, selected = GetTalentInfo(t, c, spec)
			if selected then
				EditMacro("TIER_"..t, nil, "INV_Misc_QuestionMark", "#showtooltip\n/cast "..name)
			end
		end
	end
end

local infMopTalentMacros = CreateFrame("Frame")
infMopTalentMacros:RegisterEvent("PLAYER_TALENT_UPDATE")
infMopTalentMacros:SetScript("OnEvent", OnEvent)