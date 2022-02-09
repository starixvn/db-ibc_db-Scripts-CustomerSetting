/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220209@Winfred
	Task: Update Setting detail [#RM:167635]
	DB: DBCUST-CustDB
*/

-- Update Macau 	
DECLARE @productID SMALLINT ,@settingType SMALLINT
SET @settingType =  13 -- Status	
SET @productID = 22 -- Macau Games

UPDATE ProductSettingDetail WITH(UPDLOCK,ROWLOCK)
SET SettingLevel = 2
WHERE ProductID = @productID 
		AND SettingType = @settingType 
		AND SportType  = 212 
		AND BetType = 4001
