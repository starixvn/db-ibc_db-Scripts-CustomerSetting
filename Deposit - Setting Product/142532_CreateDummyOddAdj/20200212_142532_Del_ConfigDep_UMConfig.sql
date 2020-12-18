/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Del Config deploy 1sp dep OddsAdj  [RedmineID:#142532]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DELETE FROM Dep_UMConfig WITH (ROWLOCK)    WHERE FunctionType = 1 AND ProductID = 0 AND SettingType = 0 AND LicenseeID = 0