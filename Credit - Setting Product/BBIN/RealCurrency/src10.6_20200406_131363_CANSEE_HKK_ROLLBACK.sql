/*
	Created: 20200406@Eden
	Task: Update CanSee for BBIN - HKK [Redmine: #131363] - ROLLBACK
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 241, @Bettype = 3300

UPDATE ProductLaunchedSiteCurrency WITH(ROWLOCK)
SET IsLaunched = 0
WHERE SportType = @Sporttype and bettype = @Bettype
	AND Currency = 67 --HKK

--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 241



