-- -----------------------------------------------------------------------------
-- Cancel cinematics after they start
-- -----------------------------------------------------------------------------
local f = CreateFrame("frame")
f:RegisterEvent("CINEMATIC_START")
f:SetScript("OnEvent", function(_, e)
    if e == "CINEMATIC_START" then
        if not IsControlKeyDown() then
            CinematicFrame_CancelCinematic()
        end
    end
end)



-- -----------------------------------------------------------------------------
-- Hook movies and stop them before they get called
-- -----------------------------------------------------------------------------
local PlayMovie_hook = MovieFrame_PlayMovie
MovieFrame_PlayMovie = function(...)
    if IsControlKeyDown() then
        PlayMovie_hook(...)
    else
        GameMovieFinished()
    end
end
