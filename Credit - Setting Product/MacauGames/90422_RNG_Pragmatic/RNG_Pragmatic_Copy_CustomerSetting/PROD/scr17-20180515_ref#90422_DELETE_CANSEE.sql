/*
    Created: 20180515@Vicky 
    Task: delete cansee of PP game
    DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @var_sportType INT = 248

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency 
WHERE SportType = @var_sportType
