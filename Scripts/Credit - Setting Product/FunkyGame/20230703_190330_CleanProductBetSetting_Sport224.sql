/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230703
	Task: Clean Funky Games' bet setting on ProductBetSetting
		https://nexdev.net/issues/190330
	DB: DBCust/CustDB 
*/ 
DELETE FROM ProductBetSetting WITH (ROWLOCK)
WHERE Sporttype=224