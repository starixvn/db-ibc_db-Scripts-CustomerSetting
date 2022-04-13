/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220413
	Task:  Reduce min bet by 50% for all Athena Licensees RedmineID:#171312
	DB: DBCust/CustDB
*/
	DECLARE @productID SMALLINT ,@betType SMALLINT,@sportType SMALLINT
	SET @productID = 49 
	SET @sportType = 231
	SET @betType = 5301 
	
	CREATE TABLE #TempBetLimit (currency NVARCHAR(50), MinBet MONEY,ExchangeId	INT)

	INSERT INTO #TempBetLimit(currency,MinBet,ExchangeId)
	VALUES	('GBP',0.5,12),('US$',1,3),('EURO',1,6),('UUS',1,20),
			('CAN',1,50),('USDT',1,96),('RM',2.5,2),('RMB',5,13),
			('IN',9,15),('TB',25,4),('Won',1000,45),('BND',1,46),
			('BDT',50,97),('PKR',125,121),('INR',50,61),('INH',15,51)
	
	--UPDATE c 
	--SET  c.MinBet = tmp.MinBet
	--FROM Dep_ProductBetSetting c WITH(ROWLOCK, UPDLOCK)
	--	INNER JOIN #TempBetLimit tmp ON c.Sporttype = @sportType AND c.Bettype = @betType AND c.Currency = tmp.currency

	SELECT * FROM Dep_ProductBetSetting WITH(NOLOCK) WHERE Sporttype = @sportType AND Bettype = @betType
	
	DROP TABLE #TempBetLimit