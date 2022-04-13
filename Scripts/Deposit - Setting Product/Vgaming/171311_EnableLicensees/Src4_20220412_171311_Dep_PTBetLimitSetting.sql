/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220412
	Task:  Insert PT and Betlimit Vgaming for Single Wallet Licensees - deposit RedmineID:#171311
	DB: DBCUST/CustDB
	
	P/s : Step 4 Insert PT and Betlimit all Licensee Deposit
*/
-- BEGIN STEP 4.1: Deploy this SP at DBCUST.CustDB, Run only in the FIRST running
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	@CustIDs VARCHAR(MAX) 	= ''
	,@srecommend INT
 	,@RoleID INT = 0
 	,@StakeLevelID INT 
 	,@PT SMALLMONEY
 	,@BitOrder INT
	,@currency INT 
	,@site varchar(20)
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','TESTDBCUST','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('custInfo') = 0 RETURN	
	IF dbo.f_CheckRepTable('Dep_custsuper') = 0 RETURN	
	
	CREATE TABLE #CustList (CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #CustListTemp (CustID INT PRIMARY KEY)
			    
	INSERT INTO #CustList(custid)	
	SELECT val
	FROM dbo.strSplit(@CustIDs,',')
	
	DECLARE @batch SMALLINT = 2500
	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (171, 3801)
	
	-- SMA LEVEL
	IF @RoleID <>1
	BEGIN
		WHILE(1 =1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
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
					a.CustID
				   ,t.SportType
				   ,t.BetType
				   ,0 AS IsLive
				   ,CASE WHEN @RoleID = 0 AND a.CustID = @srecommend THEN @PT ELSE 0 END AS SuperPT
				   ,CASE WHEN @RoleID = 0 THEN @PT ELSE 0 END AS MasterPT
				   ,CASE WHEN @RoleID = 2 OR a.CustID = @srecommend  THEN @PT ELSE 0 END AS AgentPT
			FROM #CustListTemp a WITH(NOLOCK)
				CROSS APPLY @SportBetType t
				
			--Agent Level
			IF @RoleID = 2
			BEGIN
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
						a.CustID
					   ,t.SportType
					   ,t.BetType
					   ,0 AS IsLive
					   ,0 AS SuperPT
					   ,0 AS MasterPT
					   ,@PT AS AgentPT
				FROM #CustListTemp a WITH(NOLOCK)
					CROSS APPLY @SportBetType t
				
				-------------------------------------Comm Setting----------------------------------------------

				INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member
					(	 [AgentID]
						,[SportType]
						,[BetType]
						,[PlayerDiscount]
						,[AgentDiscount]
						,[MasterDiscount]
						,[SuperDiscount]
					 )
				SELECT 
						a.CustID
					   ,t.SportType
					   ,t.BetType
					   ,0 AS PlayerDiscount
					   ,0 AS AgentDiscount
					   ,0 AS MasterDiscount
					   ,0 AS SuperDiscount	
				FROM #CustListTemp a WITH(NOLOCK)
					CROSS APPLY @SportBetType t

			END 
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO [dbo].[Dep_CustStakeLevel_Agent]
				   ([CustID]
				   ,[SportType]
				   ,[BetType]
				   ,[StakeLevelList])
			SELECT t.CustID, sp.sporttype, sp.BetType, @StakeLevelID
			FROM #CustListTemp t
				CROSS APPLY @SportBetType sp
			
			TRUNCATE TABLE #CustListTemp
		END
	END	
	
	IF @RoleID  = 1
	BEGIN
		WHILE(1 = 1)
		BEGIN
			
			UPDATE TOP (@batch) c WITH (ROWLOCK)
			SET c.isfinished = 1
			OUTPUT DELETED.CustID INTO #CustListTemp(CustID)
			FROM #CustList c 
			WHERE isfinished = 0
			
			IF @@ROWCOUNT = 0 BREAK
			-------------------------------------PT Setting-----------------------------------------------
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
					a.CustID
					,t.SportType
					,t.BetType
					,0 AS IsLive
					,0 AS SuperPT
					,0 AS MasterPT
					,@PT AS AgentPT
			FROM #CustListTemp a WITH(NOLOCK)
				INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
				CROSS APPLY @SportBetType t
			WHERE m.IsGroupedPT=0

			IF(@Site='asiabet88' AND @Currency IN(3,6))
			BEGIN
				INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT,isGroupedComm)
				SELECT t.CustID,1,1
				FROM #CustListTemp t WITH(NOLOCK) 
				WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
					AND EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
			END
			ELSE
			BEGIN
				INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT,isGroupedComm)
				SELECT t.CustID,1,1
				FROM #CustListTemp t WITH(NOLOCK) 
				WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode D WITH(NOLOCK) WHERE D.CustID=t.CustID)
					AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
			END
			-------------------------------------Comm Setting----------------------------------------------
			INSERT INTO dbo.Dep_CustDiscountSetting_Member
					(	 [CustID]
						,[SportType]
						,[BetType]
						,[PlayerDiscount]
						,[AgentDiscount]
						,[MasterDiscount]
						,[SuperDiscount]
					 )
				SELECT 
						a.CustID
					   ,t.SportType
					   ,t.BetType
					   ,0 AS PlayerDiscount
					   ,0 AS AgentDiscount
					   ,0 AS MasterDiscount
					   ,0 AS SuperDiscount	
				FROM #CustListTemp a WITH(NOLOCK)
					INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON m.CustID=a.CustID
					CROSS APPLY @SportBetType t
			WHERE m.IsGroupedComm=0
			-------------------------------------Betlimit Setting----------------------------------------------
			INSERT INTO [dbo].[Dep_CustStakeLevel_Member]
				   ([CustID]
				   ,[SportType]
				   ,[BetType]
				   ,[StakeLevelList]
				   ,[LastUpdated])
			SELECT CustID, sp.sporttype, sp.BetType, @StakeLevelID, GetDate()
			FROM #CustListTemp
			CROSS APPLY @SportBetType sp
		
			TRUNCATE TABLE #CustListTemp
		END 	
	END
	
	
	DROP TABLE #CustList
	DROP TABLE #CustListTemp
END
GO
-- BEGIN STEP 4: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----		
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, site	varchar(20),isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT smallmoney = 93.00 , @currency INT , @Role SMALLINT = 0,@site varchar(20)
SELECT @max_custid = xxx

INSERT INTO #supers(custid,Currency,site)
SELECT ci.custid,ci.currency, cs.site
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('JIB88','442ball','ZFRT129','NukeGaming','ABEMT','liv66SW','0sServices','WSlots','THECLUB','Winsplay',
					'ZFRT080','ZhiFeng204','PINT','M88ASIA','livv88sw','LSM99','ZFRT175','ZhiFeng133','Omni88','awc2',
					'FHLMSABAS','ZhiFeng107','UGaming','XLMEDIA','368CashSW','Apollo369','TLC','Nexus','SDYSW','AsiaBet88','Riverich','SampleSite',
					'F88IN1SW','bigbet','CENTRAL168','GmasterS','DongYing','ig128s','24AVIASL','ZhiFeng055','Zhifeng215','568WinSW','Asia999',
					'JDYGaming','ZFRT167','khmerA2','Weiwei','ZhiFeng116','Peakk','GMDFD','Betway','LEIHUO','ZFRT152','ZhiFeng208','JBO','Pay4d',
					'ZhiFeng106','ARYA','SAGAME88','ZhiFeng173','khmer','V9betSW','THEDEN','ZhiFeng122','awc','ZhiFeng200','ZhiFeng084',
					'AEUGSW','OkadaSW','yuanbao','Rakyat4DSW','De365','ZFRT115','GoToWin','ZhiFeng168','OCMSS','GSCSW')
	
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @BitOrder INT 
SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType = 171 -- SportType

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
DECLARE @StakeLevelID INT 
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0		
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SELECT @StakeLevelID = StakeLevelID	
		FROM dbo.Dep_StakeLevel WITH(NOLOCK)
		WHERE ExchangeID = @currency AND GameTypeID = 3801 AND GameGroupID = 26
		
		SET @PT = 93.00	
		
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend, ProductSettingID 
		FROM Dep_ProductSetting dp WITH(NOLOCK) 
		WHERE dp.ProductID = 66
			AND dp.SettingType IN (4,1,8,9) -- Product Status, PT, StakeLevel, Comm
			AND NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting WITH (NOLOCK) WHERE CustID = @srecommend AND ProductSettingID = dp.ProductSettingID)
	END
	ELSE
	BEGIN
	
	    UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @StakeLevelID = @StakeLevelID,@PT = @PT,@BitOrder = @BitOrder,@srecommend = @srecommend, @currency = @currency, @site = @site,@target = 'REPLICATED' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
-- BEGIN STEP 4: RUN THIS SCRIPT AT DBCUST -----
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
DROP TABLE	#supers;
CREATE TABLE #supers			(CustID INT PRIMARY KEY, Currency INT, site	varchar(20),isfinished bit default(0))
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED,srecommend INT,RoleID INT,isfinished BIT DEFAULT(0))

CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY)
CREATE TABLE #tmpSMATemp		(CustID INT PRIMARY KEY)

DECLARE @batch SMALLINT = 5000
DECLARE @CustIDs VARCHAR(MAX)
DECLARE @max_custid INT, @srecommend INT ,@PT smallmoney = 93.00 , @currency INT , @Role SMALLINT = 0,@site varchar(20)
SELECT @max_custid = xxx

INSERT INTO #supers(custid,Currency,site)
SELECT ci.custid,ci.currency, cs.site
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'	
	AND ci.CustID <= @max_custid
	AND ci.Enabled=1
	AND cs.site IN('JIB88','442ball','ZFRT129','NukeGaming','ABEMT','liv66SW','0sServices','WSlots','THECLUB','Winsplay',
					'ZFRT080','ZhiFeng204','PINT','M88ASIA','livv88sw','LSM99','ZFRT175','ZhiFeng133','Omni88','awc2',
					'FHLMSABAS','ZhiFeng107','UGaming','XLMEDIA','368CashSW','Apollo369','TLC','Nexus','SDYSW','AsiaBet88','Riverich','SampleSite',
					'F88IN1SW','bigbet','CENTRAL168','GmasterS','DongYing','ig128s','24AVIASL','ZhiFeng055','Zhifeng215','568WinSW','Asia999',
					'JDYGaming','ZFRT167','khmerA2','Weiwei','ZhiFeng116','Peakk','GMDFD','Betway','LEIHUO','ZFRT152','ZhiFeng208','JBO','Pay4d',
					'ZhiFeng106','ARYA','SAGAME88','ZhiFeng173','khmer','V9betSW','THEDEN','ZhiFeng122','awc','ZhiFeng200','ZhiFeng084',
					'AEUGSW','OkadaSW','yuanbao','Rakyat4DSW','De365','ZFRT115','GoToWin','ZhiFeng168','OCMSS','GSCSW')
ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #supers) AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')
	AND custid<=@max_custid 

INSERT INTO #tmpCust(CustID,srecommend)
SELECT CustID, srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid = 1 AND ci.Enabled=1	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

INSERT INTO #tmpSMA(CustID,RoleID,srecommend)
SELECT CustID,RoleID,srecommend
FROM custInfo ci WITH(NOLOCK)
WHERE ci.srecommend IN (SELECT CustID FROM #supers) AND ci.custid<=@max_custid 
	AND roleid IN(2,3,4) AND ci.Enabled=1 AND mrecommend NOT IN (SELECT custid FROM #Dummy)		

DECLARE @BitOrder INT 
SELECT @BitOrder= bitmapOrder 
FROM Dep_ProductStatusProfile WITH(NOLOCK) 
WHERE SportType = 171 -- SportType

DECLARE @super_cnt INT, @index INT = 0 , @DoneSM BIT, @DoneAgent BIT 
DECLARE @StakeLevelID INT
SET @super_cnt = (SELECT COUNT(*) FROM #supers )
DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

SELECT @srecommend = 0 ,@DoneSM = 0 , @DoneAgent = 0

WHILE (1 = 1)
BEGIN
	SELECT @CustIDs = ''
	IF NOT EXISTS(SELECT TOP 1 1 
				FROM #tmpSMA
				WHERE isfinished = 0 AND srecommend = @srecommend
				UNION 
				SELECT TOP 1 1 
				FROM #tmpCust
				WHERE isfinished = 0 AND srecommend = @srecommend
			)
	BEGIN
		UPDATE TOP (1) #supers
		SET isfinished = 1
			,@srecommend = custid
			,@currency = currency
			,@DoneSM = 0
			,@DoneAgent = 0	
			,@Role  = 0
			,@site = site
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0 BREAK
		SET @index = @index + 1
		RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
		
		SELECT @StakeLevelID = StakeLevelID	
		FROM dbo.Dep_StakeLevel WITH(NOLOCK)
		WHERE ExchangeID = @currency AND GameTypeID = 3801 AND GameGroupID = 26
		
		SET @PT = 93.00	
		
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend, ProductSettingID 
		FROM Dep_ProductSetting dp WITH(NOLOCK) 
		WHERE dp.ProductID = 66
			AND dp.SettingType IN (4,1,8,9) -- Product Status, PT, StakeLevel, Comm
			AND NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting WITH (NOLOCK) WHERE CustID = @srecommend AND ProductSettingID = dp.ProductSettingID)
	END
	ELSE
	BEGIN
	
	    UPDATE TOP (@batch) a
		SET a.isfinished = 1
		OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
		FROM #tmpSMA a	
		WHERE isfinished = 0 AND RoleID <>  2 AND srecommend = @srecommend
		
		IF @@ROWCOUNT = 0 SET @DoneSM = 1
		IF @DoneSM = 0
		BEGIN
		  SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
		END
		ELSE
		BEGIN
			UPDATE TOP (@batch) a
			SET a.isfinished = 1
			OUTPUT INSERTED.CustID INTO #tmpSMATemp(CustID)	
			FROM #tmpSMA a	
			WHERE isfinished = 0 AND RoleID = 2 AND srecommend = @srecommend
			
			IF @@ROWCOUNT = 0 SET @DoneAgent = 1
			IF @DoneAgent = 0
			BEGIN
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ',' FROM #tmpSMATemp
				SELECT @Role = 2
			END
			ELSE
			BEGIN
				UPDATE TOP (@batch) a
				SET a.isfinished = 1
				OUTPUT INSERTED.CustID INTO #tmpCustTemp(CustID)	
				FROM #tmpCust a	
				WHERE isfinished = 0 AND srecommend = @srecommend
				IF @@ROWCOUNT = 0 BREAK
				SELECT @CustIDs = @CustIDs + cast(custid AS VARCHAR(10)) + ','	FROM #tmpCustTemp
				SELECT @Role = 1
			END
		END

		EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @CustIDs = @CustIDs, @RoleID = @Role, @StakeLevelID = @StakeLevelID, @PT = @PT,@BitOrder = @BitOrder,@srecommend = @srecommend, @currency = @currency, @site = @site,@target = 'DBCUST' 	
	
		TRUNCATE TABLE #tmpCustTemp
		TRUNCATE TABLE #tmpSMATemp
		WAITFOR DELAY '00:00:00.280'
		
	END

END	

DROP TABLE #supers	
DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpSMATemp	
GO
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 