/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for BullFighting
	DB: DBCUST/CustDB
	Date: 20171201
*/ 
 
DECLARE @Sporttype INT
SELECT @Sporttype = 207
		
DELETE ps
FROM ProductStatusSiteCurrency ps
WHERE SportType = @Sporttype

	