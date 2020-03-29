/*
	Created: 20200303@Tiara
	Date: 20200303
	Task: Insert PT and Betlimit for SA Gaming Deposit [Redmine: 128058]
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

	DECLARE @SuperPT SMALLINT = 85
	DECLARE @currency INT, @siteId INT
	DECLARE @SportType SMALLINT = 244, @BetType SMALLINT = 3001

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
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=43)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,43
	END
	-------------------------------------Prepare Stake Level----------------------------------------------------
	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL,
		[ExhangeId] [INT] NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID], [MinStake], [MaxStake],[MinLabel],[MaxLabel],[ExhangeId])
	SELECT 3001,'50','2500',50,2500,71 UNION ALL
	SELECT 3001,'100','5000',100,5000,71 UNION ALL
	SELECT 3001,'500','10000',500,10000,71 UNION ALL
	SELECT 3001,'50','2500',50,2500,2 UNION ALL
	SELECT 3001,'100','5000',100,5000,2 UNION ALL
	SELECT 3001,'500','10000',500,10000,2 UNION ALL
	SELECT 3001,'30','3000',30,3000,67 UNION ALL
	SELECT 3001,'100','5000',100,5000,67 UNION ALL
	SELECT 3001,'500','10000',500,10000,67 UNION ALL
	SELECT 3001,'20','2000',20,2000,56 UNION ALL
	SELECT 3001,'50','5000',50,5000,56 UNION ALL
	SELECT 3001,'100','10000',100,10000,56 UNION ALL
	SELECT 3001,'30','3000',30,3000,13 UNION ALL
	SELECT 3001,'100','10000',100,10000,13 UNION ALL
	SELECT 3001,'500','20000',500,20000,13 UNION ALL
	SELECT 3001,'30','3000',30,3000,66 UNION ALL
	SELECT 3001,'100','10000',100,10000,66 UNION ALL
	SELECT 3001,'500','20000',500,20000,66 UNION ALL
	SELECT 3001,'30','3000',30,3000,81 UNION ALL
	SELECT 3001,'100','10000',100,10000,81 UNION ALL
	SELECT 3001,'500','20000',500,20000,81 UNION ALL
	SELECT 3001,'30','3000',30,3000,5 UNION ALL
	SELECT 3001,'100','10000',100,10000,5 UNION ALL
	SELECT 3001,'500','20000',500,20000,5 UNION ALL
	SELECT 3001,'30','3000',30,3000,54 UNION ALL
	SELECT 3001,'100','10000',100,10000,54 UNION ALL
	SELECT 3001,'500','20000',500,20000,54 UNION ALL
	SELECT 3001,'30','3000',30,3000,53 UNION ALL
	SELECT 3001,'100','10000',100,10000,53 UNION ALL
	SELECT 3001,'500','20000',500,20000,53 UNION ALL
	SELECT 3001,'1','500',1,500,16 UNION ALL
	SELECT 3001,'50','1000',50,1000,16 UNION ALL
	SELECT 3001,'100','2000',100,2000,16 UNION ALL
	SELECT 3001,'1','500',1,500,64 UNION ALL
	SELECT 3001,'50','1000',50,1000,64 UNION ALL
	SELECT 3001,'100','2000',100,2000,64 UNION ALL
	SELECT 3001,'1','500',1,500,35 UNION ALL
	SELECT 3001,'50','1000',50,1000,35 UNION ALL
	SELECT 3001,'100','2000',100,2000,35 UNION ALL
	SELECT 3001,'1','500',1,500,3 UNION ALL
	SELECT 3001,'50','1000',50,1000,3 UNION ALL
	SELECT 3001,'100','2000',100,2000,3 UNION ALL
	SELECT 3001,'1','500',1,500,74 UNION ALL
	SELECT 3001,'50','1000',50,1000,74 UNION ALL
	SELECT 3001,'100','2000',100,2000,74 UNION ALL
	SELECT 3001,'1','500',1,500,9 UNION ALL
	SELECT 3001,'50','1000',50,1000,9 UNION ALL
	SELECT 3001,'100','2000',100,2000,9 UNION ALL
	SELECT 3001,'1','500',1,500,20 UNION ALL
	SELECT 3001,'50','1000',50,1000,20 UNION ALL
	SELECT 3001,'100','2000',100,2000,20 UNION ALL
	SELECT 3001,'10','300',10,300,69 UNION ALL
	SELECT 3001,'100','1000',100,1000,69 UNION ALL
	SELECT 3001,'300','3000',300,3000,69 UNION ALL
	SELECT 3001,'10','300',10,300,70 UNION ALL
	SELECT 3001,'100','1000',100,1000,70 UNION ALL
	SELECT 3001,'300','3000',300,3000,70 UNION ALL
	SELECT 3001,'30','3000',30,3000,15 UNION ALL
	SELECT 3001,'500','10000',500,10000,15 UNION ALL
	SELECT 3001,'2000','20000',2000,20000,15 UNION ALL
	SELECT 3001,'30','3000',30,3000,22 UNION ALL
	SELECT 3001,'500','10000',500,10000,22 UNION ALL
	SELECT 3001,'2000','20000',2000,20000,22 UNION ALL
	SELECT 3001,'30','3000',30,3000,33 UNION ALL
	SELECT 3001,'500','10000',500,10000,33 UNION ALL
	SELECT 3001,'2000','20000',2000,20000,33 UNION ALL
	SELECT 3001,'30','3000',30,3000,34 UNION ALL
	SELECT 3001,'500','10000',500,10000,34 UNION ALL
	SELECT 3001,'2000','20000',2000,20000,34 UNION ALL
	SELECT 3001,'30','3000',30,3000,47 UNION ALL
	SELECT 3001,'500','10000',500,10000,47 UNION ALL
	SELECT 3001,'2000','20000',2000,20000,47 UNION ALL
	SELECT 3001,'100','5000',100,5000,51 UNION ALL
	SELECT 3001,'500','20000',500,20000,51 UNION ALL
	SELECT 3001,'1000','50000',1000,50000,51 UNION ALL
	SELECT 3001,'300','30000',300,30000,61 UNION ALL
	SELECT 3001,'500','50000',500,50000,61 UNION ALL
	SELECT 3001,'1000','100000',1000,100000,61 UNION ALL
	SELECT 3001,'300','30000',300,30000,55 UNION ALL
	SELECT 3001,'500','50000',500,50000,55 UNION ALL
	SELECT 3001,'1000','100000',1000,100000,55 UNION ALL
	SELECT 3001,'100','10000',100,10000,4 UNION ALL
	SELECT 3001,'1000','50000',1000,50000,4 UNION ALL
	SELECT 3001,'3000','110000',3000,110000,4 UNION ALL
	SELECT 3001,'100','10000',100,10000,43 UNION ALL
	SELECT 3001,'1000','50000',1000,50000,43 UNION ALL
	SELECT 3001,'3000','110000',3000,110000,43 UNION ALL
	SELECT 3001,'500','30000',500,30000,32 UNION ALL
	SELECT 3001,'10000','100000',10000,100000,32 UNION ALL
	SELECT 3001,'10000','300000',10000,300000,32 UNION ALL
	SELECT 3001,'1','100',1,100,6 UNION ALL
	SELECT 3001,'5','500',5,500,6 UNION ALL
	SELECT 3001,'10','2000',10,2000,6 UNION ALL
	SELECT 3001,'1','100',1,100,78 UNION ALL
	SELECT 3001,'5','500',5,500,78 UNION ALL
	SELECT 3001,'10','2000',10,2000,78 UNION ALL
	SELECT 3001,'1','100',1,100,12 UNION ALL
	SELECT 3001,'5','500',5,500,12 UNION ALL
	SELECT 3001,'10','2000',10,2000,12 UNION ALL
	SELECT 3001,'1','500',1,500,1 UNION ALL
	SELECT 3001,'10','1000',10,1000,1 UNION ALL
	SELECT 3001,'50','2000',50,2000,1 UNION ALL
	SELECT 3001,'1000','150000',1000,150000,72 UNION ALL
	SELECT 3001,'5000','500000',5000,500000,72 UNION ALL
	SELECT 3001,'10000','1000000',10000,1000000,72
	
	UPDATE t
	SET MinLabel = REVERSE(STUFF (REVERSE(t.MinLabel),4,0,','))
	FROM @DEP_Stake t
	WHERE MinStake > 999

	UPDATE t
	SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),4,0,','))
	FROM @DEP_Stake t
	WHERE MaxStake > 999

	UPDATE t
	SET MaxLabel = REVERSE(STUFF (REVERSE(t.MaxLabel),8,0,','))
	FROM @DEP_Stake t
	WHERE MaxStake > 999999


	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

	IF NOT EXISTS (	SELECT 1 
					FROM DEP_StakeLevel WITH (NOLOCK)
					WHERE SiteID = @SiteId AND ExchangeID = @currency AND GameTypeID = 3001)
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
				CONVERT(DECIMAL(19,2),t.MinStake) AS MinStake,
				CONVERT(DECIMAL(19,2),t.MaxStake) AS MaxStake,
				ExchangeId = e.exchangeid,
				GameGroupID = 0,
				@SiteId,
				StakeLevelID = @MaxStakeLevelID + ROW_NUMBER() OVER(ORDER BY e.exchangeid)
		FROM @DEP_Stake t
			INNER JOIN exchange e WITH(NOLOCK) ON t.ExhangeId = e.exchangeid
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
	WHERE ST.GameTypeID = 3001
	ORDER BY ST.GameTypeID
	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT DISTINCT t.custid,@Sporttype, TB.BettypeID, TB.StakeLevelList
	FROM Dep_StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
	CROSS JOIN  #tmpSMA t
	WHERE ExchangeId=@currency AND S.SiteID = @siteId
	--Member Level
	INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID],[SportType],[BetType],[StakeLevelList],LastUpdated) 
	SELECT DISTINCT t.custid,@Sporttype,TB.BettypeID, CAST(MIN(StakeLevelID) AS varchar(50)),GETDATE()
	FROM Dep_StakeLevel S WITH(NOLOCK) INNER JOIN #tmpSTListSMA TB WITH (NOLOCK) ON S.GameTypeID = TB.BettypeID
		CROSS JOIN  #tmpCustInsert t
	WHERE ExchangeId=@currency AND S.SiteID = @siteId
	GROUP BY t.custid, TB.BettypeID

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=44)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,44
	END
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

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

		INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
		SELECT	t.custid
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0) AS bitmapIsDisabled
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
		FROM #TempProductStatus t
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

		WAITFOR DELAY '00:00:00.100'
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=42)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,42
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #tmpCustInsert
	DROP TABLE #tmpSTListSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
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
		AND cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		AND ci.currency NOT IN (45,75,76,77,41) --Won (KRW), PTU, PS, PTH, CHF
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
		AND cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
		AND ci.currency NOT IN (45,75,76,77,41) --Won (KRW), PTU, PS, PTH, CHF 
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
