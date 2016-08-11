local slot = {'Head','Neck','Shoulder','Shirt','Chest','Waist','Legs','Feet','Wrist','Hands','Finger0','Finger1','Trinket0','Trinket1','Back','MainHand','SecondaryHand','Tabard'} 
local function CreateIlvText(slotName) 
   local f = _G[slotName] 
      f.ilv = f:CreateFontString(nil, 'OVERLAY') 
      f.ilv:SetPoint('BOTTOMLEFT', f, 'BOTTOMLEFT', -3, -2) 
      f.ilv:SetFont(STANDARD_TEXT_FONT, 16, 'OUTLINE') 
end 


local levelAdjust={ 
			["0"]=0,["1"]=8,["373"]=4,["374"]=8,["375"]=4,["376"]=4,
			["377"]=4,["379"]=4,["380"]=4,["445"]=0,["446"]=4,["447"]=8,
			["451"]=0,["452"]=8,["453"]=0,["454"]=4,["455"]=8,["456"]=0,
			["457"]=8,["458"]=0,["459"]=4,["460"]=8,["461"]=12,["462"]=16,
			["465"]=0,["466"]=4,["467"]=8,["468"]=0,["469"]=4,["470"]=8,
			["471"]=12,["472"]=16,["477"]=4,["478"]=8,["480"]=8,["491"]=0,
			["492"]=4,["493"]=8,["494"]=0,["495"]=4,["496"]=8,["497"]=12,["498"]=16,
			["504"] = 12,  ["505"] = 16,  ["506"] = 20,  ["507"] = 24,}

local function GetActualItemLevel(link, baseLevel)
   local upgrade = select(1,strsplit(":", select(11,strsplit(":", string.match(link, "item[%-?%d:]+")))))
   if not upgrade then return baseLevel end
   return baseLevel + (levelAdjust[upgrade] or 0)
end

local function CheckItem(unit, frame) 
   if unit then 
      for k, v in pairs(slot) do 
         local f = _G[frame..v..'Slot'] 
         local itemLink = GetInventoryItemLink(unit, k) 
         if not itemLink then 
            f.ilv:SetText() 
       else 
         local _, _, itemQuality, baseLevel = GetItemInfo(itemLink) 
         f.ilv:SetText(GetActualItemLevel(itemLink, baseLevel)) 
         f.ilv:SetTextColor(GetItemQualityColor(itemQuality)) 
         end 

      end 
   end 
end 

for _, v in pairs(slot) do CreateIlvText('Character'..v..'Slot') end 

CharacterFrame:HookScript('OnShow', function(self) 
   CheckItem('player', 'Character') 
   self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED') 
end) 

CharacterFrame:HookScript('OnHide', function(self) 
   self:UnregisterEvent('PLAYER_EQUIPMENT_CHANGED') 
end) 

CharacterFrame:HookScript('OnEvent', function(self, event) 
   if event ~= 'PLAYER_EQUIPMENT_CHANGED' then return end 
   CheckItem('player', 'Character') 
end)