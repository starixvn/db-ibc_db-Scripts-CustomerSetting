/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220927@Tacy
	Task: scan and update DangerLevel according to Winloss of Saba Sports [redmine:#178053]
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
		@CustList VARCHAR(MAX),
		@ScanDate DATETIME

SET @ScanDate = (SELECT MAX(CreatedDate) FROM CustDangerWinlossInfo WITH (NOLOCK))

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
		 SUM(CASE WHEN sporttype = 1 AND isParlay = 0 THEN winloss ELSE 0 END) soccer
		,MAX(CASE WHEN sporttype = 1 AND isParlay = 0 THEN 1 ELSE 0 END) isSoccer
		,SUM(CASE WHEN sporttype = 2 AND isParlay = 0 THEN winloss ELSE 0 END) basketball
		,MAX(CASE WHEN sporttype = 2 AND isParlay = 0 THEN 1 ELSE 0 END) isBasketball
	FROM CustDangerWinlossInfo t1 WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND batchNo = @batchNo
	GROUP BY custid
	)
	INSERT INTO #tblCustDangerInfo(custid,Soccer,Basketball,WinlossSoccer,WinlossBasketball,UpdateSoccer,UpdateBasketball)
	SELECT t.custid,
		CASE 
			WHEN sc.CustID IS NOT NULL THEN 13
			WHEN isSoccer=1 THEN
				CASE
					WHEN s.custid IS NOT NULL AND s.site IN ('IG128','SM88','SL88SW','LIVV88SW','365Online','SKY88','Sin88','One88')  THEN -- Flow C : 8 Licensees: IG128/SM88/SL88SW/LIVV88SW/365Online/SKY88/Sin88/One88
						CASE WHEN soccer <-250000						THEN 1
							 WHEN soccer <-200000 AND soccer >= -250000	THEN 2
							 WHEN soccer <-140000 AND soccer >= -200000	THEN 3
							 WHEN soccer <-120000 AND soccer >= -140000	THEN 4
							 WHEN soccer <-100000 AND soccer >= -120000	THEN 5
							 WHEN soccer <-80000  AND soccer >= -100000	THEN 6 
							 WHEN soccer <-60000  AND soccer >= -80000	THEN 7
							 WHEN soccer <-40000  AND soccer >= -60000	THEN 8
							 WHEN soccer < 0	  AND soccer >= -40000	THEN 9
							 WHEN soccer < 45000  AND soccer >=  0		THEN 10
							 WHEN soccer < 100000 AND soccer >=  45000	THEN 11
							 WHEN soccer < 200000 AND soccer >=  100000	THEN 12
							 WHEN Soccer >=200000						THEN 13 END
					WHEN s.custid IS NOT NULL AND s.currency IN (4,20) THEN ---- Flow B : ALL Licensee & currency = TB
						CASE WHEN soccer <-300000						THEN 1
							 WHEN soccer <-250000 AND soccer >= -300000	THEN 2
							 WHEN soccer <-200000 AND soccer >= -250000	THEN 3
							 WHEN soccer <-140000 AND soccer >= -200000 THEN 4
							 WHEN soccer <-120000 AND soccer >= -140000 THEN 5
							 WHEN soccer <-100000 AND soccer >= -120000 THEN 6
							 WHEN soccer <-80000  AND soccer >= -100000 THEN 7 
							 WHEN soccer <-60000  AND soccer >= -80000	THEN 8
							 WHEN soccer <-40000  AND soccer >= -60000	THEN 9
							 WHEN soccer < 0	  AND soccer >= -40000	THEN 10
							 WHEN soccer < 30000  AND soccer >=  0		THEN 11
							 WHEN soccer < 50000  AND soccer >=  30000	THEN 12
							 WHEN Soccer >=50000						THEN 13 END
					ELSE
						CASE WHEN soccer <-200000									THEN 1
							 WHEN soccer <-140000	AND soccer >= -200000			THEN 2
							 WHEN soccer <-120000	AND soccer >= -140000			THEN 3
							 WHEN soccer <-100000	AND soccer >= -120000			THEN 4
							 WHEN soccer <-80000	AND soccer >= -100000			THEN 5
							 WHEN soccer <-60000	AND soccer >= -80000			THEN 6
							 WHEN soccer <-40000	AND soccer >= -60000			THEN 7
							 WHEN soccer < 150000	AND soccer >= -40000		THEN
								CASE WHEN s.custid IS NULL THEN	-- Credit
									CASE WHEN soccer <-20000  AND soccer >= -40000	THEN 8
										 WHEN soccer < 0	  AND soccer >= -20000	THEN 9
										 WHEN soccer < 60000  AND soccer >=  0		THEN 10
																					ELSE 11 END
								 ELSE
									CASE WHEN soccer < 0	  AND soccer >= -40000	THEN 8
										 WHEN soccer < 60000  AND soccer >=	0		THEN 9 
										 WHEN soccer < 100000 AND soccer >= 60000	THEN 10 
																					ELSE 11 END
								 END
							 WHEN soccer < 250000 AND soccer >= 150000				THEN 12
							 WHEN soccer >=250000									THEN 13 END
					END	
		END	SoccerLevel,
		CASE 
			WHEN bb.CustID IS NOT NULL THEN 13
			WHEN isBasketball=1 THEN
				CASE
					WHEN (s.custid IS NOT NULL AND s.site in ('haifa','livv88sw'))
						OR (s.custid IS NULL AND c.site='789y')		
						OR s.currency=96											THEN -- Flow B : Haifa, 789y, Livv88sw site and USDT currency
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
					WHEN s.custid IS NOT NULL AND ((s.site IN ('Happy8','SM88','AEUG','368cash','365online') AND s.currency=51) 
						OR (s.site IN ('WINCLUB88') AND s.currency=15))							THEN	-- Flow C: (INH currency and Happy8/SM88/AEUG/368cash/365online site) or (IN currency and WINCLUB88 site)
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
								WHEN basketball < 5000		AND basketball >= 0			THEN 10
								WHEN basketball < 10000		AND basketball >= 5000		THEN 11
								WHEN basketball < 30000		AND basketball >= 10000		THEN 12
								WHEN basketball >=30000									THEN 13 END
					ELSE
							CASE 
								WHEN basketball <-140000								THEN 1
								WHEN basketball <-120000	AND basketball >=-140000	THEN 2
								WHEN basketball <-100000	AND basketball >=-120000	THEN 3
								WHEN basketball <-80000		AND basketball >=-100000	THEN 4
								WHEN basketball <-60000		AND basketball >=-80000		THEN 5
								WHEN basketball <-40000		AND basketball >=-60000		THEN 6
								WHEN basketball <-20000		AND basketball >=-40000		THEN 7
								WHEN basketball < 0			AND basketball >=-20000		THEN 8
								WHEN basketball < 10000		AND basketball >= 0			THEN 9
								WHEN basketball < 20000		AND basketball >= 10000		THEN 10
								WHEN basketball < 30000		AND basketball >= 20000		THEN 11
								WHEN basketball < 40000		AND basketball >= 30000		THEN 12
								WHEN basketball >=40000									THEN 13 END
					END
		END	BasketballLevel,
		Soccer as WinlossSoccer,
		Basketball as WinlossBasketball,
		CASE WHEN sc.CustID IS NOT NULL THEN 1 ELSE IsSoccer END UpdateSoccer,
		CASE WHEN bb.CustID IS NOT NULL THEN 1 ELSE IsBasketball END UpdateBasketball
	FROM T
		INNER JOIN Customer c WITH(NOLOCK) ON c.custid = t.custid
		LEFT JOIN Dep_custsuper s WITH(NOLOCK) ON c.srecommend = s.custid
		LEFT JOIN CustDangerJobExclusion sc WITH (NOLOCK) ON sc.custid=t.custid AND sc.SportType=1
		LEFT JOIN CustDangerJobExclusion bb WITH (NOLOCK) ON bb.custid=t.custid AND bb.SportType=2
	
	--PA List
	INSERT INTO #tblCustDangerInfo(custid,Soccer,Basketball,WinlossSoccer,WinlossBasketball,UpdateSoccer,UpdateBasketball)
	SELECT DISTINCT 
		  cd.CustID
		, CASE WHEN sc.CustID IS NOT NULL THEN 13 END SoccerLevel
		, CASE WHEN bb.CustID IS NOT NULL THEN 13 END BasketballLevel
		, NULL AS WinlossSoccer
		, NULL AS WinlossBasketball
		, CASE WHEN sc.CustID IS NOT NULL THEN 1 ELSE 0 END UpdateSoccer
		, CASE WHEN bb.CustID IS NOT NULL THEN 1 ELSE 0 END UpdateBasketball
	FROM CustDangerJobExclusion cd WITH (NOLOCK)
		OUTER APPLY (SELECT TOP (1) sc.CustID FROM CustDangerJobExclusion sc WITH (NOLOCK) WHERE sc.custid=cd.custid AND sc.SportType=1 AND sc.CreateDate>=@ScanDate) sc
		OUTER APPLY (SELECT TOP (1) bb.CustID FROM CustDangerJobExclusion bb WITH (NOLOCK) WHERE bb.custid=cd.custid AND bb.SportType=2 AND bb.CreateDate>=@ScanDate) bb
	WHERE cd.CreateDate>=@ScanDate 
		AND NOT EXISTS (SELECT 1 FROM #tblCustDangerInfo WHERE cd.CustID=Custid)

	INSERT INTO #tblCustDangerOld(custid,DangerLevel,Soccer,Basketball,IsManualSoccer,IsManualBasketball)
	SELECT custid, ISNULL(DangerLevel,0), soccer, basketball, IsManualSoccer, IsManualBasketball
	FROM custinfo c WITH(NOLOCK)
		CROSS APPLY dbo.f_GetDangerLevelInfo(ISNULL(DangerLevel,0)) t
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
			dbo.f_GenerateDangerLevelInfo(DangerLevel,Soccer,Basketball,UpdateSoccer,UpdateBasketball) as '@value'
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

