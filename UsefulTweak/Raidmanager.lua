local wm = CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton 

wm:SetParent("UIParent") 
wm:ClearAllPoints() 
wm:SetPoint("CENTER", UIParent, "CENTER", 282, 35) 
wm:SetSize(18, 18) 
wm:Hide() 

--CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButtonLeft:SetAlpha(0) 
--CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButtonMiddle:SetAlpha(0) 
--CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButtonRight:SetAlpha(0) 

wm:RegisterEvent("GROUP_ROSTER_UPDATE") 
wm:RegisterEvent("ZONE_CHANGED_NEW_AREA") 
wm:HookScript("OnEvent", function(self) 
local raid = GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > 0 
if (raid and (UnitIsGroupLeader (LE_PARTY_CATEGORY_HOME) or UnitIsGroupAssistant(LE_PARTY_CATEGORY_HOME))) or (GetNumSubgroupMembers (LE_PARTY_CATEGORY_HOME) > 0 and not raid) then 
self:Show() 
else 
self:Hide() 
end 
end) 

--[[local wmmenuFrame = CreateFrame("Frame", "wmRightClickMenu", UIParent, "UIDropDownMenuTemplate") 
local wmmenuList = { 
    {text = "准备确认", 
    func = function() DoReadyCheck() end}, 
    {text = "角色检查", 
    func = function() InitiateRolePoll() end}, 
    {text = "转化为团队", 
    func = function() ConvertToRaid() end}, 
    {text = "转化为小队", 
    func = function() ConvertToParty() end}, 
} 

wm:SetScript('OnMouseUp', function(self, button) 
wm:StopMovingOrSizing() 
    if (button=="RightButton") then 
        EasyMenu(wmmenuList, wmmenuFrame, "cursor", -150, 0, "MENU", 2) 
    end 
end)]]--