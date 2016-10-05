local f = CreateFrame("Frame") 
f:RegisterEvent("UNIT_AURA") 
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_REGEN_ENABLED")

f:SetScript("OnEvent", function(self, event, ...) 

	local _, instanceType = IsInInstance()
	if instanceType == "raid" then return end
	if not IsChatAFK() then return end	
	
	if event == "PLAYER_REGEN_DISABLED" then
		PlaySoundFile("Sound\\Creature\\BabyMurloc\\BabyMurlocA.ogg", "Master")
	elseif event == "PLAYER_REGEN_ENABLED" then
		StopMusic()
	end
end)
