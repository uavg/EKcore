if not Blizzard_GarrisonUI then LoadAddOn("Blizzard_GarrisonUI") end

local myname, ns = ...


local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
local function RemoveFollower(followerID)
	for i,frame in pairs(MissionPage.Followers) do
		if frame.info and frame.info.followerID == followerID then
			return GarrisonMissionFrame:RemoveFollowerFromMission(frame, true)
		end
	end
end


local orig = GarrisonFollowerListButton_OnClick
function GarrisonFollowerListButton_OnClick(self, button, ...)
	if MissionPage:IsVisible() and MissionPage.missionInfo and button == "RightButton" then
		if not self.info.status then
			return MissionPage:AddFollower(self.id)
		elseif self.info.status == GARRISON_FOLLOWER_IN_PARTY then
			return RemoveFollower(self.id)
		end
	end

	return orig(self, button, ...)
end
