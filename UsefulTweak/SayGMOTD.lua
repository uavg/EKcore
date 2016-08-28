GMOTD = "" -- saved variable for offline viewing at WTF\Account\ACCOUNTNAME\RealmName\CharacterName\SayGMOTD.lua

local SayGMOTD = CreateFrame("Frame", nil, UIParent)
SayGMOTD:SetPoint("CENTER", 0, GetScreenHeight()/5)
SayGMOTD:SetWidth(300)
SayGMOTD:SetHeight(65)
SayGMOTD:SetToplevel(true)
SayGMOTD:SetMovable(true)
SayGMOTD:EnableMouse(true)
SayGMOTD:SetScript("OnMouseDown", SayGMOTD.StartMoving)
SayGMOTD:SetScript("OnMouseUp", SayGMOTD.StopMovingOrSizing)
SayGMOTD:SetBackdrop({ 
  bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", 
  edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
  insets = { left = 5, right = 5, top = 5, bottom = 5 }
})

SayGMOTD.button = CreateFrame("Button", nil, SayGMOTD, "UIPanelCloseButton")
SayGMOTD.button:SetPoint("TOPRIGHT", -7, -7)
SayGMOTD.button:SetScript("OnClick", function()
   SayGMOTD:Hide()
end)

SayGMOTD.header = SayGMOTD:CreateFontString(nil, "OVERLAY", "GameFontNormal")
SayGMOTD.header:SetPoint("TOPLEFT", SayGMOTD, "TOPLEFT", 0, -20)
SayGMOTD.header:SetWidth(SayGMOTD:GetRight() - SayGMOTD:GetLeft())
SayGMOTD.header:SetText("Guild Message Of The Day")

SayGMOTD.text = SayGMOTD:CreateFontString(nil, "OVERLAY", "GameFontWhite")
SayGMOTD.text:SetPoint("TOPLEFT", SayGMOTD, "TOPLEFT", 22, -42)
SayGMOTD.text:SetWidth(SayGMOTD:GetRight() - SayGMOTD:GetLeft() - 40)
SayGMOTD.text:SetJustifyH("LEFT")

SayGMOTD:SetScript("OnEvent", function(self, event, arg1)
  if (event == "GUILD_MOTD") then
    GMOTD = arg1
  else
    GMOTD = IsInGuild() and GetGuildRosterMOTD() or ""
  end
  if (GMOTD ~= "") then
    SayGMOTD.text:SetText(GMOTD)
    SayGMOTD:SetHeight(SayGMOTD.text:GetHeight() + 65)
    SayGMOTD:Show()
  else
    SayGMOTD:Hide()
  end
end)

SayGMOTD:RegisterEvent("PLAYER_LOGIN")
SayGMOTD:RegisterEvent("GUILD_MOTD")
DEFAULT_CHAT_FRAME:AddMessage("SayGMOTD loaded")
