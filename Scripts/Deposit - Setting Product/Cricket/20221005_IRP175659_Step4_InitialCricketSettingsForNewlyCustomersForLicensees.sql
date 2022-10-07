/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221005@Johnson
	Task: Initial setting for Cricket & Saba Cricket for newly Deposit customers [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 
	--initial global setting for Dep_CustBetLimit_Special
	INSERT INTO [dbo].[Dep_CustBetLimit_Special]
           ([Site]
           ,[CurrencyID]
           ,[SportType]
           ,[AgentID]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerBall]
           ,[Bettype]
           ,[MaxPayoutPerMatch])
	SELECT [Site]
           ,[CurrencyID]
           ,t.SportType
           ,[AgentID]
           ,[MaxBet]
           ,[MaxPerMatch]
           ,[MaxPerBall]
           ,t.Bettype
           ,[MaxPayoutPerMatch]
	FROM Dep_CustBetLimit_Special cs WITH(NOLOCK)
		CROSS APPLY (SELECT 50 sporttype, 1 bettype
					UNION SELECT 9907, 1
					)t
	WHERE  cs.sporttype = 99
		AND cs.bettype = 1
		AND site NOT IN ('spondemo','Athena000','SampleSite')	
		AND NOT EXISTS (SELECT 1 FROM Dep_CustBetLimit_Special cs2 WITH(NOLOCK)
							WHERE cs.AgentID = cs2.AgentID
								AND t.sporttype = cs2.sporttype
								AND t.bettype = cs2.bettype
							)
							
	CREATE TABLE #supers (custid int, isfinished bit default(0))

	DECLARE @max_custid INT 

	SELECT @max_custid = xxx

	INSERT INTO #supers(custid)
	SELECT c.custid
	FROM customer c WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON c.site = s.site
		INNER JOIN custinfo ci  WITH (NOLOCK) ON c.custid = ci.custid
	WHERE c.roleid = 4  
		AND s.islicensee = 1
		AND ci.Enabled = 1	
		AND c.custid IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.site NOT IN ('spondemo','Athena000','SampleSite')	

	CREATE TABLE #tmpCust (CustID INT PRIMARY KEY, isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA (CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy (CustID INT PRIMARY KEY)

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend IN (SELECT custid FROM #Supers)
		AND roleid=3 
		AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #tmpCust(CustID)
	SELECT ci.CustID
	FROM custInfo ci WITH(NOLOCK)
		INNER JOIN Dep_CustSettingMode cs WITH(NOLOCK) ON cs.custid = ci.custid
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)
		AND ci.custid > @max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND cs.IsGroupedBetLimit = 0
		
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend IN (SELECT custid FROM #Supers)
		AND ci.custid > @max_custid 
		AND roleid IN (2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	IF EXISTS(SELECT 1 FROM #tmpSMA WHERE roleid = 4)
	BEGIN
		INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
		SELECT custid, ProductSettingID
		FROM #tmpSMA c
			CROSS APPLY (SELECT 154 ProductSettingID
						UNION SELECT 155 ProductSettingID) t
		WHERE roleid = 4
			AND NOT EXISTS (SELECT 1 FROM Dep_LicenseeProductSetting l WITH(NOLOCK)
							WHERE c.custid = l.custid
								AND t.ProductSettingID = l.ProductSettingID)
	END
		
	IF EXISTS(SELECT 1 FROM #tmpSMA)
	BEGIN
		INSERT INTO Dep_CustBetSettingGame_Agent(
				CustID,
				SportType,
				BetType,
				MinBet,
				MaxBet,
				MaxPerMatch,
				MaxPerNumber,
				MaxPayoutPerMatch
			)
		SELECT CustID,
				t.SportType,
				t.BetType,
				MinBet,
				MaxBet,
				MaxPerMatch,
				MaxPerNumber,
				MaxPayoutPerMatch
		FROM Dep_CustBetSettingGame_Agent cs WITH(NOLOCK)
			CROSS APPLY (SELECT 50 sporttype, 1 bettype
						UNION SELECT 9907, 1
						)t
		WHERE custid IN (SELECT custid FROM #tmpSMA)
			AND cs.sporttype = 99
			AND cs.bettype = 1
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBetSettingGame_Agent cs2 WITH(NOLOCK)
							WHERE cs.custid = cs2.custid
								AND t.sporttype = cs2.sporttype
								AND t.bettype = cs2.bettype
							)
	END
	
	IF EXISTS(SELECT 1 FROM #tmpSMA WHERE roleid = 2)
	BEGIN
		INSERT INTO [dbo].[Dep_CustBetSettingGameGroup_Member]
				   ([AgentID]
				   ,[SportType]
				   ,[BetType]
				   ,[MinBet]
				   ,[MaxBet]
				   ,[MaxPerMatch]
				   ,[MaxPerNumber]
				   ,[MaxPayoutPerMatch])
		SELECT [AgentID]
			   ,t.SportType
			   ,t.BetType
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch]
		FROM Dep_CustBetSettingGameGroup_Member cs WITH(NOLOCK)
			CROSS APPLY (SELECT 50 sporttype, 1 bettype
						UNION SELECT 9907, 1
						)t
		WHERE AgentID IN (SELECT custid FROM #tmpSMA WHERE roleid = 2)
			AND cs.sporttype = 99
			AND cs.bettype = 1	
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBetSettingGameGroup_Member cs2 WITH(NOLOCK)
							WHERE cs.AgentID = cs2.AgentID
								AND t.sporttype = cs2.sporttype
								AND t.bettype = cs2.bettype
							)
	END		
		
	DECLARE @tmp TABLE (custid INT PRIMARY KEY)
	
	WHILE(1=1)
	BEGIN
		DELETE TOP (500) t
		OUTPUT DELETED.Custid INTO @tmp(Custid)
		FROM #tmpCust t
		
		IF @@ROWCOUNT = 0
			BREAK;
			
		INSERT INTO [dbo].[Dep_CustBetSettingGame_Member]
			   ([CustID]
			   ,[SportType]
			   ,[BetType]
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch])
		SELECT [CustID]
			   ,t.SportType
			   ,t.BetType
			   ,[MinBet]
			   ,[MaxBet]
			   ,[MaxPerMatch]
			   ,[MaxPerNumber]
			   ,[MaxPayoutPerMatch]
		FROM Dep_CustBetSettingGame_Member cs WITH(NOLOCK)
			CROSS APPLY (SELECT 50 sporttype, 1 bettype
						UNION SELECT 9907, 1
						)t
		WHERE custid IN (SELECT custid FROM @tmp)
			AND cs.sporttype = 99
			AND cs.bettype = 1
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBetSettingGame_Member cs2 WITH(NOLOCK)
							WHERE cs.CustID = cs2.CustID
								AND t.sporttype = cs2.sporttype
								AND t.bettype = cs2.bettype
							)
			
		DELETE @tmp	
	END