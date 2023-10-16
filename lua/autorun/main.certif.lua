FORCE_PUSH = false
if SERVER then
    GameModeValid = include("certif/util/controlGamemode.lua")  // call module methode for gamemode control
    if ( not GameModeValid ) then return end    // ending process if gamemode not valide
    
    util.AddNetworkString("Interface")  // networking for Interface request
    util.AddNetworkString("AskChangeMap") // networking for ask change level ( form setting interface )
    util.AddNetworkString("AskDelete") // networking for ask delete data
    util.AddNetworkString("RequestEdit") // networking for ask modification data
    util.AddNetworkString("EditModeCall") // networking for pre_call modficaition into client interface
    util.AddNetworkString("EditModeApplied") // networking for call modification data
    util.AddNetworkString("RequestAdd") // networking for call add data
    util.AddNetworkString("UpdateWeaponsModel") // networking for update weapons model into client

    include("certif/util/sql/table.lua") //create table into db if not exists
    DELETE = include("certif/util/sql/removeConfig.lua") // remove into db MAP argument
    REGISTER = include("certif/util/sql/register.lua") // get db // Printed argument
    INSERT = include("certif/util/sql/setConfig.lua") // insert into db (FORCE_PUSH=TRUE for update) // MAP, VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF, PLAYERMODEL_TAB arguments
    
    include("certif/events/command.lua") //enable catch for command
    include("certif/events/pre_round.lua") // enable pre-round function check and applied

    include("certif/network/changelevel.lua") // add netowrking for change level
    include("certif/network/deletedata.lua") // add networking for data delete
    include("certif/network/updatedata.lua") // add networking for data update

    include("certif/events/post_gamemode.lua") // change model of weapons pairs map

    AddCSLuaFile("certif/interface/font.lua") // download font

    AddCSLuaFile("certif/util/interface/BoxInput.lua") // download components part
    AddCSLuaFile("certif/util/interface/ModelsInput.lua") // download components part
    AddCSLuaFile("certif/interface/container/config.lua") // download components part
    AddCSLuaFile("certif/interface/layout/main.lua") // download main interface
    AddCSLuaFile("certif/interface/layout/new.lua") // download new interface
end
if CLIENT then
    include("certif/interface/font.lua")
    net.Receive("Interface",function()
        if ( not LocalPlayer():IsSuperAdmin() ) then return end
        build_interface = include("certif/interface/layout/main.lua")
        build_interface(net.ReadTable()) // build new interface with data
    end)
    net.Receive("UpdateWeaponsModel",function()
        local knif = weapons.Get("weapon_mu_knife")
        local gun = weapons.Get("weapon_mu_magnum")
        local entity = scripted_ents.Get("mu_knife")
        
        knif.ViewModel = net.ReadString()
        knif.WorldModel = net.ReadString()
        gun.ViewModel = net.ReadString()
        gun.WorldModel = net.ReadString()
        entity.Model = net.ReadString()

        weapons.Register(knif,"weapon_mu_knife")
        weapons.Register(gun,"weapon_mu_magnum")
        scripted_ents.Register(entity,"mu_knife")
    end)
end