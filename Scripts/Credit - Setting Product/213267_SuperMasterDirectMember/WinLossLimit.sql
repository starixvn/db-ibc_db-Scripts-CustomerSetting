/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From: DBA_CheckWinLossLimitDCS_Credit
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

	
	CREATE TABLE #SuperWinLossLimit (custid INT, sporttype SMALLINT, bettype SMALLINT, MaxWinLimit SMALLMONEY, MaxLossLimit	money, IsAutoReset BIT, PRIMARY KEY(CustID,SportType,Bettype))
	CREATE TABLE #MasterWinLossLimit (custid INT, sporttype SMALLINT, bettype SMALLINT, MaxWinLimit SMALLMONEY, MaxLossLimit	money, IsAutoReset BIT, PRIMARY KEY(CustID,SportType,Bettype))
	--CREATE TABLE #AgentWinLossLimit (custid INT, mrecommend INT, sporttype SMALLINT, bettype SMALLINT, MaxWinLimit SMALLMONEY, MaxLossLimit	money, IsAutoReset BIT, PRIMARY KEY(CustID,SportType,Bettype))
	CREATE TABLE #MemberWinLossLimit (custid INT, recommend INT, mrecommend INT, sporttype SMALLINT, bettype SMALLINT, MaxWinLimit SMALLMONEY, MaxLossLimit	money, IsAutoReset BIT, PRIMARY KEY(CustID,SportType,Bettype))
	DECLARE @SportBettype TABLE (ProductID INT, sporttype INT, bettype INT, WinLimit BIT)
	DECLARE @currency INT, @Site VARCHAR(10), @SiteID INT

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
	
	CREATE TABLE #CheckWinLossLimitResult_Credit (RuleID INT,SportType INT,bettype INT,CustIDA INT,CustIDB INT,ValueA SMALLMONEY,ValueB SMALLMONEY)  
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
	AND i.Currency NOT IN (20,27,28)
	AND i.custid >= @max_CustID
	AND NOT EXISTS (SELECT 1 FROM @SiteFilter AS nos WHERE nos.site = c.site)	
	
	CREATE TABLE #OfferedProductList(
		[ProductID] [tinyint] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsHidden] [BIT] NOT NULL
	)

	INSERT INTO #OfferedProductList (ProductID, SportType, BetType, IsHidden)
	SELECT DISTINCT ps.RealProductId, ps.SportType, ps.BetType, ps.IsHidden
	FROM ProductSettingProfile ps WITH (NOLOCK)
		INNER JOIN ProductSettingType s WITH (NOLOCK)
		ON ps.SettingType = s.SettingType
	WHERE s.SettingName = 'Product Status'  
		AND ps.SettingStatus = 0

	INSERT INTO @SportBettype (productID,sporttype,bettype,WinLimit)
	SELECT ps.productID,ps.sporttype,ps.bettype, CASE WHEN SettingType = 12 THEN 0 ELSE 1 END
	FROM ProductSettingProfile ps WITH(NOLOCK) 
		INNER JOIN #OfferedProductList op ON ps.Sporttype = op.SportType AND ps.Bettype = OP.BetType
	WHERE ps.SettingType in (6,12,22)
		AND ps.SettingStatus = 0
		AND op.IsHidden = 0
		AND ps.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 

	INSERT INTO @SportBettype (productID,sporttype,bettype,WinLimit)
	SELECT DISTINCT ps.productID,ps.sporttype,ps.bettype, 1
	FROM ProductSettingProfile ps WITH(NOLOCK) 
		INNER JOIN SportBettypeSettingMatrix m WITH (NOLOCK)
			ON ps.Sporttype = m.SporttypeRefWinlossLimit AND ps.Bettype = m.BettypeRefWinlossLimit
			AND m.isLicensee = 0 AND m.Site = 'ALL' AND m.isDeleted = 0
		INNER JOIN #OfferedProductList op 
			ON  op.SportType = m.SportType
			AND CASE WHEN op.BetType = 1024 THEN 1021 ELSE op.BetType END = m.BetType
	WHERE ps.SettingType in (22)
		AND ps.SettingStatus = 0
		AND op.IsHidden = 0
		AND ps.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 
		AND NOT EXISTS( SELECT 1 
						FROM @SportBettype 
						WHERE ps.productID = productID 
							AND ps.sporttype = sporttype
							AND ps.bettype = bettype
						)


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

			--SELECT @srecommend AS srecommend , @mrecommend AS mrecommend , @recommend AS recommend , @custid AS custid
						
			TRUNCATE TABLE #SuperWinLossLimit
			TRUNCATE TABLE #MasterWinLossLimit
			TRUNCATE TABLE #MemberWinLossLimit


			SELECT @Site = Site, @Currency = currency FROM Customer WITH(NOLOCK) WHERE CustID = @srecommend
			SELECT @SiteID = siteid FROM Site WITH(NOLOCK) WHERE site = @Site

		
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

			UPDATE op
			SET op.IsHidden = CASE WHEN @Site = 'IMBC' THEN 0 ELSE 1 END
			FROM #OfferedProductList op
			WHERE ProductID = 20

			-- remove Line IsHidden = 1
			DELETE cs
			FROM #OfferedProductList cs
				INNER JOIN ProductStatusProfile prf WITH(NOLOCK) 
					ON prf.Sporttype = CASE 
									WHEN cs.sporttype IN (242) THEN 9911 
									WHEN cs.sporttype IN (9909) THEN 9919 
									ELSE cs.sporttype END -- IBCBet Live Casino use status of Live Casino (9911)
					AND prf.bettype = CASE 
									WHEN cs.sporttype IN (242) THEN 2400 
									WHEN cs.sporttype IN (9909) THEN 1501 
									ELSE cs.bettype END
				CROSS APPLY (SELECT bitmapIsHidden FROM CustProductStatus stt WITH (NOLOCK)
						 WHERE stt.CustID = @srecommend
							) cp
			--WHERE f_GetProductStatus (cp.bitmapIsHidden, prf.bitmapOrder) = 1
			WHERE 1 = CASE substring(cp.bitmapIsHidden, 1+((prf.bitmapOrder-1)/8), 1) & POWER(2, (prf.bitmapOrder-1)%8) WHEN 0 THEN 0 ELSE 1 END

			INSERT INTO #SuperWinLossLimit (custid, sporttype, bettype, MaxWinLimit, MaxLossLimit, IsAutoReset)
			SELECT custid, cs.sporttype, cs.bettype, ISNULL(MaxWinLimit,0), ISNULL(MaxLossLimit,0), ISNULL(IsAutoReset,0)
			FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
			INNER JOIN @SportBettype s ON cs.sporttype = s.sporttype AND cs.bettype =s.bettype
			WHERE custid = @srecommend		
	
			INSERT INTO #MasterWinLossLimit (custid, sporttype, bettype, MaxWinLimit, MaxLossLimit, IsAutoReset)
			SELECT cs.custid, cs.sporttype, cs.bettype, ISNULL(MaxWinLimit,0), ISNULL(MaxLossLimit,0), ISNULL(IsAutoReset,0)
			FROM CustWinLossLimit_Agent cs WITH (NOLOCK)
			INNER JOIN @SportBettype s ON cs.sporttype = s.sporttype AND cs.bettype =s.bettype
			WHERE cs.CustId = @mrecommend
			
			INSERT INTO #MemberWinLossLimit (custid, mrecommend, recommend, sporttype, bettype, MaxWinLimit, MaxLossLimit, IsAutoReset)
			SELECT cs.custid, @mrecommend, @recommend, cs.sporttype, cs.bettype, ISNULL(MaxWinLimit,0), ISNULL(MaxLossLimit,0), ISNULL(IsAutoReset,0)
			FROM CustWinLossLimit_Member cs WITH (NOLOCK)
			INNER JOIN @SportBettype s ON cs.sporttype = s.sporttype AND cs.bettype =s.bettype
			WHERE cs.CustId = @custid
		
			--missing settings
			IF @ruleid IN (0,501)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 501, s.sporttype, s.bettype, t.custid as custidA, 0, 0 , 0
				FROM @SportBettype s
					CROSS JOIN (SELECT @srecommend as custid) t
				WHERE NOT EXISTS (SELECT 1 FROM #SuperWinLossLimit cs 
								WHERE t.custid = cs.custid
									AND cs.sporttype = s.sporttype
									AND cs.bettype = s.bettype
								)
		
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 501, s.sporttype, s.bettype, ci.custid as custidA, 0, 0 , 0
				FROM custinfo ci WITH(NOLOCK)
					INNER JOIN 	customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
					CROSS JOIN (SELECT * FROM @SportBettype ) s
				WHERE ci.srecommend = @srecommend
					--AND	NOT EXISTS (SELECT 1 FROM dbo.f_GetSiteNotOffer() AS nos WHERE nos.site = c.site)
					AND ci.roleid = 3
					AND enabled = 1
					AND NOT EXISTS (SELECT 1 FROM #MasterWinLossLimit cs 
								WHERE ci.custid = cs.custid
									AND cs.sporttype = s.sporttype
									AND cs.bettype = s.bettype
								)
				
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 501, s.sporttype, s.bettype, ci.custid as custidA, 0, 0 , 0
				FROM custinfo ci WITH(NOLOCK)
					INNER JOIN 	customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
					CROSS JOIN (SELECT * FROM @SportBettype ) s
				WHERE ci.srecommend = @srecommend
					--AND	NOT EXISTS (SELECT 1 FROM dbo.f_GetSiteNotOffer() AS nos WHERE nos.site = c.site)
					AND ci.roleid = 1
					AND enabled = 1
					AND NOT EXISTS (SELECT 1 FROM #MemberWinLossLimit cs 
								WHERE ci.custid = cs.custid
									AND cs.sporttype = s.sporttype
									AND cs.bettype = s.bettype
								)
			END
	
			--Super's Maximum Win < Master's Maximum Win		
			IF @ruleid IN (0,502)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 502, scs.sporttype, scs.bettype, scs.custid as custidA, mcs.custid as custidB, scs.MaxWinLimit , mcs.MaxWinLimit
				FROM #SuperWinLossLimit scs
					INNER JOIN #MasterWinLossLimit mcs ON scs.sporttype = mcs.sporttype AND scs.bettype = mcs.bettype
					INNER JOIN @SportBettype s ON scs.sporttype = s.sporttype AND scs.bettype = s.bettype AND s.Winlimit = 1
				WHERE scs.MaxWinLimit > 0 
					AND (mcs.MaxWinLimit = 0 OR mcs.MaxWinLimit > scs.MaxWinLimit)
			END
	
	
	
			--Agent's Maximum Win < Member's Maximum Win		
			IF @ruleid IN (0,504)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 504, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.MaxWinLimit , cs.MaxWinLimit
				FROM #MasterWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs ON cs.mrecommend = acs.custid 
														AND cs.sporttype = acs.sporttype 
														AND cs.bettype = acs.bettype
														AND cs.recommend = -3
					INNER JOIN @SportBettype s ON acs.sporttype = s.sporttype AND acs.bettype = s.bettype AND s.Winlimit = 1																		
				WHERE acs.MaxWinLimit > 0 
					AND (cs.MaxWinLimit = 0 OR cs.MaxWinLimit > acs.MaxWinLimit)

				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 504, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.MaxWinLimit , cs.MaxWinLimit
				FROM #SuperWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs ON cs.sporttype = acs.sporttype 
														AND cs.bettype = acs.bettype
														AND cs.recommend = -4
					INNER JOIN @SportBettype s ON acs.sporttype = s.sporttype AND acs.bettype = s.bettype AND s.Winlimit = 1																		
				WHERE acs.MaxWinLimit > 0 
					AND (cs.MaxWinLimit = 0 OR cs.MaxWinLimit > acs.MaxWinLimit)
			END
	
			--Maximum Loss < MinLossLimit of LossLimit_GlobalSetting		
			IF @ruleid IN (0,505)
			BEGIN		
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 505, scs.sporttype, scs.bettype, scs.custid as custidA, 0 custidB, scs.MaxLossLimit , g.MinLossLimit
				FROM #SuperWinLossLimit scs	
					INNER JOIN @SportBettype s ON scs.sporttype = s.sporttype AND scs.bettype = s.bettype	
					INNER JOIN LossLimit_GlobalSetting g WITH(NOLOCK) ON s.productID = g.productID AND g.ExchangeId = @currency
				WHERE scs.MaxLossLimit < g.MinLossLimit
					AND scs.MaxLossLimit <> 0
		
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 505, cs.sporttype, cs.bettype, cs.custid as custidA, 0 custidB, cs.MaxLossLimit , g.MinLossLimit
				FROM #MasterWinLossLimit cs	
					INNER JOIN @SportBettype s ON cs.sporttype = s.sporttype AND cs.bettype = s.bettype	
					INNER JOIN LossLimit_GlobalSetting g WITH(NOLOCK) ON s.productID = g.productID AND g.ExchangeId = @currency
				WHERE cs.MaxLossLimit < g.MinLossLimit
					AND cs.MaxLossLimit <> 0
		
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 505, cs.sporttype, cs.bettype, cs.custid as custidA, 0 custidB, cs.MaxLossLimit , g.MinLossLimit
				FROM #MemberWinLossLimit cs			
					INNER JOIN @SportBettype s ON cs.sporttype = s.sporttype AND cs.bettype = s.bettype	
					INNER JOIN LossLimit_GlobalSetting g WITH(NOLOCK) ON s.productID = g.productID AND g.ExchangeId = @currency
				WHERE cs.MaxLossLimit < g.MinLossLimit
					AND cs.MaxLossLimit <> 0
			END 

			--Super's Maximum Loss < Master's Maximum Loss		
			IF @ruleid IN (0,506)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 506, scs.sporttype, scs.bettype, scs.custid as custidA, mcs.custid as custidB, scs.MaxLossLimit , mcs.MaxLossLimit
				FROM #SuperWinLossLimit scs
					INNER JOIN #MasterWinLossLimit mcs ON scs.sporttype = mcs.sporttype AND scs.bettype = mcs.bettype			
				WHERE  scs.MaxLossLimit > 0 
					AND (mcs.MaxLossLimit = 0 OR mcs.MaxLossLimit > scs.MaxLossLimit)
			END
		
			-- 	Agent's Maximum Loss < Member's Maximum Loss
			IF @ruleid IN (0,508)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 508, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.MaxLossLimit , cs.MaxLossLimit
				FROM #MasterWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs ON cs.mrecommend = acs.custid 
														AND cs.sporttype = acs.sporttype 
														AND cs.bettype = acs.bettype
														AND cs.recommend = -3
				WHERE  acs.MaxLossLimit > 0
					AND (cs.MaxLossLimit = 0 OR cs.MaxLossLimit > acs.MaxLossLimit)

				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 508, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.MaxLossLimit , cs.MaxLossLimit
				FROM #SuperWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs ON cs.sporttype = acs.sporttype 
														AND cs.bettype = acs.bettype	
														AND cs.recommend = -4
				WHERE  acs.MaxLossLimit > 0
					AND (cs.MaxLossLimit = 0 OR cs.MaxLossLimit > acs.MaxLossLimit)
			END
	
			--Upline's IsAutoReset = 0 => Downlines's IsAutoReset = 1		
			IF @ruleid IN (0,509)
			BEGIN
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 509, scs.sporttype, scs.bettype, scs.custid as custidA, mcs.custid as custidB, scs.IsAutoReset , mcs.IsAutoReset
				FROM #SuperWinLossLimit scs
					INNER JOIN #MasterWinLossLimit mcs ON scs.sporttype = mcs.sporttype AND scs.bettype = mcs.bettype			
				WHERE  scs.IsAutoReset = 0 AND mcs.IsAutoReset = 1
		
				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 509, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.IsAutoReset , cs.IsAutoReset
				FROM #MasterWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs 
						ON cs.mrecommend = acs.custid AND acs.sporttype = cs.sporttype AND acs.bettype = cs.bettype	
						AND cs.recommend = -3
				WHERE  acs.IsAutoReset = 0 AND cs.IsAutoReset = 1

				INSERT INTO #CheckWinLossLimitResult_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 509, acs.sporttype, acs.bettype, acs.custid as custidA, cs.custid as custidB, acs.IsAutoReset , cs.IsAutoReset
				FROM #SuperWinLossLimit acs
					INNER JOIN #MemberWinLossLimit cs 
						ON acs.sporttype = cs.sporttype AND acs.bettype = cs.bettype	
						AND cs.recommend = -4
				WHERE  acs.IsAutoReset = 0 AND cs.IsAutoReset = 1
			END
		END
	END


	SELECT * FROM #CheckWinLossLimitResult_Credit cwllrc

	DROP TABLE #SuperWinLossLimit
	DROP TABLE #MasterWinLossLimit
	DROP TABLE #MemberWinLossLimit	
	DROP TABLE #OfferedProductList

	DROP TABLE #List_DirectMember
	DROP TABLE #CheckWinLossLimitResult_Credit
END
GO


	