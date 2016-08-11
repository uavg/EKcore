LFDParentFrame:HookScript("OnShow",function()
  for i=1,GetNumRandomDungeons() do
   local id,name=GetLFGRandomDungeonInfo(i)
   local isHoliday=select(15,GetLFGDungeonInfo(id))
   if(isHoliday and not GetLFGDungeonRewards(id)) then LFDQueueFrame_SetType(id) end
  end
 end)