local SCALE			= 1
local WIDTH 		= 140
local HEIGHT 		= 5
local _, CLASS 		= UnitClass('player')
local COLOR			= CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[CLASS] or RAID_CLASS_COLORS[CLASS]
--local POSITION		= {'BOTTOM', Minimap, 'TOP', 0, -18}
--local POSITION		= {'TOP', Minimap, 'BOTTOM', 0, 17}
local POSITION		= {'BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 30, 6}
local OFFSET		= 150
--local TIP			= {'BOTTOMRIGHT', UIParent, -265, 85}
--local TIP			= {'TOPRIGHT', UIParent, -275, -235}
local TIP			= {'BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 310, 6}
local TEXTURE 		= [[Interface/Buttons/WHITE8X8]]

f = CreateFrame('Frame', nil, UIParent)
f:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
f:SetWidth(WIDTH)
f:SetHeight(HEIGHT)
f:SetScale(SCALE)


-- SETUP BARS
local setBar = function(frame)
	frame:SetStatusBarTexture(TEXTURE)
	frame:SetWidth(WIDTH)
	frame:SetHeight(HEIGHT)
	frame:SetScale(SCALE)
end

local setBackdrop = function(frame)
	frame.bg = CreateFrame('Frame', nil, frame)
	frame.bg:SetBackdrop({
		bgFile = [[Interface/Buttons/WHITE8X8]],
		tiled = false,
		--insets = {left = 0, right = 0, top = 0, bottom = 0}
		insets = {top = -2, left = -2, bottom = -2, right = -2}
	})
	frame.bg:SetPoint('TOPLEFT', frame, -1, 1)
	frame.bg:SetPoint('BOTTOMRIGHT', frame, 1, -1)
	frame.bg:SetFrameLevel(1)
	frame.bg:SetBackdropColor(0, 0, 0, 1)

	--frame.shadow = CreateFrame('Frame', nil, frame)
	--frame.shadow:SetBackdrop({
		--bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
		--tiled = false,
		--insets = {left = 0, right = 0, top = 0, bottom = 0}
	--})
	--frame.shadow:SetPoint('TOPLEFT', frame, -3, 3)
	--frame.shadow:SetPoint('BOTTOMRIGHT', frame, 3, -3)
	--frame.shadow:SetFrameLevel(0)
	--frame.shadow:SetBackdropColor(0, 0, 0, .6)
end

local xp = CreateFrame('StatusBar', nil, f, 'AnimatedStatusBarTemplate')
setBar(xp)
xp:SetFrameLevel(4)
xp:SetStatusBarColor(.4, .1, .6)
xp:SetAnimatedTextureColors(.4, .1, .6)
xp:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4], POSITION[5])
setBackdrop(xp)

local rest = CreateFrame('StatusBar', nil, xp)
setBar(rest)
rest:SetFrameLevel(3)
rest:EnableMouse(false)
rest:SetStatusBarColor(.2, .4, .8)
rest:SetAllPoints(xp)

local artifact = CreateFrame('StatusBar', nil, f, 'AnimatedStatusBarTemplate')
setBar(artifact)
artifact:SetFrameLevel(4)
artifact:SetStatusBarColor(230/255, 204/255, 128/255)
artifact:SetAnimatedTextureColors(230/255, 204/255, 128/255)
artifact:SetPoint(POSITION[1], POSITION[2], POSITION[3], POSITION[4] + OFFSET, POSITION[5])
setBackdrop(artifact)

-- DATA METHODS
local factionStanding = {
	[1] = { name = 'Hated' },
	[2] = { name = 'Hostile' },
	[3] = { name = 'Unfriendly' },
	[4] = { name = 'Neutral' },
	[5] = { name = 'Friendly' },
	[6] = { name = 'Honored' },
	[7] = { name = 'Revered' },
	[8] = { name = 'Exalted' },
};

local numberize = function(v)
    if v <= 9999 then return v end
    if v >= 1000000 then
        local value = string.format('%.1fm', v/1000000)
        return value
    elseif v >= 10000 then
        local value = string.format('%.1fk', v/1000)
        return value
    end
end


local xp_update = function()
	if UnitLevel('player') == MAX_PLAYER_LEVEL then
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			local faction = FACTION_BAR_COLORS[standing]
			xp:SetStatusBarColor(faction.r, faction.g, faction.b)
			xp:SetAnimatedTextureColors(faction.r, faction.g, faction.b)
			--print(cur, min, max, cur-min, 0, max-min)
			xp:SetAnimatedValues(cur - min, 0, max - min, standing)
			-- xp:SetMinMaxValues(min, max)
			-- xp:SetValue(cur)

			rest:SetMinMaxValues(0, 1)
			rest:SetValue(0)
			xp:Show()
			rest:Show()
			return
		end

		--xp:SetAnimatedValues(0, 0, 1, 1)
		xp:Hide()
		rest:Hide()
		--rest:SetMinMaxValues(0, 1)
		--rest:SetValue(0)
	else
		local c, m, l	= UnitXP('player'), UnitXPMax('player'), UnitLevel('player')
		local p 			= math.ceil(c/m*100)
		local r			= GetXPExhaustion()

		xp:SetAnimatedValues(c, 0, m, l)
		-- xp:SetMinMaxValues(min(0, c), m)
		-- xp:SetValue(c)
		rest:SetMinMaxValues(min(0, c), m)
		rest:SetValue(r and (c + r) or 0)

		xp:Show()
		rest:Show()
	end
end

local showExperienceTooltip = function(self)
	if UnitLevel('player') == MAX_PLAYER_LEVEL then
		local name, standing, min, max, cur = GetWatchedFactionInfo()
		if name then
			local faction = FACTION_BAR_COLORS[standing]

			GameTooltip:SetOwner(self, 'ANCHOR_NONE')
			GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

			GameTooltip:AddLine(name, faction.r, faction.g, faction.b)
			GameTooltip:AddLine(factionStanding[standing].name, 1, 1, 1)
			GameTooltip:AddLine(cur-min.."/"..max-min, 1, 1, 1)

			GameTooltip:Show()
		end
	else
		local xpc, xpm, xpr = UnitXP('player'), UnitXPMax('player'), GetXPExhaustion('player')

		GameTooltip:SetOwner(self, 'ANCHOR_NONE')
		GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

		GameTooltip:AddLine('Level '..UnitLevel('player'), COLOR.r, COLOR.g, COLOR.b)
		GameTooltip:AddLine((numberize(xpc)..'/'..numberize(xpm)..' ('..floor((xpc/xpm)*100) ..'%)'), 1, 1, 1)
		if xpr then
			GameTooltip:AddLine(numberize(xpr)..' ('..floor((xpr/xpm)*100) ..'%)', .2, .4, .8)
		end

		GameTooltip:Show()
	end
end

local artifact_update = function(self, event)
	if HasArtifactEquipped() then
		local id, altid, name, icon, total, spent, q = C_ArtifactUI.GetEquippedArtifactInfo()
		local faction = GetWatchedFactionInfo()
		local num, xp, next = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(spent, total)
		local percent       = math.ceil(xp/next*100)

		if not artifact:IsShown() then
			artifact:Show()
		end

		artifact:SetAnimatedValues(xp, 0, next, num + spent)
		-- artifact:SetMinMaxValues(0, next)
		-- artifact:SetValue(xp)

		local x
		if UnitLevel'player' < MAX_PLAYER_LEVEL or faction then
			x = POSITION[4] + OFFSET
		else
			x = POSITION[4]
		end

		artifact:SetPoint(POSITION[1], POSITION[2], POSITION[3], x, POSITION[5])
	else
		if artifact:IsShown() then
			artifact:Hide()
		end
	end
	if event == 'ARTIFACT_XP_UPDATE' then
		if not artifact:IsShown() then
			artifact:Show()
		end
	end
end

local showArtifactTooltip = function(self)
	local id, altid, name, icon, total, spent, q = C_ArtifactUI.GetEquippedArtifactInfo()
	local num, xp, next = MainMenuBar_GetNumArtifactTraitsPurchasableFromXP(spent, total)

	GameTooltip:SetOwner(self, 'ANCHOR_NONE')
	GameTooltip:SetPoint(TIP[1], TIP[2], TIP[3], TIP[4], TIP[5])

	GameTooltip:AddLine(name, COLOR.r, COLOR.g, COLOR.b)
	GameTooltip:AddLine(xp .. '/' .. next .. ' (' .. next-xp .. ' to go)', 1, 1, 1)
	GameTooltip:AddLine('Points to spend: ' .. num, .5, .5, .5)

	GameTooltip:Show()
end



-- events
xp:RegisterEvent('PLAYER_LEVEL_UP')
xp:RegisterEvent('PLAYER_XP_UPDATE')
xp:RegisterEvent('UPDATE_EXHAUSTION')
xp:RegisterEvent('PLAYER_ENTERING_WORLD')
xp:RegisterEvent('MODIFIER_STATE_CHANGED')
xp:RegisterEvent('UPDATE_FACTION')
xp:SetScript('OnEvent', xp_update)
xp:SetScript('OnEnter', function() showExperienceTooltip(xp) end)
xp:SetScript('OnLeave', function() GameTooltip:Hide() end)

artifact:RegisterEvent('PLAYER_ENTERING_WORLD')
artifact:RegisterEvent('ARTIFACT_XP_UPDATE')
artifact:RegisterEvent('ARTIFACT_UPDATE')
artifact:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
artifact:RegisterEvent('PLAYER_LEVEL_UP')
artifact:RegisterEvent('UPDATE_FACTION')
artifact:SetScript('OnEvent', artifact_update)
artifact:SetScript('OnEnter', function() showArtifactTooltip(artifact) end)
artifact:SetScript('OnLeave', function() GameTooltip:Hide() end)

hooksecurefunc("SetWatchedFactionIndex", function(self)
	xp_update()
	artifact_update()
end)
