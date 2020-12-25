/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201225
	Task:  Del Config deploy 1sp dep adjust PT value with 4 decimal [RedmineID:#146574 ]
	DB: DBCust/CustDB
*/
USE CustDB
GO

DELETE FROM Dep_UMConfig WITH (ROWLOCK)    WHERE FunctionType = 1 AND ProductID = 0 AND SettingType = 0 AND LicenseeID = 0