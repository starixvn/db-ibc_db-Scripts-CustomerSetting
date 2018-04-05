/*
    Created: Vicky
    Date: 20180326
    Task: setting for Pragmatic game [RedmineID: 90422]
    DB:DBCust/CustDB
*/
DECLARE @var_sportType SMALLINT = 248,
        @var_bettype SMALLINT = 4101


------------------------------------------------------------------------------------------------
DELETE FROM ProductLaunchedSiteCurrency WHERE SportType =  @var_sportType


