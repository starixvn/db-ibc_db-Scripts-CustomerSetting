/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From DBA_CheckComm_DCS
*/

BEGIN   
	SET NOCOUNT ON   
	
	DECLARE @max_CustID  INT  = xxx

	DECLARE 
	 @srecommend	INT	   = 0
	,@mrecommend	INT	   = 0
	,@recommend		INT	   = 0
	,@custid		INT	   = 0
	,@RuleId		SMALLINT = 0  
		

	CREATE TABLE #List_DirectMember (srecommend INT , mrecommend INT , recommend INT , custid INT , is_read BIT DEFAULT (0) PRIMARY KEY CLUSTERED (srecommend , mrecommend , recommend , custid))

	CREATE TABLE #CheckCommResult_Credit (RuleId INT, BetType SMALLINT, SportType SMALLINT, CustIdA INT, CustIdB INT, ValueA DECIMAL(9,8), ValueB DECIMAL(9,8)) 


	-- Starting DATA PREPARATION
	DECLARE @_Site VARCHAR(10), @_SiteID INT, @_Currency TINYINT
	CREATE TABLE #ProductSetting(
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[BitmapOrder] [TINYINT]
	)
	CREATE TABLE #OfferedProductList(
		[ProductID] [tinyint] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsHidden] [BIT] NOT NULL
	)

	CREATE TABLE #MemberComm(
		  CustID			INT
		 ,recommend			INT
		 ,mrecommend		INT
		 ,srecommend		INT
		 ,SportType			SMALLINT
		 ,BetType			SMALLINT
		 ,SuperDiscount		DECIMAL(9,8)
		 ,MasterDiscount		DECIMAL(9,8)
		 ,AgentDiscount		DECIMAL(9,8)
		 ,PlayerDiscount		DECIMAL(9,8)
		 ,ugroup			VARCHAR(3)
	)

	CREATE TABLE #MasterComm(
		  CustID			INT
		 ,srecommend		INT
		 ,SportType			SMALLINT
		 ,BetType			SMALLINT
		 ,Discount			DECIMAL(9,8)
	)

	CREATE TABLE #SuperComm(
		  CustID			INT
		 ,SportType			SMALLINT
		 ,BetType			SMALLINT
		 ,Discount			DECIMAL(9,8)
	)

	

	INSERT INTO #OfferedProductList (ProductID, SportType, BetType, IsHidden)
	SELECT DISTINCT ps.RealProductId, ps.SportType, ps.BetType, ps.IsHidden
	FROM ProductSettingProfile ps WITH (NOLOCK)
		INNER JOIN ProductSettingType s WITH (NOLOCK)
		ON ps.SettingType = s.SettingType
	WHERE s.SettingName = 'Product Status'  
		AND ps.SettingStatus = 0

	
	INSERT #ProductSetting(SportType,BetType)
	SELECT ps.SportType
		,ps.BetType
	FROM [ProductSettingProfile] ps WITH(NOLOCK)
		INNER JOIN (SELECT DISTINCT ProductID, IsHidden FROM #OfferedProductList WITH (NOLOCK)) op ON ps.RealProductId = op.ProductID
	WHERE op.IsHidden = 0 AND SettingType IN (3,19)
		AND ps.SettingStatus = 0	
		
	-- COLLECT DIRECT MEMBER & UPLINE
	INSERT INTO #List_DirectMember (srecommend , mrecommend , recommend, custid)
	SELECT TOP 10 srecommend , mrecommend , recommend , custid 
	FROM custInfo WITH (NOLOCK) 
	WHERE recommend IN (-3,-4)
	AND Enabled = 1 
	AND roleid = 1 
	--AND srecommend = 187899101
	AND Currency NOT IN (20,27,28)
	AND custid >= @max_CustID

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
		

			SELECT @_Site = Site, @_Currency = currency FROM Customer WITH(NOLOCK) WHERE CustID = @srecommend
			SELECT @_SiteID = siteid FROM Site WITH(NOLOCK) WHERE site = @_Site

			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE stt.Currency = @_Currency AND (stt.SiteID = @_SiteID OR stt.SiteID = 0)
			
			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE (stt.Currency = @_Currency OR stt.Currency = 0 ) AND stt.SiteID = @_SiteID

			UPDATE op
			SET op.IsHidden = CASE WHEN @_Site = 'IMBC' THEN 0 ELSE 1 END
			FROM #OfferedProductList op
			WHERE ProductID = 20	
	
			--Delete sport non offer
			DELETE sb		
			FROM #ProductSetting sb
				INNER JOIN [SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE stt.Currency = @_Currency AND (stt.SiteID = @_SiteID OR stt.SiteID = 0)	
	
			DELETE sb		
			FROM #ProductSetting sb
				INNER JOIN [SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE (stt.Currency = @_Currency OR stt.Currency = 0 ) AND stt.SiteID = @_SiteID

			--UPDATE cs
			--SET cs.BitmapOrder = prf.bitmapOrder
			--FROM #ProductSetting cs
			--	INNER JOIN ProductStatusProfile prf WITH(NOLOCK) 
			--		ON prf.Sporttype = CASE WHEN cs.sporttype IN (242) THEN 9911 ELSE cs.sporttype END -- IBCBet Live Casino use status of Live Casino (9911)
			--		AND prf.bettype = CASE WHEN cs.sporttype IN (242) THEN 2400 ELSE cs.bettype END

			-- For Sportsbook
			INSERT #ProductSetting(SportType,BetType,BitmapOrder)
			SELECT ps.SportType
					,ps.BetType
					,0 AS BitmapOrder 
			FROM [ProductSettingProfile] ps WITH(NOLOCK)
			WHERE SettingType IN (25)
				AND ps.SettingStatus = 0
			--------------------------------------------------------------------
			
			TRUNCATE TABLE #MemberComm
			TRUNCATE TABLE #MasterComm
			TRUNCATE TABLE #SuperComm

			INSERT INTO #MemberComm (CustID,recommend,mrecommend,srecommend,SportType,BetType,SuperDiscount,MasterDiscount,AgentDiscount,PlayerDiscount,ugroup)
			SELECT @custid , @recommend , @mrecommend , @srecommend , cs.SportType,cs.BetType,cs.SuperDiscount, cs.MasterDiscount, cs.AgentDiscount, cs.PlayerDiscount,c.ugroup
			FROM CustDiscount3rd_Member cs WITH (NOLOCK) 
			INNER JOIN #ProductSetting p ON cs.SportType = p.SportType AND cs.BetType = p.BetType
			INNER JOIN Customer c WITH (NOLOCK) ON c.custid = cs.CustID
			WHERE cs.CustID = @custid
	            AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 

			INSERT INTO #MasterComm (CustID,srecommend,SportType,BetType,Discount)
			SELECT @custid , @srecommend, cs.SportType,cs.BetType,cs.Discount
			FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
			INNER JOIN #ProductSetting p ON cs.SportType = p.SportType AND cs.BetType = p.BetType
			WHERE cs.CustID = @mrecommend
			AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 
	
			INSERT INTO #SuperComm (CustID,SportType,BetType,Discount)
			SELECT cs.CustID, cs.SportType,cs.BetType,cs.Discount
			FROM CustDiscount3rd_Agent cs WITH (NOLOCK)
			INNER JOIN #ProductSetting p ON cs.SportType = p.SportType AND cs.BetType = p.BetType
			WHERE cs.CustID = @srecommend
			AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 

			-- End of DATA PREPARATION		
	
			-- Starting check Comm Rule
			---- 101. Super''s Discount < Master''s Discount
			IF @RuleId IN (0,101)  
			BEGIN  
				----PRINT '101. Super''s Discount < Master''s Discount'  
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)   
				SELECT 101 AS RuleId, css.BetType, css.SportType, css.CustId, csm.CustId, css.Discount, csm.Discount  
				FROM #SuperComm css 
					INNER JOIN #MasterComm csm ON csm.BetType = css.BetType AND csm.SportType = css.SportType AND csm.srecommend = css.custid
				WHERE css.Discount < csm.Discount
		
			END  


			----103. Agent''s Discount < Player''s Discount
			IF @RuleId IN (0,103)  
			BEGIN   
				----PRINT '103. Agent''s Discount < Player''s Discount'
				--Master''s Discount < Player''s Discount ( master direct member)
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 103 AS RuleId, csa.BetType, csa.SportType, csa.CustId, csmem.CustId, csa.Discount, csmem.PlayerDiscount
				FROM #MasterComm csa
					INNER JOIN #MemberComm csmem 
						ON csmem.BetType = csa.BetType AND csmem.SportType = csa.SportType AND csmem.mrecommend = csa.CustID
						AND csmem.recommend = -3
				WHERE csa.Discount < csmem.PlayerDiscount
					AND NOT (csmem.SportType = 1 AND csmem.BetType = 1)

				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 103 AS RuleId, csa.BetType, csa.SportType, csa.CustId, csmem.CustId, csa.Discount, csmem.PlayerDiscount
				FROM #MasterComm csa
					INNER JOIN #MemberComm csmem 
						ON CASE WHEN csmem.ugroup IN('a', 'hka', 'dea') THEN 1 
								WHEN csmem.ugroup IN('b', 'hkb', 'deb') THEN 3
								WHEN csmem.ugroup IN('c', 'hkc', 'dec') THEN 7
								WHEN csmem.ugroup IN('d', 'hkd', 'ded') THEN 8
							END = csa.BetType 
						AND csmem.SportType = csa.SportType 
						AND csmem.mrecommend = csa.CustID
						AND csmem.recommend = -3
				WHERE csa.Discount < csmem.PlayerDiscount
					AND csmem.SportType = 1 AND csmem.BetType = 1

				--Super''s Discount < Player''s Discount ( super direct member)
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 103 AS RuleId, csa.BetType, csa.SportType, csa.CustId, csmem.CustId, csa.Discount, csmem.PlayerDiscount
				FROM #SuperComm csa
					INNER JOIN #MemberComm csmem 
						ON csmem.BetType = csa.BetType AND csmem.SportType = csa.SportType AND csmem.srecommend = csa.CustID
						AND csmem.recommend = -4
				WHERE csa.Discount < csmem.PlayerDiscount
					AND NOT (csmem.SportType = 1 AND csmem.BetType = 1)

				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 103 AS RuleId, csa.BetType, csa.SportType, csa.CustId, csmem.CustId, csa.Discount, csmem.PlayerDiscount
				FROM #SuperComm csa
					INNER JOIN #MemberComm csmem 
						ON CASE WHEN csmem.ugroup IN('a', 'hka', 'dea') THEN 1 
								WHEN csmem.ugroup IN('b', 'hkb', 'deb') THEN 3
								WHEN csmem.ugroup IN('c', 'hkc', 'dec') THEN 7
								WHEN csmem.ugroup IN('d', 'hkd', 'ded') THEN 8
							END = csa.BetType 
						AND csmem.SportType = csa.SportType 
						AND csmem.srecommend = csa.CustID
						AND csmem.recommend = -4
				WHERE csa.Discount < csmem.PlayerDiscount
					AND csmem.SportType = 1 AND csmem.BetType = 1
			END  

			----104. SuperDiscount < MasterDiscount on member level
			IF @RuleId IN (0,104)  
			BEGIN  
				----PRINT '104. SuperDiscount < MasterDiscount on member level'
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 104 as RuleId, csmem.BetType, csmem.SportType, csmem.CustId, csmem.CustId, csmem.SuperDiscount, csmem.MasterDiscount
				FROM #MemberComm csmem
				WHERE csmem.SuperDiscount < csmem.MasterDiscount
			END  
	
			----105. MasterDiscount < AgentDiscount on member level
			IF @RuleId IN (0,105)  
			BEGIN   
				----PRINT '105. MasterDiscount < AgentDiscount on member level'
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 105 as RuleId, csmem.BetType, csmem.SportType, csmem.CustId, csmem.CustId, csmem.MasterDiscount, csmem.AgentDiscount
				FROM #MemberComm csmem
				WHERE csmem.MasterDiscount < csmem.AgentDiscount

			END  

			----106. AgentDiscount < PlayerDiscount on member level
			IF @RuleId IN (0,106)  
			BEGIN   
				----PRINT '106. AgentDiscount < PlayerDiscount on member level'
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)  
				SELECT 106 as RuleId, csmem.BetType, csmem.SportType, csmem.CustId, csmem.CustId, csmem.AgentDiscount, csmem.PlayerDiscount
				FROM #MemberComm csmem
				WHERE csmem.AgentDiscount < csmem.PlayerDiscount
			END  
	
			---- 107. Super''s Discount <> Super''s Discount on member level
			IF @RuleId IN (0,107)  
			BEGIN  
				----PRINT '107. Super''s Discount <> Super''s Discount on member level'  
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)   
				SELECT 107 AS RuleId, css.BetType, css.SportType, css.CustId, csmem.CustId, css.Discount, csmem.SuperDiscount  
				FROM #SuperComm css 
					INNER JOIN #MemberComm csmem ON csmem.BetType = css.BetType AND csmem.SportType = css.SportType AND csmem.srecommend = css.custid
				WHERE css.Discount <> csmem.SuperDiscount
					AND NOT (csmem.SportType = 1 AND csmem.BetType = 1)

				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)   
				SELECT 107 AS RuleId, css.BetType, css.SportType, css.CustId, csmem.CustId, css.Discount, csmem.SuperDiscount  
				FROM #SuperComm css 
					INNER JOIN #MemberComm csmem 
						ON CASE WHEN csmem.ugroup IN('a', 'hka', 'dea') THEN 1 
								WHEN csmem.ugroup IN('b', 'hkb', 'deb') THEN 3
								WHEN csmem.ugroup IN('c', 'hkc', 'dec') THEN 7
								WHEN csmem.ugroup IN('d', 'hkd', 'ded') THEN 8
							END = css.BetType  
						AND csmem.SportType = css.SportType 
						AND csmem.srecommend = css.custid
				WHERE css.Discount <> csmem.SuperDiscount
					AND csmem.SportType = 1 AND csmem.BetType = 1
		
			END  
	
			---- 108. Master''s Discount <> Master''s Discount on member level
			IF @RuleId IN (0,108)  
			BEGIN  
				----PRINT '108. Master''s Discount < Master''s Discount on member level'  
				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)   
				SELECT 108 AS RuleId, css.BetType, css.SportType, css.CustId, csmem.CustId, css.Discount, csmem.MasterDiscount
				FROM #MasterComm css 
					INNER JOIN #MemberComm csmem ON csmem.BetType = css.BetType AND csmem.SportType = css.SportType AND csmem.mrecommend = css.custid
				WHERE css.Discount <> csmem.MasterDiscount
					AND NOT (csmem.SportType = 1 AND csmem.BetType = 1)

				INSERT INTO #CheckCommResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB)   
				SELECT 108 AS RuleId, css.BetType, css.SportType, css.CustId, csmem.CustId, css.Discount, csmem.MasterDiscount
				FROM #MasterComm css 
					INNER JOIN #MemberComm csmem 
						ON CASE WHEN csmem.ugroup IN('a', 'hka', 'dea') THEN 1 
								WHEN csmem.ugroup IN('b', 'hkb', 'deb') THEN 3
								WHEN csmem.ugroup IN('c', 'hkc', 'dec') THEN 7
								WHEN csmem.ugroup IN('d', 'hkd', 'ded') THEN 8
							END = css.BetType 
						AND csmem.SportType = css.SportType 
						AND csmem.mrecommend = css.custid
				WHERE css.Discount <> csmem.MasterDiscount
					AND csmem.SportType = 1 AND csmem.BetType = 1
		
			END 		
		END

	END

	SELECT * FROM #CheckCommResult_Credit

	DROP TABLE #MemberComm
	DROP TABLE #MasterComm
	DROP TABLE #SuperComm
	DROP TABLE #OfferedProductList
	DROP TABLE #ProductSetting

	DROP TABLE #List_DirectMember
	DROP TABLE #CheckCommResult_Credit
END

GO