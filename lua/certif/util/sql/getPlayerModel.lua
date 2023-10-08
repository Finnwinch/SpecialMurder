local PLAYERMODEL_LIST = sql.Query([[SELECT PLAYERMODEL
    FROM MurderSpecial m
    INNER JOIN MurderSpecial_playermodel e ON m.ID = e.IDE
    WHERE m.MAP = ']] .. game.GetMap().. [[' AND e.USED;
]])

if PLAYERMODEL_LIST == nil then
    PLAYERMODEL_LIST = sql.Query([[SELECT PLAYERMODEL
        FROM MurderSpecial m
        INNER JOIN MurderSpecial_playermodel e ON m.ID = e.IDE
        WHERE m.MAP = ']] ..game.GetMap() .. [[';
    ]])
end
local resultTable = {}
if PLAYERMODEL_LIST then
    for _, row in ipairs(PLAYERMODEL_LIST) do
        table.insert(resultTable, row.PLAYERMODEL)
    end
end

return resultTable