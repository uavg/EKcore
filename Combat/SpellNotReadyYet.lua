-- SpellNotReadyYet v1.2. Created by Shadowmage - Stormrage EU

-- Default values on load in
local iconsize = 52
local xoff = 0
local yoff = 0
local tfont = STANDARD_TEXT_FONT
local fontsize = 16
local fdur = 0.7


-- Backdrop for buttons
local backdrop = {
	bgFile = "Interface\\BUTTONS\\UI-Panel-Button-Up.png",
	tiled = false,
}

-- Create frame function
local function makeFrame(name, anchor, anX, anY, bdrop, sizeX, sizeY, bR, bG, bB, strata)
	name:SetPoint(anchor, anX, anY)
	name:SetSize(sizeX, sizeY)
	name:SetBackdrop(bdrop)
	name:SetBackdropColor(bR, bG, bB, 1)
	name:SetFrameStrata(strata)
end

-- Create font string function
local function makeFont(name, point, x, y, width, height, fontsize, text)
	name:SetPoint(point, x, y)
	name:SetSize(width, height)
	name:SetFont(GameFontNormal:GetFont(), fontsize)
	name:SetText(text)
 end

--------------------------------------------------------------------------------------------------
------- Localising Blizzards UIFrameFlash function to avoid taints ------------------------------------
--------------------------------------------------------------------------------------------------
local frameFlashManager = CreateFrame("FRAME");
local FLASHFRAMES = {};
local UIFrameFlashTimers = {};
local UIFrameFlashTimerRefCount = {};

-- Function to see if a frame is already flashing
local function UIFrameIsFlashing(frame)
    for index, value in pairs(FLASHFRAMES) do
        if ( value == frame ) then
            return 1;
        end
    end
    return nil;
end

-- Function to stop flashing
local function UIFrameFlashStop(frame)
    tDeleteItem(FLASHFRAMES, frame);
    frame:SetAlpha(1.0);
    frame.flashTimer = nil;
    if (frame.syncId) then
        UIFrameFlashTimerRefCount[frame.syncId] = UIFrameFlashTimerRefCount[frame.syncId]-1;
        if (UIFrameFlashTimerRefCount[frame.syncId] == 0) then
            UIFrameFlashTimers[frame.syncId] = nil;
            UIFrameFlashTimerRefCount[frame.syncId] = nil;
        end
        frame.syncId = nil;
    end
    if ( frame.showWhenDone ) then
        frame:Show();
    else
        frame:Hide();
    end
end

-- Called every frame to update flashing frames
local function UIFrameFlash_OnUpdate(self, elapsed)
    local frame;
    local index = #FLASHFRAMES;
     
    -- Update timers for all synced frames
    for syncId, timer in pairs(UIFrameFlashTimers) do
        UIFrameFlashTimers[syncId] = timer + elapsed;
    end
     
    while FLASHFRAMES[index] do
        frame = FLASHFRAMES[index];
        frame.flashTimer = frame.flashTimer + elapsed;
 
        if ( (frame.flashTimer > frame.flashDuration) and frame.flashDuration ~= -1 ) then
            UIFrameFlashStop(frame);
        else
            local flashTime = frame.flashTimer;
            local alpha;
             
            if (frame.syncId) then
                flashTime = UIFrameFlashTimers[frame.syncId];
            end
             
            flashTime = flashTime%(frame.fadeInTime+frame.fadeOutTime+(frame.flashInHoldTime or 0)+(frame.flashOutHoldTime or 0));
            if (flashTime < frame.fadeInTime) then
                alpha = flashTime/frame.fadeInTime;
            elseif (flashTime < frame.fadeInTime+(frame.flashInHoldTime or 0)) then
                alpha = 1;
            elseif (flashTime < frame.fadeInTime+(frame.flashInHoldTime or 0)+frame.fadeOutTime) then
                alpha = 1 - ((flashTime - frame.fadeInTime - (frame.flashInHoldTime or 0))/frame.fadeOutTime);
            else
                alpha = 0;
            end
             
            frame:SetAlpha(alpha);
            frame:Show();
        end
         
        -- Loop in reverse so that removing frames is safe
        index = index - 1;
    end
     
    if ( #FLASHFRAMES == 0 ) then
        self:SetScript("OnUpdate", nil);
    end
end

-- Function to start a frame flashing
local function UIFrameFlash(frame, fadeInTime, fadeOutTime, flashDuration, showWhenDone, flashInHoldTime, flashOutHoldTime, syncId)
    if ( frame ) then
        local index = 1;
        -- If frame is already set to flash then return
        while FLASHFRAMES[index] do
            if ( FLASHFRAMES[index] == frame ) then
                return;
            end
            index = index + 1;
        end

        if (syncId) then
            frame.syncId = syncId;
            if (UIFrameFlashTimers[syncId] == nil) then
                UIFrameFlashTimers[syncId] = 0;
                UIFrameFlashTimerRefCount[syncId] = 0;
            end
            UIFrameFlashTimerRefCount[syncId] = UIFrameFlashTimerRefCount[syncId]+1;
        else
            frame.syncId = nil;
        end
         
        -- Time it takes to fade in a flashing frame
        frame.fadeInTime = fadeInTime;
        -- Time it takes to fade out a flashing frame
        frame.fadeOutTime = fadeOutTime;
        -- How long to keep the frame flashing
        frame.flashDuration = flashDuration;
        -- Show the flashing frame when the fadeOutTime has passed
        frame.showWhenDone = showWhenDone;
        -- Internal timer
        frame.flashTimer = 0;
        -- How long to hold the faded in state
        frame.flashInHoldTime = flashInHoldTime;
        -- How long to hold the faded out state
        frame.flashOutHoldTime = flashOutHoldTime;
         
        tinsert(FLASHFRAMES, frame);
         
        frameFlashManager:SetScript("OnUpdate", UIFrameFlash_OnUpdate);
    end
end

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

-- Formats the time into a readable form
local formatTime = function(s)
	local day, hour, minute = 86400, 3600, 60
	if s >= day then
		return format("%dd", floor(s/day + 0.5)), s % day
	elseif s >= hour then
		return format("%dh", floor(s/hour + 0.5)), s % hour
	elseif s >= minute then
		return format("%dm", floor(s/minute + 0.5)), s % minute
	elseif s >= minute / 12 then
		return floor(s + 0.5), (s * 100 - floor(s * 100))/100
	end
	return format("%.1f", s), (s * 100 - floor(s * 100))/100
end

-- Create the frame that will register events
local frame = CreateFrame("Frame");
frame:RegisterEvent("UNIT_SPELLCAST_FAILED");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("UI_ERROR_MESSAGE");

-- Function that handles any events captured by the above frame
local function eventHandler(self, event, ...)
	if event == "UNIT_SPELLCAST_FAILED" then -- Event that triggers when something is on CD
		local unit, spellname, spellrank, spellidcounter, id = ...;
		local start, duration, enabled = GetSpellCooldown(id);
		local name, rank, fileID, castTime, minRange, maxRange, spellID = GetSpellInfo(id)
		local seconds = GetTime();
		local timeleft = (start + duration - seconds);
		local icon = GetSpellTexture(spellID)
		
        if name == "Synapse Springs" then else -- add blacklist for loop check here?
			if unit == "player"  then
				if duration > 1.5 then
                    local iconframe = CreateFrame("frame", nil, UIParent) -- Draw all this now inside the function so each frame overwrites
                    iconframe:SetPoint("CENTER", xoff, yoff)					  -- eachother and doesnt appear in a bit jumbled mess
                    iconframe:SetSize(iconsize, iconsize)
                    texture = iconframe:CreateTexture(nil, "LOW") -- creates frame to set the texture too
					texture:SetPoint("CENTER", xoff, yoff)
					texture:SetSize(iconsize, iconsize)
					texture:SetTexture(icon)
					UIFrameFlash(iconframe, 0, fdur, fdur, false, 0, 0)	
                    local tr = iconframe:CreateFontString()				
                    tr:SetPoint("BOTTOM", xoff, yoff)
                    tr:SetSize(40, 40)
                    tr:SetFont(tfont, fontsize, "OUTLINE")
                    tr:SetTextColor(1,0.7,0.7)	
					
					if timeleft < 0 then
						tr:SetText("ERR")	
                    else			
                        tr:SetText(formatTime(timeleft))
                    end	
					iconframe:SetFrameStrata("BACKGROUND")
                end
			end
         end      
	elseif event == "UI_ERROR_MESSAGE" then -- Shows a X for when you have no target or the current target is invalid. Event doesnt fire all the time however
		local message = ...;
			if message == 50 or message == 220 or message == 193 or message == 194 then
                local iconframe2 = CreateFrame("Frame", nil, UIParent)                
                iconframe2:SetPoint("CENTER", xoff, yoff)
                iconframe2:SetSize(iconsize, iconsize)
                iconframe2:SetBackdrop({
                        bgFile = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_7"
                })
                iconframe2:SetFrameStrata("BACKGROUND")
				UIFrameFlash(iconframe2, 0, fdur, fdur, false, 0, 0)
            end
	end
end
frame:SetScript("OnEvent", eventHandler); -- Script that runs the function when an event happens