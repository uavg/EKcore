------------
-- Config --
------------

local POSITION = 'BOTTOM'
local ANCHOR_POINT = 'TOP'
local YOFFSET = 10
-- not implemented yet
-- local SCALE = 1.1
local AlertFramePos = {"CENTER",UIParent,"CENTER",-400,0}

----------
-- Code --
----------

local AlertFrameHolder = CreateFrame('Frame', 'AlertFrameHolder', UIParent)
AlertFrameHolder:SetWidth(180)
AlertFrameHolder:SetHeight(20)
AlertFrameHolder:SetPoint(unpack(AlertFramePos))

local function PostAlertMove(screenQuadrant)
	AlertFrame:ClearAllPoints()
	AlertFrame:SetAllPoints(AlertFrameHolder)
	GroupLootContainer:ClearAllPoints()
	GroupLootContainer:SetPoint(POSITION, AlertFrameHolder, ANCHOR_POINT, 0, YOFFSET)
	if GroupLootContainer:IsShown() then
		GroupLootContainer_Update(GroupLootContainer)
	end
end

local function AdjustAnchors(self, relativeAlert)
	if self.alertFrame:IsShown() then
		self.alertFrame:ClearAllPoints()
		self.alertFrame:SetPoint(POSITION, relativeAlert, ANCHOR_POINT, 0, YOFFSET);
	end
end

local function AdjustQueuedAnchors(self, relativeAlert)
	for alertFrame in self.alertFramePool:EnumerateActive() do
		alertFrame:ClearAllPoints()
		alertFrame:SetPoint(POSITION, relativeAlert, ANCHOR_POINT, 0, YOFFSET);
		relativeAlert = alertFrame
	end
end

local function GroupLootContainer_Update(self)
	local lastIdx = nil

	for i = 1, self.maxIndex do
		local frame = self.rollFrames[i]
		local prevFrame = self.rollFrames[i-1]
		if frame then
			frame:ClearAllPoints()
			if prevFrame then
				frame:SetPoint(POSITION, prevFrame or self, ANCHOR_POINT, 0, YOFFSET)
			else
				frame:SetPoint('CENTER', self, 'BOTTOM', 0, self.reservedSize * (i-1 + 0.5))
			end
			lastIdx = i
		end
	end

	if lastIdx then
		self:SetHeight(self.reservedSize * lastIdx)
		self:Show()
	else
		self:Hide()
	end
end

UIPARENT_MANAGED_FRAME_POSITIONS['GroupLootContainer'] = nil
hooksecurefunc(AlertFrame, 'UpdateAnchors', PostAlertMove)
hooksecurefunc('GroupLootContainer_Update', GroupLootContainer_Update)
hooksecurefunc(AchievementAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors) 		
hooksecurefunc(CriteriaAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors) 			
hooksecurefunc(DungeonCompletionAlertSystem, 'AdjustAnchors', AdjustAnchors) 		
hooksecurefunc(GuildChallengeAlertSystem, 'AdjustAnchors', AdjustAnchors) 			
hooksecurefunc(InvasionAlertSystem, 'AdjustAnchors', AdjustAnchors) 				
hooksecurefunc(ScenarioAlertSystem, 'AdjustAnchors',  AdjustAnchors) 				
hooksecurefunc(WorldQuestCompleteAlertSystem, 'AdjustAnchors', AdjustAnchors) 		
hooksecurefunc(GarrisonBuildingAlertSystem, 'AdjustAnchors',  AdjustAnchors) 		
hooksecurefunc(GarrisonFollowerAlertSystem, 'AdjustAnchors',  AdjustAnchors) 		
hooksecurefunc(GarrisonMissionAlertSystem, 'AdjustAnchors', AdjustAnchors) 			
hooksecurefunc(GarrisonShipMissionAlertSystem, 'AdjustAnchors', AdjustAnchors)		
hooksecurefunc(GarrisonRandomMissionAlertSystem, 'AdjustAnchors', AdjustAnchors)	
hooksecurefunc(GarrisonShipFollowerAlertSystem, 'AdjustAnchors', AdjustAnchors)		
hooksecurefunc(GarrisonTalentAlertSystem, 'AdjustAnchors',  AdjustAnchors) 			
hooksecurefunc(LegendaryItemAlertSystem, 'AdjustAnchors',  AdjustAnchors) 			
hooksecurefunc(LootAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors) 				
hooksecurefunc(LootUpgradeAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors) 		
hooksecurefunc(MoneyWonAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors) 			
hooksecurefunc(StorePurchaseAlertSystem, 'AdjustAnchors', AdjustAnchors) 			
hooksecurefunc(DigsiteCompleteAlertSystem, 'AdjustAnchors', AdjustAnchors) 			
hooksecurefunc(NewRecipeLearnedAlertSystem, 'AdjustAnchors', AdjustQueuedAnchors)	