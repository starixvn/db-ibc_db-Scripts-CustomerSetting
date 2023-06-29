
/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/05/31
  Task: RNG Slot - Fix missing bet limit setting for all accounts [redmine : #188949] 
  DB: DBCUST/CustDB
  Revisions: Initial Script
*/
 ----- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST và ALL REPLICATED SERVERS -----
BEGIN   
	SET NOCOUNT ON  

	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE @SettingStatus		TINYINT = 0
		,	@ProductID			INT = 18
		,	@max_custid			INT
		,	@target				VARCHAR(20) 

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
		SET @target = 'DBCUST' 
	ELSE 
		SET @target = 'REPLICATED'
	Print 'Server Name : ' + @target

	SELECT @max_custid = xxx
		
	-- Collect SportType - BetType Of RNG SLot
	CREATE TABLE #SportBettypeFilter(SportType SMALLINT , BetType SMALLINT)  

	 INSERT INTO #SportBettypeFilter(SportType , BetType)  
	 SELECT  
		   ft.SportType,  
		   ft.BetType           
	 FROM dbo.f_CustSetting_SportBetTypeSettingSelect(@ProductID,8,@SettingStatus) ft   


	 -- Check BetLimitSetting Line Super
	 CREATE TABLE #tmpSuperBetLimitSetting (
		CustID				INT ,
		SportType			INT ,
		BetType				INT ,
		StakeLevelList		VARCHAR(200) ,
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	-- Collect StakeLevel Super
	INSERT INTO #tmpSuperBetLimitSetting (CustID , SportType , BetType , StakeLevelList)
	SELECT ca.custid , ca.SportType  , ca.BetType , ca.StakeLevelList
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	INNER JOIN exchange e WITH(NOLOCK)
				ON e.ExchangeId = ci.currency AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	LEFT JOIN CustStakeLevel_Agent ca WITH (NOLOCK)
				ON ci.custid = ca.CustID
	INNER JOIN #SportBettypeFilter sb
				ON sb.SportType = ca.SportType AND sb.BetType = ca.BetType
	WHERE ci.roleid = 4  
		AND s.site  NOT IN ('IMBC','spotico','Y987')
		AND s.islicensee = 0
		AND s.isActive = 1
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.currency <> 20 
		AND ci.custid <= @max_custid


	-- For Deployed Info
	DECLARE @Batch				INT = 5000 
	,		@RoleCheck			SMALLINT
	,		@AffectedList		VARCHAR(MAX) = ''
	,		@sma_cnt			INT
	,		@mem_cnt			INT
	,		@msg_total_sma		NVARCHAR(200) = 'Total of SMA Affected: %d.'
	,		@msg_total_mem		NVARCHAR(200) = 'Total of member Affected: %d.'

	CREATE TABLE #CustAffected (
		Custid				INT , 
		SportType			INT ,
		BetType				INT , 
		StakeLevelList		VARCHAR (200)  
	)
	
	-- Collect StakeLevel SMA
	CREATE TABLE #tmpStakeSMA (
		CustID					INT ,
		SportType				INT ,
		BetType					INT ,
		StakeLevelList			VARCHAR (200)  ,
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)
	
	INSERT INTO #tmpStakeSMA (CustID , SportType , BetType , StakeLevelList)
	SELECT ca.CustID , ca.SportType , ca.BetType  , cl.StakeLevelList
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustStakeLevel_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN	#tmpSuperBetLimitSetting	cl					ON cl.CustID = c.srecommend AND ca.SportType  = cl.SportType AND ca.BetType = cl.BetType
	WHERE  c.roleid IN (2,3,4)
	AND (ca.StakeLevelList IS NULL OR ca.StakeLevelList = '')
	AND c.Enabled = 1

	SET @sma_cnt = (SELECT COUNT(1) FROM #tmpStakeSMA )
	RAISERROR (@msg_total_sma, 0, 1, @sma_cnt) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.StakeLevelList
			INTO #CustAffected (CustID , SportType , BetType , StakeLevelList)
		FROM #tmpStakeSMA s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			as '@C' ,			-- @CustID
								SportType		as '@S' ,			-- @SportType
								BetType			as '@B'	,			-- @BetType
								StakeLevelList	as '@L'				-- @StakeLevelList
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 2 , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_sma = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_sma, 0, 1) WITH NOWAIT
	END

	-- Collect StakeLevel Member
	CREATE TABLE #tmpStakeMember (
		CustID				INT ,
		SportType			INT ,
		BetType				INT ,
		StakeLevelList		VARCHAR(200) ,
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	INSERT INTO #tmpStakeMember (CustID , SportType , BetType , StakeLevelList)
	SELECT cm.CustID , cm.SportType , cm.BetType , cl.StakeLevelList
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustStakeLevel_Member		cm WITH (NOLOCK)	ON c.custid = cm.CustID
	INNER JOIN	#tmpSuperBetLimitSetting				cl					ON cl.CustID = c.srecommend AND cm.SportType  = cl.SportType AND cm.BetType = cl.BetType
	WHERE  c.roleid = 1
	AND (cm.StakeLevelList IS NULL OR cm.StakeLevelList = '')
	AND c.Enabled = 1

	SET @mem_cnt = (SELECT COUNT(1) FROM #tmpStakeMember )
	RAISERROR (@msg_total_mem, 0, 1, @mem_cnt) WITH NOWAIT
	
	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.StakeLevelList
			INTO #CustAffected (CustID , SportType , BetType , StakeLevelList)
		FROM #tmpStakeMember s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			as '@C' ,			-- @CustID
								SportType		as '@S' ,			-- @SportType
								BetType			as '@B'	,			-- @BetType
								StakeLevelList	as '@L'				-- @StakeLevelList
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 1 , @target = @target

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_mem = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_mem, 0, 1) WITH NOWAIT
	END

	DROP TABLE #SportBettypeFilter
	DROP TABLE #tmpSuperBetLimitSetting
	DROP TABLE #tmpStakeSMA
	DROP TABLE #tmpStakeMember
	DROP TABLE #CustAffected
END