----------------------------------------------------------------------------------------------------------------------------------
-- Trade Skill Drag
----------------------------------------------------------------------------------------------------------------------------------
LoadAddOn("Blizzard_TradeSkillUI");
TradeSkillSkillIcon:RegisterForDrag("LeftButton");
TradeSkillSkillIcon:SetScript("OnDragStart",function()
	PickupSpell( strmatch( GetTradeSkillRecipeLink( TradeSkillFrame.selectedSkill ):sub(21) or "","%d+") );
end)