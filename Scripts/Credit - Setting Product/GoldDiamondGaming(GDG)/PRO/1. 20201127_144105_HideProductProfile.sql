/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20201127@Tina
	Task: Hide product profile for Gold Diamond Gaming
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE S
SET S.SettingStatus = 2
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 236



--SELECT * FROM ProductSettingDetail S WITH (NOLOCK) where SportType = 236




