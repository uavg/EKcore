local SayMassRez = CreateFrame("Frame")

SayMassRez:SetScript("OnEvent",function(_,_,_,event, _,_,sourceName, _,_,_,_,_,_,spellId)
	if ((spellId == 212040) or (spellId == 212051) or (spellId == 212036) or (spellId == 212048) or (spellId == 212056)
	and (event  == "SPELL_CAST_START")
	and (UnitInRaid(sourceName) or UnitInParty(sourceName)))
	then
		local num, group = GetNumGroupMembers(), "raid"
			if (not IsInRaid()) then
				group = "party"
			end
		DEFAULT_CHAT_FRAME:AddMessage("Mass Rez Detected ["..sourceName.."]")
		SendChatMessage(">> Mass Rez/群復 cast by ["..sourceName.."]", IsInRaid(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or group)
		
	end
end)


SayMassRez:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
--DEFAULT_CHAT_FRAME:AddMessage("SayMassRez loaded")
