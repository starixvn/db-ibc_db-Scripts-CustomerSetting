/*<info serverAlias=DBCUST-CustDB></info>*/
/*
	Created: Elodie
	Date: 20240716
	Task: Drop IsDeleted column on CustSub [RedmineID:#206738]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

ALTER TABLE custSub DROP COLUMN IsDeleted 
GO
