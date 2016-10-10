local fixf=CreateFrame("frame")
fixf:RegisterEvent("VARIABLES_LOADED")
fixf:RegisterEvent("ADDON_LOADED")
---可以發送神器上的特質與聖物到聊天
function fixf:ADDON_LOADED__ArtifactRelicSlot(...)
	if ... == "Blizzard_ArtifactUI" then
		hooksecurefunc(ArtifactFrame.PerksTab.TitleContainer,"OnRelicSlotClicked",function(self,slot)
			if IsModifiedClick() and slot.relicLink then
				HandleModifiedItemClick(slot.relicLink);
			end
		end)
		hooksecurefunc(ArtifactPowerButtonMixin,"OnClick",function(self)
			if ( IsModifiedClick("CHATLINK") ) then
				local spellid = C_ArtifactUI.GetPowerInfo(self:GetPowerID())
				local spellLink = GetSpellLink(spellid)
				if (spellLink ) then
					ChatEdit_InsertLink(spellLink);
				end
			end
		end)
	end
end

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
