/*
	Created: Elodie
	Task: Adjust Setting for PokerGames
	DB: DBCUST/CustDB
	Date: 20180815
*/ 
DECLARE @ReleaseDate DATETIME = xxx
DECLARE @MinID INT, @MaxID INT, @Batch INT = 5000

CREATE TABLE #supers (custid int)

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.site IN ('789y')
	AND ci.currency <> 20
	AND ci.currency IN (16,64)

INSERT INTO #supers(custid)
SELECT custid
FROM CustInfo ci WITH (NOLOCK)
WHERE custid IN (16)

DECLARE @msgDone NVARCHAR(200) = 'Done for sporttype %d, bettype %d.'

DECLARE @ProductID INT = 33, @currency INT

SELECT t.* 
INTO #SportBettypeFilter6
FROM ProductSettingDetail t WITH (NOLOCK)
WHERE t.SettingType = 6 AND t.ProductID = @ProductID

CREATE TABLE #MemberTemp
(
	ID INT IDENTITY(1,1),
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT,
	Credit MONEY
)

CREATE TABLE #SMATemp
(
	ID INT IDENTITY(1,1),
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
	currency INT,
	Credit MONEY
)
CREATE NONCLUSTERED INDEX IX_#MemberTemp_ID ON #MemberTemp(ID)
CREATE NONCLUSTERED INDEX IX_SMATemp_ID ON #SMATemp(ID)

SELECT DISTINCT custid INTO #ListCust
FROM DBLOG.bodb_CustomerLog.dbo.UserLog_Credit WITH (NOLOCK)
WHERE ActionID IN (1200,1201,1202,1203,1204,1205,1206,1211) AND logdate > @ReleaseDate
	
IF @@ROWCOUNT = 0
	RETURN

INSERT INTO #MemberTemp (CustID, currency, Credit)
SELECT c.custid, currency, Credit
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #ListCust l ON l.custid = c.custid
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid = 1  AND Enabled = 1
	
INSERT INTO #SMATemp (CustID, roleid, currency, Credit)
SELECT c.custid, roleid, currency, Credit
FROM Custinfo c WITH (NOLOCK)
	INNER JOIN #ListCust l ON l.custid = c.custid
WHERE srecommend IN (SELECT custid FROM #supers) AND roleid IN (2,3,4) AND Enabled = 1

--------------------------------------Win Loss Limit-------------------------------------------------		
SELECT @MinID = 1, @MaxID = @Batch
WHILE (1=1)
BEGIN
	--Agent Level
	UPDATE cs
	SET cs.MaxLossLimit = CASE	WHEN FLOOR(ci.Credit * 0.1) < ls.MinLossLimit THEN ls.MinLossLimit
								WHEN FLOOR(ci.Credit * 0.1) > ls.DefaultLossLimit THEN ls.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END
	FROM CustWinLossLimit_Agent cs
		INNER JOIN #SMATemp ci ON ci.CustID = cs.CustId
		INNER JOIN dbo.LossLimit_GlobalSetting ls WITH(NOLOCK) ON ci.currency = ls.ExchangeId
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE ls.ProductId = @ProductID	
		AND ci.ID BETWEEN @MinID AND @MaxID

	IF @@ROWCOUNT = 0 BREAK

	SELECT @MinID = @MaxID + 1
	SELECT @MaxID = @MaxID + @Batch
END

SELECT @MinID = 1, @MaxID = @Batch
WHILE (1=1)
BEGIN
	--Member Level
	UPDATE cs
	SET cs.MaxLossLimit = CASE	WHEN FLOOR(ci.Credit * 0.1) < ls.MinLossLimit THEN ls.MinLossLimit
								WHEN FLOOR(ci.Credit * 0.1) > ls.DefaultLossLimit THEN ls.DefaultLossLimit ELSE FLOOR(ci.Credit * 0.1) END
	FROM dbo.CustWinLossLimit_Member cs
		INNER JOIN #MemberTemp ci ON ci.CustID = cs.CustId
		INNER JOIN dbo.LossLimit_GlobalSetting ls WITH(NOLOCK) ON ci.currency = ls.ExchangeId
		CROSS APPLY #SportBettypeFilter6 sb
	WHERE ls.ProductId = @ProductID	
		AND ci.ID BETWEEN @MinID AND @MaxID

	IF @@ROWCOUNT = 0 BREAK

	SELECT @MinID = @MaxID + 1
	SELECT @MaxID = @MaxID + @Batch
END

DROP TABLE #SportBettypeFilter6			
