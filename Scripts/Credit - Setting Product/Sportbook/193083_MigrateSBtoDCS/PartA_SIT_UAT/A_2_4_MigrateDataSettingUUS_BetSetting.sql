/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data BetSetting SportsBook Currency UUS [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
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
			CustID INT
			PRIMARY KEY CLUSTERED (CustId)
		)

	-- Create Temp Table stored SportType - BetType...
	CREATE TABLE #Tmp_ProductSetting
		(
			SettingType SMALLINT
		    , SportType   SMALLINT
		    , BetType     SMALLINT
			PRIMARY KEY CLUSTERED (SettingType , Sporttype , Bettype)
		)

	-- Create Temp Table stored Bet Setting
	CREATE TABLE #Bet_Setting
		(
			CustID	INT
		    , SportType   SMALLINT
		    , BetType     SMALLINT
		    , MinBet	MONEY
		    , MaxBet	MONEY
		    , MaxPerMatch MONEY
			PRIMARY KEY CLUSTERED (CustId , Sporttype , Bettype)
		)

	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE
		@Batch		INT = 5000
	    , @JsonData		VARCHAR(MAX)
	    , @Srecommend		INT
	    , @Msg			VARCHAR(200)


	CREATE TABLE #CustAffected
		(
			CustID	INT
		    , SportType   SMALLINT
		    , BetType     SMALLINT
		    , MinBet	MONEY
		    , MaxBet	MONEY
		    , MaxPerMatch MONEY
		)

	---------------------------------------Initial SportType-BetType---------------------------------------

	INSERT INTO #Tmp_ProductSetting
				(
					SettingType
				    , Sporttype
				    , Bettype
				)

	-- BetSetting  : SettingType = 26
		 SELECT  26 ,  43 ,  1
	 UNION SELECT  26 ,  44 ,  3

	---------------------------------------Collect Super Infor:---------------------------------------
	INSERT INTO #TmpSuperInfo ( CustId )
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN site s WITH (NOLOCK)
		    ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.CustId		 = cs.CustId
		WHERE cu.roleid		 = 4
			AND s.isLicensee	 = 0
			AND s.IsActive	 = 1
			AND cu.username	 NOT LIKE '3rdSuper%'
			AND cs.IsInternal  = 0
			AND cu.CustId	 NOT IN (SELECT CustId FROM Dep_CustSuper WITH (NOLOCK))
			AND e.ExchangeId	 = 20
			AND cu.srecommend  <= @max_custid

	WHILE (1 = 1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustId FROM #TmpSuperInfo tsi)

		IF @Srecommend IS NULL
			BREAK;

		DELETE FROM #TmpSuperInfo WHERE CustId = @Srecommend

		-- Collect Super, Master, Agent Setting BetSetting Need Insert Follow TOP 1 Super Headline
		INSERT INTO #Bet_Setting
		(
			  CustId
			, Sporttype
			, Bettype
			, minbet
			, MaxBet
			, MaxPerMatch
		)
		SELECT
			ca.CustId
		    , ca.Sporttype
		    , ca.Bettype
		    , ca.minbet
		    , ca.MaxBet
		    , ca.MaxPerMatch
		FROM
			custInfo ci WITH (NOLOCK)
		INNER JOIN CustBetSetting3rd_Agent ca WITH (NOLOCK)
			    ON ci.CustId = ca.CustId
		INNER JOIN #Tmp_ProductSetting ps
			    ON ca.Sporttype = ps.Sporttype
			    AND ca.Bettype = ps.Bettype
			WHERE
				ps.SettingType	= 26
				AND ci.srecommend = @Srecommend
				AND ci.Enabled	= 1
				AND ci.roleid	IN (2 , 3 , 4)

		WHILE (1 = 1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) bs
			OUTPUT DELETED.CustId , DELETED.Sporttype , DELETED.Bettype , DELETED.minbet , DELETED.MaxBet , DELETED.MaxPerMatch
				INTO #CustAffected (CustId , Sporttype , Bettype , minbet , MaxBet , MaxPerMatch)
			FROM #Bet_Setting bs

			IF    @@rowcount = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch
					    FROM #CustAffected
						FOR JSON PATH
				)
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'BetSettingSMA'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for BetSetting SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

		-- Clear Temp Table
		TRUNCATE TABLE #Bet_Setting

		INSERT INTO #Bet_Setting
		(
			  CustId
			, Sporttype
			, Bettype
			, minbet
			, MaxBet
			, MaxPerMatch
		)
		SELECT
			ca.CustId
		    , ca.Sporttype
		    , ca.Bettype
		    , ca.minbet
		    , ca.MaxBet
		    , ca.MaxPerMatch
		FROM
			custInfo ci WITH (NOLOCK)
		INNER JOIN CustBetSetting3rd_Member ca WITH (NOLOCK)
			    ON ci.CustId = ca.CustId
		INNER JOIN #Tmp_ProductSetting ps
			    ON ca.Sporttype = ps.Sporttype
			    AND ca.Bettype = ps.Bettype
			WHERE
				ps.SettingType	= 26
				AND ci.srecommend = @Srecommend
				AND ci.Enabled	= 1
				AND ci.roleid	= 1

		WHILE (1 = 1)
		BEGIN
			TRUNCATE TABLE #CustAffected

			DELETE TOP (@Batch) bs
			OUTPUT DELETED.CustId , DELETED.Sporttype , DELETED.Bettype , DELETED.minbet , DELETED.MaxBet , DELETED.MaxPerMatch
				INTO #CustAffected (CustId , Sporttype , Bettype , minbet , MaxBet , MaxPerMatch)
			FROM #Bet_Setting bs

			IF    @@rowcount = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType , MinBet , MaxBet , MaxPerMatch
					    FROM #CustAffected
						FOR JSON PATH
				)
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'BetSettingMember'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for BetSetting Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

	END



	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_ProductSetting
	DROP TABLE #Bet_Setting
	DROP TABLE #CustAffected