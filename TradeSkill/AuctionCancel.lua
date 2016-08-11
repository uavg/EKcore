local g = getfenv(0)
if not Blizzard_AuctionUI then LoadAddOn("Blizzard_AuctionUI") end

local function Print(aucid)
    DEFAULT_CHAT_FRAME:AddMessage("Canceled auction "..GetAuctionItemLink("owner", aucid))
end

for i = 1, 9 do
    local aucbutton = g["AuctionsButton"..i]
    local Button_OnClick = aucbutton:GetScript("OnClick")
    aucbutton:SetScript("OnClick", function (self, ...) 
        if IsAltKeyDown() then
            local aucid = self:GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame)
            CancelAuction(aucid)
            Print(aucid)
        else return Button_OnClick(self, ...)
        end
    end)
    local aucitem = g["AuctionsButton"..i.."Item"]
    local Item_OnClick = aucitem:GetScript("OnClick")
    aucitem:SetScript("OnClick", function(self, ...) 
        if IsAltKeyDown() then
            local aucid = self:GetParent():GetID() + FauxScrollFrame_GetOffset(AuctionsScrollFrame) 
            CancelAuction(aucid)
            Print(aucid)
        else return Item_OnClick(self, ...)
        end
    end)
end

