/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20231213@Helios
	Task: Remove Redundant Setting of MuyaThai & Esport (PT , BetSetting) [#193083]
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
	,	@AffectedList		VARCHAR(MAX) = ''
	,	@Msg				VARCHAR(200)
	,	@Srecommend			INT


	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
		SET @target = 'DBCUST' 
	ELSE 
		SET @target = 'REPLICATED'
	Print 'Server Name : ' + @target

	SELECT @max_custid = xxx

	CREATE TABLE #CustAffected (
		Custid				INT , 
		SportType				INT ,
		BetType				INT
	)

	CREATE TABLE #tmpSuper (
		CustID				INT
		PRIMARY KEY CLUSTERED (CustID)
	)

	CREATE TABLE #tmpSetting (
		CustID				INT ,
		SportType				INT ,
		BetType				INT 
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	
	--------------------------------------------------------COLLECT LINE SUPER-------------------------------------------------------
	INSERT INTO #tmpSuper (CustID)
	SELECT ci.custid
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	INNER JOIN exchange e WITH(NOLOCK)
				ON e.ExchangeId = ci.currency AND e.IsActive = 1 AND e.OfferSite IN (0,1)
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND s.islicensee = 0
		AND s.isActive = 1
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND ci.custid <= @max_custid 
	

	------------------------------------------------------------START RUN----------------------------------------------------------
	WHILE (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 s.CustID FROM #tmpSuper s)

		IF @Srecommend IS NULL
			BREAK;
		
		DELETE FROM #tmpSuper WHERE CustID = @Srecommend

	--=============================
	--REMOVE PT
	--=============================
		-- Collect PT SMA
		INSERT INTO #tmpSetting (CustID , SportType , BetType)
		SELECT ca.CustID , ca.SportType , ca.BetType  
		FROM custInfo c WITH (NOLOCK)
		INNER JOIN	CustPTSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
		WHERE c.Enabled = 1
		AND c.roleid IN (2,3,4)
		AND c.srecommend = @Srecommend
		AND ca.SportType IN (43,44)
	
		-- Remove PT SMA
		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) s WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType 
				INTO #CustAffected (CustID , SportType , BetType)
			FROM #tmpSetting s
		
			IF @@ROWCOUNT = 0 
				BREAK ;
				
			SET @AffectedList =  (	SELECT ca.Custid , ca.SportType , ca.BetType
							FROM #CustAffected ca
							FOR JSON PATH
								)
		
			EXEC dbo.Acc_DynamicCustSetting3rd_16 @ModeCode = 'SMAPT'  , @JsonData = @AffectedList , @target = @target

			WAITFOR DELAY  '00:00:0.050'	

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run delete for PT SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Clear temp table
		TRUNCATE TABLE #tmpSetting

		-- Collect Group PT Line Member
		INSERT INTO #tmpSetting (CustID , SportType , BetType)
		SELECT ca.AgentID , ca.SportType , ca.BetType  
		FROM custInfo c WITH (NOLOCK)
		INNER JOIN	CustPTGroupSetting3rd_Member	ca WITH (NOLOCK)	ON c.custid = ca.AgentID
		WHERE  c.Enabled = 1
		AND c.roleid = 2
		AND c.srecommend = @Srecommend
		AND ca.SportType IN (43,44)

		-- Remove Group PT
		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) s WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType 
				INTO #CustAffected (CustID , SportType , BetType)
			FROM #tmpSetting s
		
			IF @@ROWCOUNT = 0 
				BREAK ;
				
			SET @AffectedList =  (	SELECT ca.Custid , ca.SportType , ca.BetType
							FROM #CustAffected ca
							FOR JSON PATH
								)
		
			EXEC dbo.Acc_DynamicCustSetting3rd_16 @ModeCode = 'GPT'  , @JsonData = @AffectedList , @target = @target

			WAITFOR DELAY  '00:00:0.050'	

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run delete for Group PT curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Clear temp table
		TRUNCATE TABLE #tmpSetting

		-- Collect PT Line Member
		INSERT INTO #tmpSetting (CustID , SportType , BetType)
		SELECT ca.CustID , ca.SportType , ca.BetType 
		FROM custInfo c WITH (NOLOCK)
		INNER JOIN	CustPTSetting3rd_Member ca WITH (NOLOCK)	ON c.custid = ca.CustID
		WHERE  c.roleid = 1
		AND c.Enabled = 1
		AND c.srecommend = @Srecommend
		AND ca.SportType IN (43,44)


		-- Remove PT Member
		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) s WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType 
				INTO #CustAffected (CustID , SportType , BetType)
			FROM #tmpSetting s
		
			IF @@ROWCOUNT = 0 
				BREAK ;
				
			SET @AffectedList =  (	SELECT ca.Custid , ca.SportType , ca.BetType
							FROM #CustAffected ca
							FOR JSON PATH
								)
		
			EXEC dbo.Acc_DynamicCustSetting3rd_16 @ModeCode = 'MemPT'  , @JsonData = @AffectedList , @target = @target

			WAITFOR DELAY  '00:00:0.050'	

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run delete for PT Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

	--=============================
	--REMOVE BetSetting
	--=============================
		
		-- Clear temp table
		TRUNCATE TABLE #tmpSetting

		-- Collect BetSetting Line SMA
		INSERT INTO #tmpSetting (CustID , SportType , BetType)
		SELECT ca.CustID , ca.SportType , ca.BetType 
		FROM custInfo c WITH (NOLOCK)
		INNER JOIN	CustBetSetting3rd_Agent		ca WITH (NOLOCK)	ON c.custid = ca.CustID
		WHERE c.Enabled = 1
		AND c.roleid IN (2,3,4)
		AND c.srecommend = @Srecommend
		AND ca.SportType IN (43,44)

		-- Remove BetSetting SMA
		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) s WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #CustAffected (CustID , SportType , BetType)
			FROM #tmpSetting s
		
			IF @@ROWCOUNT = 0 
				BREAK ;
				
			SET @AffectedList =  (	SELECT ca.Custid , ca.SportType , ca.BetType
							FROM #CustAffected ca
							FOR JSON PATH
						   )
		
			EXEC dbo.Acc_DynamicCustSetting3rd_16 @ModeCode = 'SMABS'  , @JsonData = @AffectedList , @target = @target

			WAITFOR DELAY  '00:00:0.050'	

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run delete for BetSetting SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

		-- Clear temp table
		TRUNCATE TABLE #tmpSetting

		-- Collect BetSetting Line Member
		INSERT INTO #tmpSetting (CustID , SportType , BetType)
		SELECT ca.CustID , ca.SportType , ca.BetType 
		FROM custInfo c WITH (NOLOCK)
		INNER JOIN	CustBetSetting3rd_Member		ca WITH (NOLOCK)	ON c.custid = ca.CustID
		WHERE c.Enabled = 1
		AND c.roleid = 1
		AND c.srecommend = @Srecommend
		AND ca.SportType IN (43,44)

		-- Remove BetSetting Member
		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) s WITH (ROWLOCK)
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #CustAffected (CustID , SportType , BetType)
			FROM #tmpSetting s
		
			IF @@ROWCOUNT = 0 
				BREAK ;
				
			SET @AffectedList =  (	SELECT ca.Custid , ca.SportType , ca.BetType
							FROM #CustAffected ca
							FOR JSON PATH
						   )
		
			EXEC dbo.Acc_DynamicCustSetting3rd_16 @ModeCode = 'MemBS'  , @JsonData = @AffectedList , @target = @target

			WAITFOR DELAY  '00:00:0.050'	

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run delete for BetSetting Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END
	END
	


	DROP TABLE #CustAffected
	DROP TABLE #tmpSetting
	DROP TABLE #tmpSuper

END