/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Enable Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE S
SET S.SettingStatus = 0
FROM ProductSettingDetail S WITH(ROWLOCK) 
WHERE Sporttype = 208