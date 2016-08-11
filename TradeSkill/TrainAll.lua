
local event= CreateFrame("frame")
event:RegisterEvent("ADDON_LOADED")
local spot=0
local cani, found, Numskills
local done=false

local function pauseit()
	spot=0
	trainall()
end

function trainall()
	if done==true then
		spot=0
		return
	end
	Numskills=GetNumTrainerServices()
	found=false
	while found==false do
		spot=spot+1
		_,_,cani=GetTrainerServiceInfo(spot)
		if cani=="available" then
			BuyTrainerService(spot)
			C_Timer.After(0.3,pauseit)
			found=true
		end
		if spot>=Numskills then
			done=true
			break
		end
	end
end

local function createit()
	local Button = CreateFrame("Button", "TrainAllButton",ClassTrainerFrame, "MagicButtonTemplate")
	Button:SetText("Train All")
	Button:SetPoint("BOTTOMRIGHT",-96,4)
	Button:SetScript("OnEnter", function()
	GameTooltip:SetOwner(Button,"ANCHOR_RIGHT")
	GameTooltip:SetText("Train All available skills")
	end)
	Button:SetScript("OnLeave", function()
	GameTooltip:Hide()
	end)
	Button:SetScript("ONClick",function() spot=0 done=false trainall()end)
end

local function woho(_,_,name)
	if name=="TrainAll" then
		if IsAddOnLoaded("Blizzard_TrainerUI") then
			createit()
		end
	elseif name=="Blizzard_TrainerUI" then
		createit()
	end
end

event:SetScript("OnEvent", woho)
