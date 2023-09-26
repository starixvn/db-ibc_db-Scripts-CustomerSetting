/*<info serverAlias="DBACC-bodb02"></info>*/
--USE CustDB
--GO
/*
	Created: 20230802@Winfred
	DB:DBACC-bodb02
	Task:  Create View Dep customer class
	Revisions:
		- 20230802@Winfred:  LAP - Player Segmentation - Add Risk Level's last update time [RedmineID: #191101]
*/
--DROP VIEW [dbo].[Dep_CustomerClass]
CREATE VIEW [dbo].[Dep_CustomerClass]
AS
SELECT        CustID, CustomerClass, CategoryID, ModifiedDate, OldCustomerClass
FROM   DBCUST.CUSTDB.dbo.Dep_CustomerClass
GO



