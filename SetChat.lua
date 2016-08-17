local AutoApply = true	          --自動套用，輸入/setchat
local def_position = {"BOTTOMLEFT",UIParent,"BOTTOMLEFT",18,35}  --聊天框位置
local chat_height = 260           --聊天框高度
local chat_width = 420            --聊天框宽度
local font = STANDARD_TEXT_FONT   --字体
local fontsize = 18               --聊天框字体大小

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
--預設的頻道(大腳世界頻道-簡體)
Dchat = function()
	JoinTemporaryChannel("大脚世界频道")
	ChatFrame_AddChannel(ChatFrame3, "大脚世界频道")

end
SlashCmdList["DCHAT"] = Dchat
SLASH_DCHAT1 = "/dchat"