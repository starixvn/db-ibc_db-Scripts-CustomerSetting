/*
	Created: 20200421@Tiara
	Date: 20200421
	Task: Update ProductStatusSiteCurrency for Sexy Gaming -Batch 2 [Redmine: #130678]
	DB: DBCUST/CustDB
*/

-- BEGIN DEPLOY THIS SCRIPT ON DBCUST/CustDB	 --
-----------------------------------------------------------
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 243, @Bettype = 3101

DELETE P
FROM ProductStatusSiteCurrency P WITH (ROWLOCK)
WHERE SportType=@Sporttype 
	AND BetType = @Bettype 
	AND P.Currency IN (6,78,69,70,13,66,81,45) --Euro, EUR; MMK, MKK, RMB, CY, YUN, WON 



