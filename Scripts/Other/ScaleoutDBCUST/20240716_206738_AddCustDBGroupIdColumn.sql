/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Add CustDBGroupID Column [RedmineID:#206738]
	DB: DBCust/CustDB
*/
USE CustDB
GO
ALTER TABLE Site ADD CustDBGroupID SMALLINT NOT NULL

ALTER TABLE [dbo].Site ADD CONSTRAINT [DF_Site_CustDBGroupID]  DEFAULT (0) FOR CustDBGroupID
GO



