/*
	Created: Eden
	Date: 20191029
	Task: Update ProductStatusSiteCurrency for Virtual games 
	DB: DBCust/CustDB
*/
 
DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 245, @Bettype = 4601
	
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype

INSERT INTO ProductStatusSiteCurrency (SportType, BetType, SiteID, Currency, IsHidden, IsDisabled)
SELECT @Sporttype, @Bettype, siteid, 0, 1, 1
FROM Site WITH (NOLOCK)
WHERE site NOT IN ('')
	