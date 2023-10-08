--[[
@TEST-UNITAIRE
$DROP TABLE
lua_run sql.Query("DROP TABLE MurderSpecial")
lua_run sql.Query("DROP TABLE MurderSpecial_playermodel");
$DATA INPUT EXEMPLE
map : gm_flatgrass
PISTOL V : models/weapons/cstrike/c_smg_mac10.mdl
PISTOL W : models/weapons/w_pist_usp.mdl
KNIF V : models/weapons/cstrike/c_rif_famas.mdl
KNIF W : models/weapons/w_rif_m4a1_silencer.mdl
@INTERFACE-STRUCTURE
-- ? lua/certif/interface/
    *Layout main and new use a dframe link only for implement DTextEntry func
    ! all implementation need edit_mode have think methode for catch
    * Font Police --? interface/font.lua
    <>Layout
        <>Main : --? Main was the panel configuration
            $container call
        <>new : --? New was the panel for add configuration
            $BoxInput dependance --? DTextEntry Methode
            $ModelsInput dependace --? Dscroll with DTextEntry methode
                %have enter methode for add new row for models
            $DFrame (GHOST)
            $BoxInput ^ 5 --? for Attributes input
            $DPanel > DScrollPanel > ModelsInput --? simple struct for contain space for the implement of multi-row for models
    <>container : --? only the box model for each config
    $BoxInput dependance --? DTextEntry Methode
    $Box : DPanel --? Container
    %use here think for catch the networking
    $section_command --? section pan for button (select,edit,del)
        $select : --? call changelevel for use
        $edit : --? Enable/Disable modification (Attributes and valid models)
        $del : --? Remove current config to list ( not removed in reason of buf with algo )
    $section_Gun/section_Couteau -- ? Attributes section
        $label --? title section
        $view --? view section
        $world -- ? world section
        #all of them applied require edit_mode
    $section_models -- ? Models selection section
        $management -- ? pan for button action (previous,next,select/deselect)
        $precedent -- ? call precedent models (the last, if not previous)
        $prochain -- ? call next models (the first, if not next)
        $selection -- ? select/deselect models
        #all of them applied require edit_mode
        $visualisation -- ? Show playermodel
        %use here think for catch data
    $section_index -- ? contain map info and models info
        $config --? return map
        $models_count --? return models data
@util-lib
    * All file into lua/certif/util/ was used like module structure for action, most time return function
    <> control gamemode : --$ used for control gamemode ( not working this script without murder )
    <> BoxInut --$ see 20
    <> ModelsInput --$ see 21
@SQL-STRUCTURE
    # 2 TABLE --? util/sql/table.lua
    $MurderSpecial PRIMARY MAP VG VK WG WK USE
    $MurderSpecial_playermodel ID MODEL USE FORGEIN
    *MurderSpecial contain ID PRIMARY KEY that was used into MurderSpecial_playermodel for identify playermodel associate (IDE) FORGEIN KEY
    ! all file with prefix get was used for internal usage (for pre_round applied)
    <> register : --$ usage for get all data for prebuild ( box ) call into command write table
        @arg print
            ? util/sql/register.lua
    <> setConfig : --$ usage for insert, delete and modify data, depend of action edit (can be used for debug( have FORCE_PUSH FOR EDIT WITH INSERT A EXISTS DATA))
    $boolean FORCE_PUSH
        @args MAP, VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF, PLAYERMODEL_TAB
            ? util/sql/setconfig.lua
    <> removeConfig : --$ remove data to display only
        @arg map
            ? util/sql/removeConfig.lua
@NETWORKING-SV reception
        <>ChangeLevel < AskChangeMap
        $ catch request from action select : change level if requester was superadmin
        # use internal methode from util/sql
        <>DeleteData
        $ catch request from action del : remove only if requester was superadmin
        # use internal methode from util/sql
        <>UpdateData <derieved form< RequestEdit | EditModeApplied | RequestAdd
        $ catch request from action update : applied only if requeser was superadmin
        # use internal methode from util/sql
        <>RequestAdd
        $ catch request from action new : applied only if requeser was superadmin
        # use internal methode from util/sql
@NETWORKING-CL reception
        <>Interface
        $ call interface
        <>AttemptEdit
        $ call request to update data --# used into interface/config.lua
@GAMEMODE MODIFICAITON
        *ONLY CHANGE INTO THIS LIGNES
            !gamemodes\murder\entities\weapons
            #weapon_mu_knife
            local special_v = sql.QueryValue("SELECT VIEWMODEL_KNIF FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
            local special_w = sql.QueryValue("SELECT WORLDMODEL_KNIF FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
            SWEP.ViewModel = Either(special_v,special_v,"models/weapons/v_knife_t.mdl")
            SWEP.WorldModel = Either(special_w,special_w,"models/weapons/w_knife_t.mdl")
            #weapon_mu_magnum
            local special_v = sql.QueryValue("SELECT VIEWMODEL_GUN FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
            local special_w = sql.QueryValue("SELECT WORLDMODEL_GUN FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
            SWEP.ViewModel = Either(special_v,special_v,"models/weapons/c_357.mdl")
            SWEP.WorldModel = Either(special_w,special_w,"models/weapons/w_357.mdl")
            !gamemodes\murder\entities\entities\mu_knife
            #init
            local special_w = sql.QueryValue("SELECT WORLDMODEL_KNIF FROM MurderSpecial WHERE MAP="..sql.SQLStr(game.GetMap()))
	        self:SetModel(Either(special_w,special_w,"models/weapons/w_knife_t.mdl"))
        ? normaly, i want to use weapons.Get with reassign methode, but some time is just not work, so i used that way
]]