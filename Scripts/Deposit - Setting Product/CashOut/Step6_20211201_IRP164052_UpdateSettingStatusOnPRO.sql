/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211201@Johnson
	Task: add profile setting for Cash Out
	DB: DBCust/CustDB
*/

USE [CustDB]
GO

UPDATE Dep_ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0
WHERE ProductSettingID = 116