return sql.QueryValue([[
    SELECT MAP
    FROM MurderSpecial
    WHERE MAP = ']] ..game.GetMap().. [[';
]])