/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Config deploy 1sp dep OddsAdj  [RedmineID:#142532]
	DB: DBCust/CustDB
*/
USE CustDB
GO

UPDATE Dep_UMConfig
SET EndTime = '2020-12-15 4:30:00'
WHERE  [FunctionType] = 1 AND  [ProductID] = 0 AND SettingType = 0 and  LicenseeID = 0