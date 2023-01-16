/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221121@Eden
	Task: Delete unused settings of VS and RNG Lottery [#180640]
	DB: DBCust/CustDB
*/
USE CustDB
GO
----> DELETE unused setting of ProductStatusSiteCurrency
	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK) 
	WHERE sporttype = 180

	DELETE 
	FROM ProductStatusSiteCurrency WITH(ROWLOCK)  
	WHERE sporttype = 220 and BetType = 1021

--> DELETE unused setting of ProductBetSetting
	DELETE p
	FROM ProductBetSetting p WITH(ROWLOCK) 
	WHERE Sporttype IN(180,181,182,183,184,185,186,190,191,192,193,199,231)

	DELETE p
	FROM ProductBetSetting p WITH(ROWLOCK) 
	WHERE Sporttype = 220 AND bettype <> 1024

--> DELETE ProductSettingSystemDisplay
	DELETE 
	FROM ProductSettingSystemDisplay WITH(ROWLOCK) 
	WHERE productid = 44 AND SettingType = 6