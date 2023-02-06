/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Remove testing sport [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO

--> Config new for ProductSettingDetail
	DELETE p
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE SportType IN(9908,9909)

	DELETE p
	FROM ProductSettingDetail p WITH(ROWLOCK,UPDLOCK) 
	WHERE sporttype = 220 and bettype = 1024  AND settingtype = 13

	