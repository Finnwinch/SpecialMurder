return function(MAP, VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF, PLAYERMODEL_TAB)
    if ( not MAP || not VIEWMODEL_GUN || not VIEWMODEL_KNIF || not WORLDMODEL_GUN || not WORLDMODEL_KNIF || not PLAYERMODEL_TAB) then
        return
    end
    if type(PLAYERMODEL_TAB) ~= "table" then PLAYERMODEL_TAB = { {PLAYERMODEL = PLAYERMODEL_TAB, SELECTED = 0 } }end
    local ID = sql.Query([[SELECT ID
        FROM MurderSpecial
        WHERE MAP = ']] .. MAP .. [[';
    ]])
    if ( ID == nil ) then
        sql.Query([[INSERT INTO MurderSpecial(MAP, VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF) VALUES(
            ]] .. sql.SQLStr(MAP) .. "," .. sql.SQLStr(VIEWMODEL_GUN) .. "," .. sql.SQLStr(VIEWMODEL_KNIF) .. "," .. sql.SQLStr(WORLDMODEL_GUN) .. "," .. sql.SQLStr(WORLDMODEL_KNIF) .. [[
        )]])
        local ID = sql.Query([[SELECT ID
            FROM MurderSpecial
            WHERE MAP = ']] .. MAP .. [[';
        ]])[1].ID
        print(ID)
        for _,v in ipairs(PLAYERMODEL_TAB) do
            sql.Query([[INSERT INTO MurderSpecial_playermodel(PLAYERMODEL, USED, IDE) VALUES(
            ]] .. sql.SQLStr(v.PLAYERMODEL) .. "," .. sql.SQLStr(v.SELECTED) .. "," .. ID .. [[
            )]])
        end
        print("Data was been write for ",MAP)
    elseif ( FORCE_PUSH ) then
        sql.Query([[UPDATE MurderSpecial
            SET VIEWMODEL_GUN = ]] .. sql.SQLStr(VIEWMODEL_GUN) .. [[,
            VIEWMODEL_KNIF = ]] .. sql.SQLStr(VIEWMODEL_KNIF) .. [[,
            WORLDMODEL_GUN = ]] .. sql.SQLStr(WORLDMODEL_GUN) .. [[,
            WORLDMODEL_KNIF = ]] .. sql.SQLStr(WORLDMODEL_KNIF) .. [[
            WHERE ID = ]] .. ID[1].ID .. [[;
        ]])
        sql.Query([[DELETE FROM MurderSpecial_playermodel
            WHERE IDE = ]] .. ID[1].ID .. [[;
        ]])
        for _,v in ipairs(PLAYERMODEL_TAB) do
            sql.Query([[INSERT INTO MurderSpecial_playermodel(PLAYERMODEL, USED, IDE) VALUES(
            ]] .. sql.SQLStr(v.PLAYERMODEL) .. "," .. sql.SQLStr(v.SELECTED) .. "," .. ID[1].ID .. [[
            )]])
        end
        print("Data was been rewrite for ",MAP)
    else
        print("Data was stunck in the progress, please think to set FORCE_PUSH ",MAP)
    end
end