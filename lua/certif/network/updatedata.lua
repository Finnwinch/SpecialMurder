net.Receive("RequestEdit",function(_,usr)
    if (not usr:IsSuperAdmin()) then return end
    net.Start("EditModeCall")
    net.Send(usr)
end)
net.Receive("EditModeApplied",function(_,usr)
    if (not usr:IsSuperAdmin()) then return end
    local models = net.ReadTable()
    local tmp_force
    if (not FORCE_PUSH) then tmp_force = true end
    if (tmp_force) then FORCE_PUSH = not FORCE_PUSH end
    INSERT(net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),net.ReadString(),models)
    if (tmp_force) then FORCE_PUSH = not FORCE_PUSH end
end)
net.Receive("RequestAdd",function(_,usr)
    if (not usr:IsSuperAdmin()) then return end
    local brut = net.ReadTable()
    if ( brut.map == "" || brut.vg == "" || brut.vk == "" || brut.wg == "" || brut.wk == "" || model=="" ) then return end
    local model = {}
    for k,v in ipairs(brut.models) do
        model[#model + 1] = {PLAYERMODEL = v,SELECTED = "0"}
    end
    INSERT(brut.map,brut.vg,brut.vk,brut.wg,brut.wk,model)
end)