/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230913@Helios
	Task: Inital Migrate Data Comm Setting SportsBook Currency UUS [#193083]
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
			CustID	INT
		    , IsSite7666B BIT
			PRIMARY KEY CLUSTERED (custid)
		)

	-- Create Temp Table stored SportType - BetType...
	CREATE TABLE #Tmp_ProductSetting
		(
			SettingType SMALLINT
		    , SportType   SMALLINT
		    , BetType     SMALLINT
		    , PRIMARY KEY CLUSTERED (SettingType , sporttype , bettype)
		)

	-- Create Temp Table stored Discount Setting
	CREATE TABLE #DiscountSMA_Setting
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		    , Discount  DECIMAL(9 , 8)
			PRIMARY KEY CLUSTERED (custid , sporttype , bettype)
		)


	CREATE TABLE #DiscountMember_Setting
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , PlayerDiscount DECIMAL(9 , 8)
		    , AgentDiscount  DECIMAL(9 , 8)
		    , MasterDiscount DECIMAL(9 , 8)
		    , SuperDiscount  DECIMAL(9 , 8)
			PRIMARY KEY CLUSTERED (custid , sporttype , bettype)
		)

	---------------------------------------Declare Deployed Info---------------------------------------
	DECLARE
		@Batch		INT = 5000
	    , @JsonData		VARCHAR(MAX)
	    , @Srecommend		INT
	    , @IsSite7666B	BIT
	    , @Msg			VARCHAR(200)


	CREATE TABLE #CustAffected_SMADiscount
		(
			CustID    INT
		    , SportType SMALLINT
		    , BetType   SMALLINT
		    , Discount  DECIMAL(9 , 8)
		)

	CREATE TABLE #CustAffected_MemberDiscount
		(
			CustID	   INT
		    , SportType	   SMALLINT
		    , BetType	   SMALLINT
		    , PlayerDiscount DECIMAL(9 , 8)
		    , AgentDiscount  DECIMAL(9 , 8)
		    , MasterDiscount DECIMAL(9 , 8)
		    , SuperDiscount  DECIMAL(9 , 8)
		)


	---------------------------------------Initial SportType-BetType---------------------------------------

	INSERT
		INTO
			#Tmp_ProductSetting
				(
					SettingType
				    , sporttype
				    , bettype
				)
	-- Comm		: SettingType = 25
		 SELECT  25 ,  1 ,  1		-- Group A
	 UNION SELECT  25 ,  1 ,  3		-- Group B	 
	 UNION SELECT  25 ,  1 ,  4		-- Other Comm
	 UNION SELECT  25 ,  1 ,  5 		-- 1X2
	 UNION SELECT  25 ,  1 ,  7		-- Group C
	 UNION SELECT  25 ,  1 ,  8		-- Group D



	---------------------------------------Collect Super Infor:---------------------------------------

	INSERT INTO #TmpSuperInfo
				(
					custid
				    , IsSite7666B
				)
	SELECT cu.custid
	    , CASE
			WHEN cu.site = '76666B' THEN 1
			ELSE 0
		END AS IsSite7666B
	FROM Customer cu WITH (NOLOCK)
	INNER JOIN site s WITH (NOLOCK)
		    ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)
		    ON cu.currency = e.ExchangeId
		    AND e.IsActive = 1
		    AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK)
		    ON cu.custid = cs.custid
		WHERE
			cu.roleid = 4
			AND s.isLicensee = 0
			AND s.IsActive = 1
			AND cu.username NOT LIKE '3rdSuper%'
			AND cs.IsInternal = 0
			AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))
			--AND e.ExchangeId <> 20
			AND cu.srecommend <= @max_custid

	WHILE (1 = 1)
	BEGIN
		-- Pick top 1 Super to run all line
		SELECT @Srecommend = NULL , @IsSite7666B = NULL
		
		SELECT TOP (1)
			@Srecommend	 = custid
		    , @IsSite7666B = IsSite7666B
		FROM #TmpSuperInfo

		IF @Srecommend IS NULL
			BREAK;

		DELETE FROM #TmpSuperInfo WHERE custid = @Srecommend

		IF    (@IsSite7666B) = 1
		BEGIN
			-- Collect data with Site = 76666B

			-- Collect Super, Master, Agent Setting Discount Need Insert Follow TOP 1 Super Headline
			INSERT INTO #DiscountSMA_Setting
			(
				  custid
				, sporttype
				, bettype
				, discount
			)
			SELECT
				cs.custid
			    , cs.sporttype
			    , cs.bettype
			    , CASE
					WHEN ps.bettype = 1				THEN cs.groupa				-- GroupA
					WHEN ps.bettype <> 1 AND ci.roleid = 4	THEN cs.sdiscount				-- 1x2 Comm ,  Others Comm
					WHEN ps.bettype <> 1 AND ci.roleid = 3	THEN cs.adiscount				-- 1x2 Comm ,  Others Comm
					WHEN ps.bettype <> 1 AND ci.roleid = 2	THEN cs.discount				-- 1x2 Comm ,  Others Comm	
				END
				AS Discount

			FROM custInfo ci WITH (NOLOCK)
			INNER JOIN custSetting cs WITH (NOLOCK)
				    ON cs.custid = ci.custid
			INNER JOIN #Tmp_ProductSetting ps
				    ON cs.sporttype = ps.sporttype
				    AND cs.bettype = ps.bettype
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid IN (2 , 3 , 4)
					AND ps.SettingType = 25
					AND ps.bettype IN (1 , 4 , 5)

			UNION

			-- Get Comm Myanmar Odds
			SELECT
				cr.custid
			    , 2		AS SportType
			    , 1		AS BetType
			    , cr.CommRate AS Discount
			FROM custInfo ci WITH (NOLOCK)
			INNER JOIN AgentCommRate cr WITH (NOLOCK)
				    ON cr.custid = ci.custid
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid IN (2 , 3 , 4)

			WHILE (1 = 1)
			BEGIN
				TRUNCATE TABLE #CustAffected_SMADiscount

				DELETE TOP (@Batch) cas
				OUTPUT DELETED.custid , DELETED.sporttype , DELETED.bettype , DELETED.discount
					INTO #CustAffected_SMADiscount (custid , sporttype , bettype , discount)
				FROM #DiscountSMA_Setting cas

				IF    @@rowcount = 0
					BREAK;

				SELECT @JsonData = 
					(
						SELECT custid , sporttype , bettype , discount
						    FROM #CustAffected_SMADiscount
							FOR JSON PATH
					)
				EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'DiscountSMA'
										  , @JsonData = @JsonData
										  , @target	  = @target

				WAITFOR DELAY '00:00:0.050'

				SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Discount SMA curdt: ' + convert(varchar(50), getdate(), 121)
				RAISERROR (@Msg, 0, 1) WITH NOWAIT
			END

			-- Collect Member Setting Discount Need Insert Follow TOP 1 Super Headline
			INSERT INTO #DiscountMember_Setting
			(
				  custid
				, sporttype
				, bettype
				, playerdiscount
				, AgentDiscount
				, MasterDiscount
				, SuperDiscount
			)
			SELECT
				cs.custid
			    , cs.sporttype
			    , cs.bettype
			    , cs.playerdiscount
			    , cs.discount
			    , cs.adiscount
			    , cs.sdiscount
			FROM
				custInfo ci WITH (NOLOCK)
			INNER JOIN custSetting cs WITH (NOLOCK)
				    ON cs.custid = ci.custid
			INNER JOIN Customer c WITH (NOLOCK)
				    ON cs.custid = c.custid
			INNER JOIN #Tmp_ProductSetting ps
				    ON cs.sporttype = ps.sporttype
				    AND cs.bettype = ps.bettype
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid = 1
					AND ps.SettingType = 25
					AND ps.bettype IN (1 , 4 , 5)

			UNION

			-- Get Comm Myanmar Odds
			SELECT
				cr.custid
			    , 2 AS SportType
			    , 1 AS BetType
			    , cr.playerdiscount
			    , cr.discount
			    , cr.adiscount
			    , cr.sdiscount
			FROM
				custInfo ci WITH (NOLOCK)
			INNER JOIN CustCommRate cr WITH (NOLOCK)
				    ON cr.custid = ci.custid
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid = 1

			WHILE (1 = 1)
			BEGIN
				TRUNCATE TABLE #CustAffected_MemberDiscount

				DELETE TOP (@Batch) dms
				OUTPUT DELETED.custid , DELETED.sporttype , DELETED.bettype , DELETED.playerdiscount , DELETED.AgentDiscount , DELETED.MasterDiscount , DELETED.SuperDiscount
					INTO #CustAffected_MemberDiscount (custid , sporttype , bettype , playerdiscount , AgentDiscount , MasterDiscount , SuperDiscount)
				FROM
					#DiscountMember_Setting dms

				IF    @@rowcount = 0
					BREAK;

				SELECT @JsonData = 
					(
						SELECT custid , sporttype , bettype , playerdiscount , AgentDiscount , MasterDiscount , SuperDiscount
						    FROM #CustAffected_MemberDiscount
							FOR JSON PATH
					)
				EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'DiscountMember'
										  , @JsonData = @JsonData
										  , @target	  = @target

				WAITFOR DELAY '00:00:0.050'

				SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Discount Member curdt: ' + convert(varchar(50), getdate(), 121)
				RAISERROR (@Msg, 0, 1) WITH NOWAIT
			END

		END
		ELSE
		BEGIN
			-- Collect data with Site <> 76666B

			--Collect Super, Master, Agent Setting Discount Need Insert Follow TOP 1 Super Headline
			INSERT INTO #DiscountSMA_Setting
			(
				  custid
				, sporttype
				, bettype
				, discount
			)
			SELECT
				cs.custid
			    , cs.sporttype
			    , cs.bettype
			    , CASE
					WHEN ps.bettype = 1				   THEN cs.groupa					-- GroupA
					WHEN ps.bettype = 3				   THEN cs.groupb					-- GroupB
					WHEN ps.bettype = 7				   THEN cs.groupc					-- GroupC
					WHEN ps.bettype = 8				   THEN cs.groupd					-- GroupD
					WHEN ps.bettype IN (4 , 5) AND ci.roleid = 4 THEN cs.sdiscount				-- 1x2 Comm ,  Others Comm
					WHEN ps.bettype IN (4 , 5) AND ci.roleid = 3 THEN cs.adiscount				-- 1x2 Comm ,  Others Comm
					WHEN ps.bettype IN (4 , 5) AND ci.roleid = 2 THEN cs.discount				-- 1x2 Comm ,  Others Comm	
				END
				AS Discount

			FROM custInfo ci WITH (NOLOCK)
			INNER JOIN custSetting cs WITH (NOLOCK)
				    ON cs.custid = ci.custid
			INNER JOIN #Tmp_ProductSetting ps
				    ON cs.sporttype = ps.sporttype
				    AND cs.bettype = ps.bettype
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid IN (2 , 3 , 4)
					AND ps.SettingType = 25

			WHILE (1 = 1)
			BEGIN
				TRUNCATE TABLE #CustAffected_SMADiscount

				DELETE TOP (@Batch) cas
				OUTPUT DELETED.custid , DELETED.sporttype , DELETED.bettype , DELETED.discount
					INTO #CustAffected_SMADiscount (custid , sporttype , bettype , discount)
				FROM #DiscountSMA_Setting cas

				IF    @@rowcount = 0
					BREAK;

				SELECT
					@JsonData = 
					(
						SELECT custid , sporttype , bettype , discount
						    FROM #CustAffected_SMADiscount
							FOR JSON PATH
					)
				EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'DiscountSMA'
										  , @JsonData = @JsonData
										  , @target	  = @target

				WAITFOR DELAY '00:00:0.050'
				
				SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Discount SMA curdt: ' + convert(varchar(50), getdate(), 121)
				RAISERROR (@Msg, 0, 1) WITH NOWAIT
			END

			-- Collect Member Setting Discount Need Insert Follow TOP 1 Super Headline
			INSERT INTO #DiscountMember_Setting
			(
				  custid
				, sporttype
				, bettype
				, playerdiscount
				, AgentDiscount
				, MasterDiscount
				, SuperDiscount
			)
			SELECT
				cs.custid
			    , cs.sporttype
			    , cs.bettype
			    , cs.playerdiscount
			    , cs.discount
			    , cs.adiscount
			    , cs.sdiscount
			FROM
				custInfo ci WITH (NOLOCK)
			INNER JOIN custSetting cs WITH (NOLOCK)
				    ON cs.custid = ci.custid
			INNER JOIN Customer c WITH (NOLOCK)
				    ON cs.custid = c.custid
			INNER JOIN #Tmp_ProductSetting ps
				    ON cs.sporttype = ps.sporttype
				    AND cs.bettype = ps.bettype
				WHERE
					ci.srecommend = @Srecommend
					AND ci.Enabled = 1
					AND ci.roleid = 1
					AND ps.SettingType = 25
					AND ( cs.bettype = CASE
									WHEN c.ugroup IN ('a' , 'hka' , 'dea') THEN 1
									WHEN c.ugroup IN ('b' , 'hkb' , 'deb') THEN 3
									WHEN c.ugroup IN ('c' , 'hkc' , 'dec') THEN 7
									WHEN c.ugroup IN ('d' , 'hkd' , 'ded') THEN 8
								  END 
					   OR cs.bettype IN (4 , 5)
					     )

			WHILE (1 = 1)
			BEGIN
				TRUNCATE TABLE #CustAffected_MemberDiscount

				DELETE TOP (@Batch) dms
				OUTPUT DELETED.custid , DELETED.sporttype , DELETED.bettype , DELETED.playerdiscount , DELETED.AgentDiscount , DELETED.MasterDiscount , DELETED.SuperDiscount
					INTO #CustAffected_MemberDiscount (custid , sporttype , bettype , playerdiscount , AgentDiscount , MasterDiscount , SuperDiscount)
				FROM
					#DiscountMember_Setting dms

				IF    @@rowcount = 0
					BREAK;

				SELECT @JsonData = 
					(
						SELECT custid , sporttype , bettype , playerdiscount , AgentDiscount , MasterDiscount , SuperDiscount
						    FROM #CustAffected_MemberDiscount
							FOR JSON PATH
					)
				EXEC dbo.[Acc_DynamicCustSetting3rd_19] @ModeCode = 'DiscountMember'
										  , @JsonData = @JsonData
										  , @target	  = @target

				WAITFOR DELAY '00:00:0.050'

				SET @Msg = 'Super' + CONVERT(VARCHAR(50) , @Srecommend) + ' end run for Discount Member curdt: ' + convert(varchar(50), getdate(), 121)
				RAISERROR (@Msg, 0, 1) WITH NOWAIT
			END

		END

	END



	DROP TABLE #TmpSuperInfo
	DROP TABLE #Tmp_ProductSetting
	DROP TABLE #DiscountSMA_Setting
	DROP TABLE #DiscountMember_Setting
	DROP TABLE #CustAffected_SMADiscount
	DROP TABLE #CustAffected_MemberDiscount