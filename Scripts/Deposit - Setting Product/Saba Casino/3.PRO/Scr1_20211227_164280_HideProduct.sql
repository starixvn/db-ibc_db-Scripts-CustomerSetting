/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Hide Saba Casino [#164280]
	DB: DBCUST/CustDB
*/
USE CustDB
GO
UPDATE [Dep_ProductSettingDetail] WITH(ROWLOCK,UPDLOCK)
SET SettingStatus = 2
WHERE SportType = 208