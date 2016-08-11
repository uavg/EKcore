local colour1 = "ffF788D2"
local active = true
local playerName = UnitName("player")

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

local taunts = {
  [355] = true,    -- Warrior
--  [114198] = true, -- Warrior (Mocking Banner)
  [2649] = true,   -- Hunter (Pet)
  [20736] = true,  -- Hunter (Distracting Shot)
  [123588] = true, -- Hunter (Distracting Shot - glyphed)
  [6795] = true,   -- Druid
  [17735] = true,  -- Warlock (Voidwalker)
  [97827] = true,  -- Warlock (Provocation (Metamorphosis))
  [49560] = true,  -- Death Knight (Death Grip (aura))
  [56222] = true,  -- Death Knight
  [73684] = true,  -- Shaman (Unleash Earth)
  [62124] = true,  -- Paladin
  [116189] = true, -- Monk (Provoke (aura))
  [118585] = true, -- Monk (Leer of the Ox)
  [118635] = true, -- Monk (Black Ox Provoke)
}

local function announce(msg, notPlayer)
  if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInRaid() then
    SendChatMessage(msg, "INSTANCE_CHAT")
    --print(msg, "| to INSTANCE_CHAT - in Looking For Raid")
  elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and notPlayer then
    SendChatMessage(msg, "INSTANCE_CHAT")
    --print(msg, "| to INSTANCE_CHAT - in Dungeon Finder (notPlayer)")
  elseif IsInGroup() and not IsInRaid() and notPlayer then
    SendChatMessage(msg, "PARTY")
    --print(msg, "| to PARTY - in Dungeon (notPlayer)")
  elseif IsInRaid() then
    SendChatMessage(msg, "RAID")
    --[[print(msg, "| to RAID - in Raid")
  else
    print(msg)]]
  end
end

local function eventHandler(self, event, ...)
  if event == "ADDON_LOADED" then
    if ... == "aunty" then
      print("|c"..colour1.."aunty|r loaded!")
    end
  else
    local _, subEvent, _, _, sourceName, _, _, _, destName, _, _, spellID, _, _, missType = ...
    if subEvent == "SPELL_AURA_APPLIED" and taunts[spellID] then
      local role = UnitGroupRolesAssigned(sourceName)
      --print(sourceName.." ("..role..") "..destName)
      if role ~= "TANK" then
        if sourceName ~= playerName then
          announce(sourceName .. " taunted " .. destName .."! ("..GetSpellLink(spellID)..")", true)
        else
          announce(sourceName .. " taunted " .. destName .."! ("..GetSpellLink(spellID)..")")
        end
      end
    elseif subEvent == "SPELL_MISSED" and taunts[spellID] then
      if sourceName ~= playerName then
        announce(sourceName .. " failed to taunt " .. destName .. " - "..(missType or "FAILED").."! ("..GetSpellLink(spellID)..")", true)
      else
        announce(sourceName .. " failed to taunt " .. destName .. " - "..(missType or "FAILED").."! ("..GetSpellLink(spellID)..")")
      end
    end
  end
end

frame:SetScript("OnEvent", eventHandler)
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

--[[SLASH_aunty1, SLASH_aunty2 = "/aunty", "/au"
function SlashCmdList.aunty(msg)
  local command, rest = msg:match("^(%S*)%s*(.-)$")
  command = strlower(command)
  
  if command == "toggle" or command =="t" then
    if active then
      frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
      active = false
      print("|c"..colour1.."aunty:|r aunty is now |cffff0000off|r!")
    else
      frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
      active = true
      print("|c"..colour1.."aunty:|r aunty is now |cff00ff00on|r!")
    end
  elseif command == "off" then
    if active then
      frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
      active = false
      print("|c"..colour1.."aunty:|r aunty is now |cffff0000off|r!")
    else
      print("|c"..colour1.."aunty:|r Oops! aunty is already off!")
    end
  elseif command == "on" then
    if active then
      print("|c"..colour1.."aunty:|r Oops! aunty is already on!")
    else
      frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
      active = true
      print("|c"..colour1.."aunty:|r aunty is now |cff00ff00on|r!")
    end
  elseif command == "" then
    print("|c"..colour1.."aunty:|r aunty is currently ".. (active and "|cff00ff00on|r" or "|cffff0000off|r") .."!")
  else
    print("|c"..colour1.."aunty:|r Oops! The command \"" .. msg .. "\" was not recognised.")
  end
end]]--
