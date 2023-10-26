/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231013@Tacy
	Task: reset null column - SIT only
		 https://nexdev.net/issues/192624 [RedmineID: #192624]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE WinLimit_ProductSettingDetail WITH (ROWLOCK, UPDLOCK)
SET IsSuspendedAccount=NULL
WHERE IsSuspendedAccount IS NOT NULL
GO