/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Remove some setting of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
DELETE p
FROM ProductBetSetting p WITH(ROWLOCK,UPDLOCK) 
WHERE Sporttype IN (180,181,182,183,184,185,186,190,191,192,193,199,231)

DELETE p
FROM ProductBetSetting p WITH(ROWLOCK,UPDLOCK) 
WHERE Sporttype = 220 AND bettype <> 1024