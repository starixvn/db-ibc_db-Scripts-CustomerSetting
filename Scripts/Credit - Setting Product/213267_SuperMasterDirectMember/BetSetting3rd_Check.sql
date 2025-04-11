/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From: DBA_CheckBetLimit_Credit_DCS
*/

BEGIN 

	SET NOCOUNT ON 	

	DECLARE @max_CustID  INT  = xxx

	DECLARE
	  @srecommend		INT	   = 0
	, @mrecommend		INT	   = 0
	, @recommend		INT	   = 0
	, @RuleId			SMALLINT = 0
	, @custid			INT	   = 0
	, @SportType		SMALLINT = 0
	-------------------PREPARATION: GET LIST SUPER/Master/Agent disabled FIRST----------------------------
		
	CREATE TABLE #CheckBetLimitResult_DCS (RuleId INT, SportType SMALLINT, BetType SMALLINT, CustIdA INT, CustIdB INT, ValueA MONEY, ValueB MONEY, CreatedDate DATETIME,IsDeposit INT)

	CREATE TABLE #List_DirectMember (srecommend INT , mrecommend INT , recommend INT , custid INT , is_read BIT DEFAULT (0) PRIMARY KEY CLUSTERED (srecommend , mrecommend , recommend , custid))


	CREATE TABLE #DCS_Super (custID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY, MaxPerNumber money)
	CREATE TABLE #DCS_Master (custID INT, UplineID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY, MaxPerNumber money)
	CREATE TABLE #DCS_Agent (custID INT,UplineID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY, MaxPerNumber money)
	CREATE TABLE #OfferedProductList(ProductID [tinyint],[SportType] [smallint] ,[BetType] [smallint], IsHidden BIT,RealProductID TINYINT)
	CREATE TABLE #GlobalSetting([SportType] [smallint] ,[BetType] [smallint], Maxbet [MONEY], Minbet [MONEY])
	
	DECLARE @SportBettypeFilter TABLE(SportType INT, Bettype INT, SettingType SMALLINT, BitmapOrder TINYINT, IsNewStructure BIT DEFAULT (1))
	DECLARE @currency INT,@Site VARCHAR(10), @SiteID INT, @Rowcount INT
	DECLARE @GlobalMaxBet money
	
	--product has offered stakelevel
	INSERT INTO #OfferedProductList (ProductID,SportType,BetType,IsHidden,RealProductID)
	SELECT DISTINCT ps.ProductId, ps.SportType, ps.BetType, ps.IsHidden,ps.RealProductId
	FROM ProductSettingProfile ps WITH (NOLOCK)
		INNER JOIN ProductSettingType s WITH (NOLOCK)
		ON ps.SettingType = s.SettingType
	WHERE s.SettingName = 'Product Status'  
		AND ps.SettingStatus = 0	
			


-- Create a table variable to store the results of the function logic : [f_GetSiteNotOffer]
	DECLARE @SiteFilter TABLE (site NVARCHAR(50))

	INSERT INTO @SiteFilter (site)
	SELECT site 
	FROM site WITH (NOLOCK)
	WHERE site IN ('IMBC', 'spotico', 'Y987') 
	   OR isLicensee = 1 
	   OR isActive = 0
	UNION ALL 
	SELECT 'Select'


	-- COLLECT DIRECT MEMBER & UPLINE
	INSERT INTO #List_DirectMember (srecommend , mrecommend , recommend, custid)
	SELECT TOP 10 i.srecommend , i.mrecommend , i.recommend , i.custid 
	FROM custInfo i WITH (NOLOCK) 
	INNER JOIN Customer c WITH (NOLOCK) ON i.custid = c.custid
	WHERE i.recommend IN (-3,-4)
	AND Enabled = 1 
	AND i.roleid = 1 
	--AND srecommend = 187899101
	AND i.Currency NOT IN (20,72,27,28)
	AND i.custid >= @max_CustID
	AND NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)	
	

	--SELECT '#List_DirectMember' AS NOTE  , * FROM #List_DirectMember

	IF EXISTS (SELECT TOP 1 1 FROM #List_DirectMember ldm)
	BEGIN
		WHILE (1=1)
		BEGIN
			SELECT TOP 1 
				@srecommend = ldm.srecommend,
				@mrecommend = ldm.mrecommend,
				@recommend = ldm.recommend,
				@custid = ldm.custid
			FROM #List_DirectMember ldm
			WHERE ldm.is_read = 0

			-- If no rows are found, break the loop
			IF @@ROWCOUNT = 0
				BREAK;

			-- Mark the row as processed
			UPDATE #List_DirectMember
			SET is_read = 1
			WHERE srecommend = @srecommend 
			  AND mrecommend = @mrecommend 
			  AND recommend = @recommend 
			  AND custid = @custid

			SELECT @currency = currency,@site = site 
			FROM customer WITH(NOLOCK)
			WHERE custid = @srecommend
	
			SELECT @SiteID = SiteID
			FROM site WITH(NOLOCK)
			WHERE site = @site

			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE stt.Currency = @Currency AND (stt.SiteID = @SiteID OR stt.SiteID = 0)
			
			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE (stt.Currency = @Currency OR stt.Currency = 0 ) AND stt.SiteID = @SiteID

			INSERT INTO @sportBettypeFilter (sportType,bettype,SettingType,IsNewStructure)
			SELECT ps.SportType,ps.BetType,ps.SettingType,CASE WHEN ps.GroupID = 4 THEN 0 ELSE 1 END
			FROM ProductSettingProfile ps WITH(NOLOCK)
				CROSS APPLY (	SELECT IsHidden
								FROM #OfferedProductList ps2
								WHERE ps2.RealProductId = ps.RealProductId 
									AND ps2.IsHidden = 0
							) ProductStatus
			WHERE SettingType in (2,9,16,20,23)
				AND SettingStatus = 0
				AND SportType NOT IN (151,152,153,154,162,50,206,255) -- AND sportType NOT IN (SELECT sportType FROM dbo.f_GetSportNotOffer(NULL))
				--AND sportType = CASE WHEN @sportType = 0 THEN sportType ELSE @sportType END
				--AND RealProductId <> 3-- Not check for NG, Happy5 (check on other sp)
				--AND SportType NOT IN (43,44,224)
			--UPDATE t
			--SET t.BitmapOrder = pl.bitmapOrder
			--FROM @SportBettypeFilter t
			--	INNER JOIN ProductStatusProfile pl WITH(NOLOCK) 
			--		ON pl.sporttype = t.sporttype 
			--		AND pl.bettype = t.bettype

			--SELECT @Rowcount = count(1)
			--FROM @SportBettypeFilter

			--IF @Rowcount = 0
			--	RETURN	

			TRUNCATE TABLE #GlobalSetting
			TRUNCATE TABLE #DCS_Super
			TRUNCATE TABLE #DCS_Master

			INSERT INTO #GlobalSetting(SportType,BetType,Maxbet,Minbet)
			SELECT s.Sporttype,s.Bettype,ISNULL(s.MaxBet,0),ISNULL(s.MinBet,0)
			FROM ProductBetSetting s WITH(NOLOCK) 
				INNER JOIN @SportBettypeFilter p ON p.SportType = s.Sporttype AND p.Bettype = s.Bettype AND p.SettingType = 20
			WHERE s.Currency = @currency 
				AND (ISNULL(s.MaxBet,0) <> 0 OR ISNULL(s.MinBet,0) <> 0)

			-- New table BetSetting3rd_Agent 
			INSERT INTO #DCS_Super (custID,SportType,BetType,minbet,maxbet,maxpermatch,MaxPerNumber)
			SELECT CPS.CustID,CPS.SportType,CPS.BetType,cps.MinBet,CPS.MaxBet,cps.MaxPerMatch,cps.MaxPerNumber
			FROM BetSetting3rd_Agent CPS (NOLOCK)
			INNER JOIN CustSuper CS WITH (NOLOCK)  ON CPS.CustID = CS.custid AND CS.IsInternal = 0
			INNER JOIN @SportBettypeFilter T ON T.SportType = CPS.SportType AND T.BetType = CPS.Bettype AND t.IsNewStructure = 1
			WHERE CPS.CustID = @srecommend
			AND (cps.MinBet <> 0 OR CPS.MaxBet <> 0 OR CPS.maxpermatch <> 0 OR CPS.MaxPerNumber <> 0)
		
			INSERT INTO #DCS_Master (custID,UplineID,SportType,BetType,minbet,maxbet,maxpermatch,MaxPerNumber)
			SELECT CPS.CustID,@srecommend,cps.SportType,cps.BetType,cps.MinBet,CPS.MaxBet,cps.MaxPerMatch,cps.MaxPerNumber
			FROM BetSetting3rd_Agent CPS (NOLOCK)
			INNER JOIN CustSuper CS WITH (NOLOCK)  ON CS.custid = @srecommend AND CS.IsInternal = 0 
			INNER JOIN @SportBettypeFilter T ON T.SportType = CPS.SportType AND T.BetType = CPS.Bettype AND t.IsNewStructure = 1
			WHERE CPS.CustID = @mrecommend
			AND (cps.MinBet <> 0 OR CPS.MaxBet <> 0 OR CPS.maxpermatch <> 0 OR CPS.MaxPerNumber <> 0)

			-------------------END OF PREPARATION: GET LIST SUPER/Master/Agent disabled FIRST----------------------------
			----------------------------FINAL RESULT ------------------------------------
			DECLARE @CreatedDate DATETIME = GETDATE()
		
			-- Rule 313: Missing bet limit setting, for DCS Products								
			--IF @RuleId IN (0,313)
			--BEGIN
			--	----INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			--	------------------------Check Old structure--------------------
			--	--SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	--FROM custInfo CI WITH (NOLOCK)
			--	--	INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--	--	CROSS JOIN @SportBettypeFilter AS T3 
			--	--	INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	--WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Super T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--	--	AND NOT EXISTS (SELECT 1 FROM CustBetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)
			--	--	AND CI.roleid = 4
			--	--	AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)	
			--	--	AND ci.srecommend = @srecommend
			--	--	AND CI.Enabled = 1
			--	--	AND CI.Currency NOT IN (20,72,27,28)
			--	--	AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--	--	AND t3.IsNewStructure = 0	
			--	--UNION ALL	
			--	--SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	--FROM custInfo CI WITH (NOLOCK)
			--	--	INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--	--	CROSS JOIN @SportBettypeFilter AS T3
			--	--	INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	--WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Master T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--	--	AND NOT EXISTS (SELECT 1 FROM CustBetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--	--	AND CI.roleid = 3
			--	--	AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--	--	AND ci.srecommend = @srecommend
			--	--	AND CI.Enabled = 1
			--	--	AND CI.Currency NOT IN (20,72,27,28)
			--	--	AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--	--	AND t3.IsNewStructure = 0
			--	--UNION ALL	
			--	--SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	--FROM custInfo CI WITH (NOLOCK)
			--	--	INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--	--	CROSS JOIN @SportBettypeFilter AS T3
			--	--	INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	--WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Agent T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--	--	AND NOT EXISTS (SELECT 1 FROM CustBetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--	--	AND CI.roleid = 2
			--	--	AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--	--	AND ci.srecommend = @srecommend
			--	--	AND CI.Enabled = 1
			--	--	AND CI.Currency NOT IN (20,72,27,28)
			--	--	AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--	--	AND t3.IsNewStructure = 0
			--	--UNION ALL	
			--	--SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	--FROM custInfo CI WITH (NOLOCK)
			--	--	INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--	--	CROSS JOIN @SportBettypeFilter AS T3
			--	--	INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	--WHERE NOT EXISTS (SELECT 1 FROM CustBetSetting3rd_Member T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--	--	AND CI.roleid = 1
			--	--	AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--	--	AND ci.srecommend = @srecommend
			--	--	AND CI.Enabled = 1
			--	--	AND CI.Currency NOT IN (20,72,27,28)
			--	--	AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--	--	AND t3.IsNewStructure = 0
			--	--UNION ALL 
			--	----------------------Check New structure--------------------
			--	SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	FROM custInfo CI WITH (NOLOCK)
			--		INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--		CROSS JOIN @SportBettypeFilter AS T3 
			--		INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Super T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--		AND NOT EXISTS (SELECT 1 FROM BetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)
			--		AND CI.roleid = 4
			--		AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)	
			--		AND ci.srecommend = @srecommend
			--		AND CI.Enabled = 1
			--		AND CI.Currency NOT IN (20,72,27,28)
			--		AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--		AND t3.IsNewStructure = 1	
			--	UNION ALL	
			--	SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	FROM custInfo CI WITH (NOLOCK)
			--		INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--		CROSS JOIN @SportBettypeFilter AS T3
			--		INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Master T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--		AND NOT EXISTS (SELECT 1 FROM BetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--		AND CI.roleid = 3
			--		AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--		AND ci.srecommend = @srecommend
			--		AND CI.Enabled = 1
			--		AND CI.Currency NOT IN (20,72,27,28)
			--		AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--		AND t3.IsNewStructure = 1
			--	UNION ALL	
			--	SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	FROM custInfo CI WITH (NOLOCK)
			--		INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--		CROSS JOIN @SportBettypeFilter AS T3
			--		INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Agent T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--		AND NOT EXISTS (SELECT 1 FROM BetSetting3rd_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--		AND CI.roleid = 2
			--		AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--		AND ci.srecommend = @srecommend
			--		AND CI.Enabled = 1
			--		AND CI.Currency NOT IN (20,72,27,28)
			--		AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--		AND t3.IsNewStructure = 1
			--	UNION ALL	
			--	SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--	FROM custInfo CI WITH (NOLOCK)
			--		INNER JOIN customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
			--		CROSS JOIN @SportBettypeFilter AS T3
			--		INNER JOIN CustProductStatus cps WITH(NOLOCK) ON ci.custid = cps.CustID
			--	WHERE NOT EXISTS (SELECT 1 FROM BetSetting3rd_Member T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--		AND CI.roleid = 1
			--		AND	NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)
			--		AND ci.srecommend = @srecommend
			--		AND CI.Enabled = 1
			--		AND CI.Currency NOT IN (20,72,27,28)
			--		AND f_GetProductStatus (cps.bitmapIsHidden,T3.bitmapOrder) = 0 
			--		AND t3.IsNewStructure = 1		
			--END
	
			-- Rule 314: minbet < 0								
			IF @RuleId IN (0,314)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
				FROM #DCS_Super T1
				WHERE T1.minbet < 0
		
				UNION ALL
		
				SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
				FROM #DCS_Master T1
				WHERE T1.minbet < 0
		
				UNION ALL
		
				SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
				FROM #DCS_Agent T1
				WHERE T1.minbet < 0
		
		
				--UNION ALL
		
				--SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T1 WITH (NOLOCK)
				--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				--	INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 0
				--WHERE T1.minbet < 0
				--	AND ci.srecommend = @srecommend
				--	AND ci.roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)

				UNION ALL
		
				SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype  AND IsNewStructure = 1
				WHERE T1.minbet < 0
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
		
			END
	
			-- Rule 315: maxbet < 0										
			IF @RuleId IN (0,315)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
				FROM #DCS_Super T1
				WHERE T1.maxbet < 0
		
				UNION ALL
		
				SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
				FROM #DCS_Master T1
				WHERE T1.maxbet < 0
		
				UNION ALL
		
				SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
				FROM #DCS_Agent T1
				WHERE T1.maxbet < 0
		
		
				--UNION ALL
		
				--SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T1 WITH (NOLOCK)
				--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				--	INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 0
				--WHERE T1.maxbet < 0
				--	AND ci.srecommend = @srecommend
				--	AND ci.roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)

				UNION ALL
		
				SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 1
				WHERE T1.maxbet < 0
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
		
			END
	
			-- Rule 316: max per match < 0								
			IF @RuleId IN (0,316)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
				FROM #DCS_Super T1
				WHERE T1.maxpermatch < 0
		
				UNION ALL
		
				SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
				FROM #DCS_Master T1
				WHERE T1.maxpermatch < 0
		
				UNION ALL
		
				SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
				FROM #DCS_Agent T1
				WHERE T1.maxpermatch < 0
		
		
				--UNION ALL
		
				--SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T1 WITH (NOLOCK)
				--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				--	INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 0
				--WHERE T1.maxpermatch < 0
				--	AND ci.srecommend = @srecommend
				--	AND ci.roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)

				UNION ALL
		
				SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 1
				WHERE T1.maxpermatch < 0
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
		
			END

			-- Rule 340: max per number < 0								
			IF @RuleId IN (0,340)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 340,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPerNumber,T1.MaxPerNumber,@CreatedDate,0
				FROM #DCS_Super T1
				WHERE T1.MaxPerNumber < 0
		
				UNION ALL
		
				SELECT 340,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPerNumber,T1.MaxPerNumber,@CreatedDate,0
				FROM #DCS_Master T1
				WHERE T1.MaxPerNumber < 0
		
				UNION ALL
		
				SELECT 340,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPerNumber,T1.MaxPerNumber,@CreatedDate,0
				FROM #DCS_Agent T1
				WHERE T1.MaxPerNumber < 0

				UNION ALL
		
				SELECT 340,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPerNumber,T1.MaxPerNumber,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN @SportBettypeFilter P ON T1.SportType = p.SportType AND T1.BetType = p.Bettype AND IsNewStructure = 1
				WHERE T1.MaxPerNumber < 0
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
		
			END

			-- Rule 329: Maxbet > Global Maxbet -- only settingtype = 20								
			IF @RuleId IN (0,329)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 329,T1.SportType,T1.BetType,T1.custID,0,T1.maxbet,T2.Maxbet,@CreatedDate,0
				FROM #DCS_Super T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Maxbet <> 0
				WHERE T1.maxbet > T2.Maxbet AND T1.Maxbet >= 1
				UNION ALL
				SELECT 329,T1.SportType,T1.BetType,T1.custID,0,T1.maxbet,T2.Maxbet,@CreatedDate,0
				FROM #DCS_Master T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Maxbet <> 0
				WHERE T1.maxbet > T2.Maxbet AND T1.Maxbet >= 1
				UNION ALL
				SELECT 329,T1.SportType,T1.BetType,T1.custID,0,T1.maxbet,T2.Maxbet,@CreatedDate,0
				FROM #DCS_Agent T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Maxbet <> 0
				WHERE T1.maxbet > T2.Maxbet AND T1.Maxbet >= 1
				--UNION ALL
				--SELECT 329,T1.SportType,T1.BetType,T1.custID,0,T1.maxbet,T2.Maxbet,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T1 WITH (NOLOCK)
				--	INNER JOIN custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				--	INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Maxbet <> 0
				--WHERE T1.MaxBet > t2.Maxbet AND T1.Maxbet >= 1
				--	AND ci.srecommend = @srecommend
				--	AND ci.roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)

				UNION ALL
				SELECT 329,T1.SportType,T1.BetType,T1.custID,0,T1.maxbet,T2.Maxbet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Maxbet <> 0
				WHERE T1.MaxBet > t2.Maxbet AND T1.Maxbet >= 1
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
			END

			IF @RuleId IN (0,330) -- Minbet < Global Minbet -- only settingtype = 20	
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 330,T1.SportType,T1.BetType,T1.custID,0,T1.minbet,T2.minbet,@CreatedDate,0
				FROM #DCS_Super T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Minbet <> 0
				WHERE T1.minbet < T2.Minbet AND T1.Maxbet >= 1
				UNION ALL
				SELECT 330,T1.SportType,T1.BetType,T1.custID,0,T1.minbet,T2.minbet,@CreatedDate,0
				FROM #DCS_Master T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Minbet <> 0
				WHERE T1.minbet < T2.Minbet AND T1.Maxbet >= 1
				UNION ALL
				SELECT 330,T1.SportType,T1.BetType,T1.custID,0,T1.minbet,T2.minbet,@CreatedDate,0
				FROM #DCS_Agent T1
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Minbet <> 0
				WHERE T1.minbet < T2.Minbet AND T1.Maxbet >= 1
				--UNION ALL
				--SELECT 330,T1.SportType,T1.BetType,T1.custID,0,T1.minbet,T2.minbet,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T1 WITH (NOLOCK)
				--	INNER JOIN custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				--	INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Minbet <> 0
				--WHERE T1.minbet < T2.Minbet AND T1.Maxbet >= 1
				--	AND ci.srecommend = @srecommend
				--	AND ci.roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)

				UNION ALL
				SELECT 330,T1.SportType,T1.BetType,T1.custID,0,T1.minbet,T2.minbet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN #GlobalSetting T2 ON t1.SportType = t2.SportType AND t1.BetType = t2.BetType AND t2.Minbet <> 0
				WHERE T1.minbet < T2.Minbet AND T1.Maxbet >= 1
					AND ci.srecommend = @srecommend
					AND ci.roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
			END
	
	
			-- Rule 350: MaxBet < Upline.MaxBet
			IF @RuleId IN (0,350)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
				FROM #DCS_Master T1
					INNER JOIN #DCS_Super T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
		
				UNION ALL
		
				SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
				FROM #DCS_Agent T1
					INNER JOIN #DCS_Master T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
		
				UNION ALL
		
				SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN #DCS_Agent T2 ON ci.recommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND  T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
					AND T1.SportType NOT IN (43,44,224)

				UNION ALL
		
				SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -3
					INNER JOIN #DCS_Master T2 ON ci.mrecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND  T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
					AND T1.SportType NOT IN (43,44,224)

				UNION ALL
		
				SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -4
					INNER JOIN #DCS_Super T2 ON ci.srecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND  T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
					AND T1.SportType NOT IN (43,44,224)
			END
	
			-- Rule 346: MaxPerMatch < Upline.MaxPerMatch
			IF @RuleId IN (0,346)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
				FROM #DCS_Master T1
					INNER JOIN #DCS_Super T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
		
				UNION ALL
		
				SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
				FROM #DCS_Agent T1
					INNER JOIN #DCS_Master T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
		
				UNION ALL
		
				SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
					INNER JOIN #DCS_Agent T2 ON ci.recommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
					AND T1.SportType NOT IN (43,44,224)

				UNION ALL
		
				SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -3
					INNER JOIN #DCS_Master T2 ON ci.mrecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
					AND T1.SportType NOT IN (43,44,224)

				UNION ALL
		
				SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
				FROM BetSetting3rd_Member T1 WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -4
					INNER JOIN #DCS_Super T2 ON ci.srecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
					AND T1.SportType NOT IN (43,44,224)
			END
			
			-- Rule 327: MaxBet < MaxPerMatch
			IF @RuleId IN (0,327)
			BEGIN
				INSERT INTO #CheckBetLimitResult_DCS (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
				SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
				FROM #DCS_Super T 
				WHERE MaxBet > MaxPerMatch
		
				UNION ALL
		
				SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
				FROM #DCS_Master T 
				WHERE MaxBet > MaxPerMatch
		
				UNION ALL
		
				SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
				FROM #DCS_Agent T 
				WHERE MaxBet > MaxPerMatch
		
				--UNION ALL
		
				--SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
				--FROM CustBetSetting3rd_Member T WITH (NOLOCK)
				--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T.CustID = CI.custid
				--WHERE ci.srecommend = @srecommend
				--	AND roleid = 1
				--	AND CI.Enabled = 1
				--	AND CI.Currency NOT IN (20,72,27,28)
				--	AND MaxBet > MaxPerMatch
				--	AND T.SportType NOT IN (43,44,224)

				UNION ALL
		
				SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
				FROM BetSetting3rd_Member T WITH (NOLOCK)
					INNER JOIN  custInfo CI WITH (NOLOCK) ON T.CustID = CI.custid
				WHERE ci.srecommend = @srecommend
					AND roleid = 1
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)
					AND MaxBet > MaxPerMatch
					AND T.SportType NOT IN (43,44,224)
			END		
	
		END

	END
	
	SELECT * FROM #CheckBetLimitResult_DCS

	DROP TABLE #DCS_Agent
	DROP TABLE #DCS_Master
	DROP TABLE #DCS_Super
	DROP TABLE #GlobalSetting
	DROP TABLE #OfferedProductList
	DROP TABLE #List_DirectMember
	DROP TABLE #CheckBetLimitResult_DCS

	SET NOCOUNT OFF	
		
END