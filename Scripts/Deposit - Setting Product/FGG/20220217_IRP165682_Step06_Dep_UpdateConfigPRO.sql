/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20220217
	Task: UPDATE global setting for FGG DEPOSIT
	DB: DBCust/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.Dep_ProductSettingDetail ps WITH(ROWLOCK)
WHERE SportType = 176