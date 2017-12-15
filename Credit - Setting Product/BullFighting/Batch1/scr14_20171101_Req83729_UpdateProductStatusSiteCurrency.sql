/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for BullFighting
	DB: DBCUST/CustDB
	Date: 20171101
*/ 
 
DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 207, @Bettype = 1004
	
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled)
SELECT @Sporttype, @Bettype, siteid, 0, 1, 1
FROM Site WITH (NOLOCK)
WHERE site NOT IN ('Indo', 'KORIBC')
	