/*
	Created: Winnie
	Task: Adjust Setting for PokerGames
	DB: DBCUST/CustDB
	Date: 20190110
*/ 
DECLARE @ReleaseDate DATETIME = xxx
DECLARE @MinID INT, @MaxID INT, @Batch INT = 3000

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

DECLARE  @currency INT

CREATE TABLE #MemberTemp
(
	ID INT IDENTITY(1,1),
	CustID INT PRIMARY KEY CLUSTERED,
	currency INT
)

CREATE TABLE #SMATemp
(
	ID INT IDENTITY(1,1),
	CustID INT PRIMARY KEY CLUSTERED,	
	currency INT
)
CREATE NONCLUSTERED INDEX IX_#MemberTemp_ID ON #MemberTemp(ID)
CREATE NONCLUSTERED INDEX IX_SMATemp_ID ON #SMATemp(ID)
--------------------------------------Win Loss Limit-------------------------------------------------		


SELECT DISTINCT custid INTO #ListCustStatus
FROM DBLOG.bodb_CustomerLog.dbo.UserLog_RunSP  WITH (NOLOCK)
WHERE (ActionID BETWEEN 60500 AND 60519 
	OR ActionID BETWEEN 65500 AND 65539 
	OR ActionID BETWEEN 70500 AND 70559 
	OR ActionID BETWEEN 75500 AND 75579 
	)
AND logdate > @ReleaseDate

DECLARE @Sporttype INT
SELECT @Sporttype=165	
DECLARE @BitOrder INT,@BitOrder1402 INT
SELECT @BitOrder= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=@Sporttype
SELECT @BitOrder1402= bitmapOrder from ProductStatusProfile WITH(NOLOCK) where SportType=163 AND Bettype=1402

CREATE TABLE #temp (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))
CREATE TABLE #tempUpdate (CustID INT PRIMARY KEY,DisableVideoGame BIT DEFAULT(1))

INSERT INTO #temp(CustID,DisableVideoGame)
SELECT ci.custid,dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)
FROM #ListCustStatus CI WITH (NOLOCK) 
	INNER JOIN CustProductStatus s WITH(NOLOCK) ON ci.custid=s.CustID
WHERE  dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder1402)<>dbo.f_GetProductStatus(s.bitmapIsDisabled,@BitOrder)
	
WHILE EXISTS(SELECT 1 FROM #temp)
BEGIN
	DELETE TOP (3000) #temp OUTPUT DELETED.* INTO #tempUpdate

	IF @@ROWCOUNT=0
		BREAK		
	UPDATE cs
	SET								
			bitmapIsHidden =  dbo.f_GenerateProductStatus (cs.bitmapIsHidden,@BitOrder,0),
			bitmapIsDisabled = dbo.f_GenerateProductStatus (cs.bitmapIsDisabled,@BitOrder,DisableVideoGame)
	FROM [dbo].[CustProductStatus] cs WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tempUpdate CI WITH (NOLOCK) ON cs.CustID = ci.CustID

	TRUNCATE TABLE #tempUpdate
END
