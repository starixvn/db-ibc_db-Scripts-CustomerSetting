/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Enable VGaming [#RM:153938]
	DB: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE ps
SET ps.SettingStatus = 0
FROM dbo.ProductSettingDetail ps WITH(ROWLOCK)
WHERE ProductID = 66