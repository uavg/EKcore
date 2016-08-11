local enabled = true
local f = CreateFrame("frame",nil)
f.d = 0

local function AddQueue()
	if (f.d + 1) <= 1 then
		f.d = f.d + 1
		enabled = false
		f:SetScript("OnUpdate",function(self,elapsed)
			f.d = f.d - elapsed
			if f.d < 0 then
				f:SetScript("OnUpdate",nil)
				enabled = true
				f.d = 0
			end
		end)
	else
		return
	end
end

hooksecurefunc("QuestMapLogTitleButton_OnClick", function(self,button)
	if ( IsModifiedClick() ) then
		if enabled then
			AddQueue()
			if IsControlKeyDown() then
				QuestMapQuestOptions_AbandonQuest(self.questID)
				print("|cffffff00放棄任務: "..GetAbandonQuestName())
			elseif IsAltKeyDown() then
				QuestMapQuestOptions_ShareQuest(self.questID)
			end
		end
	end
end)