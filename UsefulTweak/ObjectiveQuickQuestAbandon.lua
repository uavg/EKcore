hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderClick", function(block) 
   local questLogIndex = block.questLogIndex 
   if IsControlKeyDown() then 
      local items = GetAbandonQuestItems() 
      if items then 
         StaticPopup_Hide("ABANDON_QUEST") 
         StaticPopup_Show("ABANDON_QUEST_WITH_ITEMS", GetAbandonQuestName(), items) 
      else 
         StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS") 
         StaticPopup_Show("ABANDON_QUEST", GetAbandonQuestName()) 
      end 
   elseif IsAltKeyDown() and GetQuestLogPushable(questLogIndex) then 
      QuestLogPushQuest(questLogIndex) 
   end 
end)