return function(printed)
    local resultTable = {}
    local c = sql.Query([[SELECT COUNT() FROM MurderSpecial]])[1]["COUNT()"]
    if (not c && printed) then print("no data found") return end
    for i = c, 1, -1 do
        local valide = sql.Query([[SELECT USED 
        FROM MurderSpecial
        WHERE ID=]]..sql.SQLStr(i))
        if (USED=="0") then continue end
        local data_primary = sql.Query([[SELECT MAP, VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF
        FROM MurderSpecial
        WHERE ID=]].. sql.SQLStr(i))


        local data_secondary = sql.Query([[SELECT PLAYERMODEL, USED
        FROM MurderSpecial_playermodel
        WHERE IDE=]].. sql.SQLStr(i))

        if (printed) then
            print("Data",i,"control into register")
            //PrintTable(data_primary)
            //PrintTable(data_secondary)
        end
        models = {}
        for k,v in ipairs(data_secondary) do
            models[#models + 1] = {
                PLAYERMODEL = v.PLAYERMODEL,
                SELECTED = v.USED
            }
        end
        resultTable[i] = {
            MAP = data_primary[1].MAP,
            VIEWMODEL_GUN = data_primary[1].VIEWMODEL_GUN,
            VIEWMODEL_KNIF = data_primary[1].VIEWMODEL_KNIF,
            WORLDMODEL_GUN = data_primary[1].WORLDMODEL_GUN,
            WORLDMODEL_KNIF = data_primary[1].WORLDMODEL_KNIF,
            PLAYERMODEL = models
        }
    end
    return resultTable
end