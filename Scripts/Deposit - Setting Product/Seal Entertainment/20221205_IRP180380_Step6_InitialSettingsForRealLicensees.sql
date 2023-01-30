/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221205
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites for real licensees [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT
	, @currency INT
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0
		
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
		
	CREATE TABLE #tblCust (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #tblSMA (CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)	
	
	DECLARE @PT SMALLINT = 93
	DECLARE @StakeLevelID INT
	DECLARE @SportType SMALLINT = 156, @BetType SMALLINT = 8900	 ,@GameGroupID INT = 42 

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend 
		AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	
	INSERT INTO #tblSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend 
		AND ci.custid<=@max_custid 
		AND roleid IN (2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tblCust(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)		
	WHERE ci.srecommend = @srecommend 
		AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	DECLARE @BitmapOrder INT = 36
	
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,159
	UNION SELECT @srecommend,160
	UNION SELECT @srecommend,161
	
	-------------------------------------PT Setting-----------------------------------------------
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
		   ,CASE WHEN roleid IN (4) THEN @PT ELSE 0 END
		   ,CASE WHEN roleid IN (4,3) THEN @PT ELSE 0 END
		   ,CASE WHEN roleid IN (4,2) THEN @PT ELSE 0 END
	FROM #tblSMA WITH(NOLOCK)
			
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
		   ,@PT
	FROM #tblSMA
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
		   ,@PT
	FROM #tblCust t
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON t.CustID=m.CustID
	WHERE m.IsGroupedPT= 0
	
	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
	FROM #tblCust t WITH(NOLOCK)
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
	
	-------------------------------------Betlimit Setting-----------------------------------------------
	SELECT @StakeLevelID = sl.StakeLevelID 
	FROM dbo.DEP_StakeLevel sl WITH (NOLOCK) 
	WHERE sl.GameTypeID = @BetType
		AND sl.GameGroupID = @GameGroupID
		AND sl.ExchangeId = @Currency
	
	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT s.custid,@Sporttype, @BetType, @StakeLevelID
	FROM #tblSMA S 
	
	--Member Level
	DECLARE @tmpCust TABLE(CustID INT PRIMARY KEY)
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (5000) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @tmpCust(CustID)
		FROM #tblCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0		
			BREAK;
					
		INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , @SportType,@BetType,@StakeLevelID as [StakeLevelList],GETDATE() as LastUpdated
		FROM @tmpCust
		
		DELETE @tmpCust
	END
	
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpCustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	
	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)		
		INNER JOIN  #tblSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,@bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,@bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)		
		INNER JOIN  #tblCust temp ON temp.CustID = c.custid

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #tmpCustProductStatus

		UPDATE TOP (5000) t WITH (ROWLOCK)
		SET isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #tmpCustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus t 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #tmpCustProductStatus tmp ON c.CustID = tmp.CustID
	END
	
	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	t.custid
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitmapOrder,0) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitmapOrder,0)  AS bitmapIsHidden
	FROM (
		SELECT custid FROM #tblCust
		UNION ALL SELECT custid FROM #tblSMA
	) t
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)
	
	DROP TABLE #Dummy
	DROP TABLE #tblCust
	DROP TABLE #tblSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #tmpCustProductStatus
END	
GO

------------------------------------------------------	
-- BEGIN STEP 2: Initial settings
--------------------------------------------------------------------------------------
SET NOCOUNT ON
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20),
	@srecommend INT,
	@max_custid INT,
	@currency INT
	
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target
		
CREATE TABLE #supers (custid int, currency int, isfinished bit default(0))

SELECT @max_custid = xxx

INSERT INTO #supers(custid, currency)
SELECT c.custid, c.currency
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
	AND s.islicensee = 1
	AND ci.Enabled = 1
	AND c.custid <= @max_custid
	AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK)
					WHERE currency IN (2,3,4,6,12,13,15,20,32,45,46,49,51,61,70,82,96,97,121,123))
	AND ((s.site IN ('spondemo','Athena000','SampleSite') AND c.currency <> 20)
		OR s.site NOT IN ('spondemo','Athena000','SampleSite')
		)
	
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid
		,@currency = currency
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@currency = @currency
			,@target = @target
			,@max_custid = @max_custid				
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
