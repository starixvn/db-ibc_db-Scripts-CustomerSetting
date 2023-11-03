/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231102@Tacy
	Task: Add new ActionID on table Winlimit_ActionSetting
		 https://nexdev.net/issues/196155 [RedmineID: #196155]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

INSERT INTO Winlimit_ActionSetting ([ActionID], [ActionName])
SELECT 6, N'Suspended Account'
UNION
SELECT 7, N'Suspended Account and Blocked Placebet'
GO