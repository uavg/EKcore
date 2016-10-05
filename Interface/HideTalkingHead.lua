-- if not Blizzard_TalkingHeadUI then LoadAddOn("Blizzard_TalkingHeadUI") end

-- 對話框縮放/移動/隱藏
local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if addon == "Blizzard_TalkingHeadUI" then
		hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
			-- 隱藏框體與聲音
			--TalkingHeadFrame_CloseImmediately()
			-- 只隱藏框體
			TalkingHeadFrame:Hide()
			-- 縮放和位置，啟用這些要把下面的註釋取消
			--TalkingHeadFrame:SetScale(0.7)
			--TalkingHeadFrame:ClearAllPoints()
			--TalkingHeadFrame:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 90)
		end)
		self:UnregisterEvent(event)
	end
end

-- 將對話框錨點與alertframe分離
-- 如果只是移動或縮放就需要這段代碼
--[[hooksecurefunc(AlertFrame, "AddAlertFrameSubSystem", function(self, alertFrameSubSystem)
	if alertFrameSubSystem.anchorFrame == TalkingHeadFrame then
		for i, alertSubSystem in pairs(AlertFrame.alertFrameSubSystems) do
			if alertFrameSubSystem == alertSubSystem then
				tremove(AlertFrame.alertFrameSubSystems, i)
				return 
			end
		end
	end
end)]]--


f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("MODIFIER_STATE_CHANGED")
f:SetScript("OnEvent", f.OnEvent)
