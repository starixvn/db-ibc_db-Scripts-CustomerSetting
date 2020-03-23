/*
	Created: Eden
	Date: 20191029
	Task: Insert setting for Virtual game - UUS -  Athena Site
	DB: DBCust/CustDB
*/

ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
	 @srecommend INT		
	,@target VARCHAR(20)
	,@max_custid INT
	,@SiteId INT
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB230\SQLSERVER2008R2')) RETURN -- run at dbcust only

	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('Dep_CustStakeLevel_Member') = 0 RETURN

	DECLARE @currency INT

	SELECT @currency = ci.currency FROM dbo.custInfo ci WITH (NOLOCK) WHERE ci.custid = @srecommend

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
	INSERT INTO @SportBetType(SportType, BetType) VALUES (245, 4601)

	DECLARE @DEP_Stake TABLE (
		[GameTypeID] [int] NOT NULL,
		[Currency] [nvarchar](max) NULL,
		[MinStake] [money] NULL,
		[MaxStake] [money] NULL,
		[MinLabel] [varchar](20) NULL,
		[MaxLabel] [varchar](20) NULL
	) 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 500.00, '5', '500') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 1000.00, '5', '1,000') -- 
	INSERT INTO @DEP_Stake ([GameTypeID], [Currency], [MinStake], [MaxStake],[MinLabel],[MaxLabel]) VALUES (4601, N'UUS', 5.00, 2000.00, '5', '2,000') -- 

	DECLARE @MaxStakeLevelID INT
	SELECT @MaxStakeLevelID = MAX(StakeLevelID) FROM DEP_StakeLevel WITH(NOLOCK)

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
		INNER JOIN exchange e WITH(NOLOCK) ON t.Currency = e.Currency
	WHERE e.exchangeid = @currency

	-------------------------------------------------STAKE LEVEL----------------------------------------------------------------
	DECLARE @StakeLevAgent VARCHAR(200)
	DECLARE @StakeLevMember VARCHAR(200)
	SELECT @StakeLevAgent = SUBSTRING(( SELECT ',' + CONVERT(VARCHAR(5),s.StakeLevelID) 
										FROM DEP_StakeLevel s WITH(NOLOCK) 
											CROSS APPLY @SportBetType t	
										WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId
										FOR XML PATH(''))
							,2,200)

	SELECT @StakeLevMember = (	SELECT TOP 1 CONVERT(VARCHAR(5),s.StakeLevelID) 
								FROM DEP_StakeLevel s WITH(NOLOCK) 
									CROSS APPLY @SportBetType t	
								WHERE s.ExchangeId = @currency AND s.GameTypeID = t.BetType AND s.SiteID = @SiteId
								ORDER BY s.MaxStake)

	--> Bet Limit: Apply bet limit group level for all S/M/A/Member levels
	INSERT INTO DEP_CustStakeLevel_Agent(CustID, SportType, BetType, StakeLevelList)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevAgent
	FROM #SMATemp tmp
		CROSS APPLY @SportBetType t

	INSERT INTO DEP_CustStakeLevel_Member(CustID, SportType, BetType, StakeLevelList,LastUpdated)
	SELECT tmp.CustID
		,SportType = t.SportType
		,BetType = t.BetType
		,StakeLevelList = @StakeLevMember
		,GETDATE()
	FROM #MemberTemp tmp
		CROSS APPLY @SportBetType t

	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
END
GO

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS  -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int, SiteId INT, isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 90.00 --10% of Athena Licensee fee (Licensees take 90%, House takes 10%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid, SiteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20
 AND s.site IN (
				 'Athena000', 'N88','N8B','N8G'
				--,'spondemo'
				--,'Macaubet'
				--,'Aoncash'
				--,'ITCBet'
				--,'9bet'
				--,'M8bola'
				--,'Q8bola'
				--,'BE7'
				--,'NBCbet'
				--,'Unobet'
				--,'Bolanation'
				--,'Luckywin88'
				--,'Winn69'
				--,'Axiawin'
				--,'Jumbo88'
				--,'Lagadewa'
				--,'Ratugg'
				--,'Monstergol'
				)


-- For deployer info
DECLARE @super_cnt INT, @index INT = 0, @siteId INT
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
		,@siteId = SiteId
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'REPLICATED'
			,@max_custid = @max_custid
			,@siteId = @siteId
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO
-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

CREATE TABLE #supers (custid int, siteId INT, isfinished bit default(0))

DECLARE @srecommend INT , @max_custid INT
DECLARE @PT smallmoney = 90.00 --10% of Athena Licensee fee (Licensees take 90%, House takes 10%)

SELECT @max_custid = xxx

INSERT INTO #supers(custid, siteId)
SELECT c.custid, s.siteid
FROM customer c WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
	INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
WHERE c.roleid = 4  
 AND s.islicensee = 1
 AND ci.Enabled = 1
 AND c.custid <= @max_custid
 AND c.currency = 20
 AND s.site IN (
				'Athena000', 'N88','N8B','N8G'
				--,'spondemo'
				--,'Macaubet'
				--,'Aoncash'
				--,'ITCBet'
				--,'9bet'
				--,'M8bola'
				--,'Q8bola'
				--,'BE7'
				--,'NBCbet'
				--,'Unobet'
				--,'Bolanation'
				--,'Luckywin88'
				--,'Winn69'
				--,'Axiawin'
				--,'Jumbo88'
				--,'Lagadewa'
				--,'Ratugg'
				--,'Monstergol'
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
		,@siteId = siteId
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_Dep_DynamicCustSetting_09 @srecommend = @srecommend
			,@target = 'DBCUST'
			,@max_custid = @max_custid
			,@siteId = @siteId
	waitfor delay '00:00:0.100'
END

PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

DROP TABLE #supers
GO