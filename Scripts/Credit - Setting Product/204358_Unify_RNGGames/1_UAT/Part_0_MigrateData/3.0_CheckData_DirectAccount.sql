/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: @Helios
	Date: 07/06/2024
	Task: Migrate RNG Keno For Headline Is Hidden [#204358]
		- Indirect Account - Line Super:
			Scr 1: 
				product status = disable
				bet setting = 0 / 0/ 0
				Super max PT = 0.9 (max value của Keno đang offer)

			Scr 2:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value= 0 (follow rule create new customer)

		- Direct Account:
			For direct Master/ Agent/ Members, will follow:
				product status = disable
				bet setting = 0 / 0/ 0.1
				PT value = max value
				
	DB: DBCust/CustDB
*/
DECLARE 

	@SportType			SMALLINT	= 202,
	@BetType			SMALLINT	= 1501,
	@BitmapOrder_RNGKeno	TINYINT

SELECT TOP 1 @BitmapOrder_RNGKeno = bitmapOrder FROM ProductStatusProfile WITH(NOLOCK) WHERE Sporttype = @SportType AND Bettype = @BetType

--Get Super Account Affect
CREATE TABLE #SuperID (SuperID INT , PRIMARY KEY CLUSTERED (SuperID))

INSERT INTO #SuperID 
	(
		SuperID
	)
SELECT c.custid 
FROM Customer c WITH (NOLOCK) 
WHERE c.username IN ('SA-US$','SA-TB','SA-HK$','SA-EURO','SA-AUD','SA-GBP','SA-RMB','SA-IN','SA-JPY','SA-PE','SH-HK$','SH-RMB','SS-RMB')

CREATE TABLE #CustCheck
	(
		Note	     VARCHAR(18)
	    , LastLogin  SMALLDATETIME 
	    , site	     VARCHAR(10)
	    , ExchangeId INT
	    , currency   NVARCHAR(50)
	    , username   VARCHAR(30)
	    , srecommend INT
	    , mrecommend INT
	    , recommend  INT
	    , custid     INT
	    , IsHidden	BIT
	    , IsDisable	BIT
	    , roleid     TINYINT

	)


INSERT INTO #CustCheck 
	(
		Note
	    , LastLogin
	    , site
	    , ExchangeId
	    , currency
	    , username
	    , srecommend
	    , mrecommend
	    , recommend
	    , custid
	    , roleid
	)
SELECT 'Get direct Account' AS Note,  ci.lastlogged , ci.site , e.ExchangeId , e.currency , ci.username , ci.srecommend , ci.mrecommend, ci.recommend , ci.custid ,  ci.roleid
FROM #SuperID si
INNER JOIN Customer ci WITH(NOLOCK) ON si.SuperID = ci.srecommend
INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.ExchangeId
WHERE EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
UNION ALL


SELECT 'Get Dummy Account' AS Note , ci.lastlogged , ci.site , e.ExchangeId , e.currency , ci.username , ci.srecommend , ci.mrecommend, ci.recommend , ci.custid ,  ci.roleid
FROM #SuperID si
INNER JOIN Customer ci WITH(NOLOCK) ON si.SuperID = ci.srecommend
INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.ExchangeId
WHERE EXISTS (SELECT custid from dbo.Acc_CustDirect acd WITH(NOLOCK) WHERE CustID = ci.custid)


--Get ProductStatus Of SabaCasino
UPDATE temCust
	SET 
		IsHidden = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsHidden,  40))
	,	IsDisable = (SELECT value FROM dbo.f_CustSetting_ProductStatusSel (cs.bitmapIsDisabled,  40))
FROM #CustCheck temCust
INNER JOIN CustProductStatus cs WITH(NOLOCK) ON cs.CustID = temCust.CustID


SELECT 'Missing Data PT' AS Note , ci.lastlogged , ci.site , e.ExchangeId , e.currency , ci.username , ci.srecommend , ci.mrecommend, ci.recommend , ci.custid ,  ci.roleid
FROM Customer ci WITH(NOLOCK)
INNER JOIN exchange e WITH(NOLOCK) ON ci.currency = e.ExchangeId
WHERE ci.srecommend IN (32,42)


SELECT '#CustCheck' AS Note, * FROM #CustCheck

SELECT 'CustPTSetting3rd_Agent' AS Descr , temCust.* , cpa.CustID, cpa.SportType, cpa.BetType, cpa.IsLive, cpa.IsAutoMasterPT, cpa.IsAutoSuperPT, cpa.SuperPT, cpa.MasterPT, cpa.AgentPT, cpa.AutoSuperPT, cpa.AutoMasterPT
FROM #CustCheck temCust
INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON temCust.custid = cpa.CustID
WHERE cpa.SportType = @SportType
AND cpa.BetType = @BetType

UNION ALL
SELECT 'CustPTSetting3rd_Member' AS Descr , temCust.* , cpa.CustID, cpa.SportType, cpa.BetType, cpa.IsLive, cpa.IsAutoMasterPT, cpa.IsAutoSuperPT, cpa.SuperPT, cpa.MasterPT, cpa.AgentPT, cpa.AutoSuperPT, cpa.AutoMasterPT
FROM #CustCheck temCust
INNER JOIN CustPTSetting3rd_Member cpa WITH (NOLOCK) ON temCust.custid = cpa.CustID
WHERE cpa.SportType = @SportType
AND cpa.BetType = @BetType

--SELECT 'CustBetSetting3rd_Agent' AS Descr , *
--FROM #CustCheck temCust
--INNER JOIN CustBetSetting3rd_Agent cpa WITH (NOLOCK) ON temCust.custid = cpa.CustID
--WHERE cpa.SportType = @SportType
--AND cpa.BetType = @BetType
--UNION ALL
--SELECT 'CustBetSetting3rd_Member' AS Descr , *
--FROM #CustCheck temCust
--INNER JOIN CustBetSetting3rd_Member cpa WITH (NOLOCK) ON temCust.custid = cpa.CustID
--WHERE cpa.SportType = @SportType
--AND cpa.BetType = @BetType



DROP TABLE #SuperID
DROP TABLE #CustCheck