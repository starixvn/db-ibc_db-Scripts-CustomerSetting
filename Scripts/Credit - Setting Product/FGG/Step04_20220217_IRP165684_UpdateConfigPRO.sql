/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220217
	Task: UPDATE global setting for FGG CREDIT
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK)
WHERE SportType = 176

UPDATE ProductSettingSystemDisplay WITH(ROWLOCK)
SET SettingType = 18,
	DisplayMode = 3
WHERE SystemID IN (5,9)
	AND ProductID = 64
	AND SettingType = 1