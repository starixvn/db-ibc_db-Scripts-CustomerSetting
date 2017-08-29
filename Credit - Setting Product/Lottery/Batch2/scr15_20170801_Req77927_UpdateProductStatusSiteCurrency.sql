/*
	Created: Elodie
	Task: Update ProductStatusSiteCurrency for Lottery
	DB: DBCUST/CustDB
	Date: 20170801
*/ 
 
DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 220, @Bettype = 1021
	
DELETE FROM ProductStatusSiteCurrency WHERE SportType=@Sporttype


	