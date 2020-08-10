/*
	Created: Winfred
	Date: 20200805
	Task: Insert PT and Betlimit for new Customer PG Game Deposit [Redmine: 137763]
	DB: DBCUST/CustDB
*/
-- BEGIN STEP 1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
-----------------------------------------------------
	CREATE TABLE #supers (custid int,isfinished bit default(0))

	DECLARE @maxcustid INT

	SELECT @maxcustid = xxx

	INSERT INTO #supers(custid)
	SELECT ci.custid
	FROM custInfo ci WITH (NOLOCK) 	
		INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.username NOT LIKE '3rdSuper%'
			AND ci.Enabled=1
			AND cs.site IN('Macaubet','Aoncash','ITCBet','9bet','M8bola','Q8bola','BE7','NBCbet','Unobet','Bolanation','Luckywin88','Winn69','Axiawin','Jumbo88','Lagadewa','Ratugg','Monstergol')
			ORDER BY ci.custid 
	
	DECLARE @SuperPT SMALLINT = 90
	DECLARE @currency INT, @siteId INT   ,@StakeLevelID INT
	DECLARE @SportType SMALLINT = 232, @BetType SMALLINT = 6001	 ,@GameGroupID INT = 16 

	DECLARE @BitOrder INT

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype

	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN(SELECT CustID FROM #supers) 
	AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%')

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
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=4
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	
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
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=3
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

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
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

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
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=2
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
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
			ci.CustID
		   ,@Sporttype
		   ,@BetType
		   ,0
		   ,0
		   ,0
		   ,@SuperPT
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON ci.CustID=m.CustID
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND m.IsGroupedPT=0
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT ci.CustID,1
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN(SELECT custid FROM #supers)
		AND ci.custid>@maxcustid AND ci.Enabled=1 
		AND RoleID=1
		AND NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=ci.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=ci.CustID)
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,61
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=61)

	-------------------------------------Betlimit Setting-----------------------------------------------
	SELECT @StakeLevelID = sl.StakeLevelID 
	FROM dbo.DEP_StakeLevel sl WITH (NOLOCK) 
	WHERE sl.GameTypeID = @BetType
		AND sl.GameGroupID = @GameGroupID
		AND sl.ExchangeId = @Currency
		AND sl.SiteID = @siteId

	CREATE TABLE #MemberTemp  (CustID INT PRIMARY KEY,StakeLevelID VARCHAR(100),isfinished BIT DEFAULT(0))	
	CREATE TABLE #SMATemp  (CustID INT PRIMARY KEY,StakeLevelID VARCHAR(100))	
	--Agent Level
	INSERT INTO  #SMATemp (CustID,StakeLevelID)
	SELECT CI.custid, CAST(sl.StakeLevelID	AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetType
								AND sl.GameGroupID = @GameGroupID
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (2,3,4) AND Enabled = 1 AND ci.custid > @maxcustid 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)

	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT   custid,@Sporttype, @BetType, StakeLevelID
	FROM #SMATemp
	--Member Level
	INSERT INTO #MemberTemp  (CustID,StakeLevelID) 
	SELECT CI.custid, CAST(sl.StakeLevelID	AS VARCHAR(100))
	FROM Custinfo CI WITH (NOLOCK)
		INNER JOIN Customer C WITH (NOLOCK) ON C.custid = CI.custid
		INNER JOIN dbo.DEP_StakeLevel sl WITH (NOLOCK) ON sl.GameTypeID = @BetType
								AND sl.GameGroupID = @GameGroupID
								AND sl.ExchangeId = c.currency
	WHERE ci.srecommend IN(SELECT CustID FROM #supers) AND ci.roleid IN (1) 
	AND Enabled = 1 AND ci.custid > @maxcustid 
	AND CI.mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE @Cust_Temp TABLE(CustID INT,StakeLevelID VARCHAR(100))
	DECLARE @BatchSize SMALLINT = 5000
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.StakeLevelID INTO @Cust_Temp(CustID,StakeLevelID)
		FROM #MemberTemp c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		INSERT INTO dbo.CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , @SportType,@BetType,StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
		FROM @Cust_Temp	
		
		DELETE FROM @Cust_Temp
	END
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,62
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=62)
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #SMATemp SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #MemberTemp M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = @BetType AND PSP.Sporttype = @SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid

	SET @BatchSize = 5000
	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
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

		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT t.custid,62
	FROM #supers t
	WHERE t.custid>@maxcustid	
		AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting a WITH(NOLOCK) WHERE a.CustID=t.custid AND a.ProductSettingID=60)

	DROP TABLE #Dummy
	DROP TABLE #MemberTemp
	DROP TABLE #SMATemp
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
