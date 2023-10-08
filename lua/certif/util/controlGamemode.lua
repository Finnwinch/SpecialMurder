if CLIENT then return end
local GameModeValid = false
if ( engine.ActiveGamemode() == "murder" ) then
    MsgC(Color(0,255,0),"[Script Murder special edition] has been loaded!\n")
    GameModeValid = true
else
    ErrorNoHalt("[Script Murder special edition] Murder Gamemode not found!")
end
return GameModeValid