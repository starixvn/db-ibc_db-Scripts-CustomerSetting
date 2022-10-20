/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221020@Tacy
	Task: Initial data into HiddenSite column on table CategoryConfig
		https://nexdev.net/issues/178796 RedmineID: #178796
	Database: DBCUST-CustDB
*/
/*
	- Default = 0
	- Credit  = 1
	- Deposit = 2
	- All     = 3
*/
USE CustDB
GO

UPDATE CategoryConfig WITH (ROWLOCK, UPDLOCK)
SET HiddenSite=CASE WHEN CustomerClass IN (301,3000,3001) THEN 1 ELSE 0 END