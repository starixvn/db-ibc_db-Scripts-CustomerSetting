/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:  20220106
	Task:  Disable status Jackpot RedmineID:#165587
	DB: DBCust/CustDB
	P/s :  Step 3 Disable status for real currency
*/
DECLARE @productID SMALLINT ,@settingType SMALLINT,@betType SMALLINT,@sportType SMALLINT
SET @settingType =  13 -- Status	
SET @productID = 22 -- Macau Games
SET @sportType = 9904
SET @betType = 4001 

UPDATE ps
SET ps.SettingStatus = 2
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK)
WHERE ProductID = @productID  AND SportType = @sportType AND BetType = @betType AND SettingType = @settingType

