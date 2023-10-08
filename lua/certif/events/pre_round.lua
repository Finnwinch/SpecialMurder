hook.Add("OnStartRound", "MyCustomStartNewRoundHook", function()
    local SpecialConfig = include("certif/util/sql/getMap.lua")
    if ( not SpecialConfig ) then return end
    local list = include("certif/util/sql/getPlayerModel.lua")
    local size = #list
    for _,usr in ipairs(player.GetAll()) do
        usr:SetModel(list[math.random(1,size)])
    end
end)