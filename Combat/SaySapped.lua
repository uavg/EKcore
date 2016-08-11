local SaySapped = CreateFrame("Frame")
SaySapped.playername = UnitName("player")

SaySapped:SetScript("OnEvent", function(_,_,_,event, _,_,sourceName, _,_,_,destName, _,_,spellId)
	if ((spellId == 6770)
	and (destName == SaySapped.playername)
	and (event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH"))
	then
		SendChatMessage("Sapped! 被悶棍了!","SAY")
		DEFAULT_CHAT_FRAME:AddMessage("被悶棍了! Sapped by: "..(sourceName or "(unknown)"))
	end
end)

SaySapped:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
--DEFAULT_CHAT_FRAME:AddMessage("SaySapped loaded")
