


local GBLnametexts = {}
local GBLilvltexts = {}
local GBLtypetexts = {}
local GBLpricetexts = {}
local GBLcounttexts = {}

local gbl = CreateFrame("ScrollFrame", "GBLScrollFrame", GuildBankFrame, "UIPanelScrollFrameTemplate")
	gbl:SetWidth(694)
	gbl:SetHeight(279)
	--gbl:SetPoint("LEFT", 30, -20)
	gbl:SetPoint("LEFT", 15, -15)
local scrollchild = CreateFrame("Frame", "GBLScrollChild", gbl)
	scrollchild:SetPoint("TOPLEFT")
	scrollchild:SetWidth(685)
	scrollchild:SetHeight(750)
	scrollchild:EnableMouse(true)
	gbl:SetScrollChild(scrollchild)
local nametitle = gbl:CreateFontString(nil,nil,"GameFontNormalLeft")
	nametitle:SetPoint("BOTTOMLEFT", gbl, "TOPLEFT", 90, 10)
	nametitle:SetHeight(20)
	nametitle:SetWidth(100)
	nametitle:SetText("Item")
local ilvltitle = gbl:CreateFontString(nil,nil,"GameFontNormal")
	ilvltitle:SetFont("Fonts\\FRIZQT__.ttf", 11)
	ilvltitle:SetPoint("LEFT", nametitle, "RIGHT", 135, 0)
	ilvltitle:SetHeight(25)
	ilvltitle:SetWidth(100)
	ilvltitle:SetText("iLevel / useLevel")
local typetitle = gbl:CreateFontString(nil,nil,"GameFontNormalLeft")
	typetitle:SetPoint("LEFT", ilvltitle, "RIGHT", 5, 0)
	typetitle:SetHeight(20)
	typetitle:SetWidth(125)
	typetitle:SetJustifyH("LEFT")
	typetitle:SetText("Item Type")
local pricetitle = gbl:CreateFontString(nil,nil,"GameFontNormalLeft")
	pricetitle:SetPoint("LEFT", typetitle, "RIGHT", 40, 0)
	pricetitle:SetHeight(60)
	pricetitle:SetWidth(125)
	pricetitle:SetText("Vendor Price")
local separator = gbl:CreateTexture()
	separator:SetWidth(741)
	separator:SetHeight(30)
	separator:SetTexture("Interface\\MailFrame\\UI-MailFrame-InvoiceLine")
	separator:SetPoint("TOP", 14, 20)
	separator:SetAlpha(1)

local link, ilvl, itype, isubtype, price, count
local function UpdateTexts(tab, id)
	link = GetGuildBankItemLink(tab ,id)
	if link then
		_,_,_,ilvl,reqlvl,itype,isubtype,_,_,_,price = GetItemInfo(link)
		_,count,_ = GetGuildBankItemInfo(tab,id)
		GBLcounttexts[id]:SetText("x"..count)
		GBLnametexts[id]:SetText(link)
		GBLtypetexts[id]:SetText(itype..": "..isubtype)
		if ilvl then
			GBLilvltexts[id]:SetText(ilvl.." / "..reqlvl)
		end
		if price then
			GBLpricetexts[id]:SetText(GetCoinTextureString(price*count))
		end
	else
		GBLcounttexts[id]:SetText("")
		GBLnametexts[id]:SetText("<empty slot>")
		GBLilvltexts[id]:SetText("")
		GBLtypetexts[id]:SetText("")
		GBLpricetexts[id]:SetText("")
	end
end

local function FrameFactory(btn)
	local div = btn:CreateTexture()
		div:SetWidth(1000)
		div:SetHeight(30)
		div:SetTexture("Interface\\MailFrame\\UI-MailFrame-InvoiceLine")
		div:SetPoint("LEFT", -25, 0)
		div:SetAlpha(.75)
	local id = btn:GetID()
	local counttext = btn:CreateFontString()
		GBLcounttexts[id] = counttext
		counttext:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
		counttext:SetPoint("LEFT", btn, "RIGHT", 5, 0)
		counttext:SetHeight(37)
		counttext:SetWidth(50)
		counttext:SetJustifyH("LEFT")
	local nametext = btn:CreateFontString()
		GBLnametexts[id] = nametext
		nametext:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
		nametext:SetPoint("LEFT", counttext, "RIGHT", 0, 0)
		nametext:SetHeight(37)
		nametext:SetWidth(240)
		nametext:SetJustifyH("LEFT")
	local ilvltext = btn:CreateFontString()
		GBLilvltexts[id] = ilvltext
		ilvltext:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
		ilvltext:SetPoint("LEFT", nametext, "RIGHT", 15, 0)
		ilvltext:SetHeight(37)
		ilvltext:SetWidth(120)
	local typetext = btn:CreateFontString()
		GBLtypetexts[id] = typetext
		typetext:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
		typetext:SetPoint("LEFT", ilvltext, "RIGHT", 5, 0)
		typetext:SetHeight(37)
		typetext:SetWidth(160)
		typetext:SetJustifyH("LEFT")
	local pricetext = btn:CreateFontString()
		GBLpricetexts[id] = pricetext
		pricetext:SetFont(STANDARD_TEXT_FONT, 18, "OUTLINE")
		pricetext:SetPoint("LEFT", typetext, "RIGHT", 20, 0)
		pricetext:SetHeight(37)
		pricetext:SetWidth(160)
		pricetext:SetJustifyH("LEFT")
	local highlight = btn:CreateTexture()
		btn.highlight = highlight
		highlight:SetHeight(43)
		highlight:SetWidth(900)
		highlight:SetPoint("LEFT", btn, "RIGHT")
		highlight:SetTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar")
		highlight:SetAlpha(0)
		btn:HookScript("OnEnter", function(self) self.highlight:SetAlpha(.3) end)
		btn:HookScript("OnLeave", function(self) self.highlight:SetAlpha(0) end)
		highlight:SetBlendMode("ADD")
	_G[btn:GetName().."Count"]:SetAlpha(0)
	btn:SetHeight(33)
	btn:SetWidth(33)
	btn:SetHitRectInsets(0, -400, 0, 0)
	--btn:SetHitRectInsets(0, -900, 0, 0)
end

for col=1,7 do
	_G["GuildBankColumn"..col.."Background"]:Hide()
	_G["GuildBankColumn"..col]:SetParent(scrollchild)
	_G["GuildBankColumn"..col]:ClearAllPoints()
	_G["GuildBankColumn"..col]:SetScale(.9)
	_G["GuildBankColumn"..col.."Button8"]:ClearAllPoints()
	_G["GuildBankColumn"..col.."Button8"]:SetPoint("TOPLEFT", _G["GuildBankColumn"..col.."Button7"], "BOTTOMLEFT", 0, -7)
	if col == 1 then
		_G["GuildBankColumn"..col]:SetPoint("TOPLEFT", 5, 0)
		_G["GuildBankColumn"..col.."Button1"]:HookScript("OnHide", function() gbl:Hide() end)
		_G["GuildBankFrameTab1"]:HookScript("OnClick", function() gbl:Show() end)
	else
		_G["GuildBankColumn"..col]:SetPoint("TOPLEFT", _G["GuildBankColumn"..(col-1).."Button14"], "BOTTOMLEFT", -7, -4)
	end
	for btn=1,14 do
		FrameFactory(_G["GuildBankColumn"..col.."Button"..btn])
	end
end

local prevtab
gbl:SetScript("OnEvent", function(self,event)
		local tab = GetCurrentGuildBankTab()
		if tab ~= prevtab then	--only scroll to top if changing tabs, not when working with items
			gbl:SetVerticalScroll(1)
			prevtab = tab
		end
		gbl:Show()
		for i=1,98 do
			UpdateTexts(tab, i)
		end
	end)

gbl:RegisterEvent("GUILDBANKBAGSLOTS_CHANGED")
