/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Creator: 20250411@Helios
	Task: Prepare script for quick check: list out direct member real currency, check their customer setting... [Redmine: #213267]
	Database:	DBCUST-CustDB
	Clone From: DBA_CheckDCSStakeLevel_Credit
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

	CREATE TABLE #CheckResultStakeLevel_Credit (RuleID INT,SportType INT,bettype INT,CustIDA INT,CustIDB INT,ValueA VARCHAR(100),ValueB VARCHAR(100)) 
	CREATE TABLE #List_DirectMember (srecommend INT , mrecommend INT , recommend INT , custid INT , is_read BIT DEFAULT (0) PRIMARY KEY CLUSTERED (srecommend , mrecommend , recommend , custid))

	CREATE TABLE #SuperStakeLevel (CustID INT, SportType INT, bettype INT, StakeLevelList VARCHAR(100), PRIMARY KEY(CustID,SportType,Bettype))
	CREATE TABLE #MasterStakeLevel (CustID INT, SportType INT, bettype INT, StakeLevelList VARCHAR(100), PRIMARY KEY(CustID,SportType,Bettype))
	--CREATE TABLE #AgentStakeLevel (CustID INT, SportType INT, bettype INT, mrecommend INT, StakeLevelList VARCHAR(100), PRIMARY KEY(CustID,SportType,Bettype))
	CREATE TABLE #MemberStakeLevel (CustID INT, SportType INT, bettype INT, recommend INT, mrecommend INT, srecommend INT, StakeLevelList VARCHAR(100), PRIMARY KEY(CustID,SportType,Bettype))
	CREATE TABLE #GlobalStakeLevel (sporttype INT, bettype INT, StakeLevelList VARCHAR(1000))
	CREATE TABLE #OfferedProductList(ProductID [tinyint],[SportType] [smallint] ,[BetType] [smallint], IsHidden BIT)
	
	DECLARE @SportBettypeFilter TABLE(SportType INT, Bettype INT)
	DECLARE @currency INT,@Site VARCHAR(10), @SiteID INT, @Rowcount INT
		
	--product has offered stakelevel
	INSERT INTO #OfferedProductList (ProductID, SportType, BetType, IsHidden)
	SELECT DISTINCT ps.RealProductId, ps.SportType, ps.BetType, ps.IsHidden
	FROM ProductSettingProfile ps WITH (NOLOCK)
		INNER JOIN ProductSettingType s WITH (NOLOCK)
		ON ps.SettingType = s.SettingType
	WHERE s.SettingName = 'Product Status'  
		AND ps.SettingStatus = 0	
				
	INSERT INTO @sportBettypeFilter (sportType,bettype)
	SELECT ps.SportType
			,ps.BetType
	FROM [ProductSettingProfile] ps WITH(NOLOCK)
		INNER JOIN (SELECT DISTINCT ProductID, IsHidden FROM #OfferedProductList WITH (NOLOCK)) op ON ps.RealProductId = op.ProductID
	WHERE op.IsHidden = 0 AND ps.SettingType IN (7,8,17) 
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

			-- non offer stakelevel on site and currency
			DELETE sb		
			FROM @sportBettypeFilter sb
				INNER JOIN [SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE stt.Currency = @Currency AND (stt.SiteID = @SiteID OR stt.SiteID = 0)	
	
			DELETE sb		
			FROM @sportBettypeFilter sb
				INNER JOIN [SportNonOfferedSiteCurrency] stt WITH(NOLOCK) ON sb.SportType = stt.SportType AND sb.Bettype = stt.Bettype
			WHERE (stt.Currency = @Currency OR stt.Currency = 0 ) AND stt.SiteID = @SiteID

					     			   
			TRUNCATE TABLE #GlobalStakeLevel
			TRUNCATE TABLE #SuperStakeLevel
			TRUNCATE TABLE #MasterStakeLevel
			TRUNCATE TABLE #MemberStakeLevel
		
			INSERT INTO #GlobalStakeLevel(sporttype,bettype,StakeLevelList)		
			SELECT t.SportType, s1.GameTypeID,  STUFF((SELECT ',' + cast(StakeLevelID as VARCHAR(10)) 
								FROM StakeLevel s2 (NOLOCK) 
								WHERE s2.GameTypeID = s1.gametypeid and s2.ExchangeId = @currency
								FOR XML PATH('')
								),1,1,'')
			FROM StakeLevel s1 WITH(NOLOCK)
				INNER JOIN @sportBettypeFilter t ON s1.gametypeid = t.bettype
			WHERE ExchangeId = @currency
			GROUP BY t.SportType,  s1.GameTypeID
						

			INSERT INTO #SuperStakeLevel(custid,sporttype,bettype,StakeLevelList)
			SELECT cs.custid, cs.sporttype, cs.bettype, StakeLevelList
			FROM CustStakeLevel_Agent cs WITH(NOLOCK)
			INNER JOIN @sportBettypeFilter t ON cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			WHERE cs.custid = @srecommend
			
	
			INSERT INTO #MasterStakeLevel(custid,sporttype,bettype,StakeLevelList)
			SELECT cs.custid, cs.sporttype,cs.bettype,StakeLevelList
			FROM CustStakeLevel_Agent cs WITH(NOLOCK)
				INNER JOIN @sportBettypeFilter t ON cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			WHERE cs.CustID = @mrecommend


			INSERT INTO #MemberStakeLevel(custid,recommend,sporttype,bettype,StakeLevelList,mrecommend,srecommend)
			SELECT cs.custid, @recommend, cs.sporttype, cs.bettype, StakeLevelList, @mrecommend , @srecommend
			FROM CustStakeLevel_Member cs WITH(NOLOCK)
			INNER JOIN @sportBettypeFilter t ON cs.sporttype = t.sporttype AND cs.bettype = t.bettype
			WHERE cs.CustID = @custid
			-- End of DATA PREPARATION	
	
			--check missing setting
			IF @ruleid IN (0,301)
			BEGIN
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 301 as RuleId,t.sportType,t.bettype,ci.CustID custidA,0 as custidB, '' as ValueA, '' ValueB
				FROM custInfo ci WITH (NOLOCK)
					INNER JOIN 	customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
					CROSS APPLY (SELECT SportType, bettype FROM #GlobalStakeLevel) t
				WHERE CI.roleid = 4
					AND ci.srecommend = @srecommend  
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)		
					AND NOT EXISTS (SELECT 1 FROM #SuperStakeLevel cs2 
								WHERE ci.custid = cs2.custid
									AND t.bettype = cs2.bettype
									AND t.sportType = cs2.sportType							
								)
		
		
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 301 as RuleId,t.sportType,t.bettype,ci.CustID custidA,0 as custidB, '' as ValueA, '' ValueB
				FROM custInfo ci WITH (NOLOCK)
					INNER JOIN 	customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
					CROSS APPLY (SELECT SportType, bettype FROM #GlobalStakeLevel) t
				WHERE CI.roleid = 3
					AND ci.srecommend = @srecommend  
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)	
					AND NOT EXISTS (SELECT 1 FROM #MasterStakeLevel cs2 
								WHERE ci.custid = cs2.custid
									AND t.bettype = cs2.bettype
									AND t.sportType = cs2.sportType	
								)

				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 301 as RuleId,t.sportType,t.bettype,ci.CustID custidA,0 as custidB, '' as ValueA, '' ValueB
				FROM custInfo ci WITH (NOLOCK)
					INNER JOIN 	customer c 	 WITH (NOLOCK) ON ci.CustID = c.CustID
					CROSS APPLY (SELECT SportType, bettype FROM #GlobalStakeLevel) t
				WHERE CI.roleid = 1
					AND ci.srecommend = @srecommend  
					AND CI.Enabled = 1
					AND CI.Currency NOT IN (20,72,27,28)	
					AND NOT EXISTS (SELECT 1 FROM #MemberStakeLevel cs2 
								WHERE ci.custid = cs2.custid
									AND t.bettype = cs2.bettype
									AND t.sportType = cs2.sportType	
								)							
			END
	
			--check stake level super <> global setting		
			IF @ruleid IN (0,302)
			BEGIN
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 302 as RuleId,cs1.sportType,cs1.bettype,cs1.CustID custidA,0 as custidB, cs1.StakeLevelList as StakeLevelListA, cs2.StakeLevelList as StakeLevelListB
				FROM #SuperStakeLevel cs1
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t
					INNER JOIN #GlobalStakeLevel cs2 ON cs1.bettype = cs2.bettype
				WHERE CHARINDEX(t.val,cs2.StakeLevelList,0) = 0	
					AND cs1.StakeLevelList <> ''
			END
	
			--stake level master not exist in super		
			IF @ruleid IN (0, 303)
			BEGIN
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 303 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,cs2.custid as custidB, cs1.StakeLevelList as StakeLevelListA, cs2.StakeLevelList as StakeLevelListB
				FROM #MasterStakeLevel cs1
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t
					INNER JOIN #SuperStakeLevel cs2 ON cs1.bettype = cs2.bettype
													AND cs1.sporttype = cs2.sportType		
				WHERE CHARINDEX(t.val,cs2.StakeLevelList,0) = 0
					AND cs1.StakeLevelList <> ''
			END
	
			--stake level member not exist in agent( or direct upline master/super)		
			IF @ruleid IN (0, 305)
			BEGIN
				
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 305 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,cs2.custid as custidB, cs1.StakeLevelList as StakeLevelListA, cs2.StakeLevelList as StakeLevelListB
				FROM #MemberStakeLevel cs1	
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t		
					INNER JOIN #MasterStakeLevel cs2 ON cs1.bettype = cs2.bettype
													AND cs1.sporttype = cs2.sportType
													AND cs1.mrecommend = cs2.custid	
													AND cs1.recommend = -3
				WHERE CHARINDEX(t.val,cs2.StakeLevelList,0) = 0
					AND cs1.StakeLevelList <> ''

				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 305 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,cs2.custid as custidB, cs1.StakeLevelList as StakeLevelListA, cs2.StakeLevelList as StakeLevelListB
				FROM #MemberStakeLevel cs1	
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t		
					INNER JOIN #SuperStakeLevel cs2 ON cs1.bettype = cs2.bettype
													AND cs1.sporttype = cs2.sportType
													AND cs1.srecommend = cs2.custid	
													AND cs1.recommend = -4
				WHERE CHARINDEX(t.val,cs2.StakeLevelList,0) = 0
					AND cs1.StakeLevelList <> ''
			END	

			--Exceed max number of member stake level	
			IF @ruleid IN (0, 306)
			BEGIN
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT 306 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,0 as custidB, MAX(cs1.StakeLevelList) as StakeLevelListA, '' as ValueB
				FROM #MemberStakeLevel cs1		
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t	
					INNER JOIN ProductSettingProfile ps WITH(NOLOCK) 
					ON ps.sportType = cs1.SportType 
						AND ps.bettype = cs1.bettype
						AND ps.MaxChoice > 0
						AND ps.SettingType = 17 -- multi stake level
				WHERE cs1.StakeLevelList <> ''
				GROUP BY cs1.sportType,cs1.bettype,cs1.custid
				HAVING COUNT(1) > MAX(ps.MaxChoice)
			END
	
			--Check duplicate stakelevel 
			IF @ruleid IN (0,307)
			BEGIN
				--super
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 307 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,0 as custidB, MAX(cs1.StakeLevelList) as StakeLevelListA, '' as ValueB
				FROM #SuperStakeLevel cs1		
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t	
				WHERE cs1.StakeLevelList <> ''			 
				GROUP BY cs1.sportType,cs1.bettype,t.val,cs1.custid
				HAVING COUNT(1) > 1
		
				--Master
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 307 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,0 as custidB, MAX(cs1.StakeLevelList) as StakeLevelListA, '' as ValueB
				FROM #MasterStakeLevel cs1		
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t	
				WHERE cs1.StakeLevelList <> ''			  
				GROUP BY cs1.sportType,cs1.bettype,t.val,cs1.custid
				HAVING COUNT(1) > 1
			
				--member
				INSERT INTO #CheckResultStakeLevel_Credit(RuleID,SportType,bettype,CustIDA,CustIDB,ValueA,ValueB) 
				SELECT DISTINCT 307 as RuleId,cs1.sportType,cs1.bettype,cs1.custid custidA,0 as custidB, MAX(cs1.StakeLevelList) as StakeLevelListA, '' as ValueB
				FROM #MemberStakeLevel cs1		
					CROSS APPLY strSplit(cs1.StakeLevelList,',') t	
				WHERE cs1.StakeLevelList <> ''			  
				GROUP BY cs1.sportType,cs1.bettype,t.val,cs1.custid
				HAVING COUNT(1) > 1
			END



		END
	END

	SELECT * FROM #CheckResultStakeLevel_Credit
	

	DROP TABLE #CheckResultStakeLevel_Credit
	DROP TABLE #GlobalStakeLevel
	DROP TABLE #List_DirectMember
	DROP TABLE #MasterStakeLevel
	DROP TABLE #SuperStakeLevel
	DROP TABLE #MemberStakeLevel
	DROP TABLE #OfferedProductList
END
GO
	