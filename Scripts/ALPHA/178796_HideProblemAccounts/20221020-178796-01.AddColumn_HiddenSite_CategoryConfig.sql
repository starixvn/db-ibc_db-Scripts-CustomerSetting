/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20221020@Tacy
	Task: Add column HiddenSite on table CategoryConfig
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

ALTER TABLE CategoryConfig ADD HiddenSite TINYINT DEFAULT (0);
