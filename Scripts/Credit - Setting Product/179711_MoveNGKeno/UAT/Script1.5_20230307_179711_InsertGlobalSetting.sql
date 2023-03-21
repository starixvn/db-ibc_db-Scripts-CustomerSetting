/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230314@Eden
	Task: Init global setting [#179711]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DELETE FROM ProductStatusProfile WITH(ROWLOCK) WHERE [bitmapOrder] IN (40,41)

INSERT INTO ProductStatusProfile ([Sporttype], [Bettype], [bitmapOrder])
SELECT 161, 81, 41 UNION ALL
SELECT 202, 1501, 40

----> INSERT ProductSettingSystemDisplay ( Hide on Ext NAP)
--IF NOT EXISTS( SELECT 1 FROM ProductSettingSystemDisplay WITH(NOLOCK) WHERE ProductID = 44 AND SettingType = 23)
--INSERT INTO ProductSettingSystemDisplay(SystemID,ProductID,SettingType,DisplayMode)
--SELECT 5,44,23,3 UNION ALL
--SELECT 9,44,23,3 

---->Insert ProductSettingType
INSERT INTO ProductSettingType(SettingType,SettingName,SettingNameDetail)
SELECT 23,'Bet Setting','Bet Setting 23'
WHERE NOT EXISTS( SELECT 1 FROM ProductSettingType WITH(NOLOCK) WHERE SettingType = 23)

----> Insert ProductStatusSiteCurrency
--DELETE 
--FROM ProductStatusSiteCurrency WITH(ROWLOCK) 
--WHERE sporttype IN(202, 161)

--INSERT INTO ProductStatusSiteCurrency(SportType,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced)
--SELECT SportType = 202 ,BetType,Currency,SiteID,IsHidden,IsDisabled,HasSynced 
--FROM ProductStatusSiteCurrency WITH(NOLOCK) 
--WHERE sporttype = 180 and BetType = 1201

--INSERT INTO ProductBetSetting(Sporttype,Bettype,Currency,MinBet,IsDep,MaxBet,MaxPerMatch,DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)
--SELECT Sporttype = 202,Bettype = 1501,exchangeid,MinBet = 0,IsDep = 0
--		,MaxBet = 0,MaxPerMatch = 0,DefaultMinBet = NULL ,DefaultMaxBet = NULL,DefaultMaxPerMatch  = NULL
--FROM exchange WITH(NOLOCK)
--WHERE OfferSite IN(0,1)

/*
SELECT * FROM ProductStatusProfile (NOLOCK) WHERE [bitmapOrder] IN(40,41)
SELECT * FROM ProductSettingSystemDisplay WITH(NOLOCK) WHERE ProductID = 44
SELECT * FROM ProductSettingType WITH(NOLOCK) WHERE SettingType = 23
SELECT * FROM ProductBetSetting WITH(NOLOCK) WHERE sporttype = 202 AND bettype = 1501
*/
