local frame = CreateFrame("Frame")

frame:RegisterEvent("BANKFRAME_OPENED")
frame:RegisterEvent("BANKFRAME_CLOSED")
frame:RegisterEvent("GUILDBANKFRAME_OPENED")
frame:RegisterEvent("GUILDBANKFRAME_CLOSED")
frame:RegisterEvent("TRADE_SHOW")
frame:RegisterEvent("TRADE_CLOSED")
frame:RegisterEvent("MERCHANT_SHOW")
frame:RegisterEvent("MERCHANT_CLOSED")
frame:RegisterEvent("MAIL_SHOW")
frame:RegisterEvent("MAIL_CLOSED")

local bankFrameOpened = false
local guildBankFrameOpened = false
local tradeOpened = false
local merchantOpened = false
local mailOpened = false

frame:SetScript("OnEvent", function (self, event, ...)
  if event == "BANKFRAME_OPENED" then
    bankFrameOpened = true
  elseif event == "BANKFRAME_CLOSED" then
    bankFrameOpened = false
  elseif event == "GUILDBANKFRAME_OPENED" then
    guildBankFrameOpened = true
  elseif event == "GUILDBANKFRAME_CLOSED" then
    guildBankFrameOpened = false
  elseif event == "TRADE_SHOW" then
    tradeOpened = true
  elseif event == "TRADE_CLOSED" then
    tradeOpened = false
  elseif event == "MERCHANT_SHOW" then
    merchantOpened = true
  elseif event == "MERCHANT_CLOSED" then
    merchantOpened = false
  elseif event == "MAIL_SHOW" then
    mailOpened = true
  elseif event == "MAIL_CLOSED" then
    mailOpened = false
  end
end)


local sr_orig_ContainerFrameItemButton_OnModifiedClick = ContainerFrameItemButton_OnModifiedClick

ContainerFrameItemButton_OnModifiedClick = sr_ContainerFrameItemButton_OnModifiedClick

function ContainerFrameItemButton_OnModifiedClick(self, button)
  if not IsShiftKeyDown() or button ~= "RightButton" then
    return sr_orig_ContainerFrameItemButton_OnModifiedClick(self, button)
  end

  if not (bankFrameOpened or guildBankFrameOpened or tradeOpened or merchantOpened or mailOpened) then
    return sr_orig_ContainerFrameItemButton_OnModifiedClick(self, button)
  end

  local selectedBagID = self:GetParent():GetID()
  local selectedSlotID = self:GetID()
  local selectedItemID = GetContainerItemID(selectedBagID, selectedSlotID)

  if selectedItemID == nil then
    return
  end

  if selectedBagID >= 0 and selectedBagID <= 4 then
    for bagID = 0, 4 do UseItemsInBag(bagID, selectedItemID) end
  else
    UseItemsInBag(-1, selectedItemID)
    for bagID = 5, 11 do UseItemsInBag(bagID, selectedItemID) end
  end
end

function UseItemsInBag(bagID, itemID)
  for slotID = 1, GetContainerNumSlots(bagID) do
    local bagItemID = GetContainerItemID(bagID, slotID)
    if bagItemID == itemID then
      UseContainerItem(bagID, slotID)
    end
  end
end
