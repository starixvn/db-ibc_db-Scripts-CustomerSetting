/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240402@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class - Support to add CC by Sport Detail [199679]
*/
-- CC Sport Detail
--===================================================================================
ALTER TABLE dbo.CustomerClassRule ADD CustomerClassDetail SMALLINT NULL 
GO
