/*
	Created: 20200623@Eden
	Task: Update ProductStatusSiteCurrency for SAGaming - Enable HK$,HKK  [Redmine: #128128]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

DECLARE @Sporttype INT, @Bettype INT
SELECT @Sporttype = 244, @Bettype = 3001
	
DELETE 
FROM ProductStatusSiteCurrency WITH(ROWLOCK)
WHERE SportType = @Sporttype AND BetType = @Bettype AND Currency IN (5,67) --HK$, HKK


