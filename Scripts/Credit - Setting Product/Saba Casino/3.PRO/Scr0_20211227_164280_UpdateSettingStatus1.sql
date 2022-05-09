/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: mode UAT testing for Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 1
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 208