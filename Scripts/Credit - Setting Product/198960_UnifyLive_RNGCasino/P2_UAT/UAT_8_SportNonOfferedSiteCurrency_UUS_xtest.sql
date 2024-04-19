/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Inital Data Setting SportNonOfferedSiteCurrency - UUS Currency [#198960]  
	DB: DBCust/CustDB
*/

DECLARE @Temp_Site TABLE (SiteId INT)
DECLARE @Temp_Currency TABLE (ExchangeId INT)

INSERT INTO @Temp_Site (SiteId)
SELECT SiteID 
FROM Site s WITH (NOLOCK) 
WHERE s.isLicensee = 0 
AND s.isDeposit = 0 
AND s.isActive = 1


INSERT INTO @Temp_Currency (ExchangeId)
SELECT e.ExchangeId
FROM exchange e WITH (NOLOCK)
WHERE e.isActive = 1


DECLARE  @Temp_SportTypeBetType TABLE (
		SportType			SMALLINT
	    , BetType			INT
	    , IsHidden			BIT
	    , RealProductID		TINYINT
	    )

CREATE TABLE #Temp_CollectData (
		SportType			SMALLINT
	    , BetType			INT
	    , RealProductID		INT
	    , IsHidden			BIT
	    , IsHidden_NonOffer		BIT
	    , SiteID_NonOffer		INT
	    , Currency_NonOffer		TINYINT
)

CREATE TABLE #Temp_SportNonOffferSiteCurrency (
		SportType			SMALLINT
	    , BetType			INT
	    , Currency			INT
	    , SiteID			INT
	    , RealProductID		TINYINT
	    PRIMARY KEY (SportType , BetType , SiteID , Currency)
		)

-- Collect SportType BetType Affected
INSERT INTO @Temp_SportTypeBetType (SportType , BetType , IsHidden, RealProductID)
SELECT psp.SportType , psp.BetType , psp.IsHidden , psp.RealProductID
FROM ProductSettingProfile psp WITH (NOLOCK)
WHERE  psp.SettingType IN (4,11,13,21)
AND (
	ProductID IN (6 , 18 , 41 , 42 , 64 , 66)
	OR 
	(ProductID = 44 AND psp.SportType = 224 AND psp.BetType  = 5500)
)
AND psp.SportType IN (171,176,200,208,224,245)


INSERT INTO #Temp_CollectData 
	(
		SportType
	    , BetType
	    , RealProductID
	    , IsHidden
	    , IsHidden_NonOffer
	    , SiteID_NonOffer
	    , Currency_NonOffer
	)
SELECT tsno.SportType , tsno.BetType, tsno.RealProductID , tsno.IsHidden , pssc.IsHidden , pssc.SiteID, pssc.Currency
FROM @Temp_SportTypeBetType tsno
INNER JOIN ProductStatusSiteCurrency pssc WITH (NOLOCK) ON tsno.SportType = pssc.SportType AND tsno.BetType = pssc.BetType

------------------------------------------------------------------

CREATE TABLE  #Temp_SampleDataOffer (
		SportType			SMALLINT
	    , BetType			INT
	    , RealProductID		INT
	    , SiteID_Offer		INT
	    , Currency_Offer		TINYINT )

CREATE TABLE  #Temp_SiteOffer (
		SportType			SMALLINT
	    , BetType			INT
	    , RealProductID		INT
	    , SiteID_Offer		INT
	    , Currency_Offer		TINYINT 
	    )


CREATE TABLE  #Temp_CurrencyOffer (
		SportType			SMALLINT
	    , BetType			INT
	    , RealProductID		INT
	    , SiteID_Offer		INT
	    , Currency_Offer		TINYINT )


------------------------------------------------------------

-- Case 1: Some Special Site - Currency is Offer, so find Real SportType - BetType Non Offer
-- Condition : ProductStatusSiteCurrency.IsHidden = 0 , ProductStatusSiteCurrency.Currency <> 0

INSERT INTO #Temp_SampleDataOffer 
	(
		SportType
	    , BetType
	    , RealProductID
	    , SiteID_Offer
	    , Currency_Offer
	)
SELECT DISTINCT tem.SportType, tem.BetType, tem.RealProductID, tem.SiteID_NonOffer,tem.Currency_NonOffer
FROM #Temp_CollectData tem
WHERE tem.IsHidden  = 1				-- Non Offer From ProductSettingDetail
AND tem.IsHidden_NonOffer = 0				-- Offer From ProductStatusSiteCurrency
AND tem.Currency_NonOffer <> 0 


; WITH Cte_SiteOffer AS (
	SELECT DISTINCT tem.SportType, tem.BetType, tem.RealProductID, tem.SiteID_NonOffer
	FROM #Temp_CollectData tem
	WHERE tem.IsHidden  = 1
	AND tem.IsHidden_NonOffer = 0
	AND tem.Currency_NonOffer <> 0 
)

INSERT INTO #Temp_SiteOffer 
	(
		SportType
	    , BetType
	    , RealProductID
	    , SiteID_Offer
	    , Currency_Offer
	)
SELECT Cte.SportType , Cte.BetType , Cte.RealProductID , Cte.SiteID_NonOffer , c.ExchangeId
FROM Cte_SiteOffer  AS Cte
CROSS APPLY @Temp_Currency c


DELETE so
FROM #Temp_SiteOffer so
INNER JOIN #Temp_SampleDataOffer tsdo ON so.SportType = tsdo.SportType AND so.BetType = tsdo.BetType AND so.RealProductID = tsdo.RealProductID AND so.SiteID_Offer = tsdo.SiteID_Offer AND so.Currency_Offer = tsdo.Currency_Offer


; WITH Cte_CurrencyOffer AS (
	SELECT DISTINCT tem.SportType, tem.BetType, tem.RealProductID, tem.Currency_NonOffer
	FROM #Temp_CollectData tem
	WHERE tem.IsHidden   = 1
	AND tem.IsHidden_NonOffer = 0
	AND tem.Currency_NonOffer <> 0 
)

INSERT INTO #Temp_CurrencyOffer 
	(
		SportType
	    , BetType
	    , RealProductID
	    , SiteID_Offer
	    , Currency_Offer
	)
SELECT Cte.SportType , Cte.BetType , Cte.RealProductID , s.SiteId , Cte.Currency_NonOffer
FROM Cte_CurrencyOffer  AS Cte
CROSS APPLY @Temp_Site s


DELETE so
FROM #Temp_CurrencyOffer so
INNER JOIN #Temp_SampleDataOffer tsdo ON so.SportType = tsdo.SportType AND so.BetType = tsdo.BetType AND so.RealProductID = tsdo.RealProductID AND so.SiteID_Offer = tsdo.SiteID_Offer AND so.Currency_Offer = tsdo.Currency_Offer

INSERT INTO #Temp_SportNonOffferSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)

SELECT SportType , BetType , Currency_Offer AS Currency , SiteID_Offer AS SiteID, RealProductID  FROM #Temp_SiteOffer
UNION  
SELECT SportType , BetType , Currency_Offer AS Currency , SiteID_Offer AS SiteID, RealProductID FROM #Temp_CurrencyOffer


------------------------------------------
-- Case 2.1: Remove Data Of Site 1216 , 1233 Of Vgaming

DELETE FROM #Temp_SportNonOffferSiteCurrency WHERE SportType = 171 AND SiteID IN (1216,1233)


-- Case 2.2: Condition : ProductStatusSiteCurrency.IsHidden = 0 , ProductStatusSiteCurrency.Currency = 0

; WITH Cte_FGG_FunkyGames_VirtualGames AS(
	SELECT DISTINCT tem.SportType , tem.BetType , tem.RealProductID , tem.SiteID_NonOffer AS SiteOffer
	FROM #Temp_CollectData tem
	LEFT JOIN #Temp_SportNonOffferSiteCurrency tempNonOffer ON tem.SportType = tempNonOffer.SportType AND tem.BetType = tempNonOffer.BetType
	WHERE tem.IsHidden IN (0,1) AND tem.IsHidden_NonOffer = 0 AND Currency_NonOffer = 0 
	AND tempNonOffer.SportType IS NULL
	)


INSERT INTO #Temp_SportNonOffferSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
SELECT Cte.SportType , Cte.BetType , 0 AS Currency , s.siteID , Cte.RealProductID
FROM Cte_FGG_FunkyGames_VirtualGames AS Cte
CROSS APPLY @Temp_Site AS s
WHERE Cte.SiteOffer <> s.SiteId

------------------------------------------
-- Case 3: Condition : ProductStatusSiteCurrency.IsHidden = 1

DELETE TempNonOffer
FROM #Temp_SportNonOffferSiteCurrency TempNonOffer
INNER JOIN #Temp_CollectData tcd ON TempNonOffer.SportType = tcd.SportType AND TempNonOffer.BetType = tcd.BetType AND TempNonOffer.SiteID = tcd.SiteID_NonOffer AND TempNonOffer.Currency = tcd.Currency_NonOffer
WHERE tcd.IsHidden_NonOffer = 1

INSERT INTO #Temp_SportNonOffferSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)

SELECT SportType, BetType , Currency_NonOffer , SiteID_NonOffer , RealProductID
FROM #Temp_CollectData
WHERE IsHidden_NonOffer = 1

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Remove Real Currency in Temp Table

DELETE FROM #Temp_SportNonOffferSiteCurrency WHERE Currency <>  20


IF EXISTS (SELECT 1 FROM SportNonOfferedSiteCurrency sp WITH (NOLOCK)
			   INNER JOIN #Temp_SportNonOffferSiteCurrency tsnosc ON sp.SportType = tsnosc.SportType AND sp.BetType = tsnosc.BetType AND sp.Currency = tsnosc.Currency AND sp.SiteID = tsnosc.SiteID)
BEGIN
	DELETE sp
	FROM SportNonOfferedSiteCurrency sp WITH (ROWLOCK)
	INNER JOIN #Temp_SportNonOffferSiteCurrency tsnosc ON sp.SportType = tsnosc.SportType AND sp.BetType = tsnosc.BetType AND sp.Currency = tsnosc.Currency AND sp.SiteID = tsnosc.SiteID
END

-- initial data real table Just UUS Account
INSERT INTO SportNonOfferedSiteCurrency
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
SELECT	SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
FROM #Temp_SportNonOffferSiteCurrency


DROP TABLE #Temp_CollectData
DROP TABLE #Temp_CurrencyOffer
DROP TABLE #Temp_SampleDataOffer
DROP TABLE #Temp_SiteOffer
DROP TABLE #Temp_SportNonOffferSiteCurrency
