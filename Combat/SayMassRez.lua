local SayMassRez = CreateFrame("Frame")
local timer = 0

SayMassRez:SetScript("OnEvent",function(_,_,_,event, _,_,sourceName, _,_,_,_,_,_,spellId)
	if ((spellId == 212036) or (spellId == 212040) or (spellId == 212048) or (spellId == 212051) or (spellId == 212056)
	and (event  == "SPELL_CAST_START")
	and (UnitInRaid(sourceName) or UnitInParty(sourceName)))
	then
		DEFAULT_CHAT_FRAME:AddMessage("Mass Rez Detected ["..sourceName.."]")
		
		if (timer < time()) then
			local group, dead = "raid", 0
			if (not IsInRaid()) then
				group = "party"
				if UnitIsDeadOrGhost("player") then
					dead = 1
				end
			end

			for i = 1, GetNumGroupMembers() do
				if UnitIsDeadOrGhost(group..i) then
					dead = dead + 1
				end
			end

			if (dead > 0) then
				SendChatMessage(">> Mass Rez/群復 cast by ["..sourceName.."],"..dead.." rezzable", IsInRaid(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT" or group)
				timer = time() + 10
			end
		end
	end
end)

SayMassRez:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
DEFAULT_CHAT_FRAME:AddMessage("SayMassRez loaded")
