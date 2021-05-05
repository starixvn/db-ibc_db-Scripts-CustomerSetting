/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210426@Eden
	Task: Copy PT & Bet Setting & WinLossLimit for VGaming [#RM:153938]
	DB: DBCUST/CustDB And all subscriber of CustDB_Custsetting Publication
*/
USE CUSTDB
GO
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustPTGroupSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN		

	DECLARE @fSportType SMALLINT, @fBetType SMALLINT

	DECLARE @ProductID TINYINT = 66
	CREATE TABLE #DestinationSportBetType(fSportType SMALLINT, fBetType SMALLINT,tSportType SMALLINT, tBetType SMALLINT, IsLive BIT,  SettingType INT, IsFinished BIT)
	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	200, 1611, SportType, BetType, 0, SettingType, 0
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType IN (1,6)

	INSERT INTO #DestinationSportBetType (fSportType, fBetType, tSportType, tBetType, IsLive, SettingType, IsFinished)
	SELECT	NULL, NULL, SportType, BetType, 0, SettingType, 0 
	FROM dbo.ProductSettingDetail WITH (NOLOCK)
	WHERE ProductID = @ProductID AND SettingType = 8

	CREATE TABLE #MemberTemp
	(
		CustID INT,
		InsPTSetting BIT DEFAULT 0,
		InsBetSetting BIT DEFAULT 0,
		InsWinLoss BIT DEFAULT 0
	)

	CREATE TABLE #MemberTempIns
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
	
	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid = 1  AND Enabled = 1 AND custid <= @maxcustid
	
	
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend AND roleid IN (2,3,4) AND Enabled = 1 AND custid <= @maxcustid 

	DECLARE @MaxPT TINYINT, @Currency INT
	--SELECT TOP 1 @MaxPT = MaxPT FROM dbo.ProductSettingDetail WITH (NOLOCK) WHERE ProductID = @ProductID AND SettingType = 1
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend
	
	--------------------------------------PT Setting-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 1

	--AGENT LEVEL
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
		cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
		,cs.SuperPT
		,cs.MasterPT
		,cs.AgentPT
		,cs.IsAutoMasterPT
		,cs.AutoMasterPT
		,cs.IsAutoSuperPT
		,cs.AutoSuperPT
		,cs.MinPT
		,cs.MaxPT
	FROM dbo.CustPTSetting3rd_Agent cs WITH(NOLOCK) 
		INNER JOIN #SMATemp ci WITH(NOLOCK) ON ci.custid = cs.custid
		CROSS APPLY #DestinationSportBetType dest
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 1
	
	--MEMBER LEVEL
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns

		UPDATE TOP (3000) t SET t.InsPTSetting = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsPTSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO dbo.CustPTSetting3rd_Member
			(	[custid]
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
		SELECT 
			cs.custid, dest.tSportType, dest.tBetType, dest.IsLive
			,cs.SuperPT
			,cs.MasterPT
			,cs.AgentPT
			,cs.IsAutoMasterPT
			,cs.AutoMasterPT
			,cs.IsAutoSuperPT
			,cs.AutoSuperPT
		FROM dbo.CustPTSetting3rd_Member cs WITH(NOLOCK)
			INNER JOIN #MemberTempIns ci WITH(NOLOCK) ON cs.CustID = ci.custid
			CROSS APPLY #DestinationSportBetType dest
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
			AND dest.SettingType = 1
	END
	

	--------------------------------------Bet Setting-------------------------------------------------		
	--Agent Level
	INSERT INTO dbo.CustStakeLevel_Agent (CustID, SportType, BetType, StakeLevelList)	      
	SELECT CustID, dest.tSportType, dest.tBetType, CAST(s.StakeLevelID AS VARCHAR(20))		
	FROM dbo.StakeLevel s WITH(NOLOCK)
		INNER JOIN #DestinationSportBetType dest ON s.GameTypeID = dest.tBetType
		CROSS APPLY #SMATemp ci WITH(NOLOCK) 
	WHERE dest.SettingType = 8 AND s.ExchangeId = @Currency

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns

		UPDATE TOP (3000)  t SET t.InsBetSetting = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsBetSetting = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO dbo.CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList, LastUpdated)	      
		SELECT CustID, dest.tSportType, dest.tBetType, CAST(s.StakeLevelID AS VARCHAR(20)), GETDATE()
		FROM dbo.StakeLevel s WITH(NOLOCK)
			INNER JOIN #DestinationSportBetType dest ON s.GameTypeID = dest.tBetType
			CROSS APPLY #MemberTempIns ci WITH(NOLOCK) 
		WHERE dest.SettingType = 8 AND s.ExchangeId = @Currency
	END
	
	--------------------------------------Win Loss Limit-------------------------------------------------	
	SELECT TOP (1) @fBetType = fBetType, @fSportType = fSportType 
	FROM #DestinationSportBetType		
	WHERE SettingType = 6
		
	--Agent Level
	INSERT INTO dbo.CustWinLossLimit_Agent (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
	SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.MaxWinLimit, cs.MaxLossLimit, cs.IsAutoReset
	FROM #SMATemp ci WITH(NOLOCK) 
		INNER JOIN dbo.CustWinLossLimit_Agent cs WITH (NOLOCK) ON ci.CustID = cs.CustId
		CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
	WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
		AND dest.SettingType = 6

	--Member Level
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #MemberTempIns

		UPDATE TOP (3000)  t SET t.InsWinLoss = 1 OUTPUT DELETED.CustID INTO #MemberTempIns(CustID) FROM #MemberTemp t WHERE t.InsWinLoss = 0

		IF @@ROWCOUNT=0
			BREAK

		INSERT INTO dbo.CustWinLossLimit_Member (CustId, SportType, BetType, MaxWinLimit, MaxLossLimit, IsAutoReset)
		SELECT ci.custid, dest.tsporttype, dest.tbettype, cs.MaxWinLimit, cs.MaxLossLimit, cs.IsAutoReset
		FROM #MemberTempIns ci WITH(NOLOCK) 
			INNER JOIN dbo.CustWinLossLimit_Member cs WITH (NOLOCK) ON ci.CustID = cs.CustId
			CROSS APPLY #DestinationSportBetType dest WITH(NOLOCK) 
		WHERE cs.bettype = @fBetType AND cs.sporttype = @fSportType
			AND dest.SettingType = 6
	END
	

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #DestinationSportBetType	
	DROP TABLE #MemberTempIns		
END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS AND DBCUST(run finally)
--------------------------------------------------------------------------------------
DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
	AND ci.username NOT LIKE '3rdSuper%'
	AND cs.isinternal = 0
	AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
	AND s.islicensee = 0
	AND ci.custid <= @max_custid
	AND ci.site IN ('BEST-ODDS', 'INDO', 'XYZBET', '611111', '722222', '733333', '222223', '755555', 'KORIBC', '7aa666', 'IBCIndo')
	AND ci.currency IN (
							13, --CNY(RMB)
							6,  --EUR(EURO)
							12, --GBP(GBP)
							5,  --HKD(HK$)
							67, --HKD(HKK)
							47, --IDR(DDD)
							33, --IDR(IDD)
							34, --IDR(IDR)
							15, --IDR(IN)
							22, --IDR(IND)
							45, --KRW(Won)
							69, --MMK(MMK)
							2,  --MYR(RM)
							43 --THB(THB)
						
	)
	AND 1 = (CASE WHEN s.[site] = 'BEST-ODDS' AND ci.currency IN (43,47,33,34,15,22) THEN 0 ELSE 1 END) --exclude Site BEST-ODDS with currencies: THB(THB), IDR(DDD), IDR(IDR), IDR(IDR), IDR(IN), IDR(IND)


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
			,@maxcustid = @max_custid
			,@target = @target
			
	waitfor delay '00:00:0.200'
END
DROP TABLE #supers
GO
