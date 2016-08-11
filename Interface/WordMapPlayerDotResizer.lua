local defaults = {
	party = 30,
	raid = 30,
}

local _G = _G
local pairs = pairs
local tonumber = tonumber
local strlower = strlower
local strsplit = strsplit


local f = CreateFrame("FRAME")
f.events = {}


function f.events.VARIABLES_LOADED(self, event, ...)
	--update Dot sizes
	self:SetDotSizes()
end


f:SetScript("OnEvent", function(self, event, ...)
	if self.events[event] then
		self.events[event](self, event, ...)
	end
end)

for event,func in pairs(f.events) do
	f:RegisterEvent(event)
end


local ps, rs, dot
function f:SetDotSizes()
	ps = defaults.party
	rs = defaults.raid
	
	for i=1,4 do
		dot = _G["WorldMapParty"..i]
		if dot then
			dot:SetSize(ps,ps)
		end
	end
	
	for i=1,40 do
		dot = _G["WorldMapRaid"..i]
		if dot then
			dot:SetSize(rs,rs)
		end
	end
end

