/*
	Date: 20200420
	Created: Eden
	Task: Insert setting for Saba.Club - Deposit [#132698] - UUS
	DB: DBCUST/CUSTDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	,@PT smallmoney
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN

	DECLARE @currency INT, @siteId INT

	SELECT @currency = ci.currency, @siteId = s.siteid 
	FROM dbo.customer ci WITH (NOLOCK) 
		INNER JOIN site s ON s.site = ci.site
	WHERE ci.custid = @srecommend

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
		,roleid	TINYINT
	)
	
	CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND username LIKE '%Acc%'
		AND custid<=@max_custid 

	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	
	INSERT INTO #SMATemp (CustID,roleid)
	SELECT custid,roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid
	AND mrecommend NOT IN (SELECT custid FROM #Dummy)

	DECLARE @SportBetType TABLE
	(
		SportType SMALLINT, 
		BetType   SMALLINT
	)
	INSERT INTO @SportBetType(SportType, BetType) VALUES (200, 1611)

	--------------------------------------------Product Status------------------------------------------------
	DECLARE @bitmapOrder INT
	 
	SELECT @bitmapOrder = bitmapOrder 
	FROM dbo.Dep_ProductStatusProfile m WITH (NOLOCK) 
		INNER JOIN @SportBetType t ON t.Sporttype = m.SportType AND t.Bettype = m.BetType

	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))

	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #SMATemp temp ON temp.CustID = c.custid
	UNION ALL
	SELECT c.CustID
		,bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,0)
		,bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,0)
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		CROSS APPLY @SportBetType t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.BetType AND PSP.Sporttype = t.SportType
		INNER JOIN  #MemberTemp temp ON temp.CustID = c.custid
	
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
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0) AS bitmapIsDisabled
				, dbo.f_GenerateProductStatus (0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF, @bitmapOrder,0)  AS bitmapIsHidden
		FROM #TempProductStatus t
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = t.CustID)

		WAITFOR DELAY '00:00:00.100'
	END

	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT temp.CustID
		  ,st.ProductSettingID
	FROM #SMATemp temp 
		 CROSS APPLY (	SELECT ProductSettingID 
						FROM Dep_ProductSetting dp WITH(NOLOCK) 
						WHERE dp.ProductID = 42
							AND dp.SettingType IN (4,1,8) -- Product Status, PT, StakeLevelGroup
						) st
	WHERE temp.roleid = 4

	------------------------------------PT Setting-------------------------------------------------	
	--SMA LEVEL
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
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = CASE WHEN d.roleid = 4 THEN @PT ELSE 0 END
			,[MasterPT] = CASE WHEN d.roleid IN (4,3) THEN @PT ELSE 0 END
			,[AgentPT] = CASE WHEN d.roleid IN (4,2) THEN @PT ELSE 0 END
	FROM #SMATemp d
		CROSS APPLY @SportBetType t

	----MEMBER LEVEL
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
		)
	SELECT 
			 d.[CustID]
			,t.[SportType]
			,t.[BetType]
			,[IsLive] = 0
			,[SuperPT] = 0
			,[MasterPT] = 0
			,[AgentPT] = @PT
	FROM #MemberTemp d
		CROSS APPLY @SportBetType t
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) ON d.CustID = m.CustID
	WHERE m.IsGroupedPT = 0

	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT d.[CustID]
		,t.[SportType]
		,t.[BetType]
		,[IsLive] = 0
		,[SuperPT] = 0
		,[MasterPT] = 0
		,[AgentPT] = @PT
	FROM #SMATemp d
		CROSS APPLY @SportBetType t	
	WHERE roleid = 2

	INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
	SELECT t.CustID,1
	FROM #MemberTemp t WITH(NOLOCK)
		LEFT JOIN Dep_CustSettingMode d WITH(NOLOCK) ON  d.CustID = t.CustID
	WHERE d.CustID IS NULL

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 90.00 

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency IN (20)
 AND s.site IN ('12Bet'
				,'asiabet88'
				,'mansion88'
				,'alog'
				,'SunGame'
				,'Mayfair'
				,'haifa'
				,'Bodog'
				,'W88'
				,'88Macao'
				,'Boma365'
				,'Ae88'
				,'Hengcai88'
				,'368Cash'
				,'KeenOcean'
				,'9Club'
				,'iBET'
				,'ISC888'
				,'DEWA'
				,'IBO'
				,'GamingSoft'
				,'DBP'
				,'HL8'
				,'Starnet'
				,'365online'
				,'NextBet'
				,'KhmerG'
				,'IONclub'
				,'webet88'
				,'Brown888'
				,'Taipanbet'
				,'IGPTech'
				,'Dawoo'
				,'IvoryBet'
				,'Opal88'
				,'Sunrise'
				,'UN168'
				,'K8VN'
				,'ECLBET'
				,'Lucky88'
				,'GPIGAME'
				,'Bobo88'
				,'Sunriseb2b'
				,'396Club'
				,'BBIN2'
				,'YongBao'
				,'GMASTER'
				,'ALPHA88'
				,'Tripleone'
				,'11bet'
				,'ENTAPLAY'
				,'zt828'
				,'9wickets'
				,'FB88'
				,'Monaco'
				,'MARS'
				,'Fabet'
				,'One88'
				,'VWIN66'
				,'A1game'
				,'AEUG'
				,'ig128'
				,'VN88'
				,'Sin88'
				,'Zbet'
				,'Debet'
				,'Sunwin'
				,'GGBOOK'
				,'HeleThai'
				,'Onegaming'
				,'Five88'
				,'WKCUR'
				,'WKPHIL'
				,'Win88'
				,'Xtu168'
				,'Asian88'
				,'BBIN3'
				,'ENT22'
				,'INSERTGAME'
				,'B24VN'
				,'Nova88'
				,'BBIN4'
				,'BOG22'
				,'Wanfang'
				,'24AVIA'
				,'KUTECH'
				,'Datang'
				,'erhaozhan'
				,'WKIBPH'
				,'MTech'
				,'12B'
				,'N88'
				,'QASite'
				,'Red88'
				,'Lode88'
				,'afb99'
				,'XTDGT'
				,'Zowin'
				,'N8G'
				,'N8B'
				,'GGBOOKES'
				,'SV88'
				,'Junbet'
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
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 90.00 

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency IN (20)
 AND s.site IN ('12Bet'
				,'asiabet88'
				,'mansion88'
				,'alog'
				,'SunGame'
				,'Mayfair'
				,'haifa'
				,'Bodog'
				,'W88'
				,'88Macao'
				,'Boma365'
				,'Ae88'
				,'Hengcai88'
				,'368Cash'
				,'KeenOcean'
				,'9Club'
				,'iBET'
				,'ISC888'
				,'DEWA'
				,'IBO'
				,'GamingSoft'
				,'DBP'
				,'HL8'
				,'Starnet'
				,'365online'
				,'NextBet'
				,'KhmerG'
				,'IONclub'
				,'webet88'
				,'Brown888'
				,'Taipanbet'
				,'IGPTech'
				,'Dawoo'
				,'IvoryBet'
				,'Opal88'
				,'Sunrise'
				,'UN168'
				,'K8VN'
				,'ECLBET'
				,'Lucky88'
				,'GPIGAME'
				,'Bobo88'
				,'Sunriseb2b'
				,'396Club'
				,'BBIN2'
				,'YongBao'
				,'GMASTER'
				,'ALPHA88'
				,'Tripleone'
				,'11bet'
				,'ENTAPLAY'
				,'zt828'
				,'9wickets'
				,'FB88'
				,'Monaco'
				,'MARS'
				,'Fabet'
				,'One88'
				,'VWIN66'
				,'A1game'
				,'AEUG'
				,'ig128'
				,'VN88'
				,'Sin88'
				,'Zbet'
				,'Debet'
				,'Sunwin'
				,'GGBOOK'
				,'HeleThai'
				,'Onegaming'
				,'Five88'
				,'WKCUR'
				,'WKPHIL'
				,'Win88'
				,'Xtu168'
				,'Asian88'
				,'BBIN3'
				,'ENT22'
				,'INSERTGAME'
				,'B24VN'
				,'Nova88'
				,'BBIN4'
				,'BOG22'
				,'Wanfang'
				,'24AVIA'
				,'KUTECH'
				,'Datang'
				,'erhaozhan'
				,'WKIBPH'
				,'MTech'
				,'12B'
				,'N88'
				,'QASite'
				,'Red88'
				,'Lode88'
				,'afb99'
				,'XTDGT'
				,'Zowin'
				,'N8G'
				,'N8B'
				,'GGBOOKES'
				,'SV88'
				,'Junbet'
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
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
			,@PT = @PT
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO