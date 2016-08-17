local function customFixAnchors(self, ...)
AlertFrame:ClearAllPoints()
AlertFrame:SetPoint("CENTER",UIParent,"CENTER",-400,0)
end

hooksecurefunc(AlertFrame,"UpdateAnchors", customFixAnchors)
