local Attribues =  sql.Query([[
    SELECT VIEWMODEL_GUN, VIEWMODEL_KNIF, WORLDMODEL_GUN, WORLDMODEL_KNIF
    FROM MurderSpecial
    WHERE MAP = ']] ..game.GetMap().. [[';
]])
local resultTable = {}
resultTable.viewmodelGun = Attribues[1].VIEWMODEL_GUN
resultTable.viewmodelKnif = Attribues[1].VIEWMODEL_KNIF
resultTable.worldmodelGun = Attribues[1].WORLDMODEL_GUN
resultTable.worldmodelKnif = Attribues[1].WORLDMODEL_KNIF

return resultTable