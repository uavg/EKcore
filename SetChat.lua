local AutoApply = true	          --自動套用，輸入/setchat
local def_position = {"BOTTOMLEFT",UIParent,"BOTTOMLEFT",10,20}  --位置
local chat_height = 186           --聊天框高度
local chat_width = 360            --聊天框寬度
local font = STANDARD_TEXT_FONT   --字體
local fontsize = 16               --字體大小

SetChat = function()
    FCF_SetLocked(ChatFrame1, nil)
    ChatFrame1:ClearAllPoints()
    ChatFrame1:SetPoint(unpack(def_position))
    ChatFrame1:SetWidth(chat_width)
    ChatFrame1:SetHeight(chat_height)
    ChatFrame1:SetFrameLevel(8)
    ChatFrame1:SetUserPlaced(true)
	for i=1,10 do local cf = _G["ChatFrame"..i] 
	FCF_SetWindowAlpha(cf, 0) 
	FCF_SetChatWindowFontSize(self,cf, fontsize)
	end
    FCF_SavePositionAndDimensions(ChatFrame1)
	FCF_SetLocked(ChatFrame1, true)
end
SlashCmdList["SETCHAT"] = SetChat
SLASH_SETCHAT1 = "/setchat"

if AutoApply then
	local f = CreateFrame"Frame"
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	f:SetScript("OnEvent", function() SetChat() end)
end

--預設的頻道(暗影之月)
Gchat = function()
	JoinTemporaryChannel("組隊頻道")
	ChatFrame_AddChannel(ChatFrame3, "組隊頻道")
	JoinTemporaryChannel("Gruul")
	ChatFrame_AddChannel(ChatFrame1, "Gruul")
	ChatFrame_AddChannel(ChatFrame3, "Gruul")
end
SlashCmdList["GCHAT"] = Gchat
SLASH_GCHAT1 = "/gchat"

--大腳世界頻道
Dchat = function()
	JoinTemporaryChannel("大腳世界頻道")
	ChatFrame_AddChannel(ChatFrame3, "大腳世界頻道")

end
SlashCmdList["DCHAT"] = Dchat
SLASH_DCHAT1 = "/dchat"

--清空聊天框
SlashCmdList["CLEAR"] = function()
  -- Clear selected ChatFrame
  SELECTED_CHAT_FRAME:Clear()
  -- Check for CombatLog Frame and Clear it the right way
  if IsCombatLog(SELECTED_CHAT_FRAME) then
		CombatLogClearEntries()
	end	  
end
SLASH_CLEAR1        = "/cc"

--清空所有聊天框
SlashCmdList["CLEARALL"] = function()
  -- Clear ALL ChatFrames
	for i=1, NUM_CHAT_WINDOWS do
		_G["ChatFrame"..i]:Clear()
	end  
  -- Clear CombatLog the right way
	CombatLogClearEntries()  
end
SLASH_CLEARALL1     = "/cca"