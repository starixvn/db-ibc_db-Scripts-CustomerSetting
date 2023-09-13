/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: Remove Unused Setting   [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
----- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST và ALL REPLICATED SERVERS -----
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

BEGIN
	SET NOCOUNT ON
	
	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	DECLARE
		@max_custid			INT
	,	@target			VARCHAR(20) 
	,	@Batch			INT = 5000 
	,	@RoleCheck			SMALLINT
	,	@AffectedList		VARCHAR(MAX) = ''
	,	@sma_cnt			INT
	,	@mem_cnt			INT
	,	@msg_total_sma_pt		NVARCHAR(200) = 'Total of SMA PT Affected: %d.'
	,	@msg_total_mem_pt		NVARCHAR(200) = 'Total of member PT Affected: %d.'
	,	@msg_total_sma_bs		NVARCHAR(200) = 'Total of SMA BetSetting Affected: %d.'
	,	@msg_total_mem_bs		NVARCHAR(200) = 'Total of member BetSetting Affected: %d.'


	--IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
	--	SET @target = 'DBCUST' 
	--ELSE 
	--	SET @target = 'REPLICATED'
	--Print 'Server Name : ' + @target

	--SELECT @max_custid = xxx

	CREATE TABLE #SportBettypeFilter(SportType SMALLINT , BetType SMALLINT)  

	INSERT INTO #SportBettypeFilter(SportType , BetType)  
	SELECT 43 , 1
	UNION
	SELECT 44 , 3

	--=============================
	--REMOVE PT
	--=============================
	CREATE TABLE #CustAffected_PT (
		Custid				INT , 
		SportType				INT ,
		BetType				INT , 
		IsLive				BIT
	)
	
	CREATE TABLE #tmpSuperPTSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT ,
		IsLive				BIT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType, IsLive)
	)

	-- Collect PT Line Super
	INSERT INTO #tmpSuperPTSetting (CustID , SportType , BetType, IsLive)
	SELECT cpa.custid , cpa.SportType  , cpa.BetType , cpa.IsLive
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	INNER JOIN exchange e WITH(NOLOCK)
				ON e.ExchangeId = ci.currency AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	LEFT JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK)
				ON ci.custid = cpa.CustID
	INNER JOIN #SportBettypeFilter sb
				ON sb.SportType = cpa.SportType AND sb.BetType = cpa.BetType
	WHERE ci.roleid = 4  
		AND s.site  NOT IN ('IMBC','spotico','Y987')
		AND s.islicensee = 0
		AND s.isActive = 1
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.currency <> 20 
		--AND ci.custid <= @max_custid


	-- Collect PT Line SMA
	CREATE TABLE #tmpSMAPTSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT ,
		IsLive				BIT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType, IsLive)
	)
	
	INSERT INTO #tmpSMAPTSetting (CustID , SportType , BetType , IsLive)
	SELECT ca.CustID , ca.SportType , ca.BetType  , ca.IsLive
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustPTSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN	#tmpSuperPTSetting		sp			ON sp.CustID = c.srecommend AND ca.SportType  = sp.SportType AND ca.BetType = sp.BetType AND ca.IsLive = sp.IsLive
	WHERE  c.roleid IN (2,3,4)
	AND c.Enabled = 1

	SET @sma_cnt = (SELECT COUNT(1) FROM #tmpSMAPTSetting )
	RAISERROR (@msg_total_sma_pt, 0, 1, @sma_cnt) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected_PT

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive
			INTO #CustAffected_PT (CustID , SportType , BetType , IsLive)
		FROM #tmpSMAPTSetting s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			AS '@C' ,				-- @CustID
								SportType			AS '@S' ,				-- @SportType
								BetType			AS '@B'	,			-- @BetType
								IsLive			AS '@L'				-- @IsLive
								FROM #CustAffected_PT
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		--EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 2 , @target = @target

		SELECT @AffectedList

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_sma_pt = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_sma_pt, 0, 1) WITH NOWAIT
	END

	DROP TABLE #tmpSMAPTSetting
	     
	-- Collect PT Line Member
	CREATE TABLE #tmpMemberPTSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT ,
		IsLive				BIT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType, IsLive)
	)

	INSERT INTO #tmpMemberPTSetting (CustID , SportType , BetType , IsLive)
	SELECT ca.CustID , ca.SportType , ca.BetType  , ca.IsLive
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustPTSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN	#tmpSuperPTSetting		sp			ON sp.CustID = c.srecommend AND ca.SportType  = sp.SportType AND ca.BetType = sp.BetType AND ca.IsLive = sp.IsLive
	WHERE  c.roleid = 1
	AND c.Enabled = 1

	SET @mem_cnt = (SELECT COUNT(1) FROM #tmpMemberPTSetting )
	RAISERROR (@msg_total_mem_pt, 0, 1, @mem_cnt) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected_PT

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive
			INTO #CustAffected_PT (CustID , SportType , BetType , IsLive)
		FROM #tmpMemberPTSetting s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			AS '@C' ,				-- @CustID
								SportType			AS '@S' ,				-- @SportType
								BetType			AS '@B'	,			-- @BetType
								IsLive			AS '@L'				-- @IsLive
								FROM #CustAffected_PT
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		--EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 2 , @target = @target

		SELECT @AffectedList

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_mem_pt = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_mem_pt, 0, 1) WITH NOWAIT
	END

	DROP TABLE #tmpMemberPTSetting
	DROP TABLE #tmpSuperPTSetting
	DROP TABLE #CustAffected_PT

	--=============================
	--REMOVE BETSETTING
	--=============================
	CREATE TABLE #CustAffected_BS (
		Custid				INT , 
		SportType				INT ,
		BetType				INT , 
		IsLive				BIT
	)
	
	CREATE TABLE #tmpSuperBetSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT 
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	---- Collect BetSetting Line Super
	INSERT INTO #tmpSuperBetSetting (CustID , SportType , BetType)
	SELECT cpa.custid , cpa.SportType  , cpa.BetType
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	INNER JOIN exchange e WITH(NOLOCK)
				ON e.ExchangeId = ci.currency AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	LEFT JOIN CustBetSetting3rd_Agent cpa WITH (NOLOCK)
				ON ci.custid = cpa.CustID
	INNER JOIN #SportBettypeFilter sb
				ON sb.SportType = cpa.SportType AND sb.BetType = cpa.BetType
	WHERE ci.roleid = 4  
		AND s.site  NOT IN ('IMBC','spotico','Y987')
		AND s.islicensee = 0
		AND s.isActive = 1
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.currency <> 20 
		--AND ci.custid <= @max_custid

	-- Collect BetSetting Line SMA
	CREATE TABLE #tmpSMABetSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT 
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)
	
	INSERT INTO #tmpSMABetSetting (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType 
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustBetSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN	#tmpSuperBetSetting		sp			ON sp.CustID = c.srecommend AND ca.SportType  = sp.SportType AND ca.BetType = sp.BetType
	WHERE  c.roleid IN (2,3,4)
	AND c.Enabled = 1

	SET @sma_cnt = (SELECT COUNT(1) FROM #tmpSMABetSetting )
	RAISERROR (@msg_total_sma_bs, 0, 1, @sma_cnt) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected_BS

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected_BS (CustID , SportType , BetType)
		FROM #tmpSMABetSetting s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			AS '@C' ,				-- @CustID
								SportType			AS '@S' ,				-- @SportType
								BetType			AS '@B'				-- @BetType
								FROM #CustAffected_BS
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		--EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 2 , @target = @target

		SELECT @AffectedList

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_sma_bs = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_sma_bs, 0, 1) WITH NOWAIT
	END

	DROP TABLE #tmpSMABetSetting
	     
	-- Collect PT Line Member
	CREATE TABLE #tmpMemberBetSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	INSERT INTO #tmpMemberBetSetting (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType 
	FROM custInfo c WITH (NOLOCK)
	LEFT JOIN	CustBetSetting3rd_Member	ca WITH (NOLOCK)	ON c.custid = ca.CustID
	INNER JOIN	#tmpSuperBetSetting		sp			ON sp.CustID = c.srecommend AND ca.SportType  = sp.SportType AND ca.BetType = sp.BetType
	WHERE  c.roleid = 1
	AND c.Enabled = 1

	SET @mem_cnt = (SELECT COUNT(1) FROM #tmpMemberBetSetting )
	RAISERROR (@msg_total_mem_bs, 0, 1, @mem_cnt) WITH NOWAIT

	WHILE (1=1)
	BEGIN
		TRUNCATE TABLE #CustAffected_BS

		DELETE TOP (@Batch) s WITH (ROWLOCK)
		OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
			INTO #CustAffected_BS (CustID , SportType , BetType)
		FROM #tmpMemberBetSetting s
		
		IF @@ROWCOUNT = 0 
			BREAK ;
				
		SET @AffectedList =  (	SELECT 
								CustID			AS '@C' ,				-- @CustID
								SportType			AS '@S' ,				-- @SportType
								BetType			AS '@B'				-- @BetType
								FROM #CustAffected_BS
								FOR XML PATH('r'), ROOT ('root')  
							)
		
		--EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList  , @RoleCheck = 2 , @target = @target

		SELECT @AffectedList

		WAITFOR DELAY  '00:00:0.050'	

		SET @msg_total_mem_bs = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_mem_bs, 0, 1) WITH NOWAIT
	END

	
	DROP TABLE #tmpMemberBetSetting
	DROP TABLE #tmpSuperBetSetting
	DROP TABLE #CustAffected_BS
	

	DROP TABLE #SportBettypeFilter
	



END