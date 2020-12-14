/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201202
	Task:  Config deploy 1sp dep OddsAdj  [RedmineID:#142532]
	DB: DBCust/CustDB
*/
USE CustDB
GO

INSERT INTO Dep_UMConfig ([FunctionType],[ProductID],[SettingType],[LicenseeID],[BeginTime],[EndTime])
VALUES (1, 0 , 0 , 0 , '2020-12-15 00:00:00' , '2020-12-15 00:30:00')