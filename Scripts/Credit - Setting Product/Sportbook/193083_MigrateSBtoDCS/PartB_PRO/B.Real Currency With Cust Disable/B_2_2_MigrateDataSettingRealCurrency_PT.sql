/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data PT Setting SportsBook Real Currency With Exchange have IsActive = 0 , CustSuper.isinternal = 1 [#193083]
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
			PRIMARY KEY CLUSTERED (CustID)
		)

	-- Create Temp Table stored SportType - BetType...
	CREATE TABLE #Tmp_ProductSetting
		(
			SettingType	  SMALLINT
		    , Scr_SportType SMALLINT
		    , Scr_BetType	  SMALLINT
		    , Islive	  BIT DEFAULT 0
		    , Dst_SportType SMALLINT
		    , Dst_BetType	  SMALLINT
			PRIMARY KEY CLUSTERED (SettingType , Scr_SportType , Scr_BetType , Islive)
		)

	-- Create Temp Table stored PT Setting
	CREATE TABLE #SMAPT_Setting
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , IsLive	   BIT
		    , IsAutoMasterPT BIT
		    , IsAutoSuperPT  BIT
		    , SuperPT	   SMALLMONEY
		    , MasterPT	   SMALLMONEY
		    , AgentPT	   SMALLMONEY
		    , AutoSuperPT	   SMALLMONEY
		    , AutoMasterPT   SMALLMONEY
		    , MinPT		   SMALLMONEY
		    , MaxPT		   SMALLMONEY
			PRIMARY KEY CLUSTERED (CustID , SportType , BetType , IsLive)
		)

	CREATE TABLE #MemberPT_Setting
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , IsLive	   BIT
		    , IsAutoMasterPT BIT
		    , IsAutoSuperPT  BIT
		    , SuperPT	   SMALLMONEY
		    , MasterPT	   SMALLMONEY
		    , AgentPT	   SMALLMONEY
		    , AutoSuperPT	   SMALLMONEY
		    , AutoMasterPT   SMALLMONEY
			PRIMARY KEY CLUSTERED (CustID , SportType , BetType , IsLive)
		)


	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE
		@Batch		INT = 5000
	    , @JsonData		VARCHAR(MAX)
	    , @Srecommend		INT
	    , @Msg			VARCHAR(200)

	CREATE TABLE #CustAffected_SMAPT
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , IsLive	   BIT
		    , IsAutoMasterPT BIT
		    , IsAutoSuperPT  BIT
		    , SuperPT	   SMALLMONEY
		    , MasterPT	   SMALLMONEY
		    , AgentPT	   SMALLMONEY
		    , AutoSuperPT	   SMALLMONEY
		    , AutoMasterPT   SMALLMONEY
		    , MinPT		   SMALLMONEY
		    , MaxPT		   SMALLMONEY
		)

	CREATE TABLE #CustAffected_MemberPT
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , IsLive	   BIT
		    , IsAutoMasterPT BIT
		    , IsAutoSuperPT  BIT
		    , SuperPT	   SMALLMONEY
		    , MasterPT	   SMALLMONEY
		    , AgentPT	   SMALLMONEY
		    , AutoSuperPT	   SMALLMONEY
		    , AutoMasterPT   SMALLMONEY
		)


	---------------------------------------Initial SportType-BetType---------------------------------------

	INSERT INTO #Tmp_ProductSetting
				(
					SettingType
				    , Scr_SportType
				    , Scr_BetType
				    , Islive
				    , Dst_SportType
				    , Dst_BetType
				)

	-- PT			: SettingType = 28
	SELECT 28 , 1 , 1 , 0 , 9914 , 915
	UNION
	SELECT 28 , 1 , 1 , 1 , 9913 , 915
	UNION
	SELECT 28 , 1 , 5 , 0 , 9914 , 916
	UNION
	SELECT 28 , 1 , 5 , 1 , 9913 , 916
	UNION
	SELECT 28 , 1 , 9999 , 0 , 9914 , 917
	UNION
	SELECT 28 , 1 , 9999 , 1 , 9913 , 917
	UNION
	SELECT 28 , 99 , 9 , 0 , 9915 , 918


	---------------------------------------Collect Super Infor:---------------------------------------

	INSERT INTO #TmpSuperInfo ( CustID )
	SELECT cu.CustId
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN Site s WITH (NOLOCK)
		    ON cu.Site = s.Site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid			= 4
			AND s.islicensee		= 0
			AND s.isActive		= 1
			AND cu.username		NOT LIKE '3rdSuper%'
			AND ((e.IsActive = 0)  OR (e.IsActive = 1 AND cs.IsInternal = 1))
			AND cu.custid		NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId		<> 20
			AND cu.srecommend		<= @max_custid


	WHILE (1=1)
	BEGIN

		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 tsi.CustID FROM #TmpSuperInfo tsi)

		IF @Srecommend IS NULL
			BREAK;

		DELETE FROM #TmpSuperInfo WHERE CustID = @Srecommend

		-- Collect Super, Master, Agent Setting PT Need Insert Follow TOP 1 Super Headline

		INSERT INTO #SMAPT_Setting
		(       CustID
			, SportType
			, BetType
			, IsLive
			, SuperPT
			, MasterPT
			, AgentPT
			, AutoSuperPT
			, IsAutoSuperPT
			, AutoMasterPT
			, IsAutoMasterPT
			, MinPT
			, MaxPT
		)

		-- Just affected Non Live PT Values
		SELECT
			ci.custId
		    , ps.Dst_SportType					AS SportType
		    , ps.Dst_BetType					AS BetType
		    , ps.Islive						AS Islive
		    , spositiontaking			* 100		AS SuperPT
		    , mpositiontaking			* 100		AS MasterPT
		    , apositiontaking			* 100		AS AgentPT
		    , autopositiontaking		* 100		AS AutoSuperPT
		    , isautopositiontaking				AS IsAutoSuperPT
		    , autompositiontaking		* 100		AS AutoMasterPT
		    , isautompositiontaking				AS IsAutoMasterPT
		    , ISNULL ( co.minpositiontaking * 100 , 0 ) AS MinPT
		    , 100							AS MaxPT
		FROM custInfo ci WITH (NOLOCK)
		INNER JOIN custOverride co WITH (NOLOCK)
			    ON ci.custid = co.custid
		INNER JOIN #Tmp_ProductSetting ps
			    ON co.SportType = ps.Scr_SportType
			    AND co.BetType = ps.Scr_BetType
		INNER JOIN custSetting cs WITH (NOLOCK)
			    ON cs.custid = co.custid
			    AND cs.SportType = co.SportType
			    AND cs.BetType = co.BetType
			WHERE
				ci.Enabled				= 1
				AND ci.roleid			IN (2 , 3 , 4)
				AND ci.srecommend			= @Srecommend
				AND ps.SettingType		= 28
				AND ps.Islive			= 0


		UNION

		-- BetType = 1  is Handicap : Collect Live Values
		-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive
		SELECT
			ci.custId
		    , ps.Dst_SportType AS SportType
		    , ps.Dst_BetType   AS BetType
		    , ps.Islive	     AS Islive
		    , CASE
				WHEN cs.betType = 1 THEN slivepositiontaking * 100
				ELSE spositiontaking * 100
			END		     AS SuperPT
		    , CASE
				WHEN cs.betType = 1 THEN mlivepositiontaking * 100
				ELSE mpositiontaking * 100
			END		     AS MasterPT
		    , CASE
				WHEN cs.betType = 1 THEN alivepositiontaking * 100
				ELSE apositiontaking * 100
			END		     AS AgentPT
		    , CASE
				WHEN cs.betType = 1 THEN autolivepositiontaking * 100
				ELSE autopositiontaking * 100
			END		     AS AutoSuperPT
		    , CASE
				WHEN cs.betType = 1 THEN isautolivepositiontaking
				ELSE isautopositiontaking
			END		     AS IsAutoSuperPT
		    , CASE
				WHEN cs.betType = 1 THEN autolivempositiontaking * 100
				ELSE autompositiontaking * 100
			END		     AS AutoMasterPT
		    , CASE
				WHEN cs.betType = 1 THEN isautolivempositiontaking
				ELSE isautompositiontaking
			END		     AS IsAutoMasterPT
		    , CASE
				WHEN cs.betType = 1 THEN ISNULL ( co.minlivepositiontaking * 100 , 0 )
				ELSE ISNULL ( co.minpositiontaking * 100 , 0 )
			END		     AS MinPT
		    , 100		     AS MaxPT
		FROM custInfo ci WITH (NOLOCK)
		INNER JOIN custOverride co WITH (NOLOCK)
			    ON ci.custid		= co.custid
		INNER JOIN #Tmp_ProductSetting ps
			    ON co.SportType	= ps.Scr_SportType
			    AND co.BetType	= ps.Scr_BetType
		INNER JOIN custSetting cs WITH (NOLOCK)
			    ON cs.custid		= co.custid
			    AND cs.SportType	= co.SportType
			    AND cs.BetType	= co.BetType
			WHERE
				ci.Enabled		= 1
				AND ci.roleid	IN (2 , 3 , 4)
				AND ci.srecommend = @Srecommend
				AND ps.SettingType= 28
				AND ps.Islive	= 1

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected_SMAPT

			DELETE TOP (@Batch) ss
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT , DELETED.MinPT , DELETED.MaxPT
				INTO #CustAffected_SMAPT (CustID , SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT , SuperPT , MasterPT , AgentPT , AutoSuperPT , AutoMasterPT , MinPT , MaxPT)
			FROM #SMAPT_Setting ss

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT , SuperPT , MasterPT , AgentPT , AutoSuperPT , AutoMasterPT , MinPT , MaxPT
					    FROM #CustAffected_SMAPT
						FOR JSON PATH
				)
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'PTSMA'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for PT SMA curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT

		END


		-- Collect Member Setting PT Need Insert Follow TOP 1 Super Headline
		INSERT INTO #MemberPT_Setting
		(
			  CustID
			, SportType
			, BetType
			, IsLive
			, SuperPT
			, MasterPT
			, AgentPT
			, AutoSuperPT
			, IsAutoSuperPT
			, AutoMasterPT
			, IsAutoMasterPT
		)

		-- Just affected Non Live PT Values
		SELECT
			ci.custid
		    , ps.Dst_SportType				AS SportType
		    , ps.Dst_BetType				AS BetType
		    , ps.Islive					AS Islive
		    , spositiontaking		* 100		AS SuperPT
		    , mpositiontaking		* 100		AS MasterPT
		    , apositiontaking		* 100		AS AgentPT
		    , autopositiontaking	* 100		AS AutoSuperPT
		    , isautopositiontaking			AS IsAutoSuperPT
		    , autompositiontaking	* 100		AS AutoMasterPT
		    , isautompositiontaking			AS IsAutoMasterPT
		FROM custInfo ci WITH (NOLOCK)
		INNER JOIN custSetting cs WITH (NOLOCK)
			    ON ci.custid = cs.custid
		INNER JOIN #Tmp_ProductSetting ps
			    ON cs.SportType = ps.Scr_SportType
			    AND cs.BetType = ps.Scr_BetType
			WHERE
				ci.srecommend	 = @Srecommend
				AND ci.Enabled	 = 1
				AND ci.roleid	 = 1
				AND ps.SettingType = 28
				AND ps.Islive	 = 0


		UNION

		-- BetType = 1  is Handicap : Collect Live Values
		-- BetType <> 1 is (1X2, Others) : Copy Values From NonLive
		SELECT
			ci.custId
		    , ps.Dst_SportType AS SportType
		    , ps.Dst_BetType   AS BetType
		    , ps.Islive	     AS Islive
		    , CASE
				WHEN cs.betType = 1 THEN slivepositiontaking * 100
				ELSE spositiontaking * 100
			END		     AS SuperPT
		    , CASE
				WHEN cs.betType = 1 THEN mlivepositiontaking * 100
				ELSE mpositiontaking * 100
			END		     AS MasterPT
		    , CASE
				WHEN cs.betType = 1 THEN alivepositiontaking * 100
				ELSE apositiontaking * 100
			END		     AS AgentPT
		    , CASE
				WHEN cs.betType = 1 THEN autolivepositiontaking * 100
				ELSE autopositiontaking * 100
			END		     AS AutoSuperPT
		    , CASE
				WHEN cs.betType = 1 THEN isautolivepositiontaking
				ELSE isautopositiontaking
			END		     AS IsAutoSuperPT
		    , CASE
				WHEN cs.betType = 1 THEN autolivempositiontaking * 100
				ELSE autompositiontaking * 100
			END		     AS AutoMasterPT
		    , CASE
				WHEN cs.betType = 1 THEN isautolivempositiontaking
				ELSE isautompositiontaking
			END		     AS IsAutoMasterPT
		FROM custInfo ci WITH (NOLOCK)
		INNER JOIN custSetting cs WITH (NOLOCK)
			    ON ci.custid = cs.custid
		INNER JOIN #Tmp_ProductSetting ps
			    ON cs.SportType = ps.Scr_SportType
			    AND cs.BetType = ps.Scr_BetType
			WHERE
				ci.srecommend = @Srecommend
				AND ci.Enabled = 1
				AND ci.roleid = 1
				AND ps.SettingType = 28
				AND ps.Islive = 1

		WHILE (1=1)
		BEGIN
			TRUNCATE TABLE #CustAffected_MemberPT

			DELETE TOP (@Batch) ms
			OUTPUT DELETED.CustID , DELETED.SportType , DELETED.BetType , DELETED.IsLive , DELETED.IsAutoMasterPT , DELETED.IsAutoSuperPT , DELETED.SuperPT , DELETED.MasterPT , DELETED.AgentPT , DELETED.AutoSuperPT , DELETED.AutoMasterPT
				INTO #CustAffected_MemberPT (CustID , SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT , SuperPT , MasterPT , AgentPT , AutoSuperPT , AutoMasterPT)
			FROM #MemberPT_Setting ms

			 IF @@ROWCOUNT = 0
				BREAK;

			SELECT @JsonData = 
				(
					SELECT CustID , SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT , SuperPT , MasterPT , AgentPT , AutoSuperPT , AutoMasterPT
					    FROM #CustAffected_MemberPT
						FOR JSON PATH
				)
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'PTMember'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for PT Member curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END
		


	END

	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_ProductSetting
	DROP TABLE #SMAPT_Setting
	DROP TABLE #MemberPT_Setting
	DROP TABLE #CustAffected_SMAPT
	DROP TABLE #CustAffected_MemberPT
	