return function(MAP)
    /* BUG WITH TRAITEMENT FOR OTHER ID,
    DONT HAVE ANY TIME TO PATCH THAT, SO I USE KICKLY METHODE
    local ID = sql.Query([[SELECT ID
    FROM MurderSpecial
    WHERE MAP =']]..MAP..[[']])
    if ( ID ) then
        ID = ID[1].ID
        sql.Query([[DELETE FROM MurderSpecial
            WHERE ID = ]] .. ID)
        sql.Query([[DELETE FROM MurderSpecial_playermodel
        WHERE IDE = ]] .. ID)
        print("Data was been delete ",MAP)
    else
        print("No Data found from",MAP)
    end
    */
    sql.Query([[UPDATE MurderSpecial
            SET USED = 0
            WHERE MAP = ]] .. MAP.. [[;
    ]])
end