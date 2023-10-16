hook.Add("PlayerInitialSpawn","attemptToUpdateWeaponsModel",function(usr)
    local knif = weapons.Get("weapon_mu_knife")
    local gun = weapons.Get("weapon_mu_magnum")
    local entity = scripted_ents.Get("mu_knife")

    local Kspecial_v = sql.QueryValue("SELECT VIEWMODEL_KNIF FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
    local Kspecial_w = sql.QueryValue("SELECT WORLDMODEL_KNIF FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
    local Gspecial_v = sql.QueryValue("SELECT VIEWMODEL_GUN FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
    local Gspecial_w = sql.QueryValue("SELECT WORLDMODEL_GUN FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))


    weapons.Register(knif,"weapon_mu_knife")
    weapons.Register(gun,"weapon_mu_magnum")
    scripted_ents.Register(entity,"mu_knife")

    knif.ViewModel = Either(Kspecial_v,Kspecial_v,"models/weapons/v_knife_t.mdl")
    knif.WorldModel = Either(Kspecial_w,Kspecial_w,"models/weapons/w_knife_t.mdl")
    gun.ViewModel = Either(Gspecial_v,Gspecial_v,"models/weapons/c_357.mdl")
    gun.WorldModel = Either(Gspecial_w,Gspecial_w,"models/weapons/w_357.mdl")
	entity.Model = knif.WorldModel

    net.Start("UpdateWeaponsModel")
    net.WriteString(knif.ViewModel)
    net.WriteString(knif.WorldModel)
    net.WriteString(gun.ViewModel)
    net.WriteString(gun.WorldModel)
    net.WriteString(knif.WorldModel)
    net.Send(usr)
end)