/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20230712@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM]  Customer Class - Enhance for CC [187368]
*/
-- Disable Parlay data
--===================================================================================
ALTER TABLE dbo.CustomerClassRule DROP COLUMN EnableParlay 
GO
