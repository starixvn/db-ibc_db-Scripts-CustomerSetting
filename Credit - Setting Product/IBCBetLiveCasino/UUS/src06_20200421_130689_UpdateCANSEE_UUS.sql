/*
	Created: 20200529@Tiara
	Task: Update CanSee for GTCasino UUS [Redmine: #130689] 
	DB: DBCUST/CustDB
*/ 
USE CustDB
GO

DECLARE @Sporttype SMALLINT, @Bettype INT
SELECT @Sporttype = 242, @Bettype = 3201


UPDATE P
SET P.IsTest = 0
FROM ProductLaunchedSiteCurrency P WITH (ROWLOCK,UPDLOCK)
WHERE SportType = @Sporttype AND P.BetType = @Bettype AND P.Currency = 20


--SELECT * FROM ProductLaunchedSiteCurrency WITH(NOLOCK) WHERE SportType = 242



