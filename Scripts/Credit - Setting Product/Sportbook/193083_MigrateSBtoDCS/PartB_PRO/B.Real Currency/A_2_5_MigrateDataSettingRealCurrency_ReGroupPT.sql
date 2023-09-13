/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data Re Group PT Setting SportsBook Currency UUS [#193083]
		https://nexdev.net/issues/193083
	DB: DBCust/CustDB
*/
	SET NOCOUNT ON

	DECLARE
		@target VARCHAR(20)

	IF    @@servername IN ('DBCUST' , 'SITDBCUST' , 'TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE
		SET @target = 'REPLICATED'

	PRINT 'Server Name : ' + @target

	-------------------------------------------------------------------------------------------------------------------

	--Declare Temp Table

	CREATE TABLE #supers
		(
			CustID     INT
		    , isfinished BIT DEFAULT (0)
		)

	CREATE TABLE #CustomerTemp
		(
			CustID    INT PRIMARY KEY CLUSTERED
		    , Recommend INT
		)

	CREATE TABLE #UnGroupedCustomer
		(
			CustID    INT PRIMARY KEY CLUSTERED
		    , Recommend INT
		)

	CREATE TABLE #GroupedCustomer
		(
			CustID INT PRIMARY KEY CLUSTERED
		)

	CREATE TABLE #tempData
		(
			recommend INT
		    , custid    INT
		    , cs1	    BIGINT
		    , cs2	    INT
		)

	CREATE TABLE #tempGroup
		(
			recommend INT
		    , cs1	    BIGINT
		    , cs2	    INT
		    , memberCNT INT
		    , repCustID INT
		)


	--Declare Param

	DECLARE
		@Srecommend		INT
	    , @JsonData		VARCHAR(MAX)
	    , @Msg			VARCHAR(200)

	-------------------------------------------------------------------------------------------------------------------

	-- Collect Headline Affected
	INSERT INTO #supers ( CustID )
	SELECT ci.custid
	FROM Customer ci WITH (NOLOCK)
		WHERE
			ci.custid IN (
			13869621 ,
			5340162 ,
			12262401 ,
			12141653 ,
			4138910 ,
			6379932 ,
			16112208 ,
			12141529 ,
			1539339 ,
			720475
			--UUS
			, 17287861
			, 18879367
			, 14373244
			, 18362423
			, 18479460
			, 18289591
			)
			AND currency <> 20

	WHILE (1=1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL

		SELECT @Srecommend =  (SELECT TOP 1 s.CustID FROM #supers s)

		IF @Srecommend IS NULL
			BREAK;

		DELETE FROM #supers WHERE CustID = @Srecommend

		--Get a list of customers Member
		INSERT #CustomerTemp
		(
			  CustID
			, Recommend
		)
		SELECT
			ci.CustID
		    , ci.recommend
		FROM dbo.CustSettingMode3rd m WITH(NOLOCK)
		INNER JOIN dbo.custInfo ci WITH(NOLOCK)
			ON m.CustID = ci.custid
		WHERE IsGrouped = 1 AND ci.srecommend = @srecommend AND ci.roleid = 1


		--Get representative CustID
		;
		WITH _s AS
			(
				SELECT c.recommend , c.custid , rdSetting = CAST ( DENSE_RANK () OVER (ORDER BY SportType , BetType , islive , superPT , masterPT , agentPT , isAutoMasterPT , AutoMasterPT , isAutoSuperPT , AutoSuperPT) AS INT ) , rdProduct = CAST ( DENSE_RANK () OVER (ORDER BY SportType , BetType , islive) AS INT )
					FROM #CustomerTemp c WITH (NOLOCK)
					INNER JOIN dbo.CustPTSetting3rd_Member pt WITH (NOLOCK) ON c.custid = pt.custid AND pt.SportType IN (9913 , 9914 , 9915)
			)
		INSERT INTO #tempData
					(
						recommend
					    , custid
					    , cs1
					    , cs2
					)
		SELECT
			recommend
		    , custid
		    , SUM ( CONVERT ( BIGINT , rdSetting ) + POWER ( 2 , rdProduct%10+1 ) )
		    , CHECKSUM_AGG ( CHECKSUM ( HASHBYTES ( 'SHA1' , CONVERT ( NVARCHAR(MAX) , rdSetting ) ) ) )
		FROM _s
		GROUP BY recommend , custid

		INSERT INTO #tempGroup
		(
			  recommend
			, cs1
			, cs2
			, memberCNT
			, repCustID
		)
		SELECT
			recommend
		    , cs1
		    , cs2
		    , memberCNT
		    , repCustID
		FROM (
				SELECT recommend , cs1 , cs2 , rn = ROW_NUMBER () OVER (PARTITION BY recommend ORDER BY COUNT ( 1 ) DESC , MAX ( custid ) DESC) , memberCnt = COUNT ( 1 ) , repCustID = MAX ( custid )
				    FROM #tempData
					GROUP BY recommend , cs1 , cs2
			) x
			WHERE rn = 1

		--Get a list of customers that do not continue using PT Group 
		INSERT INTO #UnGroupedCustomer
		(
			  CustID
			, Recommend
		)
		SELECT
			c.CustID
		    , c.Recommend
		FROM #CustomerTemp c WITH (NOLOCK)
		INNER JOIN #tempData tmp1 WITH (NOLOCK)
			    ON tmp1.custid = c.CustID
		INNER JOIN #tempGroup tmp2 WITH (NOLOCK)
			    ON tmp1.recommend = tmp2.recommend
			WHERE
				tmp1.cs2 <> tmp2.cs2
				OR
				tmp1.cs1 <> tmp2.cs1

		--Get a list of customers that will be using PT Group 
		INSERT INTO #GroupedCustomer
		(
			CustID
		)
		SELECT c.CustID
		FROM #CustomerTemp c WITH (NOLOCK)
		INNER JOIN #tempData tmp1 WITH (NOLOCK)
			    ON tmp1.custid = c.CustID
		INNER JOIN #tempGroup tmp2 WITH (NOLOCK)
			    ON tmp1.recommend = tmp2.recommend
			WHERE
				tmp1.cs2 = tmp2.cs2
				AND
				tmp1.cs1 = tmp2.cs1

		--Insert Individual PT for customers that do not continue using PT Group 
		SELECT @JsonData = 
			(
				SELECT c.CustID , cs.SportType , cs.BetType , cs.IsLive , cs.IsAutoMasterPT , cs.IsAutoSuperPT , cs.SuperPT , cs.MasterPT , cs.AgentPT , cs.AutoSuperPT , cs.AutoMasterPT
				    FROM [dbo].[CustPTGroupSetting3rd_Member] cs WITH (NOLOCK)
				    INNER JOIN #UnGroupedCustomer c WITH (NOLOCK) ON c.Recommend = cs.AgentID
					FOR JSON PATH
			)

		IF    (@JsonData IS NOT NULL OR @JsonData <> '')
		BEGIN
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'PTMember'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Group PTMember curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

		--Update IsGrouped=0 for customers that do not continue using PT Group 	
		SELECT @JsonData = 
			(
				SELECT CustID
				    FROM #UnGroupedCustomer
					FOR JSON PATH
			)

		IF    (@JsonData IS NOT NULL OR @JsonData <> '')
		BEGIN
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'UpdIsGroupPT'
									  , @JsonData = @JsonData
									  , @target	  = @target

			
			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Group PT UpdIsGroupPT curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

		--Insert setting of Group PT
		SELECT @JsonData = 
			(
				SELECT tmp.recommend , SportType , BetType , IsLive , IsAutoMasterPT , IsAutoSuperPT , SuperPT , MasterPT , AgentPT , AutoSuperPT , AutoMasterPT
				    FROM [dbo].[CustPTSetting3rd_Member] mb WITH (NOLOCK)
				    INNER JOIN #tempGroup tmp ON mb.CustID = tmp.repCustID
					  AND mb.SportType IN (9913 , 9914 , 9915)
					FOR JSON PATH
			)

		IF    (@JsonData IS NOT NULL OR @JsonData <> '')
		BEGIN
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'InsGroupPT'
									  , @JsonData = @JsonData
									  , @target	  = @target

			
			WAITFOR DELAY '00:00:0.050'
			
			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Group PT InsGroupPT curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END

		--Delete redundant individual setting
		SELECT @JsonData = 
			(
				SELECT cs.CustID
				    FROM [dbo].[CustPTSetting3rd_Member] cs WITH (NOLOCK)
				    INNER JOIN #GroupedCustomer temp1 WITH (NOLOCK) ON cs.CustID = temp1.CustID
					WHERE cs.SportType IN (9913 , 9914 , 9915)
					FOR JSON PATH
			)

		IF    (@JsonData IS NOT NULL OR @JsonData <> '')
		BEGIN
			EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'DelPT'
									  , @JsonData = @JsonData
									  , @target	  = @target

			WAITFOR DELAY '00:00:0.050'

			SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Group PT DelPT curdt: ' + convert(varchar(50), getdate(), 121)
			RAISERROR (@Msg, 0, 1) WITH NOWAIT
		END


		TRUNCATE TABLE #GroupedCustomer
		TRUNCATE TABLE #tempGroup
		TRUNCATE TABLE #UnGroupedCustomer
		TRUNCATE TABLE #tempData
		TRUNCATE TABLE #CustomerTemp
	END



	DROP TABLE #supers
	DROP TABLE #GroupedCustomer
	DROP TABLE #CustomerTemp
	DROP TABLE #tempData
	DROP TABLE #tempGroup
	DROP TABLE #UnGroupedCustomer