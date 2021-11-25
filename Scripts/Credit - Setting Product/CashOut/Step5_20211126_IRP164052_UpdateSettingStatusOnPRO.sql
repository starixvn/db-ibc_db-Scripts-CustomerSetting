/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211126@Johnson
	Task: update settingstatus = 0 for Cash Out on PRO
	DB: DBCust/CustDB
*/

USE [CustDB]
GO

UPDATE ProductSettingDetail WITH(ROWLOCK)
SET SettingStatus = 0
WHERE sporttype = 9903
	AND settingType = 4
