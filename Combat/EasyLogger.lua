local f = CreateFrame("Frame")

f:SetScript("OnEvent", function ()
	local _, instanceType, difficulty = IsInInstance()
	if instanceType == "raid" or difficulty == 8 then
		if not LoggingCombat() then
			LoggingCombat(true)
			print("EasyLogger: |cff00FF00ON|r")
		end
	else
		if LoggingCombat() then
			LoggingCombat(false)
			print("EasyLogger: |cffFF0000OFF|r")
		end
	end
end)

SLASH_EASYLOGGER1, EASYLOGGER2 = "/easylogger", "/el"
SlashCmdList.EASYLOGGER = function()
	if LoggingCombat() then
		print("EasyLogger is |cff00FF00ON|r")
	else
		print("EasyLogger is |cffFF0000OFF|r")
	end
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")