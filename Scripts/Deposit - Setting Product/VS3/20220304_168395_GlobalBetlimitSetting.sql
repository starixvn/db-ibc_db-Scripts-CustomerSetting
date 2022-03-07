/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220304
	Task:  Insert Global Setting Product Leap Gaming Virtual Sports 3 Deposit RedmineID:#168395
	DB: DBCust/CustDB
*/
	DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
	SET @productID = 49 
	SET @sportType = 231
	SET @betType = 5301 
	
	DELETE FROM Dep_ProductBetSetting WHERE Sporttype = @sportType AND Bettype = @betType
	
	CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,MaxBet MONEY,ExchangeId	INT)

	INSERT INTO #TempBetLimit(currency,MinBet,MaxBet,ExchangeId)
	VALUES	('GBP',1,2000,12),
			('US$',2,2500,3),
			('EURO',2,2500,6),
			('UUS',2,2500,20),
			('CAN',2,2500,50),
			('USDT',2,2500,96),
			('RM',5,10000,2),
			('RMB',10,20000,13),
			('IN',18,18000,15),
			('TB',50,50000,4),
			('Won',2000,3000000,45),
			('BND',2,400,46),
			('BDT',100,30000,97),
			('PKR',250,60000,121),
			('INR',100,30000,61),
			('INH',30,10000,51)
	
	INSERT INTO Dep_ProductBetSetting(Sporttype,Bettype,Currency,MinBet,MaxBet,MaxPerMatch,
										DefaultMinBet,DefaultMaxBet,DefaultMaxPerMatch)		
	SELECT @sportType AS Sporttype, @betType AS Bettype, ExchangeId AS Currency, MinBet,MaxBet, 
		   0 AS MaxPerMatch,  0 AS DefaultMinBet,  0 AS DefaultMaxBet,  0 AS DefaultMaxPerMatch
	FROM #TempBetLimit
	ORDER BY ExchangeId
	
	SELECT * FROM Dep_ProductBetSetting WITH(NOLOCK)
	
	DROP TABLE #TempBetLimit