/*
	Created: Winfred
	Date: 20200828
	Task: Insert PT and Betlimit and Status for WM Deposit [Redmine: 131589]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 

		OR dbo.f_CheckRepTable('Dep_StakeLevel') = 0 
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #tmpCustInsert		(CustID INT PRIMARY KEY)
	CREATE TABLE #tmpSTListSMA (BettypeID INT, StakeLevelList VARCHAR(500))

	DECLARE @SuperPT SMALLINT = 88
	DECLARE @currency INT, @siteId INT
	DECLARE @SportType SMALLINT = 233, @BetType SMALLINT = 3401 ,@StakeLevelList_min varchar(50)

	SELECT @currency = c.currency, @siteId = s.siteid
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN site s ON s.site = c.site
	WHERE c.custid = @srecommend

	DECLARE @BitOrder INT

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

	INSERT INTO #tmpCust(CustID)
	SELECT CustID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)							   
	

	-------------------------------------PT Setting-----------------------------------------------
	--Agent Level
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,@SuperPT
		   ,@SuperPT
		   ,@SuperPT
	FROM #tmpSMA WITH(NOLOCK)
	WHERE RoleID=4
	
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,@SuperPT
		   ,0	
	FROM #tmpSMA WITH(NOLOCK)
	WHERE RoleID=3

	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM #tmpSMA WITH(NOLOCK)
	WHERE RoleID=2

	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			[CustID]
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM #tmpSMA
	WHERE RoleID=2
	--Member Level
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			t.CustID
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM #tmpCust t
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID=m.CustID
	WHERE m.IsGroupedPT=0

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM #tmpCust t WITH(NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) 
				WHERE Custid=@srecommend AND ProductSettingID=71)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,71
	END
	-------------------------------------Insert Stake Level-----------------------------------------------
	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL,
		[ExchangeId] [INT] NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID],[ExchangeId],[MinLabel],[MaxLabel], [MinStake], [MaxStake])
	--USD (US$, Yen, $US,UT, USD)
	SELECT 3401 , 3, '1', '100', 1, 100 UNION ALL 
	SELECT 3401 , 3, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 3, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 3, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 16, '1', '100', 1, 100 UNION ALL 
	SELECT 3401 , 16, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 16, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 16, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 35, '1', '100', 1, 100 UNION ALL 
	SELECT 3401 , 35, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 35, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 35, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 64, '1', '100', 1, 100 UNION ALL 
	SELECT 3401 , 64, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 64, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 64, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 95, '1', '100', 1, 100 UNION ALL 
	SELECT 3401 , 95, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 95, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 95, '50', '5,000', 50, 5000 UNION ALL 
	--MYR (RM);HKD (HK$,HKK);CNY (RMB, YUN)
	SELECT 3401 , 2, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 2, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 2, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 2, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 5, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 5, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 5, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 5, '100', '10,000', 100, 10000 UNION ALL
	--HKK
	SELECT 3401 , 67, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 67, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 67, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 67, '100', '10,000', 100, 10000 UNION ALL 
	---------------------------- 
	SELECT 3401 , 13, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 13, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 13, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 13, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 66, '10', '1,000', 10, 1000 UNION ALL 
	SELECT 3401 , 66, '30', '3,000', 30, 3000 UNION ALL 
	SELECT 3401 , 66, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 66, '100', '10,000', 100, 10000 UNION ALL 
	--THB (TB,THB)
	SELECT 3401 , 43, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 43, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 43, '500', '50,000', 500, 50000 UNION ALL 
	--TB
	SELECT 3401 , 4, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 4, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 4, '500', '50,000', 500, 50000 UNION ALL 
	---------------------------------------
	--IDR (IN,IND,IDD,IDR,DDD)
	SELECT 3401 , 15, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 15, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 15, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 15, '500', '50,000', 500, 50000 UNION ALL
	----IND,IDD,IDR,DDD
	SELECT 3401 , 22, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 22, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 22, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 22, '500', '50,000', 500, 50000 UNION ALL
	SELECT 3401 , 33, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 33, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 33, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 33, '500', '50,000', 500, 50000 UNION ALL  
	SELECT 3401 , 34, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 34, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 34, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 34, '500', '50,000', 500, 50000 UNION ALL
	SELECT 3401 , 47, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 47, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 47, '200', '20,000', 200, 20000 UNION ALL 
	SELECT 3401 , 47, '500', '50,000', 500, 50000 UNION ALL  
	--------------------------------------- 
	--KRW (Won)
	SELECT 3401 , 45, '10,000', '1,000,000', 10000, 1000000 UNION ALL 
	--VND (INH)
	SELECT 3401 , 51, '50', '5,000', 50, 5000 UNION ALL 
	SELECT 3401 , 51, '20', '30,000', 20, 30000 UNION ALL 
	SELECT 3401 , 51, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 51, '500', '50,000', 500, 50000 UNION ALL  
	--YNG 
	SELECT 3401 , 72, '50', '5,000', 50, 5000  UNION ALL 
	SELECT 3401 , 72, '20', '30,000', 20, 30000  UNION ALL 
	SELECT 3401 , 72, '100', '10,000', 100, 10000 UNION ALL 
	SELECT 3401 , 72, '500', '50,000', 500, 50000 UNION ALL 
	--UUS
	SELECT 3401 , 20, '1', '100', 1, 100 
	  
	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

	IF NOT EXISTS (	SELECT 1 
					FROM DEP_StakeLevel WITH (NOLOCK)
					WHERE SiteID = @SiteId AND ExchangeID = @currency AND GameTypeID = @BetType)
	BEGIN
		INSERT INTO DEP_StakeLevel(
			GameTypeID
			,MinLabel
			,MaxLabel
			,MinStake
			,MaxStake
			,ExchangeId
			,GameGroupID
			,SiteID
			,StakeLevelID
		)
		SELECT	t.GameTypeID,
				t.MinLabel,
				t.MaxLabel,
				t.MinStake,
				t.MaxStake,
				ExchangeId = e.exchangeid,
				GameGroupID = 0,
				@SiteId,
				StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
		FROM @DEP_Stake t
			INNER JOIN exchange e WITH(NOLOCK) ON t.ExchangeId = e.exchangeid
		WHERE e.exchangeid = @currency 
	END

	-------------------------------------Betlimit Setting-----------------------------------------------
	INSERT INTO #tmpSTListSMA(BettypeID, StakelevelList)
	SELECT DISTINCT ST.GameTypeID, CAST (STUFF (STL, 1,1, '')AS VARCHAR(500)) AS StakeLevelList
	FROM #tmpSMA SMA CROSS JOIN Dep_StakeLevel ST
	CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
			FROM Dep_StakeLevel S WITH (NOLOCK)
			WHERE S.GameTypeID =ST.GameTypeID AND S.ExchangeId=@Currency AND S.SiteID = @siteId
			FOR XML PATH ('') ) AS A(STL)
	WHERE ST.GameTypeID = @BetType
	ORDER BY ST.GameTypeID
	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT DISTINCT t.custid,@Sporttype, TB.BettypeID, TB.StakeLevelList
	FROM Dep_StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
	CROSS JOIN  #tmpSMA t
	WHERE ExchangeId=@currency AND S.SiteID = @siteId
	--Member Level
	SET  @StakeLevelList_min  = (SELECT TOP 1 StakeLevelID 
									FROM Dep_StakeLevel WITH(NOLOCK)
									WHERE ExchangeId=@currency AND GameTypeID = @Bettype AND SiteID = @siteId 
									ORDER BY MaxStake ASC)
	
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID],[SportType],[BetType],[StakeLevelList],LastUpdated) 
	SELECT DISTINCT t.custid,@Sporttype,TB.BettypeID, @StakeLevelList_min,GETDATE()
	FROM #tmpSTListSMA TB WITH (NOLOCK)  
			CROSS JOIN  #tmpCust t
	GROUP BY t.custid, TB.BettypeID

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=72)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,72
	END
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

	DECLARE @batch int = 3000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		DELETE TOP (@batch) a
		OUTPUT deleted.CustID,deleted.bitmapIsHidden,deleted.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 

		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.100'
	END
	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	A.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=70)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,70
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #tmpCustInsert
	DROP TABLE #tmpSTListSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.CustID <= @max_custid
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = 'REPLICATED' 	
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO

-- END STEP 2: Run this SP at replicated DB: DB06, DBTP -----
-----------------------------------------------------------------------------------
-- BEGIN STEP 3: Run this SP at DBCust -----
-------------------------------------------------
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.CustID <= @max_custid
		AND ci.Enabled=1
		AND (cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		OR  (cs.site IN('spondemo','Athena000') AND ci.currency NOT IN (20,72)))
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
		
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid
			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend,@max_custid=@max_custid,@target = 'DBCUST'
		
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO		


-- END STEP 3: Run this SP at DBCust -----
-------------------------------------------------
