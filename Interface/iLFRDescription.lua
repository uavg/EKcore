local _, iLFRD = ...
local function setBosses(parentFrame,dungeonID)
	if iLFRD.encounters[dungeonID] then
		local bosses = ''
		for _,orderInInstance in ipairs(iLFRD.encounters[dungeonID]) do
			local boss,_,saved = GetLFGDungeonEncounterInfo(dungeonID, orderInInstance)
			bosses = bosses .. (saved and '\124cffFF1919' or '') .. boss .. '\124r\n'
		end
		RaidFinderQueueFrameScrollFrameChildFrameDescription:SetText(bosses)
		RaidFinderQueueFrameScrollFrameChildFrameEncounterList:Hide()
	end
end
hooksecurefunc('LFGRewardsFrame_UpdateFrame', setBosses)