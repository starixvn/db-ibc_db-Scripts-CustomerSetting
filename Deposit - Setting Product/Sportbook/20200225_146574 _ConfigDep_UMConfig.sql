/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20201225
	Task:  Config deploy 1sp dep adjust PT value with 4 decimal [RedmineID:#146574 ]
	DB: DBCust/CustDB
*/
USE CustDB
GO

INSERT INTO Dep_UMConfig ([FunctionType],[ProductID],[SettingType],[LicenseeID],[BeginTime],[EndTime])
VALUES (1, 0 , 0 , 0 , '2020-12-27 23:00:00' , '2020-12-27 23:30:00')