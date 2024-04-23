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
AND e.OfferSite IN (0,1)


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
VALUES
(171, 3801, CONVERT(bit, 'True'), 66),
(176, 8201, CONVERT(bit, 'False'), 70),
(200, 1611, CONVERT(bit, 'True'), 42),
(208, 2101, CONVERT(bit, 'False'), 6),
(224, 5500, CONVERT(bit, 'False'), 50),
(245, 4601, CONVERT(bit, 'False'), 38),
(245, 4602, CONVERT(bit, 'False'), 38)


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


--SELECT * FROM #Temp_CollectData
--SELECT  COUNT(1) FROM @Temp_Site
--SELECT  COUNT(1) FROM @Temp_Currency

; WITH 
	Filter1 AS (
SELECT DISTINCT SportType , BetType
FROM #Temp_CollectData temp
)
,	Filter2 AS (
SELECT c.SportType , c.BetType , s.SiteId , e.ExchangeId
FROM Filter1 c
CROSS APPLY @Temp_Site s
CROSS APPLY @Temp_Currency e
)

--SELECT 
--	a.SportType 
----,	COUNT(DISTINCT SiteId) 
----,	COUNT(DISTINCT ExchangeId)
--FROM Filter2 a
--GROUP BY a.SportType

INSERT INTO #Temp_SportNonOffferSiteCurrency 
	(
		SportType
	    , BetType
	    , SiteID
	    , Currency
	)
SELECT SportType
	    , BetType
	    , SiteID
	    , ExchangeId
FROM Filter2


--SELECT COUNT(1) FROM #Temp_SportNonOffferSiteCurrency tsnosc

/*
Checked - 1 : Remove Real Offer Site
SELECT * 
FROM #Temp_SportNonOffferSiteCurrency FilterData
INNER JOIN #Temp_CollectData temp ON FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer 
WHERE temp.IsHidden_NonOffer = 0 AND temp.Currency_NonOffer = 0
*/

--SELECT '#Temp_SportNonOffferSiteCurrency_1' AS Note , * FROM #Temp_SportNonOffferSiteCurrency

DELETE FilterData
FROM #Temp_SportNonOffferSiteCurrency FilterData
INNER JOIN #Temp_CollectData temp ON FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer 
WHERE temp.IsHidden_NonOffer = 0 AND temp.Currency_NonOffer = 0


/*
Checked - 2 : Remove Real Offer Site - Currency
SELECT * 
FROM #Temp_SportNonOffferSiteCurrency FilterData
INNER JOIN #Temp_CollectData temp ON FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
WHERE temp.IsHidden_NonOffer = 0 AND temp.Currency_NonOffer <> 0
*/

--SELECT '#Temp_SportNonOffferSiteCurrency_2' AS Note , * FROM #Temp_SportNonOffferSiteCurrency

DELETE FilterData
FROM #Temp_SportNonOffferSiteCurrency FilterData
INNER JOIN #Temp_CollectData temp ON FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
WHERE temp.IsHidden_NonOffer = 0 AND temp.Currency_NonOffer <> 0



/*

Checked - 3 : Remove Redundant NonOffer

SELECT 'Checked' AS Note , FilterData.SportType , FilterData.BetType , FilterData.SiteID , FilterData.Currency
FROM #Temp_SportNonOffferSiteCurrency FilterData
WHERE NOT EXISTS (
				SELECT TOP 1 1 
				FROM #Temp_CollectData temp 
				WHERE temp.IsHidden_NonOffer = 1 
				AND temp.SportType NOT IN (171,200)
				AND FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
			)
*/

--SELECT '#Temp_SportNonOffferSiteCurrency_3' AS Note , * FROM #Temp_SportNonOffferSiteCurrency


DELETE FilterData
FROM #Temp_SportNonOffferSiteCurrency FilterData
WHERE NOT EXISTS (
				SELECT TOP 1 1 
				FROM #Temp_CollectData temp 
				WHERE 
				IsHidden_NonOffer = 1
				AND
				FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
			)
AND FilterData.SportType IN (176,224,208,245)

/*

Checked - 4 : Initial Non Offer for Site = 0 OR Currency =0

SELECT 'Checked' AS Note , FilterData.SportType , FilterData.BetType , FilterData.SiteID , FilterData.Currency
FROM #Temp_SportNonOffferSiteCurrency FilterData
WHERE EXISTS (
				SELECT temp.SportType , temp.BetType , temp.SiteID_NonOffer, temp.Currency_NonOffer
				FROM #Temp_CollectData temp 
				WHERE temp.IsHidden_NonOffer = 1 
				AND (temp.SiteID_NonOffer = 0 OR temp.Currency_NonOffer = 0)
				AND FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
			)
*/
			

IF NOT EXISTS (	SELECT 1
			FROM #Temp_SportNonOffferSiteCurrency FilterData
			WHERE EXISTS (
						SELECT temp.SportType , temp.BetType , temp.SiteID_NonOffer, temp.Currency_NonOffer
						FROM #Temp_CollectData temp 
						WHERE temp.IsHidden_NonOffer = 1 
						AND (temp.SiteID_NonOffer = 0 OR temp.Currency_NonOffer = 0)
						AND FilterData.SportType = temp.SportType AND FilterData.BetType = temp.BetType AND FilterData.SiteID = temp.SiteID_NonOffer AND FilterData.Currency = temp.Currency_NonOffer 
					)
		)

BEGIN
	INSERT INTO #Temp_SportNonOffferSiteCurrency 
	(
		SportType
	    , BetType
	    , Currency
	    , SiteID
	    , RealProductID
	)
	SELECT SportType
	    , BetType
	    , Currency_NonOffer
	    , SiteID_NonOffer
	    , RealProductID
	FROM #Temp_CollectData
	WHERE IsHidden_NonOffer = 1
	AND (SiteID_NonOffer = 0 OR Currency_NonOffer = 0)
END


--SELECT	DISTINCT
--		SportType
--	    , RealProductID
--	FROM #Temp_CollectData

UPDATE FilterData
	SET FilterData.RealProductID = CASE 
							WHEN FilterData.SportType = 171	THEN	66
							WHEN FilterData.SportType = 176	THEN  70
							WHEN FilterData.SportType = 200	THEN  42
							WHEN FilterData.SportType = 208	THEN  6
							WHEN FilterData.SportType = 224	THEN  50
							WHEN FilterData.SportType = 245	THEN  38
						 END
FROM #Temp_SportNonOffferSiteCurrency FilterData

-- Final Check --
--SELECT * FROM #Temp_SportNonOffferSiteCurrency


-- Remove Real Currency for initial UUS
DELETE FROM #Temp_SportNonOffferSiteCurrency WHERE Currency <> 20


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
DROP TABLE #Temp_SportNonOffferSiteCurrency

