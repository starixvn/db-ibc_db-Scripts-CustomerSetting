/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for Lucky3
	DB: DBCUST/CustDB
	Date: 20171214
*/ 
 
DECLARE @Sporttype INT
SELECT @Sporttype = 160
		
DELETE ps
FROM ProductStatusSiteCurrency ps
WHERE SportType = @Sporttype

	