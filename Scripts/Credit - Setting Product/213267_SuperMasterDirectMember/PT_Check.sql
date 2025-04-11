/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From DBA_CheckPT_DCS

*/
BEGIN   	
	SET NOCOUNT ON   
	DECLARE
		@srecommend INT	   = 0
	    , @mrecommend INT	   = 0
	    , @recommend  INT	   = 0
	    , @custid     INT	   = 0
	    , @RuleId     SMALLINT = 0
	
	DECLARE @max_CustID  INT  = xxx

	CREATE TABLE #CheckPTResult_Credit (
		RuleId INT,
		BetType SMALLINT,
		SportType SMALLINT,
		CustIdA INT,
		CustIdB INT,
		ValueA SMALLMONEY,
		ValueB SMALLMONEY,
		IsLive BIT
	)
	CREATE TABLE #List_DirectMember (srecommend INT , mrecommend INT , recommend INT , custid INT , is_read BIT DEFAULT (0) PRIMARY KEY CLUSTERED (srecommend , mrecommend , recommend , custid))

	-- Starting DATA PREPARATION
	CREATE TABLE #MemberPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY, IsGroup BIT)
	CREATE TABLE #MasterPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY, MinPT SMALLMONEY, MaxPT SMALLMONEY)
	CREATE TABLE #SuperPT (CustID INT, recommend INT, mrecommend INT, srecommend INT, sporttype SMALLINT, bettype SMALLINT, IsLive BIT, SuperPT SMALLMONEY, MasterPT SMALLMONEY, AgentPT SMALLMONEY, IsAutoMasterPT BIT, AutoMasterPT SMALLMONEY, IsAutoSuperPT BIT, AutoSuperPT SMALLMONEY, MinPT SMALLMONEY, MaxPT SMALLMONEY)
	
	CREATE CLUSTERED INDEX CIX_MemberPT ON #MemberPT(CustID, sporttype, bettype)
	CREATE CLUSTERED INDEX CIX_MasterPT ON #MasterPT(CustID, sporttype, bettype)
	CREATE CLUSTERED INDEX CIX_SuperPT ON #SuperPT(CustID, sporttype, bettype)
	
	CREATE TABLE #ProductSetting(
				[SportType] [smallint] NOT NULL,
				[BetType] [smallint] NOT NULL,
				[IsLive] [bit] NOT NULL,
				[BitmapOrder] [TINYINT],
				[MaxPT] smallmoney
			)
	CREATE TABLE #OfferedProductList(
		[ProductID] [tinyint] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[BetType] [smallint] NOT NULL,
		[IsHidden] [BIT] NOT NULL
	)

	INSERT INTO #OfferedProductList (ProductID, SportType, BetType, IsHidden)
	SELECT DISTINCT ps.RealProductId, ps.SportType, ps.BetType, ps.IsHidden
	FROM dbo.ProductSettingProfile ps WITH (NOLOCK)
		INNER JOIN dbo.ProductSettingType s WITH (NOLOCK)
		ON ps.SettingType = s.SettingType
	WHERE s.SettingName = 'Product Status'  
		AND ps.SettingStatus = 0

	INSERT #ProductSetting(SportType,BetType,IsLive,MaxPT)
	SELECT ps.SportType
			,ps.BetType
			,ps.IsLive
			,ps.MaxPT
	FROM [dbo].[ProductSettingProfile] ps WITH(NOLOCK)
		INNER JOIN (SELECT DISTINCT ProductID, IsHidden FROM #OfferedProductList WITH (NOLOCK)) op ON ps.RealProductId = op.ProductID
	WHERE op.IsHidden = 0 AND SettingType IN (1 ,18)
		AND ps.SettingStatus = 0
		
	--UPDATE cs
	--SET cs.BitmapOrder = prf.bitmapOrder
	--FROM #ProductSetting cs
	--	INNER JOIN dbo.ProductStatusProfile prf WITH(NOLOCK) 
	--		ON prf.Sporttype = CASE WHEN cs.sporttype IN (242) THEN 9911 ELSE cs.sporttype END -- IBCBet Live Casino use status of Live Casino (9911)
	--		AND prf.bettype = CASE WHEN cs.sporttype IN (242) THEN 2400 ELSE cs.bettype END

	-- For Sportsbook
	INSERT #ProductSetting(SportType,BetType,IsLive,BitmapOrder,MaxPT)
	SELECT ps.SportType
			,ps.BetType
			,ps.IsLive
			,0 AS BitmapOrder 
			,ps.MaxPT
	FROM [dbo].[ProductSettingProfile] ps WITH(NOLOCK)
	WHERE SettingType IN (28)
		AND ps.SettingStatus = 0
	
	--SELECT * FROM #OfferedProductList
	--SELECT * FROM #ProductSetting
		
	DECLARE @RowCount INT

	SELECT @RowCount = COUNT(1)
	FROM #ProductSetting
	WHERE SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 

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
	AND i.Currency NOT IN (20,27,28)
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


			--SELECT @srecommend AS srecommend , @mrecommend AS mrecommend , @recommend AS recommend , @custid AS custid
						
			TRUNCATE TABLE #MemberPT
			TRUNCATE TABLE #MasterPT
			TRUNCATE TABLE #SuperPT
			
			INSERT INTO #MemberPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,IsGroup)
			SELECT @custid ,  @recommend , @mrecommend , @srecommend , cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,0 IsGroup
			FROM dbo.CustPTSetting3rd_Member cs WITH (NOLOCK)
			INNER JOIN #ProductSetting ps ON cs.SportType = ps.SportType AND cs.Bettype = ps.Bettype AND cs.IsLive = ps.IsLive
			WHERE cs.CustID = @custid
			AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 
	
			INSERT INTO #MasterPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,MinPT,MaxPT)			
			SELECT @custid ,  @recommend , @mrecommend , @srecommend , cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
			FROM dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #ProductSetting ps ON cs.SportType = ps.SportType AND cs.Bettype = ps.Bettype AND cs.IsLive = ps.IsLive
			WHERE cs.CustID = @mrecommend
			AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 
	
			INSERT INTO #SuperPT (CustID, recommend,mrecommend,srecommend,SportType,BetType,IsLive,SuperPT,MasterPT,AgentPT,IsAutoMasterPT,AutoMasterPT,IsAutoSuperPT,AutoSuperPT,MinPT,MaxPT)			
			SELECT @custid ,  @recommend , @mrecommend , @srecommend , cs.SportType,cs.BetType,cs.IsLive,cs.SuperPT,cs.MasterPT,cs.AgentPT,cs.IsAutoMasterPT,cs.AutoMasterPT,cs.IsAutoSuperPT,cs.AutoSuperPT,cs.MinPT,cs.MaxPT
			FROM dbo.CustPTSetting3rd_Agent cs WITH (NOLOCK) 
			INNER JOIN #ProductSetting ps ON cs.SportType = ps.SportType AND cs.Bettype = ps.Bettype AND cs.IsLive = ps.IsLive
			WHERE cs.CustID = @srecommend
			AND cs.SportType NOT IN (151,152,153,154,162,50,206,255) -- AND SportType NOT IN (SELECT sporttype FROM f_GetSportNotOffer ('CustSettingDCS')) 
			
			--SELECT '#MemberPT' AS Note , * FROM #MemberPT
			--SELECT '#MasterPT' AS Note , * FROM #MasterPT
			--SELECT '#SuperPT' AS Note , * FROM #SuperPT
					
			DECLARE @_Site VARCHAR(10), @_SiteID INT, @_Currency TINYINT
			
			SELECT @_Site = Site, @_Currency = currency FROM dbo.Customer WITH(NOLOCK) WHERE CustID = @srecommend
			SELECT @_SiteID = siteid FROM dbo.Site WITH(NOLOCK) WHERE site = @_Site
		
			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN dbo.ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE stt.Currency = @_Currency AND (stt.SiteID = @_SiteID OR stt.SiteID = 0)
			
			UPDATE op
			SET op.IsHidden = stt.IsHidden
			FROM #OfferedProductList op
				INNER JOIN dbo.ProductStatusSiteCurrency stt WITH(NOLOCK) ON op.SportType = stt.SportType AND op.Bettype = stt.Bettype
			WHERE (stt.Currency = @_Currency OR stt.Currency = 0 ) AND stt.SiteID = @_SiteID

			UPDATE op
			SET op.IsHidden = CASE WHEN @_Site = 'IMBC' THEN 0 ELSE 1 END
			FROM #OfferedProductList op
			WHERE ProductID = 20

			-- End of DATA PREPARATION			
	
			--Delete sport non offer
			DELETE sb		
			FROM #ProductSetting sb
				INNER JOIN [dbo].[SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE stt.Currency = @_Currency AND (stt.SiteID = @_SiteID OR stt.SiteID = 0)	
	
			DELETE sb		
			FROM #ProductSetting sb
				INNER JOIN [dbo].[SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE (stt.Currency = @_Currency OR stt.Currency = 0 ) AND stt.SiteID = @_SiteID

			-- Starting check PT Rule
		
			---- 1. S1 < 0 OR M1 < 0 OR A1 < 0  
			IF @RuleId IN (0,1)  
			BEGIN  
				----PRINT '1. S1 < 0 OR M1 < 0 OR A1 < 0 '  
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)   
				SELECT 1 AS RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,  
					 CASE 
						WHEN cs.SuperPT < 0 THEN cs.SuperPT
						WHEN cs.MasterPT < 0 THEN cs.MasterPT
						WHEN cs.AgentPT < 0 THEN cs.AgentPT
						ELSE 0  
					 END,  
					 0,   
					 cs.Islive  
				FROM #MemberPT cs 
				WHERE cs.SuperPT < 0 OR cs.MasterPT < 0 OR cs.AgentPT < 0
		
			END  

			----2. S4 > MaxPT OR M4 > MaxPT OR A4 > MaxPT  
			IF @RuleId IN (0,2)  
			BEGIN  
				----PRINT '2. S4 > 90 OR M4 > 90 OR A4 > 90 '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 2 AS RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId,  
					 CASE 
						WHEN cs.SuperPT > ps.MaxPT THEN cs.SuperPT
						WHEN cs.MasterPT > ps.MaxPT THEN cs.MasterPT
						WHEN cs.AgentPT > ps.MaxPT THEN cs.AgentPT   
						ELSE ps.MaxPT   
					 END,  
					 ps.MaxPT,  
					 cs.Islive
				FROM #SuperPT cs 
					INNER JOIN #ProductSetting ps ON cs.SportType = ps.SportType AND cs.Bettype = ps.Bettype AND cs.IsLive = ps.IsLive
				WHERE cs.SuperPT > ps.MaxPT OR cs.MasterPT > ps.MaxPT OR cs.AgentPT > ps.MaxPT
		
			END  

			----3. S4 < M4   

			IF @RuleId IN (0,3)  
			BEGIN   
				----PRINT '3. S4 < M4 '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 3 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId
					, cs.SuperPT
					, cs.MasterPT
					, cs.IsLive  
				FROM #SuperPT cs 
				WHERE cs.SuperPT < cs.MasterPT

			END  

			----4. S4 < A4  

			IF @RuleId IN (0,4)  
			BEGIN  
				----PRINT '4. S4 < A4 '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 4 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.SuperPT, cs.AgentPT, cs.IsLive  
				FROM #SuperPT cs
				WHERE cs.SuperPT < cs.AgentPT
			END  
	
			----5. S4 < N4   

			IF @RuleId IN (0,5)  
			BEGIN   
				----PRINT '5. S4 < N4 '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 5 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.SuperPT, cs.MinPT, cs.IsLive  
				FROM #SuperPT cs  
				WHERE cs.superPT < cs.MinPT

			END  
	

			----6. S4 < US3   
	
			IF @RuleId IN (0,6)  
			BEGIN   
				----PRINT '6. S4 < US3   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 6 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT , cs.AutoSuperPT, cs.IsLive  
				FROM #MasterPT cs 
					JOIN #SuperPT scs ON scs.CustID = cs.srecommend  AND scs.SportType = cs.SportType  
													AND scs.BetType = cs.BetType 
													AND scs.IsLive = cs.IsLive  
				WHERE scs.SuperPT < cs.AutoSuperPT
		
			END  
	
			----7. S4 < US1   

			IF @RuleId IN (0,7)  
			BEGIN   
				----PRINT '7. S4 < US1'
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 7 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.AutoSuperPT, scs.IsLive
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType  
													AND scs.BetType = cs.BetType 
													AND scs.IsLive = cs.IsLive 
				WHERE scs.SuperPT < cs.AutoSuperPT
		
			END  

			----8. S4 < S3 + M3   

			IF @RuleId IN (0,8)  
			BEGIN   
				----PRINT '8. S4 < S3 + M3   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 8 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.SuperPT + cs.MasterPT, scs.IsLive  
				FROM #MasterPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType	AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive 
				WHERE scs.SuperPT < cs.SuperPT + cs.MasterPT
		
			END  

			----9. S4 < S1 + M1 + A1   

			IF @RuleId IN (0,9)  
			BEGIN   
				----PRINT '9. S4 < S1 + M1 + A1   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 9 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.SuperPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, scs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive 
				WHERE scs.SuperPT < cs.SuperPT + cs.MasterPT + cs.AgentPT

			END  

			----10. N4 > S1 + M1 + A1   
			----PRINT '10. N4 > S1 + M1 + A1 '
			IF @RuleId IN (0,10)  
			BEGIN 
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 10 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, scs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MinPT > cs.SuperPT + cs.MasterPT + cs.AgentPT
		  
			END  


			-----------------------------------------------------------------------  
			----11. M4 < A4  

			IF @RuleId IN (0,11)  
			BEGIN   
				----PRINT '11. M4 < A4  '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 11 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.MasterPT, cs.AgentPT, cs.IsLive  
				FROM #SuperPT cs 
				WHERE cs.MasterPT < cs.AgentPT
		
			END  
			----12. M4 < M3   
			IF @RuleId IN (0,12)  
			BEGIN  
				----PRINT '12. M4 < M3'
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 12 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT, scs.IsLive  
				FROM #MasterPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
				WHERE scs.MasterPT < cs.MasterPT
		 
			END  
			----13. M4 < N3   

			IF @RuleId IN (0,13)  
			BEGIN  
				----PRINT '13. M4 < N3'
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 13 as RuleId, scs.BetType, scs.SportType, scs.CustId, cs.CustId, scs.MasterPT , cs.MinPT, scs.IsLive  
				FROM #MasterPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
				WHERE scs.MasterPT < cs.MinPT


			END  
			----14. M4 < UM2   

			--IF @RuleId IN (0,14)  
			--BEGIN  
			--	----PRINT '14. M4 < UM2 '
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 14 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.AutoMasterPT, scs.IsLive  
			--	FROM #AgentPT cs
			--		INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive   
			--	WHERE scs.MasterPT < cs.AutoMasterPT
		
			--END  

			----15. M4 < UM1   

			IF @RuleId IN (0,15)  
			BEGIN  
				----PRINT '15. M4 < UM1   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 15 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.AutoMasterPT, scs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MasterPT < cs.AutoMasterPT
			
			END  

			----16. M4 < M1 + A1   
	
			IF @RuleId IN (0,16)  
			BEGIN  
				----PRINT '16. M4 < M1 + A1 '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 16 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT , cs.MasterPT + cs.AgentPT, scs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND  scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
			END  


			----17. M3 < N3   

			IF @RuleId IN (0,17)  
			BEGIN  
				----PRINT '17. M3 < N3   '
		
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 17 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.MasterPT, cs.MinPT, cs.IsLive  
				FROM #MasterPT cs
				WHERE cs.MasterPT < cs.MinPT
		
			END  

			--------------------------------------------------------------------------------------------  
			----18. M3 < M2 + A2   

			--IF @RuleId IN (0,18)  
			--BEGIN   
			--	----PRINT '18. M3 < M2 + A2   '
		
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 18 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
			--	FROM #AgentPT cs
			--		INNER JOIN #MasterPT scs ON cs.mrecommend = scs.Custid AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
			--	WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
		
			--END  

			----19. M3 < M1 + A1   

			IF @RuleId IN (0,19)  
			BEGIN   
				----PRINT '19. M3 < M1 + A1   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 19 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MasterPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MasterPT < cs.MasterPT + cs.AgentPT
		
			END  

	 
			----20. N3 > M1 + A1   

			IF @RuleId IN (0,20)  
			BEGIN  
				----PRINT '20. N3 > M1 + A1   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 20 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MinPT > cs.MasterPT + cs.AgentPT
		
			END    


			----21. A4 < A2  

			--IF @RuleId IN (0,21)  
			--BEGIN   
			--	----PRINT '21. A4 < A2  '
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLIve)  
			--	SELECT 21 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.AgentPT, cs.AgentPT, scs.IsLive  
			--	FROM #AgentPT cs
			--		INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
			--	WHERE scs.AgentPT < cs.AgentPT
		  
			--END   


			----22. A4 < A1  

			IF @RuleId IN (0,22)  
			BEGIN  
				----PRINT '22. A4 < A1  '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 22 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.AgentPT, cs.AgentPT, scs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.AgentPT < cs.AgentPT
			
			END   

			----23. A2 < N2  

			--IF @RuleId IN (0,23)  
			--BEGIN   
			--	----PRINT '23. A2 < N2  '	
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 23 as RuleId, cs.BetType, cs.SportType, cs.CustId, cs.CustId, cs.AgentPT, cs.MinPT, cs.IsLive
			--	FROM #AgentPT  cs
			--	WHERE cs.AgentPT < cs.MinPT
		  
			--END   

			------24. N2 > A1  

			--IF @RuleId IN (0,24)  
			--BEGIN  
			--	----PRINT '24. N2 > A1  '
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 24 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MinPT, cs.AgentPT, cs.IsLive   
			--	FROM #MemberPT cs
			--		INNER JOIN #AgentPT scs ON scs.CustID = cs.recommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
			--	WHERE   scs.MinPT > cs.AgentPT

		  
			--END  


			---------------------------------------------------  
			---- 25. L4 < S1 + M1 + A1   
			IF @RuleId IN (0,25)  
			BEGIN   
				----PRINT '25. L4 < S1 + M1 + A1   '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 25 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.SuperPT + cs.MasterPT + cs.AgentPT, cs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MaxPT < cs.SuperPT + cs.MasterPT + cs.AgentPT

		  
			END  

			---- 26. L3 < M1 +A1  
			IF @RuleId IN (0,26)  
			BEGIN  
				----PRINT '26. L3 < M1 +A1  '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 26 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.MasterPT + cs.AgentPT, cs.IsLive  
				FROM #MemberPT cs
					INNER JOIN #MasterPT scs ON scs.CustID = cs.mrecommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
				WHERE scs.MaxPT < cs.MasterPT + cs.AgentPT
		
			END    
			---- 27. L2 < A1   
			--IF @RuleId IN (0,27)  
			--BEGIN  
			--	----PRINT '27. L2 < A1   '
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 27 as RuleId, cs.BetType, cs.SportType, scs.CustId, cs.CustId, scs.MaxPT, cs.AgentPT, cs.IsLive  
			--	FROM #MemberPT cs
			--		INNER JOIN #AgentPT scs	ON scs.CustID = cs.recommend AND scs.SportType = cs.SportType AND scs.BetType = cs.BetType AND scs.IsLive = cs.IsLive  
			--	WHERE  scs.MaxPT < cs.AgentPT

			--END  


			---- 28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1  
			IF @RuleId IN (0,28)  
			BEGIN   
				----PRINT '28. MIN(S4-M1-A1, (IS1?US1,US3)) > S1  '
				INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				SELECT 28 AS RuleId, cs.BetType, cs.SportType   
						,CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
						  THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
							  THEN cs.CustId   
							  ELSE mcs.CustId   
							END)  
						  ELSE scs.CustId  
						 END   
						,cs.CustId      
						,CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
						  THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
							  THEN cs.AutoSuperPT   
							  ELSE mcs.AutoSuperPT   
							END)  
						  ELSE scs.SuperPT - cs.MasterPT - cs.AgentPT
						 END   
						,cs.SuperPT  
						,cs.IsLive  
				FROM #MemberPT cs WITH (NOLOCK)  
					INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType  AND scs.bettype = cs.bettype  AND scs.IsLive = cs.IsLive  
					INNER JOIN #MasterPT mcs ON mcs.CustID = cs.mrecommend AND mcs.SportType = cs.SportType AND mcs.bettype = cs.bettype AND mcs.IsLive = cs.IsLive 							   
		
				WHERE (cs.IsAutoSuperPT = 1 OR mcs.IsAutoSuperPT = 1)  
					AND cs.SuperPT < CASE WHEN scs.SuperPT - cs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoSuperPT = 1 THEN cs.AutoSuperPT ELSE mcs.AutoSuperPT END)     
							THEN ( CASE WHEN cs.IsAutoSuperPT = 1   
								THEN cs.AutoSuperPT   
								ELSE mcs.AutoSuperPT   
							  END)  
							ELSE scs.SuperPT - cs.MasterPT - cs.AgentPT  
						   END   
				   
			END   

	
			---- 29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1 
			--IF @RuleId IN (0,29)  
			--BEGIN   
			--	----PRINT '29. MIN (M4-A1, M3-A1,(IM1?UM1,UM2)) > M1   '
			--	INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	SELECT 29 AS RuleId, cs.BetType, cs.SportType   
			--	,CASE WHEN scs.MasterPT > mcs.MasterPT   
			--	   THEN CASE WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--		 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--		   THEN cs.CustId  
			--		   ELSE acs.CustId   
			--		   END  
			--			)  
			--		 ELSE mcs.CustId  
			--	   END  
			--	 ELSE   
			--	   CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--		 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--		   THEN cs.CustId  
			--		   ELSE acs.CustId   
			--		  END  
			--		  )  
			--		 ELSE scs.CustId  
			--	   END  
			--	 END  
			--	,cs.CustId  
			--	,CASE WHEN scs.MasterPT > mcs.MasterPT   
			--	   THEN CASE WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--		 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--		   THEN cs.AutoMasterPT  
			--		   ELSE acs.AutoMasterPT   
			--			END  
			--			)  
			--		 ELSE mcs.MasterPT - cs.AgentPT  
			--	   END  
			--	 ELSE   
			--	   CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--		 THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--		   THEN cs.AutoMasterPT  
			--		   ELSE acs.AutoMasterPT   
			--		  END  
			--		  )  
			--		 ELSE scs.MasterPT - cs.AgentPT  
			--	   END  
			--	 END  
			--	,cs.MasterPT  
			--	,cs.IsLive  
			--	FROM #MemberPT cs 
			--		INNER JOIN #SuperPT scs ON scs.CustID = cs.srecommend AND scs.SportType = cs.SportType AND scs.bettype = cs.bettype AND scs.IsLive = cs.IsLive
			--		INNER JOIN #MasterPT mcs ON mcs.CustId = cs.mrecommend AND mcs.SportType = cs.SportType AND mcs.bettype = cs.bettype AND mcs.IsLive = cs.IsLive
			--		INNER JOIN #AgentPT acs ON acs.CustId = cs.recommend  AND acs.SportType = cs.SportType AND acs.bettype = cs.bettype AND acs.IsLive = cs.IsLive	   		     
				   
			--	WHERE ( acs.IsAutoMasterPT = 1 OR cs.IsAutoMasterPT = 1 )  
			--		AND cs.MasterPT < CASE WHEN scs.MasterPT > mcs.MasterPT   
			--				 THEN CASE  WHEN mcs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--				   THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--					 THEN cs.AutoMasterPT  
			--					 ELSE acs.AutoMasterPT
			--					  END  
			--					  )  
			--				   ELSE mcs.MasterPT - cs.AgentPT  
			--				   END  
			--				ELSE   
			--				  CASE WHEN scs.MasterPT - cs.AgentPT > (CASE WHEN cs.IsAutoMasterPT = 1 THEN cs.AutoMasterPT ELSE acs.AutoMasterPT END)   
			--					THEN (CASE WHEN cs.IsAutoMasterPT = 1   
			--					  THEN cs.AutoMasterPT  
			--					  ELSE acs.AutoMasterPT   
			--					 END  
			--					 )  
			--					ELSE scs.MasterPT - cs.AgentPT  
			--					END  
			--				END  

			--END   

			---- 33. PT setting of member exists in both Individual and group PT   
			--IF @RuleId IN (0,33)  
			--BEGIN   
			--	 ----PRINT ' 30. PT setting of member exists in both Individual and group PT'
			--	 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	 SELECT DISTINCT 33,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
			--	 FROM #MemberPT M
			--	 WHERE EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.CustID = M.CustID)
			--		   AND EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 1)	
			--END	
	
			------ 34. IsGrouped Flag = 0 but not exists in Individual PT table
			--IF @RuleId IN (0,34)  
			--BEGIN   
			--	 ----PRINT '31. IsGrouped Flag = 0 but not exists in Individual PT table'
			--	 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	 SELECT DISTINCT 34,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
			--	 FROM #MemberPT M
			--	 WHERE EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 0)	
			--		   AND NOT EXISTS (SELECT 1 FROM dbo.CustPTSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.CustID = M.CustID)
			   
			--END	 
	
			------ 35. IsGrouped Flag = 1 but not exists in Group PT table
			--IF @RuleId IN (0,35)  
			--BEGIN   
			--	 ----PRINT '32. IsGrouped Flag = 1 but not exists in Group PT table'
			--	 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
			--	 SELECT DISTINCT 35,NULL,NULL,M.CustID,M.CustID,NULL,NULL,NULL
			--	 FROM #MemberPT M
			--	 WHERE EXISTS (SELECT 1 FROM dbo.CustSettingMode3rd csm WITH (NOLOCK) WHERE csm.CustID = M.CustID AND csm.IsGrouped = 1)	
			--			AND NOT EXISTS (SELECT 1 FROM dbo.CustPTGroupSetting3rd_Member M1 WITH (NOLOCK) WHERE M1.AgentID = M.recommend)
			   
			--END	 
			
			---- 72. S4 = M4 = A4 = 0
			IF @RuleId IN (0,72)  
			BEGIN   
				 ----PRINT '72. S4 = M4 = A4 = 0'
				 INSERT INTO #CheckPTResult_Credit (RuleId, BetType, SportType, CustIdA, CustIdB, ValueA, ValueB, IsLive)  
				 SELECT DISTINCT 72,bettype,sporttype,CustID,CustID,NULL,NULL,IsLive
				 FROM #SuperPT 
				 WHERE SuperPT = 0 AND MasterPT = 0 AND AgentPT = 0	   
			END	 
			
		END

	END

	SELECT * FROM #CheckPTResult_Credit

	
	drop table #masterpt
	drop table #memberpt
	drop table #superpt
	drop table #list_directmember
	drop table #offeredproductlist
	drop table #productsetting
	drop table #checkptresult_credit
	
END