/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220711@Tacy
	Task: Add new flow for Haifa, 789y site and USDT currency to update danger level for Saba Basketball Sport [redmine:#175247]
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
CREATE TABLE #tblCustDangerInfo (Custid INT PRIMARY KEY, Basketball TINYINT, WinlossBasketball MONEY, UpdateBasketball BIT)
CREATE TABLE #tblCustDangerOld (Custid INT PRIMARY KEY, DangerLevel BIGINT, Basketball TINYINT, IsManualBasketball BIT)
CREATE TABLE #tblCustUpdate (Custid INT PRIMARY KEY, DangerLevel BIGINT, Basketball TINYINT, BasketballOld TINYINT, UpdateBasketball BIT, WinlossBasketball MONEY)
	
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)

DECLARE @batchNo INT,
	@CustList VARCHAR(MAX)

--get batchNo import from DW for this batch 
SELECT @batchNo = MAX(batchNo)
FROM CustDangerWinlossInfo WITH(NOLOCK)
	
-- For deployer info
DECLARE @Cust_CNT INT, @index INT = 0, @cnt INT
DECLARE @msg NVARCHAR(200) = 'Currently at order: %d'	
DECLARE @msg_total NVARCHAR(200) = 'Total of customer: %d.'

INSERT INTO #tblCust(custid)
SELECT DISTINCT custid
FROM CustDangerWinlossInfo WITH(NOLOCK)
WHERE batchNo = @batchNo

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
		SUM(CASE WHEN sporttype = 2 AND isParlay = 0 THEN winloss ELSE 0 END) basketball,
		MAX(CASE WHEN sporttype = 2 THEN 1 ELSE 0 END) isBasketball,
		SUM(CASE WHEN sporttype = 2 AND isParlay = 1 THEN winloss ELSE 0 END) basketballParlay,
		MAX(CASE WHEN sporttype = 2 AND isParlay = 1 THEN 1 ELSE 0 END) isBasketballParlay
	FROM CustDangerWinlossInfo t1 WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND batchNo = @batchNo
	GROUP BY custid
	)
	INSERT INTO #tblCustDangerInfo(custid,Basketball,WinlossBasketball,UpdateBasketball)
	SELECT t.custid,
			CASE WHEN s.custid IS NOT NULL AND (s.site IN ('haifa','789y') OR s.currency=96) THEN -- Flow B : Haifa, 789y site and USDT currency
					CASE WHEN basketball + basketballParlay < 8000 OR isbasketballParlay = 0 THEN
						CASE 
							WHEN basketball <-140000								THEN 1
							WHEN basketball <-110000	AND basketball >=-140000	THEN 2
							WHEN basketball <-80000		AND basketball >=-110000	THEN 3
							WHEN basketball <-60000		AND basketball >=-80000		THEN 4
							WHEN basketball <-35000		AND basketball >=-60000		THEN 5
							WHEN basketball <-20000		AND basketball >=-35000		THEN 6 
							WHEN basketball <-10000		AND basketball >=-20000		THEN 7
							WHEN basketball <-5000		AND basketball >=-10000		THEN 8
							WHEN basketball < 0			AND basketball >=-5000		THEN 9
							WHEN basketball < 1500		AND basketball >= 0			THEN 10
							WHEN basketball < 3000		AND basketball >= 1500		THEN 11
							WHEN basketball < 8000		AND basketball >= 3000		THEN 12
							WHEN basketball >=8000									THEN 13 END
					ELSE	
						CASE WHEN isbasketballParlay = 1 AND basketball + basketballParlay < 25000 THEN 14 ELSE 15 END
					END
			ELSE
				CASE WHEN s.custid IS NOT NULL AND (basketball + basketballParlay < 50000 OR isbasketballParlay = 0) THEN 
						CASE 
							WHEN basketball <-140000								THEN 1
							WHEN basketball <-120000	AND basketball >=-140000	THEN 2
							WHEN basketball <-100000	AND basketball >=-120000	THEN 3
							WHEN basketball <-80000		AND basketball >=-100000	THEN 4
							WHEN basketball <-60000		AND basketball >=-80000		THEN 5
							WHEN basketball <-40000		AND basketball >=-60000		THEN 6
							WHEN basketball <-20000		AND basketball >=-40000		THEN 7
							WHEN basketball < 0			AND basketball >=-20000		THEN 8
							WHEN basketball < 20000		AND basketball >= 0			THEN 9
							WHEN basketball < 40000		AND basketball >= 20000		THEN 10
							WHEN basketball < 60000		AND basketball >= 40000		THEN 11
							WHEN basketball < 80000		AND basketball >= 60000		THEN 12
							WHEN basketball >=80000									THEN 13 END
				ELSE
					CASE WHEN isbasketballParlay = 1 AND basketball + basketballParlay < 75000 THEN 14 ELSE 15 END
				END
			END	BasketballLevel,
		Basketball + basketballParlay as WinlossBasketball,
		IsBasketball
	FROM T
		INNER JOIN custinfo ci WITH(NOLOCK) ON t.custid = ci.custid
		LEFT JOIN Dep_custsuper s WITH(NOLOCK) ON ci.srecommend = s.custid
	
	INSERT INTO #tblCustDangerOld(custid,DangerLevel,Basketball,IsManualBasketball)
	SELECT custid, ISNULL(DangerLevel,0), basketball, IsManualBasketball
	FROM custinfo c WITH(NOLOCK)
		CROSS APPLY dbo.f_GetDangerLevelInfo(ISNULL(DangerLevel,0)) t
	WHERE custid IN (SELECT custid FROM #tblCustDangerInfo)
	
	INSERT INTO #tblCustUpdate(custid, Basketball, UpdateBasketball, DangerLevel, BasketballOld, WinlossBasketball)
	SELECT t1.custid, t1.Basketball,
		CASE WHEN IsManualBasketball = 0 AND UpdateBasketball = 1 AND t1.Basketball <> t2.Basketball THEN 1 ELSE 0 END as UpdateBasketball,
		t2.DangerLevel,
		t2.basketball as BasketballOld,
		t1.WinlossBasketball		
	FROM #tblCustDangerInfo t1
		INNER JOIN #tblCustDangerOld t2 ON t1.custid = t2.Custid
	WHERE (IsManualBasketball = 0 AND UpdateBasketball = 1 AND t1.Basketball <> t2.Basketball)
	
	SELECT @CustList = ''
	
	SELECT @CustList = CAST((
		SELECT custid as '@id',
			dbo.f_GenerateDangerLevelInfo(DangerLevel,0,Basketball,0,UpdateBasketball) as '@value'
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

