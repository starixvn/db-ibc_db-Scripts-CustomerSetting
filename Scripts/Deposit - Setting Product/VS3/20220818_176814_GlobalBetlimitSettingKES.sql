/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date:	 20220818
	Task:	 [VS3] - Add global betlimit for KES RedmineID:#176814
	DB:		 DBCust/CustDB

	P/s : Step 1 Add global betlimit for KES
*/
	USE CustDB
	GO

	DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
	SET @productID = 49 
	SET @sportType = 231
	SET @betType = 5301 
	
	CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,ExchangeId	INT,MaxBet MONEY)
	
	INSERT INTO #TempBetLimit(currency,MinBet,MaxBet,ExchangeId)
	VALUES	('KES',50,30000,79)
	
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