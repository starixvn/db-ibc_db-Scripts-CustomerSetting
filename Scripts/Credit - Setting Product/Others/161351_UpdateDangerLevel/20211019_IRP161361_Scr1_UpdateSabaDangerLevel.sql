/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211019@Johnson
	Task: update DangerLevel for saba
	DB: DBCust/CustDB
*/

-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
ALTER PROCEDURE [dbo].[Acc_CustomerInfo_Execrep_09]	
	@CustList VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
		
	IF dbo.f_CheckRepTable('Custinfo') = 0 RETURN	
	
	CREATE TABLE #tblCustDangerLevel (custid INT PRIMARY KEY, DangerLevel BIGINT)
	DECLARE @tmpCust TABLE (custid INT PRIMARY KEY, DangerLevel BIGINT)
	
	DECLARE @xml XML = CAST (@CustList as XML)
	DECLARE @batchNo INT
	
	INSERT INTO #tblCustDangerLevel (custid, DangerLevel)
	SELECT t.c.value('@id[1]','int'),
		t.c.value('@value[1]','bigint')
	FROM @xml.nodes('Root/r')as t(c)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP(5000) t
		OUTPUT DELETED.custid, DELETED.DangerLevel
		INTO @tmpCust(custid,DangerLevel)
		FROM #tblCustDangerLevel t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		UPDATE c
		SET c.DangerLevel = t.DangerLevel
		FROM custinfo c WITH(ROWLOCK)
			INNER JOIN @tmpCust t ON c.custid = t.custid
		
		DELETE @tmpCust
		
		WAITFOR DELAY '0:0:0.1'
	END
	
	DROP TABLE #tblCustDangerLevel
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------			


-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST ONLY -----
--------------------------------------------------------------------------------------
SET NOCOUNT ON

CREATE TABLE #tblCust (custid INT PRIMARY KEY, IsFinished BIT DEFAULT 0)
CREATE TABLE #tblCustDangerInfo (Custid INT PRIMARY KEY, Soccer TINYINT, Basketball TINYINT, WinlossSoccer MONEY, WinlossBasketball MONEY, UpdateSoccer BIT, UpdateBasketball BIT)
CREATE TABLE #tblCustDangerOld (Custid INT PRIMARY KEY, DangerLevel BIGINT, Soccer TINYINT, Basketball TINYINT, IsManualSoccer BIT, IsManualBasketball BIT)
CREATE TABLE #tblCustUpdate (Custid INT PRIMARY KEY, DangerLevel BIGINT, Soccer TINYINT, Basketball TINYINT, SoccerOld TINYINT, BasketballOld TINYINT, UpdateSoccer BIT, UpdateBasketball BIT, WinlossSoccer MONEY, WinlossBasketball MONEY)
	
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)

DECLARE @batchNo INT,
	@CustList VARCHAR(MAX)

SELECT @batchNo = MAX(batchNo)
FROM CustDangerWinlossInfo (NOLOCK)
	
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0, @cnt INT
DECLARE @msg NVARCHAR(200) = 'Currently at order: %d'	
DECLARE @msg_total NVARCHAR(200) = 'Total of customer: %d.'

INSERT INTO #tblCust(custid)
SELECT DISTINCT custid
FROM CustDangerWinlossInfo WITH(NOLOCK)
WHERE batchNo = @batchNo

DELETE t
FROM #tblCust t
	INNER JOIN custinfo c WITH(NOLOCK) ON t.custid = c.custid
WHERE c.Enabled = 0

SELECT @Cust_CNT = COUNT(1) FROM #tblCust

RAISERROR (@msg_total, 0, 1, @Cust_CNT ) WITH NOWAIT

WHILE(1=1)
BEGIN
	UPDATE TOP(20000) t
	SET isFinished = 1
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	FROM #tblCust t
	WHERE isFinished = 0
	
	SELECT @cnt = @@ROWCOUNT 
	
	IF @cnt = 0
		BREAK;
	
	SELECT @index = @index + @cnt
	RAISERROR (@msg, 0, 1, @index) WITH NOWAIT
	
	;WITH T AS (
	SELECT custid,	
		SUM(CASE WHEN sporttype = 1 AND isParlay = 0 THEN winloss ELSE 0 END) soccer,
		MAX(CASE WHEN sporttype = 1 THEN 1 ELSE 0 END) isSoccer,
		SUM(CASE WHEN sporttype = 1 AND isParlay = 1 THEN winloss ELSE 0 END) soccerParlay,
		MAX(CASE WHEN sporttype = 1 AND isParlay = 1 THEN 1 ELSE 0 END) isSoccerParlay,
		SUM(CASE WHEN sporttype = 2 AND isParlay = 0 THEN winloss ELSE 0 END) basketball,
		MAX(CASE WHEN sporttype = 2 THEN 1 ELSE 0 END) isBasketball
	FROM CustDangerWinlossInfo t1 WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND batchNo = @batchNo
	GROUP BY custid
	)
	INSERT INTO #tblCustDangerInfo(custid,Soccer,Basketball,WinlossSoccer,WinlossBasketball,UpdateSoccer,UpdateBasketball)
	SELECT t.custid,
		CASE WHEN soccer + soccerParlay < 100000 THEN
				CASE WHEN soccer < -200000 THEN 1
					WHEN soccer <-140000 AND soccer >= -200000 THEN 2
					WHEN soccer <-120000 AND soccer >= -140000 THEN 3
					WHEN soccer <-100000 AND soccer >= -120000 THEN 4
					WHEN soccer <-80000 AND soccer >= -100000 THEN 5
					WHEN soccer <-60000 AND soccer >= -80000 THEN 6
					WHEN soccer <-40000 AND soccer >= -60000 THEN 7 
				ELSE
					CASE WHEN s.custid IS NULL THEN	
						CASE WHEN soccer <-20000 AND soccer >= -40000 THEN 8
							WHEN soccer <0 AND soccer >= -20000 THEN 9
							WHEN soccer <60000 AND soccer >= 0 THEN 10
							ELSE 11 END
						ELSE 
						CASE WHEN soccer <0 AND soccer >= -40000 THEN 8
							WHEN soccer <60000 AND soccer >= 0 THEN 9 
							ELSE 10 END
					END	
				END					
			ELSE 	
				CASE WHEN isSoccerParlay = 0 THEN
					CASE WHEN Soccer < 150000 THEN 11
						WHEN soccer < 250000 AND soccer >= 150000 THEN 12
						ELSE 13 END
					ELSE 
					CASE WHEN soccer + soccerParlay < 150000 THEN 14
						ELSE 15 END
				END
			END SoccerLevel,
		CASE WHEN basketball < -200000 THEN 1
			WHEN basketball < -140000 AND basketball >= -200000 THEN 2
			WHEN basketball < -100000 AND basketball >= -140000 THEN 3
			WHEN basketball < -80000 AND basketball >= -100000 THEN 4
			WHEN basketball < -60000 AND basketball >= -80000 THEN 5
			WHEN basketball < -40000 AND basketball >= -60000 THEN 6
			WHEN basketball < -20000 AND basketball >= -40000 THEN 7
			WHEN basketball < 0 AND basketball >= -20000 THEN 8
			WHEN basketball < 20000 AND basketball >= 0 THEN 9
			WHEN basketball < 40000 AND basketball >= 20000 THEN 10
			WHEN basketball < 60000 AND basketball >= 40000 THEN 11
			WHEN basketball < 100000 AND basketball >= 60000 THEN 12
			ELSE 13 END as BasketballLevel,
		Soccer + SoccerParlay as WinlossSoccer,
		Basketball as WinlossBasketball,
		IsSoccer,
		IsBasketball
	FROM T
		INNER JOIN custinfo ci WITH(NOLOCK) ON t.custid = ci.custid
		LEFT JOIN Dep_custsuper s WITH(NOLOCK) ON ci.srecommend = s.custid
	
	INSERT INTO #tblCustDangerOld(custid,DangerLevel,Soccer,Basketball,IsManualSoccer,IsManualBasketball)
	SELECT custid, ISNULL(DangerLevel,0), soccer, basketball, IsManualSoccer, IsManualBasketball
	FROM custinfo c WITH(NOLOCK)
		CROSS APPLY dbo.f_GetDangerLevelInfo_xtest(ISNULL(DangerLevel,0)) t
	WHERE custid IN (SELECT custid FROM #tblCustDangerInfo)
	
	INSERT INTO #tblCustUpdate(custid, Soccer, Basketball, UpdateSoccer, UpdateBasketball, DangerLevel, SoccerOld, BasketballOld, WinlossSoccer, WinlossBasketball)
	SELECT t1.custid, t1.Soccer , t1.Basketball,
		CASE WHEN IsManualSoccer = 0 AND UpdateSoccer = 1 AND t1.Soccer <> t2.soccer THEN 1 ELSE 0 END as UpdateSoccer,
		CASE WHEN IsManualBasketball = 0 AND UpdateBasketball = 1 AND t1.Basketball <> t2.Basketball THEN 1 ELSE 0 END as UpdateBasketball,
		t2.DangerLevel,
		t2.soccer as SoccerOld,
		t2.basketball as BasketballOld,
		t1.WinlossSoccer,
		t1.WinlossBasketball		
	FROM #tblCustDangerInfo t1
		INNER JOIN #tblCustDangerOld t2 ON t1.custid = t2.Custid
	WHERE (IsManualSoccer = 0 AND UpdateSoccer = 1 AND t1.Soccer <> t2.soccer)
		OR (IsManualBasketball = 0 AND UpdateBasketball = 1 AND t1.Basketball <> t2.Basketball)
	
	SELECT @CustList = ''
	
	SELECT @CustList = CAST((
		SELECT custid as '@id',
			dbo.f_GenerateDangerLevelInfo_xtest(DangerLevel,Soccer,Basketball,UpdateSoccer,UpdateBasketball) as '@value'
		FROM #tblCustUpdate
		FOR XML PATH('r'),ROOT('Root')
	) AS VARCHAR(MAX))
	
	EXEC Acc_CustomerInfo_Execrep_09 @CustList = @CustList
	
	DELETE #tblCustDangerInfo
	DELETE #tblCustUpdate
	DELETE #tblCustDangerOld
END

DROP TABLE #tblCust
DROP TABLE #tblCustDangerInfo
DROP TABLE #tblCustDangerOld
DROP TABLE #tblCustUpdate

