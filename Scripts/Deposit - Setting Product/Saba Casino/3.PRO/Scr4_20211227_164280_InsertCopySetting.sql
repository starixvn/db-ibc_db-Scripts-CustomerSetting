/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211227@Eden
	Task: Insert Setting for Saba Casino - Real Currency [#164280]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB ------
------------------------------------------------------
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
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0	
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0	
	   )
		RETURN
	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY,isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)

	DECLARE @SuperPT SMALLINT = 93
	DECLARE @currency INT, @BitOrder INT
	DECLARE @SportType SMALLINT = 208, @BetType SMALLINT = 2101
	DECLARE @BatchSize SMALLINT = 5000

	SELECT @currency = c.currency
	FROM dbo.customer c WITH (NOLOCK) 
		INNER JOIN site s ON s.site = c.site
	WHERE c.custid = @srecommend 

	SELECT @BitOrder= bitmapOrder 
	FROM Dep_ProductStatusProfile WITH(NOLOCK) 
	WHERE SportType=@Sporttype AND Bettype = @BetType

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
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=117)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,117
	END
	-------------------------------------Betlimit Setting-----------------------------------------------
	DECLARE @StakeLevelList VARCHAR(200), 
			@Min_StakeLevel VARCHAR(20)

	SELECT @StakeLevelList = CAST (STUFF (STL, 1,1, '') AS VARCHAR(500))
		 , @Min_StakeLevel = CAST (M.StakeLevelID AS VARCHAR(10))
	FROM (VALUES (@BetType)) AS t(Bettype)
		CROSS APPLY (SELECT ',' + CAST(StakeLevelID AS VARCHAR(10))
					FROM Dep_StakeLevel S WITH (NOLOCK)
					WHERE S.GameTypeID = t.BetType AND S.ExchangeId = @Currency
					FOR XML PATH ('') 
					) AS A(STL)
		CROSS APPLY (SELECT TOP 1 StakeLevelID
					FROM Dep_StakeLevel S WITH (NOLOCK)
						LEFT JOIN GameGroup gg WITH(NOLOCK) 
							ON s.GameGroupID = gg.GameGroupID
					WHERE S.GameTypeID = t.BetType AND S.ExchangeId = @Currency
					ORDER BY s.MaxStake ASC, s.MinStake ASC, gg.GroupName ASC
					) AS M

	--Agent Level
	INSERT INTO dbo.Dep_CustStakeLevel_Agent  ([CustID],[SportType],[BetType],[StakeLevelList]) 
	SELECT DISTINCT s.custid,@Sporttype, @BetType, @StakeLevelList
	FROM #tmpSMA S 

	--Member Level
	DECLARE @Cust_Temp TABLE(CustID INT)
	
	WHILE(1 =1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
		BEGIN 
			BREAK
		END 	
			
		INSERT INTO dbo.Dep_CustStakeLevel_Member([CustID]
										   ,[SportType]
										   ,[BetType]
										   ,[StakeLevelList]
										   ,LastUpdated) 
		SELECT CustID , @SportType,@BetType,@Min_StakeLevel as [StakeLevelList],GETDATE() as LastUpdated
		FROM @Cust_Temp	
		
		DELETE FROM @Cust_Temp
	END
	
	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=118)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,118
	END
	--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #AllUsers (CustID)
	SELECT DISTINCT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT DISTINCT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,ci.DisableCasino))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN  #tmpSMA temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder,ci.DisableCasino))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN  #tmpCust temp ON temp.CustID = c.custid

	SET @BatchSize = 5000

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 
		WHERE a.isfinished = 0
		
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
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,ci.DisableCasino) AS bitmapIsDisabled
			, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @BitOrder,0)  AS bitmapIsHidden
	FROM #AllUsers A
		INNER JOIN custInfo ci WITH(NOLOCK) ON A.CustID = ci.custid
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=116)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,116
	END

	----------Commm--------------------------
	--insert group comm setting
	INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
		(AgentID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount		
		)
	SELECT t.custid, sb.Sporttype, sb.Bettype, 0, 0, 0, 0
	FROM #tmpSMA t	
		CROSS APPLY ( SELECT * FROM (VALUES (@SportType, @BetType)) AS sp(SportType, BetType)
					)sb
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID and dcs.SportType = sb.sporttype
			AND dcs.BetType = sb.bettype	
	WHERE t.roleid = 2 AND dcs.AgentID IS NULL

	UPDATE #tmpCust SET isfinished = 0
	
	WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		-- UPDATE comm group for cust have not offered comm yet.
		UPDATE cs
			SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @Cust_Temp cb ON cb.CustID = cs.CustID
			OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
						 WHERE dcs_m.CustID = cs.CustID
						) AS tmp
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
		-- insert private setting if already offered comm before and not belong to comm group
		INSERT INTO Dep_CustDiscountSetting_Member (CustID
							,SportType
							,BetType
							,PlayerDiscount
							,AgentDiscount
							,MasterDiscount
							,SuperDiscount)  	
		SELECT c.CustID, tmp.sporttype, tmp.bettype, 0,0,0,0
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN @Cust_Temp cb ON c.CustID = cb.CustID
			CROSS APPLY (SELECT * FROM (VALUES (@SportType, @BetType)) AS sp(SportType, BetType)
						) AS tmp
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = tmp.sporttype
				AND dcs_m.BetType = tmp.bettype				
		WHERE c.IsGroupedComm = 0 AND dcs_m.custid IS NULL
			
		DELETE FROM @Cust_Temp
	END

	IF NOT EXISTS(SELECT TOP 1 1 FROM Dep_LicenseeProductSetting WITH(NOLOCK) WHERE Custid=@srecommend AND ProductSettingID=119)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT @srecommend,119
	END

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 5.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 5.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
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
			OR (cs.site IN('spondemo','Athena000')	AND Ci.currency NOT IN (20)))
		AND Ci.currency IN (
							 2	-- 	RM
							,3	-- 	US$
							,4	-- 	TB
							,12	-- 	GBP
							,13	-- 	RMB
							,15	-- 	IN
							,51	-- 	INH
							,61	-- 	INR
							,66	-- 	YUN
							,70	-- 	MKK
							,96	-- 	USDT
							,20 --	UUS
							)
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
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
