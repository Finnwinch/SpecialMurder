net.Receive("AskDelete",function(_,usr)
    if ( not usr:IsSuperAdmin() ) then return end
    DELETE(net.ReadString())
    print("deleted!")
end)