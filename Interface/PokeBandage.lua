--[[--------------------------------------------------------------------
	PokéBandage
	Adds a button to the pet journal for using Battle Pet Bandages.
	Copyright (c) 2014-2016 Phanx <addons@phanx.net>. All rights reserved.
	http://www.wowinterface.com/downloads/info22735-PokéBandage
	http://www.curse.com/addons/wow/pokebandage
	https://github.com/Phanx/PokeBandage
----------------------------------------------------------------------]]

local ITEMID = 86143 -- Battle Pet Bandage
GetItemInfo(ITEMID) -- make sure it's cached for later

local loader = CreateFrame("Frame")
loader:RegisterEvent("ADDON_LOADED")
loader:SetScript("OnEvent", function(self)
	if not PetJournal then return end
	if InCombatLockdown() then return self:RegisterEvent("PLAYER_REGEN_ENABLED") end
	self:UnregisterAllEvents()
	self:SetScript("OnEvent", nil)

	PetJournalHealPetButton.spellname:Hide()

	local f = CreateFrame("Button", "$parentBandageButton", PetJournal, "SecureActionButtonTemplate")
	f:SetPoint("RIGHT", PetJournalHealPetButton, "LEFT", -4, 0)
	f:SetSize(33, 33)

	f:SetAttribute("type", "item")
	f:SetAttribute("item", "item:"..ITEMID)

	local tx = f:CreateTexture(nil, "ARTWORK")
	tx:SetAllPoints(true)
	f.Icon = tx

	local ct = f:CreateFontString(nil, "ARTWORK", "NumberFontNormal")
	ct:SetPoint("TOPRIGHT")
	f.Count = ct

	local bk = f:CreateTexture(nil, "OVERLAY")
	bk:SetAllPoints(true)
	bk:SetTexture(0, 0, 0, 0.6)
	bk:Hide()
	f.BlackCover = bk

	local bd = f:CreateTexture(nil, "OVERLAY", "ActionBarFlyoutButton-IconFrame", 1)
	bd:SetSize(35, 35)
	bd:SetPoint("CENTER")
	f.Border = bd

	local lk = f:CreateTexture(nil, "OVERLAY", nil, 1)
	lk:SetAllPoints(true)
	lk:SetTexture("Interface\\PetBattles\\PetBattle-LockIcon")
	f.LockIcon = lk

	local cd = CreateFrame("Cooldown", nil, f, "CooldownFrameTemplate")
	f.Cooldown = cd

	f:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	f:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	if PhanxBorder then
		f:SetPoint("RIGHT", PetJournalHealPetButton, "LEFT", -8, 0)
		f.Icon:SetDrawLayer("BACKGROUND")
		f.BlackCover:SetDrawLayer("ARTWORK")
		f.Border:SetTexture("")
		PhanxBorder.AddBorder(f)
	end

	function f:UpdateItem()
		local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(ITEMID)
		self.Icon:SetTexture(icon)

		self.bagID, self.slotID = nil, nil
		for bag = 0, NUM_BAG_SLOTS do
			for slot = 1, GetContainerNumSlots(bag) do
				if GetContainerItemID(bag, slot) == ITEMID then
					self.bagID, self.slotID = bag, slot
					return
				end
			end
		end
	end

	function f:UpdateUsability()
		local count = GetItemCount(ITEMID)
		if count > 0 and C_PetJournal.IsJournalUnlocked() then
			if C_PetBattles.IsInBattle() or not IsUsableItem(ITEMID) then
				self:SetButtonState("NORMAL", true)
				self.Icon:SetDesaturated(true)
				self.BlackCover:Show()
				self.LockIcon:Show()
				self.Count:Hide()
			else
				self:SetButtonState("NORMAL", false)
				self.Icon:SetDesaturated(false)
				self.BlackCover:Hide()
				self.LockIcon:Hide()
				self.Count:Show()
				self.Count:SetText(count)
				self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
				self:RegisterForDrag("LeftButton")
			end
		else
			self.Icon:SetDesaturated(true)
			self.BlackCover:Show()
			self.Count:Hide()
		end
	end

	function f:UpdateCooldown()
		local start, duration, enable = GetItemCooldown(ITEMID)
		CooldownFrame_Set(self.Cooldown, start, duration, enable)
	end

	function f:UpdateTooltip()
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		if self.bagID and self.slotID then
			GameTooltip:SetBagItem(self.bagID, self.slotID)
		else
			GameTooltip:SetItemByID(ITEMID)
			GameTooltip:AddLine(INSTANCE_UNAVAILABLE_SELF_MISSING_ITEM, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
			-- TODO: check translations in other locales
		end
		if not C_PetJournal.IsJournalUnlocked() then
			GameTooltip:AddLine(PET_JOURNAL_HEAL_SPELL_LOCKED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
		elseif C_PetBattles.IsInBattle() then
			GameTooltip:AddLine(PET_JOURNAL_HEAL_SPELL_IN_BATTLE, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, 1)
		end
		GameTooltip:Show()
	end

	PetJournal:HookScript("OnShow", function()
		f:UpdateItem()
	end)

	f:SetScript("OnShow", function(self)
		-- Battle Pet Bandage
		self:RegisterEvent("BAG_UPDATE_COOLDOWN")
		self:RegisterEvent("BAG_UPDATE_DELAYED")
		self:RegisterEvent("PET_BATTLE_OPENING_START")
		self:RegisterEvent("PET_BATTLE_CLOSE")
		self:UpdateItem()
		self:UpdateCooldown()
		self:UpdateUsability()
	end)

	f:SetScript("OnHide", function(self)
		self:UnregisterAllEvents()
	end)

	f:SetScript("OnEvent", function(self, event, ...)
		if event == "BAG_UPDATE_COOLDOWN" then
			self:UpdateCooldown()
			if GameTooltip:GetOwner() == self then
				self:UpdateTooltip()
			end
		else
			self:UpdateUsability()
		end
	end)

	f:SetMotionScriptsWhileDisabled(true)
	f:SetScript("OnEnter", f.UpdateTooltip)
	f:SetScript("OnLeave", GameTooltip_Hide)

	f:SetScript("OnDragStart", function(self)
		if self.bagID and self.slotID then
			return PickupContainerItem(self.bagID, self.slotID)
		end
	end)
end)
