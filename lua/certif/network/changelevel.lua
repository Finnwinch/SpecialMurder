net.Receive("AskChangeMap",function(_,usr)
    if ( not usr:IsSuperAdmin() ) then return end
    game.ConsoleCommand("changelevel " .. net.ReadString() .. "\n")
end)