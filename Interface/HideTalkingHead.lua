-- License: Public Domain

local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if addon == "Blizzard_TalkingHeadUI" then
		hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
			TalkingHeadFrame:Hide()
			--TalkingHeadFrame:SetScale(0.7)
			--TalkingHeadFrame:ClearAllPoints()
			--TalkingHeadFrame:(point, uiparent, Point, x, y)
		end)
		self:UnregisterEvent(event)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)
