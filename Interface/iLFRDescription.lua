local _, iLFRD = ...
local questMarker = '\124cffFFD100! \124r'
local function setBosses(parentFrame,dungeonID)
	if iLFRD.encounters[dungeonID] then
		local bosses = ''
		for _,v in ipairs(iLFRD.encounters[dungeonID]) do
			for _,questID in pairs(v.q) do
				if GetQuestLogIndexByID(questID) > 0 then
					bosses = bosses .. questMarker
					break
				end
			end
			local boss,_,saved = GetLFGDungeonEncounterInfo(dungeonID, v.i)
			bosses = bosses .. (saved and '\124cffFF1919' or '') .. boss .. '\124r\n'
		end
		RaidFinderQueueFrameScrollFrameChildFrameDescription:SetText(bosses)
		RaidFinderQueueFrameScrollFrameChildFrameEncounterList:Hide()
	end
end
hooksecurefunc('LFGRewardsFrame_UpdateFrame', setBosses)