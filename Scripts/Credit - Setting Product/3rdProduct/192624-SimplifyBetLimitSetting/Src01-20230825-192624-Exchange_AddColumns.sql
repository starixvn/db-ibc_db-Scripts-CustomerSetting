/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20230825@Tacy
	Task: Add column CreditGroupID, LicenseeGroupID on table [exchange]
		 https://nexdev.net/issues/192624 [RedmineID: #192624]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

ALTER TABLE exchange ADD CreditGroupID TINYINT NULL
GO

ALTER TABLE exchange ADD LicenseeGroupID TINYINT NULL
GO