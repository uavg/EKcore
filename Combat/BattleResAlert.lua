local BattleResAlert = CreateFrame("Frame")

BattleResAlert:SetScript("OnEvent",function(a,b,c,event, d,e,sourceName, f,g,h,destName, i,j,spellId)
	if (((spellId == 95750) or (spellId == 20484) or (spellId == 113269)
	or (spellId == 61999) or (spellId == 126393))
	and (event == "SPELL_CAST_SUCCESS") and (destName == UnitName("player")))
	then
		DEFAULT_CHAT_FRAME:AddMessage("已被"..sourceName.."戰復")
		PlaySound("ReadyCheck", "Master")
	end
	
end)

BattleResAlert:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
--DEFAULT_CHAT_FRAME:AddMessage("BattleResAlert loaded")