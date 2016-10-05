local f = CreateFrame("Frame")
f:RegisterUnitEvent("UNIT_HEALTH", "player")

local last = 0

f:SetScript("OnEvent", function(UNIT_HEALTH) 
    local lowHealth = (UnitHealth("player") / UnitHealthMax("player") < 0.3)	
	if UnitIsDeadOrGhost("player") then return end
	
	local now = GetTime()
    if now - last < 2 then return end	
	
	if lowHealth then
	
	--PlaySoundFile("Sound\\Interface\\RaidWarning.ogg", "Master") 
	PlaySoundFile("Interface\\Addons\\EKcore\\Combat\\HealthWarning.ogg", "Master") 
	elseif not lowHealth then return end
	
	last = now
end)



