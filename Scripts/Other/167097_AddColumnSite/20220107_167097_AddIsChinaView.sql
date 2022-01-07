/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220107
	Task:  Add a new column into Site table RedmineID:#167097
	DB: DBCust/CustDB
*/

USE CustDB
GO

ALTER TABLE dbo.Site ADD IsChinaView BIT NULL
GO