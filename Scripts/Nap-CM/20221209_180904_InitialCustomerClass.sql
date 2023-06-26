/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20221209@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Build Customer Class Management
	Revisions:
		- 20221209@Winfred: [NAP CM] Build Customer Class Management [RedmineID: #180904] 
*/
--Conver Data from CustomerClassPolicy
--===================================================================================
	DECLARE @SportType SMALLINT = 1
	CREATE TABLE #CustomerClassRule_Clone(RuleClassID INT IDENTITY(1,1), CustomerClass SMALLINT, SportType SMALLINT, Enable BIT,isLicensee	bit
										,PeakHourSpreadAdjustment SMALLINT ,RuleTitle VARCHAR(500), IsLive VARCHAR(5), DiffBalanceRatio DECIMAL(9, 2), BetDelay DECIMAL(9, 2)
										,NextBetInterval SMALLINT, SuperBetInterval SMALLINT, SiteBetInterval SMALLINT ,MinBet INT, MaxBet INT, MaxPerMatch INT, RepeatedBets TINYINT, SeizeBetTicket TINYINT
										,EnableParlay BIT, AgentBetInterval SMALLINT, LeagueGroupIDs VARCHAR(MAX) , Currency VARCHAR(MAX),Platforms	VARCHAR(MAX), sites NVARCHAR(MAX)
										,RuleID INT, PolicyID INT, PolicyTitle VARCHAR(500),PerformanceType	tinyint, isFinished BIT DEFAULT(0)
										)

	CREATE TABLE #CustomerClassPolicy(SportType	tinyint,CustomerClass	smallint,Liveindicator	 VARCHAR(5),isLicensee	bit,SiteID	VARCHAR(MAX),LeagueGroupIDs	VARCHAR(MAX),
			DiffBalanceRatio	decimal(19,4),BetDelay	decimal (19,4),NextBetInterval	smallint,MaxPerMatch	int,MaxBet	int,Enabled	bit,Platforms	VARCHAR(MAX),
			CurrencyID	VARCHAR(MAX),RepeatedBets	tinyint,MinBet	int,SeizeBetTicket	tinyint,AgentBetInterval	smallint,DisableParlay	bit,SiteBetInterval	smallint, site NVARCHAR(50),PerformanceType	tinyint, VersionPolicy INT)

	CREATE TABLE #CCPolicyManagement(SportType SMALLINT, isLicensee	BIT, Currency VARCHAR(MAX),Platforms	VARCHAR(MAX), sites VARCHAR(MAX),RuleIDs VARCHAR(MAX), PolicyID INT, PolicyTitle VARCHAR(500), NewPolicyTitle VARCHAR(500),PerformanceType	tinyint, IsLive VARCHAR(5), isFinished BIT DEFAULT(0))

	-- Merge LeagueGroupID
	INSERT INTO #CustomerClassPolicy(SportType,CustomerClass,Liveindicator,
isLicensee,SiteID,LeagueGroupIDs,DiffBalanceRatio,BetDelay,NextBetInterval,MaxPerMatch,MaxBet,Enabled,Platforms	,CurrencyID	,RepeatedBets	,MinBet	,SeizeBetTicket	,AgentBetInterval,DisableParlay	,SiteBetInterval, PerformanceType,VersionPolicy)
	SELECT DISTINCT a.SportType,a.CustomerClass,a.Liveindicator,
a.isLicensee,ISNULL(a.SiteID,0) AS SiteID,d.LeagueGroupIDs,a.DiffBalanceRatio,a.BetDelay,a.NextBetInterval,a.MaxPerMatch,a.MaxBet,a.Enabled,a.Platform	,ISNULL(a.CurrencyID,0) AS CurrencyID	,a.RepeatedBets	,a.MinBet	,a.SeizeBetTicket	,AgentBetInterval,a.DisableParlay	,a.SiteBetInterval 
,ccsp.PerformanceType , 1 AS VersionPolicy 
	FROM CustomerClassPolicy a WITH (NOLOCK)
	INNER JOIN CustomerClassSitePerformance ccsp WITH (NOLOCK) ON a.SportType = ccsp.Sporttype  AND a.LeagueGroupID = ccsp.LeagueGroupID AND a.Platform = ccsp.Platform AND a.isLicensee = ccsp.isLicensee AND a.SiteID = ccsp.SiteID AND a.CurrencyID = ccsp.CurrencyID 
	INNER JOIN CustomerClassPolicyPerformance ccpp WITH (NOLOCK) ON a.CustomerClass = ccpp.CustomerClass AND a.SportType = ccpp.SportType AND a.Liveindicator = ccpp.Liveindicator AND a.Platform = ccpp.Platform  AND ((a.DiffBalanceRatio IS NULL AND ccpp.DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = ccpp.DiffBalanceRatio)) 
								AND ((a.BetDelay IS NULL AND ccpp.BetDelay IS NULL) OR (a.BetDelay = ccpp.BetDelay ))
								AND ((a.NextBetInterval IS NULL AND ccpp.NextBetInterval IS NULL) OR (a.NextBetInterval = ccpp.NextBetInterval ))
								AND ((a.AgentBetInterval IS NULL AND ccpp.SuperBetInterval IS NULL) OR (a.AgentBetInterval = ccpp.SuperBetInterval  ))
								AND ((a.SeizeBetTicket IS NULL AND ccpp.SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = ccpp.SeizeBetTicket  ))
								AND ((a.DisableParlay IS NULL AND ccpp.DisableParlay IS NULL) OR (a.DisableParlay = ccpp.DisableParlay ))
								AND ((a.SiteBetInterval IS NULL AND ccpp.SiteBetInterval IS NULL) OR (a.SiteBetInterval = ccpp.SiteBetInterval ))
								AND ((a.MaxPerMatch IS NULL AND ccpp.MaxPerMatch IS NULL) OR (a.MaxPerMatch = ccpp.MaxPerMatch ))
								AND ((a.MinBet IS NULL AND ccpp.MinBet IS NULL) OR (a.MinBet = ccpp.MinBet ))
								AND ((a.MaxBet IS NULL AND ccpp.MaxBet IS NULL) OR (a.MaxBet = ccpp.MaxBet ))
								AND ((a.RepeatedBets IS NULL AND ccpp.RepeatedBets IS NULL) OR (a.RepeatedBets = ccpp.RepeatedBets))
								AND ccpp.PerformanceType = ccsp.PerformanceType
	CROSS APPLY(
			SELECT STRING_AGG(LeagueGroupID, ',') WITHIN GROUP (ORDER BY LeagueGroupID)  AS LeagueGroupIDs
			FROM (SELECT DISTINCT CAST(ISNULL(LeagueGroupID,-1) AS VARCHAR(20)) AS LeagueGroupID
				FROM CustomerClassPolicy WITH(NOLOCK)
				WHERE CustomerClass = a.CustomerClass AND a.SportType = SportType
					AND (a.SiteID = SiteID OR ( a.SiteID IS NULL AND SiteID IS NULL))
					AND (a.CurrencyID = CurrencyID OR ( a.CurrencyID IS NULL AND CurrencyID IS NULL))
					AND a.Platform = Platform	 AND a.Liveindicator = Liveindicator  AND isLicensee = a.isLicensee
					AND ((a.DiffBalanceRatio IS NULL AND DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = DiffBalanceRatio)) 
					AND ((a.BetDelay IS NULL AND BetDelay IS NULL) OR (a.BetDelay = BetDelay ))
					AND ((a.NextBetInterval IS NULL AND NextBetInterval IS NULL) OR (a.NextBetInterval = NextBetInterval ))
					AND ((a.AgentBetInterval IS NULL AND AgentBetInterval IS NULL) OR (a.AgentBetInterval = AgentBetInterval  ))
					AND ((a.SeizeBetTicket IS NULL AND SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = SeizeBetTicket  ))
					AND ((a.DisableParlay IS NULL AND DisableParlay IS NULL) OR (a.DisableParlay = DisableParlay ))
					AND ((a.SiteBetInterval IS NULL AND SiteBetInterval IS NULL) OR (a.SiteBetInterval = SiteBetInterval ))
					AND ((a.MaxPerMatch IS NULL AND MaxPerMatch IS NULL) OR (a.MaxPerMatch = MaxPerMatch ))
					AND ((a.MinBet IS NULL AND MinBet IS NULL) OR (a.MinBet = MinBet ))
					AND ((a.MaxBet IS NULL AND MaxBet IS NULL) OR (a.MaxBet = MaxBet ))
					AND ((a.RepeatedBets IS NULL AND RepeatedBets IS NULL) OR (a.RepeatedBets = RepeatedBets))
				) mis
		) d
	WHERE a.SportType = @SportType 
	ORDER BY CustomerClass,SportType,SiteID,IsLicensee,Enabled

	-- Merge CurrencyID
	INSERT INTO #CustomerClassPolicy(SportType,CustomerClass,Liveindicator,
isLicensee,SiteID,LeagueGroupIDs,DiffBalanceRatio,BetDelay,NextBetInterval,MaxPerMatch,MaxBet,Enabled,Platforms	,CurrencyID	,RepeatedBets	,MinBet	,SeizeBetTicket	,AgentBetInterval,DisableParlay	,SiteBetInterval, PerformanceType,VersionPolicy)
	SELECT DISTINCT a.SportType,a.CustomerClass,a.Liveindicator,
a.isLicensee,a.SiteID,a.LeagueGroupIDs,a.DiffBalanceRatio,a.BetDelay,a.NextBetInterval,a.MaxPerMatch,a.MaxBet,a.Enabled,a.Platforms	,mis.CurrencyIDs,a.RepeatedBets	,a.MinBet	,a.SeizeBetTicket	,AgentBetInterval,a.DisableParlay	,a.SiteBetInterval , a.PerformanceType , 2 AS VersionPolicy -- merge currrency
	FROM #CustomerClassPolicy a WITH (NOLOCK)
	CROSS APPLY(
			SELECT STRING_AGG(CurrencyID, ',') WITHIN GROUP (ORDER BY CurrencyID)  AS CurrencyIDs
			FROM (SELECT DISTINCT CAST(CurrencyID AS VARCHAR(20)) AS CurrencyID
				FROM #CustomerClassPolicy WITH(NOLOCK)
				WHERE CustomerClass = a.CustomerClass AND a.SportType = SportType AND VersionPolicy = a.VersionPolicy
					AND (a.SiteID = SiteID OR ( a.SiteID IS NULL AND SiteID IS NULL))
					AND a.Platforms = Platforms	 AND a.Liveindicator = Liveindicator  AND isLicensee = a.isLicensee
					AND ((a.LeagueGroupIDs IS NULL AND LeagueGroupIDs IS NULL) OR (a.LeagueGroupIDs = LeagueGroupIDs)) 
					AND ((a.DiffBalanceRatio IS NULL AND DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = DiffBalanceRatio)) 
					AND ((a.BetDelay IS NULL AND BetDelay IS NULL) OR (a.BetDelay = BetDelay ))
					AND ((a.NextBetInterval IS NULL AND NextBetInterval IS NULL) OR (a.NextBetInterval = NextBetInterval ))
					AND ((a.AgentBetInterval IS NULL AND AgentBetInterval IS NULL) OR (a.AgentBetInterval = AgentBetInterval  ))
					AND ((a.SeizeBetTicket IS NULL AND SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = SeizeBetTicket  ))
					AND ((a.DisableParlay IS NULL AND DisableParlay IS NULL) OR (a.DisableParlay = DisableParlay ))
					AND ((a.SiteBetInterval IS NULL AND SiteBetInterval IS NULL) OR (a.SiteBetInterval = SiteBetInterval ))
					AND ((a.MaxPerMatch IS NULL AND MaxPerMatch IS NULL) OR (a.MaxPerMatch = MaxPerMatch ))
					AND ((a.MinBet IS NULL AND MinBet IS NULL) OR (a.MinBet = MinBet ))
					AND ((a.MaxBet IS NULL AND MaxBet IS NULL) OR (a.MaxBet = MaxBet ))
					AND ((a.RepeatedBets IS NULL AND RepeatedBets IS NULL) OR (a.RepeatedBets = RepeatedBets))
				) d 
			) mis
	WHERE a.VersionPolicy = 1
	ORDER BY CustomerClass,SportType,SiteID,IsLicensee,Enabled
	
	-- Merge Platforms
	INSERT INTO #CustomerClassPolicy(SportType,CustomerClass,Liveindicator,
isLicensee,SiteID,LeagueGroupIDs,DiffBalanceRatio,BetDelay,NextBetInterval,MaxPerMatch,MaxBet,Enabled,Platforms	,CurrencyID	,RepeatedBets	,MinBet	,SeizeBetTicket	,AgentBetInterval,DisableParlay	,SiteBetInterval, PerformanceType,VersionPolicy)
	SELECT DISTINCT a.SportType,a.CustomerClass,a.Liveindicator,
a.isLicensee,a.SiteID,a.LeagueGroupIDs,a.DiffBalanceRatio,a.BetDelay,a.NextBetInterval,a.MaxPerMatch,a.MaxBet,a.Enabled,mis.Platforms	,a.CurrencyID,a.RepeatedBets	,a.MinBet	,a.SeizeBetTicket	,AgentBetInterval,a.DisableParlay	,a.SiteBetInterval , a.PerformanceType , 3 AS VersionPolicy -- merge Platforms
	FROM #CustomerClassPolicy a WITH (NOLOCK)
	CROSS APPLY(
			SELECT STRING_AGG(Platforms, ',') WITHIN GROUP (ORDER BY Platforms)  AS Platforms
			FROM (SELECT DISTINCT CAST(Platforms AS VARCHAR(20)) AS Platforms
				FROM #CustomerClassPolicy WITH(NOLOCK)
				WHERE CustomerClass = a.CustomerClass AND a.SportType = SportType AND VersionPolicy = a.VersionPolicy
					AND (a.CurrencyID = CurrencyID OR ( a.CurrencyID IS NULL AND CurrencyID IS NULL))
					AND (a.SiteID = SiteID OR ( a.SiteID IS NULL AND SiteID IS NULL))  AND isLicensee = a.isLicensee
					AND a.Liveindicator = Liveindicator AND a.LeagueGroupIDs = LeagueGroupIDs	
					AND ((a.DiffBalanceRatio IS NULL AND DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = DiffBalanceRatio)) 
					AND ((a.BetDelay IS NULL AND BetDelay IS NULL) OR (a.BetDelay = BetDelay ))
					AND ((a.NextBetInterval IS NULL AND NextBetInterval IS NULL) OR (a.NextBetInterval = NextBetInterval ))
					AND ((a.AgentBetInterval IS NULL AND AgentBetInterval IS NULL) OR (a.AgentBetInterval = AgentBetInterval  ))
					AND ((a.SeizeBetTicket IS NULL AND SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = SeizeBetTicket  ))
					AND ((a.DisableParlay IS NULL AND DisableParlay IS NULL) OR (a.DisableParlay = DisableParlay ))
					AND ((a.SiteBetInterval IS NULL AND SiteBetInterval IS NULL) OR (a.SiteBetInterval = SiteBetInterval ))
					AND ((a.MaxPerMatch IS NULL AND MaxPerMatch IS NULL) OR (a.MaxPerMatch = MaxPerMatch ))
					AND ((a.MinBet IS NULL AND MinBet IS NULL) OR (a.MinBet = MinBet ))
					AND ((a.MaxBet IS NULL AND MaxBet IS NULL) OR (a.MaxBet = MaxBet ))
					AND ((a.RepeatedBets IS NULL AND RepeatedBets IS NULL) OR (a.RepeatedBets = RepeatedBets))
				) d 
			) mis
	WHERE a.VersionPolicy = 2
	ORDER BY CustomerClass,SportType,IsLicensee,Enabled

	-- Merge Liveindicator
	INSERT INTO #CustomerClassPolicy(SportType,CustomerClass,Liveindicator,
isLicensee,SiteID,LeagueGroupIDs,DiffBalanceRatio,BetDelay,NextBetInterval,MaxPerMatch,MaxBet,Enabled,Platforms	,CurrencyID	,RepeatedBets	,MinBet	,SeizeBetTicket	,AgentBetInterval,DisableParlay	,SiteBetInterval, PerformanceType,VersionPolicy)
	SELECT DISTINCT a.SportType,a.CustomerClass,mis.Liveindicators,
a.isLicensee,a.SiteID,a.LeagueGroupIDs,a.DiffBalanceRatio,a.BetDelay,a.NextBetInterval,a.MaxPerMatch,a.MaxBet,a.Enabled,a.Platforms	,a.CurrencyID,a.RepeatedBets	,a.MinBet	,a.SeizeBetTicket	,AgentBetInterval,a.DisableParlay	,a.SiteBetInterval , a.PerformanceType , 4 AS VersionPolicy -- merge Liveindicators
	FROM #CustomerClassPolicy a WITH (NOLOCK)
	CROSS APPLY(
			SELECT STRING_AGG(Liveindicator, ',') WITHIN GROUP (ORDER BY Liveindicator)  AS Liveindicators
			FROM (SELECT DISTINCT CAST(Liveindicator AS VARCHAR(20)) AS Liveindicator
				FROM #CustomerClassPolicy WITH(NOLOCK)
				WHERE CustomerClass = a.CustomerClass AND a.SportType = SportType AND VersionPolicy = a.VersionPolicy
					AND (a.SiteID = SiteID OR ( a.SiteID IS NULL AND SiteID IS NULL))
					AND (a.CurrencyID = CurrencyID OR ( a.CurrencyID IS NULL AND CurrencyID IS NULL))
					AND a.Platforms = Platforms	 AND a.LeagueGroupIDs = LeagueGroupIDs	  AND isLicensee = a.isLicensee
					AND ((a.DiffBalanceRatio IS NULL AND DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = DiffBalanceRatio)) 
					AND ((a.BetDelay IS NULL AND BetDelay IS NULL) OR (a.BetDelay = BetDelay ))
					AND ((a.NextBetInterval IS NULL AND NextBetInterval IS NULL) OR (a.NextBetInterval = NextBetInterval ))
					AND ((a.AgentBetInterval IS NULL AND AgentBetInterval IS NULL) OR (a.AgentBetInterval = AgentBetInterval  ))
					AND ((a.SeizeBetTicket IS NULL AND SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = SeizeBetTicket  ))
					AND ((a.DisableParlay IS NULL AND DisableParlay IS NULL) OR (a.DisableParlay = DisableParlay ))
					AND ((a.SiteBetInterval IS NULL AND SiteBetInterval IS NULL) OR (a.SiteBetInterval = SiteBetInterval ))
					AND ((a.MaxPerMatch IS NULL AND MaxPerMatch IS NULL) OR (a.MaxPerMatch = MaxPerMatch ))
					AND ((a.MinBet IS NULL AND MinBet IS NULL) OR (a.MinBet = MinBet ))
					AND ((a.MaxBet IS NULL AND MaxBet IS NULL) OR (a.MaxBet = MaxBet ))
					AND ((a.RepeatedBets IS NULL AND RepeatedBets IS NULL) OR (a.RepeatedBets = RepeatedBets))
				) d 
			) mis
	WHERE a.VersionPolicy = 3
	ORDER BY CustomerClass,SportType,IsLicensee,Enabled
	
	DELETE FROM #CustomerClassPolicy WHERE VersionPolicy IN ( 1, 2, 3 )
	
	UPDATE a 
	SET a.site = ISNULL(p.SiteName, a.SiteID)
	FROM #CustomerClassPolicy a
		LEFT JOIN SiteConfig.dbo.LicVendorProfile p WITH(NOLOCK)  ON a.SiteId  = p.SiteId
	WHERE VersionPolicy = 4

	--UPDATE a  SET a.site = a.SiteID FROM #CustomerClassPolicy a WHERE VersionPolicy = 4
	
	-- Merge SiteName
	INSERT INTO #CustomerClassRule_Clone(SportType,CustomerClass,IsLive,
isLicensee,LeagueGroupIDs,DiffBalanceRatio,BetDelay,NextBetInterval,MaxPerMatch,MaxBet,Enable,Platforms	,Currency	,RepeatedBets	,MinBet	,SeizeBetTicket	,AgentBetInterval,EnableParlay	,SiteBetInterval,sites, PerformanceType,RuleTitle,PolicyTitle)
	SELECT DISTINCT a.SportType,a.CustomerClass,CASE WHEN Liveindicator = '0,1' OR Liveindicator = '1,0' OR Liveindicator IS NULL  THEN 'All' ELSE Liveindicator END AS Liveindicator,
a.isLicensee,a.LeagueGroupIDs,a.DiffBalanceRatio,a.BetDelay,a.NextBetInterval,a.MaxPerMatch,a.MaxBet,a.Enabled,a.Platforms	,a.CurrencyID,a.RepeatedBets	,a.MinBet	,a.SeizeBetTicket	,AgentBetInterval,a.DisableParlay	,a.SiteBetInterval , mis.SiteNames, a.PerformanceType ,
	'CC ' + CAST(CustomerClass AS VARCHAR(10)) + ', ' + 
	CASE SportType WHEN 1 THEN 'Soccer' WHEN 2 THEN 'Basketball'  WHEN 99 THEN 'Other Sports' WHEN 43 THEN 'E-Sports' ELSE 'Other Sports' END +
	', IsLive '+ CASE WHEN Liveindicator = '0,1' OR Liveindicator = '1,0' OR Liveindicator IS NULL  THEN 'All' ELSE Liveindicator END + 
	CASE WHEN DiffBalanceRatio IS NULL  THEN '' ELSE ', DiffBalanceRatio ' + CAST(CAST((DiffBalanceRatio - 1)*100 AS INT) AS VARCHAR(20)) + '% ' END + 
	CASE WHEN BetDelay IS NULL  THEN '' ELSE ', BetDelay ' + CAST(CAST((BetDelay - 1)*100 AS INT) AS VARCHAR(20)) + '% ' END + 
	CASE WHEN SeizeBetTicket IS NULL  THEN '' ELSE ', SeizeBetTicket ' + CAST(SeizeBetTicket AS VARCHAR(20)) + '% ' END + 
	CASE WHEN NextBetInterval IS NULL  THEN '' ELSE ', NextBetInterval ' + CAST(NextBetInterval AS VARCHAR(20)) + ' ' END + 
	CASE WHEN AgentBetInterval IS NULL  THEN '' ELSE ', AgentBetInterval ' + CAST(AgentBetInterval AS VARCHAR(20)) + ' ' END + 
	CASE WHEN MinBet IS NULL  THEN '' ELSE ', MinBet ' + CAST(MinBet AS VARCHAR(20)) + ' ' END + 
	CASE WHEN MaxBet IS NULL  THEN '' ELSE ', MaxBet ' + CAST(MaxBet AS VARCHAR(20)) + ' ' END + 
	CASE WHEN MaxPerMatch IS NULL  THEN '' ELSE ', MaxPerMatch ' + CAST(MaxPerMatch AS VARCHAR(20)) + ' ' END + 
	CASE WHEN RepeatedBets IS NULL  THEN '' ELSE ', RepeatedBets ' + CAST(RepeatedBets AS VARCHAR(20)) + ' ' END + 
	CASE WHEN SiteBetInterval IS NULL  THEN '' ELSE ',SiteBetInterval ' + CAST(SiteBetInterval AS VARCHAR(20)) + ' ' END + 
	CASE WHEN DisableParlay IS NULL  THEN '' ELSE ', DisableParlay ' + CAST(DisableParlay AS VARCHAR(20)) + ' ' END 
	AS RuleTitle,
	CASE SportType WHEN 1 THEN 'SC' WHEN 2 THEN 'BK'  WHEN 99 THEN 'OS' WHEN 43 THEN 'ES' ELSE 'OS' END + ' - ' +
	CASE PerformanceType WHEN 1 THEN 'Bad' WHEN 2 THEN 'Standard' WHEN 3 THEN 'Good' WHEN 4 THEN 'Qualified' WHEN 5 THEN 'SuperHeavy'
						 WHEN 6 THEN 'Heavy' WHEN 7 THEN 'Special3' WHEN 8 THEN 'Special4' WHEN 9 THEN 'Special5' WHEN 10 THEN 'Special6'
		ELSE 'Bad' END AS PolicyTitle
	FROM #CustomerClassPolicy a WITH (NOLOCK)
	CROSS APPLY(
			SELECT STRING_AGG(SiteName, ',') WITHIN GROUP (ORDER BY SiteName)  AS SiteNames
			FROM (SELECT DISTINCT CAST(site AS VARCHAR(20)) AS SiteName
				FROM #CustomerClassPolicy WITH(NOLOCK)
				WHERE CustomerClass = a.CustomerClass AND a.SportType = SportType AND VersionPolicy = a.VersionPolicy AND PerformanceType = a.PerformanceType
					AND (a.CurrencyID = CurrencyID OR ( a.CurrencyID IS NULL AND CurrencyID IS NULL))  AND isLicensee = a.isLicensee
					AND a.Platforms = Platforms	 AND a.LeagueGroupIDs = LeagueGroupIDs	AND a.Liveindicator = Liveindicator	
					AND ((a.DiffBalanceRatio IS NULL AND DiffBalanceRatio IS NULL) OR (a.DiffBalanceRatio = DiffBalanceRatio)) 
					AND ((a.BetDelay IS NULL AND BetDelay IS NULL) OR (a.BetDelay = BetDelay ))
					AND ((a.NextBetInterval IS NULL AND NextBetInterval IS NULL) OR (a.NextBetInterval = NextBetInterval ))
					AND ((a.AgentBetInterval IS NULL AND AgentBetInterval IS NULL) OR (a.AgentBetInterval = AgentBetInterval  ))
					AND ((a.SeizeBetTicket IS NULL AND SeizeBetTicket IS NULL) OR (a.SeizeBetTicket = SeizeBetTicket  ))
					AND ((a.DisableParlay IS NULL AND DisableParlay IS NULL) OR (a.DisableParlay = DisableParlay ))
					AND ((a.SiteBetInterval IS NULL AND SiteBetInterval IS NULL) OR (a.SiteBetInterval = SiteBetInterval ))
					AND ((a.MaxPerMatch IS NULL AND MaxPerMatch IS NULL) OR (a.MaxPerMatch = MaxPerMatch ))
					AND ((a.MinBet IS NULL AND MinBet IS NULL) OR (a.MinBet = MinBet ))
					AND ((a.MaxBet IS NULL AND MaxBet IS NULL) OR (a.MaxBet = MaxBet ))
					AND ((a.RepeatedBets IS NULL AND RepeatedBets IS NULL) OR (a.RepeatedBets = RepeatedBets))
				) d 
			) mis
	ORDER BY CustomerClass,SportType,IsLicensee,Enabled
----==================================================================================
	DECLARE @RuleClassID INT , @RuleID INT = 0 ,@PolicyID INT = 0, @NewPolicyTitle VARCHAR(500) , @RuleIDs VARCHAR(MAX) , @RuleTitle VARCHAR(500)
	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #CustomerClassRule_Clone
		SET isFinished = 1
			,@RuleClassID=RuleClassID
			,@RuleTitle = RuleTitle
		WHERE isFinished = 0	
			
		IF @@ROWCOUNT = 0 BREAK 
			
		INSERT INTO CustomerClassRule(
 			CustomerClass 				
		,	RuleTitle 					    
		,	SportType 					
		,	IsLive 					
		,	DiffBalanceRatio 			    
		,	BetDelay 					    
		,	NextBetInterval 			
		,	SuperBetInterval 			
		,	SiteBetInterval 			
		,	MinBet 					
		,	MaxBet 					
		,	MaxPerMatch 				
		,	RepeatedBets 				
		,	SeizeBetTicket 			
		,	EnableParlay 		  
		,	PeakHourSpreadAdjustment 	
		,	AgentBetInterval
		,	Enable 	
		,	IsTest
		,  LastModifiedUser
		,  LastModifiedTime)	
		SELECT
			CustomerClass 				
			,RuleTitle 					    
			,SportType 					
			,CASE WHEN IsLive = 'All' THEN 2 ELSE IsLive END AS IsLive					
			,DiffBalanceRatio 			    
			,BetDelay 					    
			,NextBetInterval 			
			,SuperBetInterval 			
			,SiteBetInterval 			
			,MinBet 					
			,MaxBet 					
			,MaxPerMatch 				
			,RepeatedBets 				
			,SeizeBetTicket 			
			,EnableParlay 				  
			,PeakHourSpreadAdjustment 	
			,AgentBetInterval
			,Enable
			,0 AS IsTest
			,null As UserID
			,GETDATE()
		FROM #CustomerClassRule_Clone
		WHERE RuleClassID = @RuleClassID
		
		SET @RuleID = SCOPE_IDENTITY()
			
		UPDATE #CustomerClassRule_Clone SET RuleID  = @RuleID,isFinished = 1 WHERE RuleTitle = @RuleTitle
			
		INSERT INTO CustomerClassRuleLeagueGroup(RuleID ,  LeagueGroupID)	
		SELECT a.RuleID ,CAST(b.LeagueGroupID  AS SMALLINT) AS LeagueGroupID
		FROM #CustomerClassRule_Clone a
		CROSS APPLY ( SELECT VALUE AS LeagueGroupID FROM STRING_SPLIT(a.LeagueGroupIDs,',') WHERE VALUE <> '' ) b
		WHERE RuleClassID = @RuleClassID
	END	


	UPDATE a 
	SET a.RuleID = kq.RowNumber
	FROM #CustomerClassRule_Clone a		
		INNER JOIN (
				SELECT CustomerClass, SportType, RuleTitle,LeagueGroupIDs,isLicensee,
					DENSE_RANK() over (order by CustomerClass, SportType, RuleTitle,LeagueGroupIDs,isLicensee) RowNumber
				FROM #CustomerClassRule_Clone
		   ) kq ON kq.CustomerClass = a.CustomerClass AND a.SportType = kq.SportType AND a.isLicensee = kq.isLicensee
				AND a.RuleTitle = kq.RuleTitle AND a.LeagueGroupIDs = kq.LeagueGroupIDs

	INSERT INTO #CCPolicyManagement(SportType , isLicensee, RuleIDs, Sites, Currency, Platforms,IsLive, PolicyTitle , PerformanceType ,NewPolicyTitle)
	SELECT DISTINCT a.SportType, a.isLicensee, RuleIDs, Sites, Currency, Platforms,IsLive, PolicyTitle , PerformanceType , 
		PolicyTitle + ' - ' + CASE IsLive WHEN  '0' THEN 'NonLive' WHEN  'All ' THEN 'Live/NonLive' ELSE 'Live' END  + ' - ' + CAST(DENSE_RANK() OVER ( PARTITION BY PolicyTitle,IsLive ORDER BY  RuleIDs) as varchar(5)) AS NewPolicyTitle 
	FROM #CustomerClassRule_Clone a
	CROSS APPLY(
			SELECT STRING_AGG(RuleID, ',') WITHIN GROUP (ORDER BY RuleID)  AS RuleIDs
			FROM (SELECT DISTINCT CAST(RuleID AS VARCHAR(20)) AS RuleID
				FROM #CustomerClassRule_Clone WITH(NOLOCK)
				WHERE a.SportType = SportType AND Sites = a.Sites AND Currency = a.Currency 
				AND Platforms = a.Platforms AND PolicyTitle = a.PolicyTitle AND IsLive = a.IsLive AND isLicensee = a.isLicensee
				) d 
			) mis
	ORDER BY PolicyTitle

	WHILE (1 = 1)
	BEGIN
		UPDATE TOP (1) #CCPolicyManagement
		SET isFinished = 1
			,@NewPolicyTitle = NewPolicyTitle
			,@RuleIDs = RuleIDs
		WHERE isFinished = 0	
			
		IF @@ROWCOUNT = 0 BREAK 
		
		INSERT INTO CustomerClassPolicyManagement(
			PolicyTitle 
			,  SportType
			,  IsTest
			,  LastModifiedUser
			,  LastModifiedTime)	
		SELECT @NewPolicyTitle AS  PolicyTitle, @SportType AS  SportType, 0 AS IsTest
			,null As UserID, GETDATE()
		
		SET @PolicyID = SCOPE_IDENTITY()

		UPDATE #CCPolicyManagement
		SET isFinished = 1 ,PolicyID = @PolicyID
		WHERE NewPolicyTitle = @NewPolicyTitle

		INSERT INTO CustomerClassPolicyRule(PolicyID ,  RuleID)	
		SELECT @PolicyID AS PolicyID, VALUE AS RuleID FROM STRING_SPLIT(@RuleIDs,',') WHERE VALUE <> ''

		INSERT INTO CustomerClassSiteManagement(PolicyID,Site,Currency,Platform,LastModifiedUser,LastModifiedTime)
		SELECT a.PolicyID, d.sites, c.Currency, b.Platform ,null As UserID, GETDATE()
		FROM #CCPolicyManagement a
			CROSS APPLY( SELECT VALUE AS Platform FROM STRING_SPLIT(a.Platforms,',') WHERE VALUE <> '') b
			CROSS APPLY( SELECT VALUE AS Currency FROM STRING_SPLIT(a.Currency,',') WHERE VALUE <> '') c
			CROSS APPLY( SELECT VALUE AS sites FROM STRING_SPLIT(a.sites,',') WHERE VALUE <> '') d
		WHERE PolicyID = @PolicyID
	END	

	SELECT * FROM #CCPolicyManagement ORDER BY PolicyTitle,IsLive  , RuleIDs

	SELECT * FROM #CustomerClassRule_Clone 
	order by CustomerClass,RuleTitle,  sites, Currency, Platforms, PolicyTitle
	--order by SportType, isLicensee, PolicyTitle, sites, Platforms, Currency
	
	DROP TABLE #CCPolicyManagement
	DROP TABLE #CustomerClassRule_Clone
	DROP TABLE #CustomerClassPolicy