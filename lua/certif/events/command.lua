
if CLIENT then return end
hook.Add("PlayerSay","chat commande",function(usr,text)
    if ( not usr:IsSuperAdmin() ) then return end
    if ( string.lower(text) != "mu_openconfig" ) then return end
    net.Start("Interface")
    net.WriteTable(REGISTER(true))
    net.Send(usr)
    return ""
end)
concommand.Add("mu_openconfig",function(usr)
    if ( not usr:IsSuperAdmin() ) then return end
    net.Start("Interface")
    net.WriteTable(REGISTER(true))
    net.Send(usr)
end)