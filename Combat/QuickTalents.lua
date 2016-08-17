----------------------------------------------------------------------------------------------------------------------------------
-- QuickTalents
----------------------------------------------------------------------------------------------------------------------------------
CreateFrame("Button","QuickTalents",UIParent,"SecureHandlerClickTemplate,SecureHandlerStateTemplate"):RegisterEvent("ADDON_LOADED");
QuickTalents:SetScript("OnEvent",function(self)
	self:UnregisterEvent("ADDON_LOADED");
	
	-- Load/Validate Settings
	local settings = {
		Scale = {1,"Set size/scale."},
		ShowTooltips = {false,"Toggle mouseover tooltips on talents."},
		BackgroundAlpha = {0.75,"Set background opacity."},
		Collapsed = {false},
		CollapseInCombat = {false,"Automatically hide buttons while in combat."},
		--UnfocusedAlpha = {1,"Set frame opacity when not in use."},
		--FixMacroSpells = {false,"Enable/Disable  in macros"},
		BarBottom = {true,"Show reagent bar on the bottom & collapse downwards."},
		BarVisible = {true, "Toggle reagents & spec bar visibility"},
		ButtonSize = {18, "Button size" },
		ButtonSpacing = {1, "Button spacing" },
		Display = { true, "Display all talents" },
		Columns = { 3, "Number of columns to display" },
		Lock = { false, "Toggle window lock" },
		Equipment = { {} },
		Filter  = { {} }, -- An array because each specialization has its own talents bitmask setup
	};
	
	local cfg = QT_Settings or {};
	for k,v in pairs(settings) do
		if type(cfg[k]) ~= type(v[1]) then cfg[k] = v[1]; end
	end
	QT_Settings = cfg;
	
	-- Options Popup Menu
	do
		local minmax = { [true] = math.min, [false] = math.max }
		local function RangeSet(info)
			local field, method, value, limit = strsplit(';',info.value)
			value = tonumber(value); limit = tonumber(limit)
			cfg[field] = limit and minmax[value>0]( limit, cfg[field]+value ) or value
			self[method](self)
		end
		local function ToggleGet(info)
			local field,_,negate = strsplit(';', info.value)
			if negate then return not cfg[field] end
			return cfg[field]
		end
		local function ToggleSet(info)
			local field,method = strsplit(';',info.value)
			cfg[field] = not cfg[field]
			if method then self[method](self) end
		end
		local function TalentGet(info)
			return bit.band( cfg.Filter[self.playerSpec] or 2097151, bit.lshift(1,info.value-1) ) ~= 0
		end
		local function TalentSet(info)
			cfg.Filter[self.playerSpec] = bit.bxor( cfg.Filter[self.playerSpec] or 2097151, bit.lshift(1,info.value-1) ); self:Layout()
		end	
		local function EquipmentGet(info)
			return info.value == (cfg.Equipment[ UIDROPDOWNMENU_MENU_VALUE ] or 0)
		end
		local function EquipmentSet(info)
			local spec = UIDROPDOWNMENU_MENU_VALUE
			cfg.Equipment[spec] = info.value~=0 and info.value or nil;
			if GetSpecialization() == spec then
				self:Equip(info.value)
			end	
		end
		self.menuTalents = {}
		self.menuEquipment = {}
		self.menuTable = {
			{ text = 'Player Specialization', notCheckable= true, isTitle = true },
			{ text = 'Talents to Display', notCheckable= true, isTitle = true },
			{ text = 'All talents', value = 'Display;Layout',   checked = ToggleGet, func = ToggleSet },
			{ text = 'Only these talents',  value = 'Display;Layout;!', checked = ToggleGet, func = ToggleSet, hasArrow = true, menuList = self.menuTalents },
			{ text = 'Appearance', notCheckable= true, isTitle = true },
			{ text = 'Buttons per Row', notCheckable= true, hasArrow = true, menuList = {
				{ text = 'Increase++',  value = 'Columns;Layout;+1;21', notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Decrease--',  value = 'Columns;Layout;-1;1',  notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Default (3)', value = 'Columns;Layout;3',     notCheckable= true, keepShownOnClick=1, func = RangeSet },
			} },	
			{ text = 'Buttons Size', notCheckable= true, hasArrow = true, menuList = {
				{ text = 'Increase++',   value = 'ButtonSize;Layout;+1;64', notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Decrease--',   value = 'ButtonSize;Layout;-1;1',  notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Default (26)', value = 'ButtonSize;Layout;26',    notCheckable= true, keepShownOnClick=1, func = RangeSet },
			} },
			{ text = 'Buttons Spacing', notCheckable= true, hasArrow = true, menuList = {
				{ text = 'Increase++',  value = 'ButtonSpacing;Layout;+1;16', notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Decrease--',  value = 'ButtonSpacing;Layout;-1;0',  notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Default (2)', value = 'ButtonSpacing;Layout;2',     notCheckable= true, keepShownOnClick=1, func = RangeSet },
			} },	
			{ text = 'Window Scale', notCheckable= true, hasArrow = true, menuList = {
				{ text = 'Increase++',  value = 'Scale;Update;+0.01;5',   notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Decrease--',  value = 'Scale;Update;-0.01;0.1', notCheckable= true, keepShownOnClick=1, func = RangeSet },	
				{ text = 'Default (1)', value = 'Scale;Update;1',         notCheckable= true, keepShownOnClick=1, func = RangeSet },		
			} },	
			{ text = 'Background Alpha', notCheckable= true, hasArrow = true, menuList = {
				{ text = 'More opaque++',  value = 'BackgroundAlpha;Update;+0.05;1', notCheckable= true, keepShownOnClick=1, func = RangeSet },
				{ text = 'Less opaque--',  value = 'BackgroundAlpha;Update;-0.05;0', notCheckable= true, keepShownOnClick=1, func = RangeSet },
				{ text = 'Default (0.75)', value = 'BackgroundAlpha;Update;0.75',    notCheckable= true, keepShownOnClick=1, func = RangeSet },
			} },	
			{ text = 'Spec bar visible', value = 'BarVisible;Update', isNotRadio=true, checked = ToggleGet, func = ToggleSet },			
			{ text = 'Spec bar on bottom', value = 'BarBottom;Update', isNotRadio=true, checked = ToggleGet, func = ToggleSet },
			{ text = 'Miscellaneous',  notCheckable= true, isTitle = true },			
			{ text = 'Collapse in Combat', value = 'CollapseInCombat', isNotRadio=true, checked = ToggleGet, func = ToggleSet },
			{ text = 'Show Tooltips',      value = 'ShowTooltips',     isNotRadio=true, checked = ToggleGet, func = ToggleSet },			
			{ text = 'Lock Window',        value = 'Lock;UpdateLock',  isNotRadio=true, checked = ToggleGet, func = ToggleSet },			
		}
		for i=1,7 do
			local id = (i-1)*3
			self.menuTalents[i] = { text = 'Tier '..i,  notCheckable= true, hasArrow = true, menuList = {
				{ text = '1', value=id+1, isNotRadio=true, keepShownOnClick=1, checked = TalentGet, func = TalentSet },
				{ text = '2', value=id+2, isNotRadio=true, keepShownOnClick=1, checked = TalentGet, func = TalentSet },
				{ text = '3', value=id+3, isNotRadio=true, keepShownOnClick=1, checked = TalentGet, func = TalentSet },
			} }
		end
		function self:ShowMenu()
			if not self.specLoaded then
				for i=GetNumSpecializations(),1,-1 do
					local _, specName = GetSpecializationInfo(i)
					table.insert(self.menuTable, 2, { 
						text = specName, value = i, hasArrow = true, checked = function() return self.playerSpec==i end, func = function() SetSpecialization(i) end, menuList = self.menuEquipment 
					} )	
				end
				self.specLoaded = true
			end
			if self.playerSpec ~= self.menuFrame.playerSpec then
				self.menuFrame.playerSpec = self.playerSpec		
				local specGroup = GetActiveSpecGroup()
				if specGroup then
					for tier = 1, MAX_TALENT_TIERS do
						for col = 1, NUM_TALENT_COLUMNS do
							local _, name, icon = GetTalentInfo(tier, col, specGroup)
							self.menuTalents[tier].menuList[col].text = string.format("|T%s:0|t %s", icon or "", name or col)
						end	
					end
				end	
			end	
			if self.equipmentCount ~= GetNumEquipmentSets() then
				self.equipmentCount = GetNumEquipmentSets()
				wipe(self.menuEquipment)
				self.menuEquipment[1] = { text = 'Set to Equip', notCheckable= true, isTitle = true }								
				for i=1,self.equipmentCount do
					local name = GetEquipmentSetInfo(i)
					self.menuEquipment[i+1] = { text = name, value = name, checked = EquipmentGet, func = EquipmentSet }
				end
				self.menuEquipment[#self.menuEquipment+1] = { text = 'Do nothing', value = 0, checked = EquipmentGet, func = EquipmentSet }
			end	
			EasyMenu(self.menuTable, self.menuFrame, "cursor", 0 , 0, "MENU", 1)
		end
		self.menuFrame = CreateFrame("Frame", "QuickTalentsPopupMenu", UIParent, "UIDropDownMenuTemplate")				
	end

	-- Main Frame
	self:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 4,-131);
	self:SetSize(58,16);
	self:SetMovable(true)	
	self:IsUserPlaced(true);
	self:SetClampedToScreen(true);
	self:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	self:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8"});

	local SpecText = self:CreateFontString();
	SpecText:SetFont("Fonts\\ARIALN.TTF", 12, "OUTLINE");
	SpecText:SetJustifyH("LEFT")
	SpecText:SetPoint("LEFT",0,0);
	SpecText:SetPoint("RIGHT",0,0)
	
	local ButtonContainer = CreateFrame('Frame', '$parentButtonContainer', self, 'SecureFrameTemplate');
	ButtonContainer:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8"});
	ButtonContainer:SetSize(58,134);
	ButtonContainer:SetShown(not cfg.Collapsed) 
	
	self.Buttons = {};
	do -- Create Buttons
		local OnEnter = function(btn)
			if cfg.ShowTooltips then
				GameTooltip:SetOwner(btn, "ANCHOR_RIGHT");
				GameTooltip:SetTalent(btn.talentId);
				GameTooltip:Show();
			end
			btn:SetAlpha(btn.selected and 1 or 0.5);
		end
		local OnLeave = function(btn)
			GameTooltip:Hide();
			btn:SetAlpha(btn.selected and 1 or 0.25);
		end
		local OnDragStart = function(btn)
			return InCombatLockdown() or PickupTalent(btn.talentId);
		end;
		for i = 1,21 do
			local btn = CreateFrame("BUTTON","$parent_Button"..i,ButtonContainer,"SecureActionButtonTemplate");
			btn:SetAttribute("type1","macro");
			btn:SetScript("OnLeave",OnLeave);
			btn:SetScript("OnEnter",OnEnter);
			btn:SetScript("OnDragStart",OnDragStart);
			btn:RegisterForDrag("LeftButton");
			btn:SetAttribute("macrotext",
				"/stopmacro [combat]\n"..
				"/click QuickTalentsOpener\n".. -- ensures the talent frame is ready for interaction
				"/click PlayerTalentFrameTalentsTalentRow"..ceil(i/3).."Talent"..((i-1)%3+1).."\n".. -- only way(?) to get the unlearn popup without taint
				"/click StaticPopup1Button1\n".. -- confirm unlearn (TODO: what if popup1 is not the talent prompt)
				"/run QuickTalents:Learn("..i..")\n" -- queue new talents for learn
			);
			btn.texture = btn:CreateTexture(nil,"BACKGROUND");
			btn.texture:SetAllPoints();
			btn.texture:SetTexCoord(0.075,0.925,0.075,0.925);
			self.Buttons[i] = btn;
		end
	end
	
	-- Handles the safe loading & opening of the Blizzard Talent UI
	CreateFrame("BUTTON","QuickTalentsOpener",self,"SecureActionButtonTemplate"):SetAttribute("type","macro");
	QuickTalentsOpener:SetAttribute("macrotext",
		"/click TalentMicroButton\n"..
		"/click [spec:1] PlayerSpecTab1\n"..
		"/click [spec:2] PlayerSpecTab2\n"..
		"/click PlayerTalentFrameTab3\n"..
		"/click PlayerTalentFrameTab2\n"..
		"/click TalentMicroButton"
	);

	-- Equip a Set
	function self:Equip(name)
		if name and not (InCombatLockdown() or select(3,GetEquipmentSetInfoByName(name)))  then
			return UseEquipmentSet(name)
		end	
	end
	
	-- Window lock/unlock
	function self:UpdateLock()
		if cfg.Lock then
			self:RegisterForDrag()
			self:SetScript("OnDragStart", nil)
			self:SetScript("OnDragStop", nil)
		else
			self:RegisterForDrag("LeftButton")
			self:SetScript("OnDragStart", self.StartMoving)
			self:SetScript("OnDragStop", self.StopMovingOrSizing)
		end		
	end
	self:UpdateLock()
	
	-- Learn Queue
	function self:Learn(i)
		local id, _, _, selected, free = GetTalentInfo( ceil(i/3), 1+(i-1)%3, 1 );
		if not selected then 
			C_Timer.After( free and 0 or 0.1, function()
				LearnTalents(id)
			end);
		end	
	end
			
	-- Layout Buttons
	function self:Layout()
		local filter  = cfg.Filter[self.playerSpec or -1] or 2097151
		local spacing = cfg.ButtonSpacing
		local btnsize = cfg.ButtonSize
		local colsize = btnsize + spacing
		local cols    = cfg.Columns
		local count   = 0
		for i,btn in next, self.Buttons do
			if cfg.Display or bit.band( filter, bit.lshift(1,i-1) ) ~= 0 then
				count = count + 1			
				btn:SetSize(btnsize,btnsize)
				btn:SetPoint("TOPLEFT",spacing+((count-1)%cols)*colsize,-((ceil(count/cols)-1)*colsize)-spacing);
				btn:Show()
			else
				btn:Hide()
			end	
		end
		cols = math.min( cols, count )
		local width = colsize*cols+spacing
		ButtonContainer:SetSize( width, colsize*ceil(count/cols)+spacing )
		SpecText:SetShown( width>35 )
		self:SetWidth(width)
	end
	
	-- Updates button textures and stuff on talent changes
	function self:Update()
		local group = GetActiveSpecGroup();
		for i,btn in pairs(self.Buttons) do
			local id, name, texture, selected = GetTalentInfo( ceil(i/3), 1+(i-1)%3, group );
			btn.talentId = id;
			btn.selected = selected;
			btn:SetAlpha(selected and 1 or 0.25);
			btn.texture:SetTexture(texture);
		end
		
		-- apply settings
		SpecText:SetAlpha( cfg.BarVisible and 1 or 0)
		self:SetBackdropColor(0,0,0,cfg.BarVisible and cfg.BackgroundAlpha or 0)
		ButtonContainer:SetBackdropColor(0,0,0,cfg.BackgroundAlpha);
		if not InCombatLockdown() then
			self:SetAttribute("CollapseInCombat",cfg.CollapseInCombat);
			self:SetScale(cfg.Scale);
			ButtonContainer:ClearAllPoints();
			if cfg.BarBottom then
				ButtonContainer:SetPoint('BOTTOMLEFT',self,'TOPLEFT',0,-2);
			else
				ButtonContainer:SetPoint('TOPLEFT',self,'BOTTOMLEFT',0,2);
			end
		end
		
		-- Update Layout & Menu Talents
		local spec = GetSpecialization()
		if spec ~= self.playerSpec then
			local specName = select(2,GetSpecializationInfo(spec))
			if specName then
				self.playerSpec = spec		
				SpecText:SetText( specName  )
				self:Equip( cfg.Equipment[spec] )
				self:Layout()
			end	
		end
	end
	self:Update()
	
	-- Event Handler
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("BAG_UPDATE_DELAYED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");
	self:RegisterEvent("PLAYER_REGEN_DISABLED");
	self:SetScript("OnEvent",function(self,e,...)
		if e:match("^PLAYER_REGEN") then
			for i,btn in pairs(self.Buttons) do
				SetDesaturation(btn.texture, e=="PLAYER_REGEN_DISABLED");
			end
		end
		self:Update();
	end);
	
	-- Collapse stuff
	self:SetAttribute("Collapsed",cfg.Collapsed);
	self:SetAttribute("_onclick",[[
		if button == "LeftButton" then
			self:SetAttribute("Collapsed", not not self:GetFrameRef("ButtonContainer"):IsShown() );
			if self:GetAttribute("Collapsed") then
				self:GetFrameRef("ButtonContainer"):Hide()
			else
				self:GetFrameRef("ButtonContainer"):Show()
			end
		end	
	]]);
	self:HookScript("OnClick",function(_,button)
		if button=='LeftButton' then
			cfg.Collapsed = self:GetAttribute("Collapsed");
		elseif button=='RightButton' and not InCombatLockdown() then
			self:ShowMenu()
		end
	end);
	RegisterStateDriver(self, 'combat', '[combat]1;2;');
	self:SetAttribute("_onstate-combat",[[
		if PlayerInCombat() and self:GetAttribute("CollapseInCombat") then
			self:GetFrameRef("ButtonContainer"):Hide()
		elseif not self:GetAttribute("Collapsed") then
			self:GetFrameRef("ButtonContainer"):Show()
		end
	]]);	
	self:SetFrameRef("ButtonContainer", ButtonContainer);
	
	SLASH_QUICKTALENTS1,SLASH_QUICKTALENTS2 = "/quicktalents","/qts";
	SlashCmdList.QUICKTALENTS = function(args)
		local arg1,arg2 = strsplit(" ",strlower(args),2);
		
		for key, info in pairs(settings) do
			if strlower(key) == arg1 then
				if type(info[1]) == 'boolean' then
					cfg[key] = not not (( arg2 == 'true' ) or ( arg2 ~= 'false' and not cfg[key] ));
				elseif type(info[1]) == 'number' then
					cfg[key] = tonumber(arg2) or cfg[key];
				end
				print(format("|cFF0088FF%s|r: |cFF00BBFF%s|r", key, tostring(cfg[key])));
				self:Update();
				return;
			end
		end
		
		print("Options:");
		for key, info in pairs(settings) do
			if info[2] then
				print(format("|cFF0088FF%s|r [|cFF00BBFF%s|r] - %s", key, tostring(cfg[key]), info[2]));
			end
		end
	end
	
end);
