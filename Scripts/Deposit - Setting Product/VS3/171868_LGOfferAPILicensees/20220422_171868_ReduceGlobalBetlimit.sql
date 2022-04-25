/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220422
	Task:  Reduce min bet global RedmineID:#171868
	DB: DBCust/CustDB

	P/s : Step 1 Reduce min bet global
*/
	USE CustDB
	GO

	DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
	SET @productID = 49 
	SET @sportType = 231
	SET @betType = 5301 
	
	CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,ExchangeId	INT,MaxBet MONEY)

	INSERT INTO #TempBetLimit(currency,MinBet,ExchangeId)
	VALUES	('US$',0.5,3),('USDT',0.5,96),('RMB',4,13),('IN',10,15),('TB',20,4)

	UPDATE c 
	SET  c.MinBet = tmp.MinBet
	FROM Dep_ProductBetSetting c WITH(ROWLOCK, UPDLOCK)
		INNER JOIN #TempBetLimit tmp ON c.Sporttype = @sportType AND c.Bettype = @betType AND c.Currency = tmp.ExchangeId
	
	INSERT INTO #TempBetLimit(currency,MinBet,MaxBet,ExchangeId)
	VALUES	('HK$',5,20000,5),
			('HID',5,20000,92),
			('MK',1,3000,94),
			('MKK',1,3000,70)
	
	INSERT INTO Dep_ProductBetSetting(Sporttype,Bettype,Currency,MinBet,MaxBet,MaxPerMatch,
										DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)		
	SELECT @sportType AS Sporttype, @betType AS Bettype, ExchangeId AS Currency, MinBet,MaxBet, 
		   0 AS MaxPerMatch,  0 AS DefaultMinBet,  0 AS DefaultMaxBet,  0 AS DefaultMaxPerMatch
	FROM #TempBetLimit t
	WHERE NOT EXISTS(	SELECT TOP 1 1 
						FROM dbo.Dep_ProductBetSetting psd WITH(NOLOCK)
						WHERE 	psd.Currency = t.ExchangeId 
								AND Sporttype = @sportType 
								AND Bettype = @betType	)
	ORDER BY ExchangeId

	SELECT * FROM Dep_ProductBetSetting WITH(NOLOCK) WHERE Sporttype = @sportType AND Bettype = @betType
	
	DROP TABLE #TempBetLimit