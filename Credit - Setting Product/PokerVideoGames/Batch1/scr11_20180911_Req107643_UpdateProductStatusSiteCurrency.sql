/*
	Created: Winnie
	Task: Update ProductStatusSiteCurrency for Poker Games
	DB: DBCUST/CustDB
	Date: 20190110
*/ 
--SELECT * FROM ProductStatusSiteCurrency WHERE SportType=165
DECLARE @Sporttype INT
SELECT @Sporttype = 165

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled, HasSynced)
SELECT @Sporttype, 1901, siteid, 16, 0, 0, 1
FROM Site WITH (NOLOCK)
WHERE site IN ('789y')
UNION ALL
SELECT @Sporttype, 1901, siteid, 64, 0, 0, 1
FROM Site WITH (NOLOCK)	
WHERE site IN ('789y')

