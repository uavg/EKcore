local fixf=CreateFrame("frame")
fixf:RegisterEvent("VARIABLES_LOADED")
fixf:RegisterEvent("ADDON_LOADED")
---whoframe的等級字體
local fontscale_who = 12
for i=1, WHOS_TO_DISPLAY do
	_G["WhoFrameButton"..i.."Level"]:SetFont(_G["WhoFrameButton"..i.."Level"]:GetFont(),fontscale_who);
end
---公會的等級字體
local fontscale_guild = 13
function fixf:ADDON_LOADED__GuildRoster(...)
	if ... == "Blizzard_GuildUI" then
		hooksecurefunc("GuildRosterButton_SetStringText",function(buttonString, text)
			buttonString:SetFont(buttonString:GetFont(),tonumber(text) and fontscale_guild or 15);
		end)
	end
end

fixf:SetScript("OnEvent",function(self,event,...)
	for fname,func in pairs(fixf) do
		if type(fname)=="string" and fname:find(event.."__") then
			func(self, ...)
		end
	end
end)
