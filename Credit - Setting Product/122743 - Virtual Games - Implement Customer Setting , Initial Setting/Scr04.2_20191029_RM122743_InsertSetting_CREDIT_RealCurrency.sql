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
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	
	
	DECLARE @currency INT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

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

	------------------------------------PT Setting-------------------------------------------------	
	--SMA LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Agent
		(	[CustID]
			,[SportType]
			,[BetType]
			,[IsLive]
			,[SuperPT]
			,[MasterPT]
			,[AgentPT]
			,[IsAutoMasterPT]
			,[AutoMasterPT]
			,[IsAutoSuperPT]
			,[AutoSuperPT]
			,[MinPT]
			,[MaxPT])
	SELECT 
			 c.[CustID]
			,t.[tSportType]
			,t.[tBetType]
			,c.[IsLive]
			,c.[SuperPT]
			,c.[MasterPT]
			,c.[AgentPT]
			,c.[IsAutoMasterPT]
			,c.[AutoMasterPT]
			,c.[IsAutoSuperPT]
			,c.[AutoSuperPT]
			,c.[MinPT]
			,c.[MaxPT]
	FROM CustPTSetting3rd_Agent c WITH(NOLOCK)
		INNER JOIN #SMATemp d ON c.CustID = d.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

	----MEMBER LEVEL
	INSERT INTO dbo.CustPTSetting3rd_Member
		(	    [custid]
			,	[sporttype]
			,	[bettype]
			,	[islive]
			,	[superPT]
			,	[masterPT]
			,	[agentPT]
			,	[IsAutoMasterPT]
			,	[AutoMasterPT]
			,	[IsAutoSuperPT]
			,	[AutoSuperPT])
	SELECT   c.[custid]
			,t.[tsporttype]
			,t.[tbettype]
			,c.[islive]
			,c.[superPT]
			,c.[masterPT]
			,c.[agentPT]
			,c.[IsAutoMasterPT]
			,c.[AutoMasterPT]
			,c.[IsAutoSuperPT]
			,c.[AutoSuperPT]
	FROM CustPTSetting3rd_Member c WITH(NOLOCK)
		 INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType
	
	INSERT INTO CustPTGroupSetting3rd_Member(
		 AgentID
		,SportType
		,BetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
		,IsAutoMasterPT
		,AutoMasterPT
		,IsAutoSuperPT
		,AutoSuperPT
	)
	SELECT AgentID
		,t.tSportType
		,t.tBetType
		,IsLive
		,SuperPT
		,MasterPT
		,AgentPT
		,IsAutoMasterPT
		,AutoMasterPT
		,IsAutoSuperPT
		,AutoSuperPT 
	FROM CustPTGroupSetting3rd_Member c WITH(NOLOCK) 
		JOIN #SMATemp tmp ON c.AgentID = tmp.CustID
		CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	

	----------------------------------------WinLoss Limit Setting-------------------------------------------------		
	--Agent Level
	
	INSERT INTO dbo.CustWinLossLimit_Agent
       (
		CustID, 
		SportType, 
		BetType, 
		MaxWinLimit, 
		MaxLossLimit, 
		IsAutoReset
       )
       SELECT c.CustID, 
              t.tSportType, 
              t.tBetType, 
              c.MaxWinLimit, 
              c.MaxLossLimit, 
              c.IsAutoReset
		FROM CustWinLossLimit_Agent c WITH(NOLOCK)
			INNER JOIN #SMATemp d ON c.CustID = d.CustID
			CROSS APPLY @SportBettype t
		WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType	
		 
	--Member Level
	INSERT INTO dbo.CustWinLossLimit_Member
	(
		CustID, 
		SportType, 
		BetType, 
		MaxWinLimit, 
		MaxLossLimit, 
		IsAutoReset
	)
	SELECT  c.CustID, 
			t.tSportType, 
			t.tBetType, 
			c.MaxWinLimit, 
			c.MaxLossLimit, 
			c.IsAutoReset
	FROM CustWinLossLimit_Member c WITH(NOLOCK)
		 INNER JOIN #MemberTemp d ON c.CustID = d.CustID
		 CROSS APPLY @SportBettype t
	WHERE c.SportType  = t.fSportType and c.BetType = t.fBetType

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	DECLARE @StakeLevAgent VARCHAR(200)
	DECLARE @StakeLevMember VARCHAR(200)
	SELECT @StakeLevAgent = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM StakeLevel s WITH(NOLOCK) 
											CROSS APPLY @SportBetType t	
										WHERE s.ExchangeId = @currency AND s.GameTypeID = t.tBetType 
										FOR XML PATH(''))
							,2,200)

	SELECT @StakeLevMember = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
								FROM StakeLevel s WITH(NOLOCK) 
									CROSS APPLY @SportBetType t	
								WHERE s.ExchangeId = @currency AND s.GameTypeID = t.tBetType 
								ORDER BY s.MinStake)
										

	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = @StakeLevAgent
	FROM #SMATemp tmp
		CROSS APPLY @SportBettype t

	INSERT INTO CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.tSportType
		,BetType = t.tBetType
		,StakeLevelList = @StakeLevMember
	FROM #MemberTemp tmp
		CROSS APPLY @SportBettype t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @srecommend INT,@max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 0
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency <> 20

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

DECLARE @srecommend INT,@max_custid INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT c.custid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 0
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency <> 20

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