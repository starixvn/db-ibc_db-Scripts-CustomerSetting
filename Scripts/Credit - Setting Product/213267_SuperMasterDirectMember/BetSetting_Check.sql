/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From: DBA_CheckBetLimit_Credit 
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
	CREATE TABLE #SportTypeCheck (SportType SMALLINT, BetType SMALLINT, PRIMARY KEY (BetType,SportType) )	
	INSERT INTO #SportTypeCheck (SportType,BetType)
	SELECT ps.SportType,ps.BetType
	FROM ProductSettingProfile ps WITH(NOLOCK)
	WHERE SettingType in (26)
		AND SettingStatus = 0
		AND SportType NOT IN (151,152,153,154,162,50,206,255) -- AND sportType NOT IN (SELECT sportType FROM dbo.f_GetSportNotOffer(NULL))
		AND sportType = CASE WHEN @sportType = 0 THEN sportType ELSE @sportType END
		AND RealProductId IN (1)

	CREATE TABLE #DCS_Super (custID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY
							, MaxPayoutPerMatch money, PRIMARY KEY (custID,Bettype,SportType))
	
	CREATE TABLE #DCS_Master (custID INT, UplineID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY
							, MaxPayoutPerMatch money, PRIMARY KEY (custID,Bettype,SportType))
	
	--CREATE TABLE #DCS_Agent (custID INT,UplineID INT,SportType SMALLINT, BetType SMALLINT, minbet MONEY, maxbet MONEY, maxpermatch MONEY
	--						, MaxPayoutPerMatch money, PRIMARY KEY (custID,Bettype,SportType))

	CREATE TABLE #CheckBetLimitResult (RuleId INT, SportType SMALLINT, BetType SMALLINT, CustIdA INT, CustIdB INT, ValueA MONEY, ValueB MONEY, CreatedDate DATETIME,IsDeposit INT)

	DECLARE @SiteFilter TABLE (site NVARCHAR(50))

	INSERT INTO @SiteFilter (site)
	SELECT site 
	FROM site WITH (NOLOCK)
	WHERE site IN ('IMBC', 'spotico', 'Y987') 
	   OR isLicensee = 1 
	   OR isActive = 0
	UNION ALL 
	SELECT 'Select'


	CREATE TABLE #List_DirectMember (srecommend INT , mrecommend INT , recommend INT , custid INT , is_read BIT DEFAULT (0) PRIMARY KEY CLUSTERED (srecommend , mrecommend , recommend , custid))
	

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

		
		TRUNCATE TABLE #DCS_Super
		TRUNCATE TABLE #DCS_Master
			
		INSERT INTO #DCS_Super (custID,SportType,BetType,minbet,maxbet,maxpermatch,MaxPayoutPerMatch)
		SELECT CPS.CustID,CPS.SportType,CPS.BetType,cps.MinBet,CPS.MaxBet,CPS.maxpermatch,cps.MaxPayoutPerMatch
		FROM BetSetting_Agent CPS (NOLOCK)
			INNER JOIN CustSuper CS WITH (NOLOCK)  ON CPS.custid = CS.custid AND CS.IsInternal = 0
			INNER JOIN #SportTypeCheck S ON CPS.SportType = s.SportType AND CPS.BetType = s.BetType
		WHERE CPS.CustID = @srecommend
		AND (cps.MinBet <> 0 OR CPS.MaxBet <> 0 OR CPS.maxpermatch <> 0 OR CPS.MaxPayoutPerMatch <> 0)
		
		
		INSERT INTO #DCS_Master (custID,UplineID,SportType,BetType,minbet,maxbet,maxpermatch,MaxPayoutPerMatch)
		SELECT CPS.CustID,@srecommend,CPS.SportType,CPS.BetType,cps.MinBet,CPS.MaxBet,CPS.maxpermatch,cps.MaxPayoutPerMatch
		FROM BetSetting_Agent CPS (NOLOCK)
			INNER JOIN CustSuper CS WITH (NOLOCK)  ON CS.custid = @srecommend AND CS.IsInternal = 0 
			INNER JOIN #SportTypeCheck S ON CPS.SportType = s.SportType AND CPS.BetType = s.BetType
		WHERE CPS.CustID = @mrecommend
		AND (cps.MinBet <> 0 OR CPS.MaxBet <> 0 OR CPS.maxpermatch <> 0 OR CPS.MaxPayoutPerMatch <> 0)	
		
		
		-------------------END OF PREPARATION: GET LIST SUPER/Master/Agent disabled FIRST----------------------------
		----------------------------FINAL RESULT ------------------------------------
		DECLARE @CreatedDate DATETIME = GETDATE()
		
		-- Rule 313: Missing bet limit setting
		IF @RuleId IN (0,313)
		BEGIN
			-- New table
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			FROM custInfo CI WITH (NOLOCK)
				CROSS JOIN #SportTypeCheck AS T3
			WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Super T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
				AND NOT EXISTS (SELECT 1 FROM BetSetting_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)
				AND CI.roleid = 4
				AND ci.srecommend = @srecommend
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				
			UNION ALL	
		
			SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			FROM custInfo CI WITH (NOLOCK)
				CROSS JOIN #SportTypeCheck AS T3
			WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Master T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
				AND NOT EXISTS (SELECT 1 FROM BetSetting_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
				AND CI.roleid = 3
				AND ci.srecommend = @srecommend
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
		
			UNION ALL	
		
			--SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			--FROM custInfo CI WITH (NOLOCK)
			--	CROSS JOIN #SportTypeCheck AS T3
			--WHERE CI.custid NOT IN (SELECT custID FROM #DCS_Agent T5 WHERE T5.SportType = T3.SportType AND T5.BetType = T3.BetType)
			--	AND NOT EXISTS (SELECT 1 FROM BetSetting_Agent T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
			--	AND CI.roleid = 2
			--	AND ci.srecommend = @srecommend
			--	AND CI.Enabled = 1
			--	AND CI.Currency NOT IN (20,72,27,28)
		
			--UNION ALL	
		
			SELECT 313,T3.SportType,T3.BetType,CI.custID,CI.custID,NULL,NULL,@CreatedDate,0
			FROM custInfo CI WITH (NOLOCK)
				CROSS JOIN #SportTypeCheck AS T3
			WHERE NOT EXISTS (SELECT 1 FROM BetSetting_Member T4 WITH (NOLOCK) WHERE T4.custid = CI.CustID AND T4.SportType = T3.SportType AND T4.BetType = T3.BetType)		
				AND CI.roleid = 1
				AND ci.srecommend = @srecommend
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)	
	
		END
		-- Rule 314: minbet < 0								
		IF @RuleId IN (0,314)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
			FROM #DCS_Super T1
			WHERE T1.minbet < 0
		
			UNION ALL
		
			SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
			FROM #DCS_Master T1
			WHERE T1.minbet < 0
		
			UNION ALL
		
			--SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
			--FROM #DCS_Agent T1
			--WHERE T1.minbet < 0
		
			--UNION ALL
		
			SELECT 314,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.minbet,T1.minbet,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				INNER JOIN #SportTypeCheck S ON T1.SportType = S.SportType AND T1.Bettype = S.Bettype
			WHERE T1.minbet < 0
				AND ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
		
		END
	
		-- Rule 315: maxbet < 0										
		IF @RuleId IN (0,315)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
			FROM #DCS_Super T1
			WHERE T1.maxbet < 0
		
			UNION ALL
		
			SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
			FROM #DCS_Master T1
			WHERE T1.maxbet < 0
		
			UNION ALL
		
			--SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
			--FROM #DCS_Agent T1
			--WHERE T1.maxbet < 0
		
			--UNION ALL
		
			SELECT 315,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxbet,T1.maxbet,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				INNER JOIN #SportTypeCheck S ON T1.SportType = S.SportType AND T1.Bettype = S.Bettype
			WHERE T1.maxbet < 0
				AND ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
		
		END
	
		-- Rule 316: max per match < 0								
		IF @RuleId IN (0,316)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
			FROM #DCS_Super T1
			WHERE T1.maxpermatch < 0
		
			UNION ALL
		
			SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
			FROM #DCS_Master T1
			WHERE T1.maxpermatch < 0
		
			UNION ALL
		
			--SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
			--FROM #DCS_Agent T1
			--WHERE T1.maxpermatch < 0

			--UNION ALL
		
			SELECT 316,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.maxpermatch,T1.maxpermatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				INNER JOIN #SportTypeCheck S ON T1.SportType = S.SportType AND T1.Bettype = S.Bettype
			WHERE T1.maxpermatch < 0
				AND ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
		
		END

		-- Rule 341: max payout per match < 0							
		IF @RuleId IN (0,341)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 341,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPayoutPerMatch,T1.MaxPayoutPerMatch,@CreatedDate,0
			FROM #DCS_Super T1
			WHERE T1.MaxPayoutPerMatch < 0
		
			UNION ALL
		
			SELECT 341,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPayoutPerMatch,T1.MaxPayoutPerMatch,@CreatedDate,0
			FROM #DCS_Master T1
			WHERE T1.MaxPayoutPerMatch < 0
		
			UNION ALL
		
			--SELECT 341,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPayoutPerMatch,T1.MaxPayoutPerMatch,@CreatedDate,0
			--FROM #DCS_Agent T1
			--WHERE T1.MaxPayoutPerMatch < 0
		
			--UNION ALL
		
			SELECT 341,T1.SportType,T1.BetType,T1.custID,T1.custID,T1.MaxPayoutPerMatch,T1.MaxPayoutPerMatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
				INNER JOIN #SportTypeCheck S ON T1.SportType = S.SportType AND T1.Bettype = S.Bettype
			WHERE T1.MaxPayoutPerMatch < 0
				AND ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
		
		END
	
		-- Rule 350: MaxBet < Upline.MaxBet
		IF @RuleId IN (0,350)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
			FROM #DCS_Master T1
				INNER JOIN #DCS_Super T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
		
			--UNION ALL
		
			--SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
			--FROM #DCS_Agent T1
			--	INNER JOIN #DCS_Master T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE T2.MaxBet > 0 AND T1.MaxBet > T2.MaxBet
		
			--UNION ALL
		
			--SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
			--FROM BetSetting_Member T1 WITH (NOLOCK)
			--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
			--	INNER JOIN #DCS_Agent T2 ON ci.recommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE ci.srecommend = @srecommend
			--	AND roleid = 1
			--	AND CI.Enabled = 1
			--	AND CI.Currency NOT IN (20,72,27,28)
			--	AND T1.MaxBet > T2.MaxBet
			--	AND T2.MaxBet > 0	

			UNION ALL -- master direct member
		
			SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -3
				INNER JOIN #DCS_Master T2 ON ci.mrecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T1.MaxBet > T2.MaxBet
				AND T2.MaxBet > 0
			
			UNION ALL -- super direct member
		
			SELECT 350,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxBet,T2.MaxBet,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -4
				INNER JOIN #DCS_Super T2 ON ci.srecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T1.MaxBet > T2.MaxBet
				AND T2.MaxBet > 0
		END
	
		-- Rule 346: MaxPerMatch < Upline.MaxPerMatch
		IF @RuleId IN (0,346)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
			FROM #DCS_Master T1
				INNER JOIN #DCS_Super T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
		
			--UNION ALL
		
			--SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
			--FROM #DCS_Agent T1
			--	INNER JOIN #DCS_Master T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch
		
			--UNION ALL
		
			--SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
			--FROM BetSetting_Member T1 WITH (NOLOCK)
			--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
			--	INNER JOIN #DCS_Agent T2 ON ci.recommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE ci.srecommend = @srecommend
			--	AND roleid = 1
			--	AND CI.Enabled = 1
			--	AND CI.Currency NOT IN (20,72,27,28)
			--	AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch	

			UNION ALL
		
			SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid  AND ci.recommend = -3
				INNER JOIN #DCS_Master T2 ON ci.mrecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch	

			UNION ALL
		
			SELECT 346,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPerMatch,T2.MaxPerMatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid  AND ci.recommend = -4
				INNER JOIN #DCS_Super T2 ON ci.srecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T2.MaxPerMatch > 0 AND T1.MaxPerMatch > T2.MaxPerMatch	
		END
	
		-- Rule 347: MaxPayoutPerMatch < Upline.MaxPayoutPerMatch
		IF @RuleId IN (0,347)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 347,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPayoutPerMatch,T2.MaxPayoutPerMatch,@CreatedDate,0
			FROM #DCS_Master T1
				INNER JOIN #DCS_Super T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE T2.MaxPayoutPerMatch > 0 AND T1.MaxPayoutPerMatch > T2.MaxPayoutPerMatch
		
			--UNION ALL
		
			--SELECT 347,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPayoutPerMatch,T2.MaxPayoutPerMatch,@CreatedDate,0
			--FROM #DCS_Agent T1
			--	INNER JOIN #DCS_Master T2 ON T1.UplineID = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE T2.MaxPayoutPerMatch > 0 AND T1.MaxPayoutPerMatch > T2.MaxPayoutPerMatch
		
			--UNION ALL
		
			--SELECT 347,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPayoutPerMatch,T2.MaxPayoutPerMatch,@CreatedDate,0
			--FROM BetSetting_Member T1 WITH (NOLOCK)
			--	INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid
			--	INNER JOIN #DCS_Agent T2 ON ci.recommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			--WHERE ci.srecommend = @srecommend
			--	AND roleid = 1
			--	AND CI.Enabled = 1
			--	AND CI.Currency NOT IN (20,72,27,28)
			--	AND T2.MaxPayoutPerMatch > 0 AND T1.MaxPayoutPerMatch > T2.MaxPayoutPerMatch
			
			UNION ALL
		
			SELECT 347,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPayoutPerMatch,T2.MaxPayoutPerMatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -3
				INNER JOIN #DCS_Master T2 ON ci.mrecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T2.MaxPayoutPerMatch > 0 AND T1.MaxPayoutPerMatch > T2.MaxPayoutPerMatch

			UNION ALL
		
			SELECT 347,T1.SportType,T1.BetType,T1.custID,T2.custID,T1.MaxPayoutPerMatch,T2.MaxPayoutPerMatch,@CreatedDate,0
			FROM BetSetting_Member T1 WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T1.CustID = CI.custid AND ci.recommend = -4
				INNER JOIN #DCS_Super T2 ON ci.srecommend = T2.CustID AND T1.SportType = T2.SportType AND T1.Bettype = T2.Bettype
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND T2.MaxPayoutPerMatch > 0 AND T1.MaxPayoutPerMatch > T2.MaxPayoutPerMatch
		END
						
		-- Rule 327: MaxBet < MaxPerMatch
		IF @RuleId IN (0,327)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
			FROM #DCS_Super T 
			WHERE MaxBet > MaxPerMatch
		
			UNION ALL
		
			SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
			FROM #DCS_Master T 
			WHERE MaxBet > MaxPerMatch
		
			--UNION ALL
		
			--SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
			--FROM #DCS_Agent T 
			--WHERE MaxBet > MaxPerMatch
		
			UNION ALL
		
			SELECT 327,T.SportType,T.BetType,T.custID,T.custID,T.MaxBet,T.MaxPerMatch,@CreatedDate,0
			FROM BetSetting_Member T WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T.CustID = CI.custid
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND MaxBet > MaxPerMatch
		END		
			
		-- Rule 344: MaxPerMatch < MaxPayoutPerMatch
		IF @RuleId IN (0,344)
		BEGIN
			INSERT INTO #CheckBetLimitResult (RuleId, SportType, BetType, CustIdA, CustIdB, ValueA, ValueB, CreatedDate,IsDeposit )
			SELECT 344,T.SportType,T.BetType,T.custID,T.custID,T.MaxPerMatch,T.MaxPayoutPerMatch,@CreatedDate,0
			FROM #DCS_Super T 
			WHERE MaxPerMatch > MaxPayoutPerMatch
				AND T.SportType NOT IN (161,164,43,44)
		
			UNION ALL
		
			SELECT 344,T.SportType,T.BetType,T.custID,T.custID,T.MaxPerMatch,T.MaxPayoutPerMatch,@CreatedDate,0
			FROM #DCS_Master T 
			WHERE MaxPerMatch > MaxPayoutPerMatch
				AND T.SportType NOT IN (161,164,43,44)
		
			--UNION ALL
		
			--SELECT 344,T.SportType,T.BetType,T.custID,T.custID,T.MaxPerMatch,T.MaxPayoutPerMatch,@CreatedDate,0
			--FROM #DCS_Agent T 
			--WHERE MaxPerMatch > MaxPayoutPerMatch
				AND T.SportType NOT IN (161,164,43,44)
		
			UNION ALL
		
			SELECT 344,T.SportType,T.BetType,T.custID,T.custID,T.MaxPerMatch,T.MaxPayoutPerMatch,@CreatedDate,0
			FROM BetSetting_Member T WITH (NOLOCK)
				INNER JOIN  custInfo CI WITH (NOLOCK) ON T.CustID = CI.custid
			WHERE ci.srecommend = @srecommend
				AND roleid = 1
				AND CI.Enabled = 1
				AND CI.Currency NOT IN (20,72,27,28)
				AND MaxPerMatch > MaxPayoutPerMatch
				AND T.SportType NOT IN (161,164,43,44)
		END
	

		END
	END



	SELECT *
	FROM #CheckBetLimitResult 

	--DROP TABLE #DCS_Agent
	DROP TABLE #DCS_Master
	DROP TABLE #DCS_Super
	DROP TABLE #SportTypeCheck
	DROP TABLE #List_DirectMember
	DROP TABLE #CheckBetLimitResult

	SET NOCOUNT OFF	
END
GO
