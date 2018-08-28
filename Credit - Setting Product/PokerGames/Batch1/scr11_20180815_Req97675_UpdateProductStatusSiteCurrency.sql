/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for Poker Games
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
--SELECT * FROM ProductStatusSiteCurrency WHERE SportType=163
DECLARE @Sporttype INT
SELECT @Sporttype = 163
	
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, Bettype, siteid, 16, 0, 0, 1
FROM Site WITH (NOLOCK)
	CROSS APPLY (SELECT 1401 AS Bettype UNION ALL SELECT 1402 UNION ALL SELECT 1403 UNION ALL SELECT 1404) b
WHERE site IN ('789y')
UNION ALL
SELECT @Sporttype, Bettype, siteid, 64, 0, 0, 1
FROM Site WITH (NOLOCK)
	CROSS APPLY (SELECT 1401 AS Bettype UNION ALL SELECT 1402 UNION ALL SELECT 1403 UNION ALL SELECT 1404) b
WHERE site IN ('789y')
UNION ALL
SELECT @Sporttype, Bettype, siteid, 20, 0, 0, 1
FROM Site WITH (NOLOCK)
	CROSS APPLY (SELECT 1401 AS Bettype UNION ALL SELECT 1402 UNION ALL SELECT 1403 UNION ALL SELECT 1404) b
WHERE site IN ('789y')	

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, Bettype, siteid, 20, 0, 0, 1
FROM Site WITH (NOLOCK)
	CROSS APPLY (SELECT 1401 AS Bettype UNION ALL SELECT 1402 UNION ALL SELECT 1403 UNION ALL SELECT 1404) b
WHERE site IN ('BEST-ODDS')