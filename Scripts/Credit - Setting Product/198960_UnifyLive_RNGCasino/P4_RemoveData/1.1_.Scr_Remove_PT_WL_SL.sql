/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240129@Helios
	Task: Remove Redundant Data Position Taking , Win Loss Limit , Stake Level [#198960] 
	DB: DBCust/CustDB
*/

SET ANSI_NULLS  ON
GO

SET QUOTED_IDENTIFIER ON
GO

	SET NOCOUNT ON

	DECLARE
		@max_custid INT
	    , @target     VARCHAR(20)

	IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE
		SET @target = 'REPLICATED'

	PRINT 'Server Name : ' + @target

	SELECT @max_custid = xxx

	---------------------------------------CREARE TEMP TABLE--------------------------------------
	
	-- Create Temp Table stored SuperInfo
	CREATE TABLE #TmpSuperInfo
	(
		CustID	INT,
		IsDeleted	INT DEFAULT (0)
		PRIMARY KEY CLUSTERED (CustID)
	)

	CREATE TABLE #ProfileSetting (SettingType SMALLINT  , SportType SMALLINT , BetType SMALLINT )--, IsLive BIT DEFAULT (0))

	CREATE TABLE #Tmp_DataSettingRemove (CustID INT , SportType SMALLINT , BetType SMALLINT )--, IsLive BIT)
	CREATE TABLE #Tmp_DataSettingAffect (CustID INT , SportType SMALLINT , BetType SMALLINT )--, IsLive BIT)

	INSERT INTO #ProfileSetting (SettingType , SportType , BetType)
		SELECT 18 , 245 , 4601  
	UNION SELECT 18 , 200 , 1611  
	UNION SELECT 18 , 224 , 5500  
	UNION SELECT 18 , 171 , 3801  
	UNION SELECT 18 , 208 , 2101  
	UNION SELECT 18 , 176 , 8201  
	UNION SELECT 22 , 208 , 2101  
	UNION SELECT 22 , 245 , 4601  
	UNION SELECT 22 , 171 , 3801  
	UNION SELECT 22 , 176 , 8201  
	UNION SELECT 22 , 200 , 1611  
	UNION SELECT 22 , 9909 , 3700  
	UNION SELECT 7  , 176  , 8201  
	UNION SELECT 7  , 245  , 4601  
	UNION SELECT 7  , 245  , 4602  
	UNION SELECT 7  , 245  , 4605  
	UNION SELECT 7  , 171  , 3801  
	UNION SELECT 7  , 200  , 1611  
	UNION SELECT 7  , 208  , 2101  
	UNION SELECT 7  , 224  , 5500  

	---------------------------------------Collect Super Infor:---------------------------------------

	INSERT INTO #TmpSuperInfo ( CustID )
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
		    ON cu.Site = s.Site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid			= 4
			AND s.islicensee		= 0
			AND s.isActive		= 1
			AND cu.username		NOT LIKE '3rdSuper%'
			AND cs.isinternal		= 0
			AND cu.custid		NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId		<> 20
			
	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE
		@Batch		INT = 5000
	    , @JsonData		VARCHAR(MAX)
	    , @Srecommend		INT
	    , @Msg			VARCHAR(200)


	---------------------------------------REMOVE POSITION TAKING SETTING---------------------------------------
	WHILE  (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi WHERE tsi.IsDeleted = 0)

		IF @Srecommend IS NULL
			BREAK;

		UPDATE tmp 
			SET IsDeleted = 1
		FROM #TmpSuperInfo tmp WHERE CustID = @Srecommend

		-- Collect Super, Master, Agent Setting Position Taking Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustPTSetting3rd_Agent cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType -- AND cpa.IsLive = ps.IsLive
		WHERE i.Enabled = 1
		AND	i.roleid IN (2,3,4)
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID		<= @max_custid
		AND	ps.SettingType = 18
		AND	cpa.IsLive = 0

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PT_SMA'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Position Taking SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Refresh Temp Table
		TRUNCATE TABLE #Tmp_DataSettingRemove

		-- Collect Member Setting GroupPT Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.AgentID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustPTGroupSetting3rd_Member cpa WITH (NOLOCK) ON i.custid = cpa.AgentID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType -- AND cpa.IsLive = ps.IsLive
		WHERE i.Enabled = 1
		AND	i.roleid = 2
		AND	i.srecommend = @Srecommend
		AND   cpa.AgentID		<= @max_custid
		AND	ps.SettingType = 18
		AND	cpa.IsLive = 0

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PTGroup_Remove'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for GroupPT curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Refresh Temp Table
		TRUNCATE TABLE #Tmp_DataSettingRemove

		-- Collect Member Setting PT Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustPTSetting3rd_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType -- AND cpa.IsLive = ps.IsLive
		WHERE i.Enabled = 1
		AND	i.roleid = 1
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID		<= @max_custid
		AND	ps.SettingType = 18
		AND	cpa.IsLive = 0

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'PT_Member'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Position Taking Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END


	END

	---------------------------------------REMOVE WIN LOSS LIMIT SETTING---------------------------------------
	-- Refresh Temp Table
	TRUNCATE TABLE #Tmp_DataSettingRemove

	WHILE  (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi WHERE tsi.IsDeleted = 1)

		IF @Srecommend IS NULL
			BREAK;

		UPDATE tmp 
			SET IsDeleted = 2
		FROM #TmpSuperInfo tmp WHERE CustID = @Srecommend

		-- Collect Super, Master, Agent Setting Win Loss Limit Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustWinLossLimit_Agent cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType -- AND cpa.IsLive = ps.IsLive
		WHERE i.Enabled = 1
		AND	i.roleid IN (2,3,4)
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID		<= @max_custid
		AND	ps.SettingType = 22

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'WL_SMA'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Win Loss Limit SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Refresh Temp Table
		TRUNCATE TABLE #Tmp_DataSettingRemove

		-- Collect Member Setting Win Loss Limit Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustWinLossLimit_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType -- AND cpa.IsLive = ps.IsLive
		WHERE i.Enabled = 1
		AND	i.roleid = 1
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID		<= @max_custid
		AND	ps.SettingType = 22

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'WL_Member'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Win Loss Limit Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

	END

	---------------------------------------REMOVE STAKELEVEL SETTING---------------------------------------
	-- Refresh Temp Table
	TRUNCATE TABLE #Tmp_DataSettingRemove

	WHILE  (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi WHERE tsi.IsDeleted = 2)

		IF @Srecommend IS NULL
			BREAK;

		DELETE tmp FROM #TmpSuperInfo tmp WHERE CustID = @Srecommend

		-- Collect Super, Master, Agent Setting StakeLevel Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustStakeLevel_Agent cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType
		WHERE i.Enabled = 1
		AND	i.roleid IN (2,3,4)
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID	<= @max_custid
		AND ps.SettingType = 7 

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'StakeLevel_SMA'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for StakeLevel SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

		-- Refresh Temp Table
		TRUNCATE TABLE #Tmp_DataSettingRemove

		-- Collect Member Setting StakeLevel Need Remove Follow TOP 1 Super Headline

		INSERT INTO #Tmp_DataSettingRemove 
		(
			CustID
		    , SportType
		    , BetType
		)
		SELECT cpa.CustID , cpa.SportType , cpa.BetType
		FROM custInfo i WITH (NOLOCK)
		INNER JOIN CustStakeLevel_Member cpa WITH (NOLOCK) ON i.custid = cpa.CustID
		INNER JOIN #ProfileSetting ps ON cpa.SportType = ps.SportType AND cpa.BetType = ps.BetType
		WHERE i.Enabled = 1
		AND	i.roleid = 1
		AND	i.srecommend = @Srecommend
		AND   cpa.CustID	 <= @max_custid
		AND ps.SettingType = 7 

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #Tmp_DataSettingAffect

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType
				INTO #Tmp_DataSettingAffect (CustID , SportType, BetType)
			FROM #Tmp_DataSettingRemove ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType 
					FROM #Tmp_DataSettingAffect
						FOR JSON PATH
				)

			EXEC dbo.[Acc_DynamicCustSetting3rd_18] @ModeCode = 'StakeLevel_Member'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super ' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for StakeLevel Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END

	END


	DROP TABLE #ProfileSetting
	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_DataSettingRemove
	DROP TABLE #Tmp_DataSettingAffect
