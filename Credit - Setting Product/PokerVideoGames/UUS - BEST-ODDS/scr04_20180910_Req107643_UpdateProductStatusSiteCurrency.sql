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
SELECT @Sporttype, 1901, siteid, 20, 0, 0, 1
FROM Site WITH (NOLOCK)	
WHERE site IN ('BEST-ODDS')	
