/*
	Created: Eden
	Date: 20191029
	Task: Insert setting for Virtual game follow by Macau games 
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_ProductSetting') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN
	
	DECLARE @ProductID INT = 38, @currency INT--, @MaxPT TINYINT, @MinPT TINYINT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend
	--SELECT TOP 1 @MaxPT= MaxPT from ProductSettingDetail WITH(NOLOCK) where ProductID = @ProductID and SettingType = 1

	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED
	)
	
	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @max_custid

	
	INSERT INTO #SMATemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @max_custid

	
	DECLARE @SportBettype TABLE
	(
		fSportType SMALLINT, 
		fBetType   SMALLINT, 
		tSportType SMALLINT, 
		tBetType   SMALLINT
	)
	INSERT INTO @SportBettype(fSportType, fBetType, tSportType, tBetType) VALUES (212, 4001, 245, 4601)

	--------------------------------------------Product Status------------------------------------------------
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, PSP.bitmapOrder)) as isHidden,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #SMAStatus
	FROM Dep_CustProductStatus c WITH (NOLOCK)
		INNER JOIN #SMATemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType
	
	SELECT
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsHidden, PSP.bitmapOrder)) as isHidden,
		(SELECT value FROM dbo.f_CustSetting_ProductStatusSel(c.bitmapIsDisabled, PSP.bitmapOrder)) as isDisabled,
		c.CustID
	INTO #MemberStatus
	FROM Dep_CustProductStatus c WITH (NOLOCK)
		INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
		INNER JOIN dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.fBetType AND PSP.Sporttype = t.fSportType

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,isHidden)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #SMAStatus temp ON temp.CustID = c.custid

	UPDATE c 
	SET  c.bitmapIsHidden = dbo.f_GenerateProductStatus (c.bitmapIsHidden,psp.bitmapOrder,isHidden)
		,c.bitmapIsDisabled = dbo.f_GenerateProductStatus (c.bitmapIsDisabled,psp.bitmapOrder,isDisabled)
	FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
		CROSS APPLY @SportBettype t
		INNER JOIN  dbo.Dep_ProductStatusProfile psp WITH (NOLOCK) ON PSP.Bettype = t.tBetType AND PSP.Sporttype = t.tSportType
		INNER JOIN  #MemberStatus temp ON temp.CustID = c.custid

	-----------------------------------------Dep_LicenseeProductSetting-------------------------------------------------------

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID
		  ,dpt.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		 INNER JOIN  #SMATemp temp ON temp.CustID = dl.custid
		 INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		 INNER JOIN Dep_ProductSetting dpt WITH(NOLOCK) ON dp.SettingType = dpt.SettingType AND dpt.ProductID = 38
	WHERE dp.ProductID = 22
		AND dp.SettingType IN (4,1,8) -- Product Status, PT, Bet Limit

	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT dl.CustID
		  ,dpt.ProductSettingID
	FROM Dep_LicenseeProductSetting dl WITH(NOLOCK)
		 INNER JOIN  #MemberTemp temp ON temp.CustID = dl.custid
		 INNER JOIN Dep_ProductSetting dp WITH(NOLOCK) ON dl.ProductSettingID = dp.ProductSettingID
		 INNER JOIN Dep_ProductSetting dpt WITH(NOLOCK) ON dp.SettingType = dpt.SettingType AND dpt.ProductID = 38
	WHERE dp.ProductID = 22
		AND dp.SettingType IN (4,1,8) -- Product Status, PT, Bet Limit

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
			 c.[CustID]
			,t.[tSportType]
			,t.[tBetType]
			,c.[IsLive]
			,c.[SuperPT]
			,c.[MasterPT]
			,c.[AgentPT]
	FROM Dep_CustPTSetting_Agent c WITH(NOLOCK)
		INNER JOIN #SMATemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

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
	SELECT   c.[custid]
			,t.[tsporttype]
			,t.[tbettype]
			,c.[islive]
			,c.[superPT]
			,c.[masterPT]
			,c.[agentPT]
	FROM Dep_CustPTSetting_Member c WITH(NOLOCK)
		 INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType
	
	INSERT INTO Dep_CustPTGroupSetting_Member (
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	)
	SELECT AgentID
		,t.tSportType
		,t.tBetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
	FROM Dep_CustPTGroupSetting_Member c WITH(NOLOCK) 
		JOIN #SMATemp tmp ON c.AgentID = tmp.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	INSERT INTO Dep_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM Dep_CustStakeLevel_Agent ca WITH (NOLOCK)
		INNER JOIN #SMATemp tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM Dep_StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = @currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	INSERT INTO Dep_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)
	SELECT ca.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = CONVERT(VARCHAR(200),st.StakeLevelID)
	FROM Dep_CustStakeLevel_Member ca WITH (NOLOCK)
		INNER JOIN #MemberTemp tmp ON tmp.CustID = ca.CustID
		CROSS APPLY @SportBettype t
		CROSS APPLY ( SELECT s.StakeLevelID FROM Dep_StakeLevel s WITH(NOLOCK) WHERE s.ExchangeId = @currency AND s.GameTypeID = t.tBetType) st
	WHERE ca.SportType  = t.fSportType and ca.BetType = t.fBetType

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #SMAStatus
	DROP TABLE #MemberStatus
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT

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
 --AND c.currency = 20

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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
						
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
 --AND c.currency = 20

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

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
						
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO