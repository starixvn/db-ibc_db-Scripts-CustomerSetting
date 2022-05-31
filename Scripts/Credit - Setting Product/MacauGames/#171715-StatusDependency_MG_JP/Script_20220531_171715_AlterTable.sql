/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20220531@Eden
	Task: Add new column [redmine : 171715]
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
ALTER TABLE ProductSettingDetail ADD Parent_SportType SMALLINT, Parent_BetType SMALLINT