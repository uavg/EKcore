--[[ Note: Code from user jnwhiteh here : http://wowprogramming.com/forums/development/104 slightly changed for use with this addon ]]

local delay = 0.5
local time = 0
local frame = CreateFrame("Frame")
frame:Hide()
frame:RegisterEvent("ACHIEVEMENT_EARNED")

frame:SetScript("OnUpdate", function(self, elapsed)
   time = time + elapsed
   if time >= delay then
     Screenshot()
     time = 0
     self:Hide()
   end
end)

frame:SetScript("OnEvent", function(self, event, ...)
   self:Show()
end)
