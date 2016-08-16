local _, iLFRD = ...
local function setBosses(dungeonID)
	local bosses = 'error: no data found'
	if iLFRD.encounters[dungeonID] then
		bosses = ''
		for _,orderInInstance in ipairs(iLFRD.encounters[dungeonID]) do
			local boss,_,saved = GetLFGDungeonEncounterInfo(dungeonID, orderInInstance)
			bosses = bosses .. (saved and '\124cffFF1919' or '') .. boss .. '\124r\n'
		end
	end
	RaidFinderQueueFrameScrollFrameChildFrameDescription:SetText(bosses)
	RaidFinderQueueFrameScrollFrameChildFrameEncounterList:Hide()
end

hooksecurefunc('RaidFinderQueueFrame_SetRaid', setBosses)

local function onShow(encounterList)
	C_Timer.After(0.05, function()
		setBosses(RaidFinderQueueFrameSelectionDropDown.selectedValue)
	end)
end

RaidFinderQueueFrameSelectionDropDown:HookScript('OnShow', onShow)