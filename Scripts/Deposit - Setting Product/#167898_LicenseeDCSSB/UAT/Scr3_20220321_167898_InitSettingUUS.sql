/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20220321
	Task: Insert copy Data - for SB,NG,Keno DCS [Redmine:#167898]
	DB: DBCUST/CustDB and all subscriber of CustDB_custseting Pub
*/
-- BEGIN STEP 1: DEPLOY THIS SP @DBCUST.CustDB -----
------------------------------------------------------
ALTER PROCEDURE [dbo].[Acc_Dep_DynamicCustSetting_09]
 	 @srecommend INT	
	, @max_custid INT
	, @target VARCHAR(20)
	
AS
BEGIN	
	SET NOCOUNT ON
	IF (@target = 'REPLICATED' AND @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME NOT IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')) RETURN -- run at dbtrans only
	
	IF (dbo.f_CheckRepTable('Dep_CustSettingMode') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTSetting_Agent') = 0
		OR dbo.f_CheckRepTable('Dep_CustPTGroupSetting_Member') = 0

		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSetting_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Agent') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 0 
		OR dbo.f_CheckRepTable('Dep_CustBetSettingGameGroup_Member') = 0 

		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Member') = 0		
		OR dbo.f_CheckRepTable('Dep_CustDiscountGroupSetting_Member') = 0
		OR dbo.f_CheckRepTable('Dep_CustDiscountSetting_Agent') = 0
		
		OR dbo.f_CheckRepTable('Dep_ProductSetting') = 0
		OR dbo.f_CheckRepTable('Dep_ProductSettingDetail') = 0
		OR dbo.f_CheckRepTable('Dep_LicenseeProductSetting') = 0 
		
		OR dbo.f_CheckRepTable('CustInfo') = 0 
		OR dbo.f_CheckRepTable('Customer') = 0 

		OR dbo.f_CheckRepTable('Dep_CustProductStatus') = 0 
	    OR dbo.f_CheckRepTable('Dep_ProductStatusProfile') = 0 
	   )
		RETURN

	CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY, recommend INT, isfinished BIT DEFAULT(0))
	CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY,RoleID INT)
	CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)

	DECLARE @Currency INT, @Site VARCHAR(50)

	SELECT @Site = site, @Currency = currency FROM Customer WITH(NOLOCK) WHERE custid = @srecommend

	DECLARE @BatchSize SMALLINT = 5000

	INSERT INTO #Dummy(CustID)
	SELECT CustID FROM Customer WITH(NOLOCK) 
	WHERE srecommend=@srecommend AND roleid=3 AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

	INSERT INTO #tmpCust(CustID,recommend)
	SELECT ci.CustID,ci.recommend
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid = 1 
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)
	
	INSERT INTO #tmpSMA(CustID,RoleID)
	SELECT CustID,RoleID
	FROM custInfo ci WITH(NOLOCK)
	WHERE ci.srecommend = @srecommend AND ci.custid<=@max_custid 
		AND roleid IN(2,3,4)
		AND ci.Enabled=1
		AND mrecommend NOT IN (SELECT custid FROM #Dummy)		
		
	------------
	DECLARE @SportBettype_tbl Table(Sporttype SMALLINT, BetType SMALLINT, HavePT BIT, HaveComm BIT, HaveBetSetting BIT, HaveBetSettingGame BIT,ProductID TINYINT)
	INSERT INTO @SportBettype_tbl(Sporttype,BetType,HavePT,HaveComm,HaveBetSetting,HaveBetSettingGame,ProductID)
	SELECT a.SportType,a.BetType,
		MAX(CASE WHEN b.SettingType = 1 THEN 1 ELSE 0 END) AS HavePT,
		MAX(CASE WHEN b.SettingType = 9 THEN 1 ELSE 0 END) AS HaveComm,
		MAX(CASE WHEN b.SettingType IN (2,11) THEN 1 ELSE 0 END) AS HaveBetSetting,
		MAX(CASE WHEN b.SettingType IN (10,12) THEN 1 ELSE 0 END) AS HaveBetSettingGame,
		MAX(b.ProductID) AS ProductID
	FROM Dep_ProductSettingDetail a WITH(NOLOCK)
		INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
	WHERE b.ProductID IN(1,3,8)
	GROUP BY a.SportType,a.BetType

-------------------------------------PT Setting-----------------------------------------------
--SMA Level
	--SB
	INSERT INTO dbo.Dep_CustPTSetting_Agent
		(	[CustID]
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,dc.spositiontaking
		   ,dc.mpositiontaking
		   ,dc.apositiontaking
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND dc.islive = 0
	WHERE sp.HavePT = 1
	--NG
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,dc.spositiontaking
		   ,dc.mpositiontaking
		   ,dc.apositiontaking
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
	WHERE sp.HavePT = 1
	--Keno
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,dc.spositiontaking
		   ,dc.mpositiontaking
		   ,dc.apositiontaking
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN CustSettingGame dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
	WHERE sp.HavePT = 1
	
--Member Level
	--SB
	INSERT INTO dbo.Dep_CustPTSetting_Member
		(	CustID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,dc.apositiontaking
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) 
			ON t.CustID = m.CustID 
			AND m.IsGroupedPT = 0
	WHERE sp.HavePT = 1
	--NG
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,dc.apositiontaking
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) 
			ON t.CustID = m.CustID 
			AND m.IsGroupedPT = 0
	WHERE sp.HavePT = 1
	--Keno
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,dc.apositiontaking
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN CustSettingGame dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
		INNER JOIN Dep_CustSettingMode m WITH(NOLOCK) 
			ON t.CustID = m.CustID 
			AND m.IsGroupedPT = 0
	WHERE sp.HavePT = 1

--Group Member Level
	--SB
	INSERT INTO dbo.Dep_CustPTGroupSetting_Member
		(	AgentID
		   ,[SportType]
		   ,[BetType]
		   ,[IsLive]
		   ,[SuperPT]
		   ,[MasterPT]
		   ,[AgentPT]
		 )
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,CASE WHEN  @site = 'asiabet88' AND @currency IN(3,6) AND sp.sporttype = 1 AND sp.bettype = 1
				THEN 0 ELSE dc.apositiontaking END
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND dc.islive = 0
	WHERE sp.HavePT = 1
		AND t.RoleID = 2
	--NG
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,dc.apositiontaking
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
	WHERE sp.HavePT = 1
		AND t.RoleID = 2
	--Keno
	UNION ALL
	SELECT 
			t.[CustID]
		   ,sp.Sporttype
		   ,sp.BetType
		   ,0
		   ,0
		   ,0
		   ,dc.apositiontaking
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN CustSettingGame dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
	WHERE sp.HavePT = 1
		AND t.RoleID = 2

	----------------
	IF @site = 'asiabet88' AND @currency IN(3,6)
	BEGIN
		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #tmpCust t WITH(NOLOCK)
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
			AND EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
	END
	ELSE
	BEGIN
		INSERT INTO Dep_CustSettingMode(CustID,IsGroupedPT)
		SELECT t.CustID,1
		FROM #tmpCust t WITH(NOLOCK)
		WHERE NOT EXISTS (SELECT 1 FROM Dep_CustSettingMode WITH(NOLOCK) WHERE CustID=t.CustID)
			AND NOT EXISTS (SELECT 1 FROM Dep_CustBAActive BA WITH (NOLOCK) WHERE BA.CustId=t.CustID)
	END

	--Insert Dep_LicenseeProductSetting --> PT
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,d.ProductSettingID
	FROM Dep_ProductSetting d WITH(NOLOCK)
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
			ON d.ProductSettingID = dl.ProductSettingID
			AND dl.CustID = @srecommend
	WHERE d.ProductID IN(1,3,8)
		AND d.SettingType = 1
		AND dl.CustID IS NULL

---------------Comm--------------------------
	--insert Dep_CustDiscountSetting_Agent
	IF @site IN ('Saba789','Athena000') --> Init Licensee comm for SB
	BEGIN
		INSERT INTO dbo.Dep_CustDiscountSetting_Agent
		(
			 CustID
			,SportType
			,BetType
			,Discount	
		)
		SELECT t.[CustID]
			   ,sp.Sporttype
			   ,sp.BetType
			   ,CASE WHEN RoleID = 4 THEN  dc.sdiscount
					 WHEN RoleID = 3 THEN  dc.adiscount
				ELSE dc.discount END AS discount
		FROM #tmpSMA t
			CROSS JOIN @SportBettype_tbl sp
			INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
				ON t.CustID = dc.custid
				AND sp.Sporttype = dc.sporttype
				AND sp.BetType = dc.bettype
				AND islive = 0
		WHERE sp.HaveComm = 1
			AND NOT(dc.sdiscount = 0 AND dc.adiscount = 0 AND dc.discount = 0) -- no need initial when discount = 0
	END

	--insert group comm setting
	INSERT INTO dbo.Dep_CustDiscountGroupSetting_Member 
		(AgentID
		,SportType
		,BetType
		,PlayerDiscount
		,AgentDiscount
		,MasterDiscount
		,SuperDiscount		
		)
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,0 AS PlayerDiscount
			,ISNULL(a.discount,0) AS discount
			,ISNULL(a.discount,0) AS adiscount
			,ISNULL(a.discount,0) AS sdiscount
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		LEFT JOIN Dep_CustDiscountSetting_Agent a WITH(NOLOCK) ON a.custid = t.custid AND sp.Sporttype = a.SportType AND sp.BetType = a.BetType
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID 
			and dcs.SportType = sp.sporttype
			AND dcs.BetType = sp.bettype
	WHERE sp.HaveComm = 1
		AND t.roleid = 2
		AND dcs.AgentID IS NULL
	--NG
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,0 AS PlayerDiscount
			,ISNULL(a.discount,0) AS discount
			,ISNULL(a.discount,0) AS adiscount
			,ISNULL(a.discount,0) AS sdiscount
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		LEFT JOIN Dep_CustDiscountSetting_Agent a WITH(NOLOCK) ON a.custid = t.custid AND sp.Sporttype = a.SportType AND sp.BetType = a.BetType
		INNER JOIN Dep_custsetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID 
			and dcs.SportType = sp.sporttype
			AND dcs.BetType = sp.bettype
	WHERE sp.HaveComm = 1
		AND t.roleid = 2
		AND dcs.AgentID IS NULL
	--Keno
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,0 AS PlayerDiscount
			,ISNULL(a.discount,0) AS discount
			,ISNULL(a.discount,0) AS adiscount
			,ISNULL(a.discount,0) AS sdiscount
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		LEFT JOIN Dep_CustDiscountSetting_Agent a WITH(NOLOCK) ON a.custid = t.custid AND sp.Sporttype = a.SportType AND sp.BetType = a.BetType
		INNER JOIN CustSettingGame dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
		LEFT JOIN Dep_CustDiscountGroupSetting_Member dcs WITH (NOLOCK) 
			ON dcs.AgentID = t.CustID 
			and dcs.SportType = sp.sporttype
			AND dcs.BetType = sp.bettype
	WHERE sp.HaveComm = 1
		AND t.roleid = 2
		AND dcs.AgentID IS NULL

	UPDATE #tmpCust SET isfinished = 0
	DECLARE @Cust_Temp TABLE(CustID INT)

	WHILE (1=1)
	BEGIN
		UPDATE TOP (@BatchSize) c WITH (ROWLOCK)
		SET c.isfinished = 1
		OUTPUT DELETED.CustID INTO @Cust_Temp(CustID)
		FROM #tmpCust c 
		WHERE isfinished = 0
		
		IF @@ROWCOUNT = 0
			BREAK;
		
		-- UPDATE comm group for cust have not offered comm yet.
		UPDATE cs
			SET isGroupedComm = 1
		FROM dbo.Dep_CustSettingMode cs WITH(UPDLOCK,ROWLOCK)
			INNER JOIN @Cust_Temp cb ON cb.CustID = cs.CustID
			OUTER APPLY (SELECT TOP 1 dcs_m.CustID FROM Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) WHERE dcs_m.CustID = cs.CustID) AS tmp
		WHERE ISNULL(cs.IsGroupedComm,0) = 0 AND tmp.CustID IS NULL
		
		-- insert private setting if already offered comm before and not belong to comm group
		INSERT INTO Dep_CustDiscountSetting_Member (CustID
							,SportType
							,BetType
							,PlayerDiscount
							,AgentDiscount
							,MasterDiscount
							,SuperDiscount)  	
		SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,0 AS PlayerDiscount
			,ISNULL(a.discount,0) AS discount
			,ISNULL(a.discount,0) AS adiscount
			,ISNULL(a.discount,0) AS sdiscount
		FROM Dep_CustSettingMode c WITH (NOLOCK)
			INNER JOIN #tmpCust t ON c.CustID = t.CustID
			CROSS JOIN @SportBettype_tbl sp
			LEFT JOIN Dep_CustDiscountSetting_Agent a WITH(NOLOCK,FORCESEEK) 
				ON a.custid = t.recommend 
				AND sp.Sporttype = a.SportType 
				AND sp.BetType = a.BetType
			LEFT JOIN Dep_CustDiscountSetting_Member dcs_m WITH (NOLOCK) 
				ON dcs_m.CustID = c.CustID and dcs_m.SportType = sp.sporttype
				AND dcs_m.BetType = sp.bettype				
		WHERE c.IsGroupedComm = 0 
			AND dcs_m.custid IS NULL
			AND sp.HaveComm = 1
			
		DELETE FROM @Cust_Temp
	END

	--Insert Dep_LicenseeProductSetting --> Comm
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,d.ProductSettingID
	FROM Dep_ProductSetting d WITH(NOLOCK)
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
			ON d.ProductSettingID = dl.ProductSettingID
			AND dl.CustID = @srecommend
	WHERE d.ProductID IN(1,3,8)
		AND d.SettingType = 9
		AND dl.CustID IS NULL
-------------------------------------Bet Setting Game-----------------------------------------------------------
--SMA
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
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,Maxpermatch = CASE WHEN sp.Sporttype = 1 AND sp.BetType = 1 THEN ci.maxpermatch 
								WHEN sp.Sporttype = 1 AND sp.BetType = 9 THEN ci.MaxPerMatch1MP 
								WHEN sp.Sporttype = 2 AND sp.BetType = 1 THEN ci.maxpermatch2 
								WHEN sp.Sporttype = 3 AND sp.BetType = 1 THEN ci.maxpermatch3 
								WHEN sp.Sporttype = 5 AND sp.BetType = 1 THEN ci.maxpermatch5 
								WHEN sp.Sporttype = 8 AND sp.BetType = 1 THEN ci.maxpermatch8 
								WHEN sp.Sporttype = 10 AND sp.BetType = 1 THEN ci.maxpermatch10 
								WHEN sp.Sporttype = 11 AND sp.BetType = 1 THEN ci.maxpermatch11 
								WHEN sp.Sporttype = 99 AND sp.BetType = 1 THEN ci.maxpermatch99 
								WHEN sp.Sporttype = 99 AND sp.BetType = 9 THEN ci.MaxPerMatch99MP
							END
			,MaxPerBall = NULL
			,MaxPayoutPermatch = CASE	WHEN sp.sporttype = 1 AND sp.bettype = 1 AND ci.maxpermatch >= 1 THEN ci.maxpermatch*8
								WHEN sp.sporttype = 1 AND sp.bettype = 9 AND ci.MaxPerMatch1MP >= 1 THEN ci.MaxPerMatch1MP*8
								WHEN sp.sporttype = 2 AND sp.bettype = 1 AND ci.maxpermatch2 >= 1 THEN ci.maxpermatch2*8
								WHEN sp.sporttype = 3 AND sp.bettype = 1 AND ci.maxpermatch3 >= 1 THEN ci.maxpermatch3*8
								WHEN sp.sporttype = 5 AND sp.bettype = 1 AND ci.maxpermatch5 >= 1 THEN ci.maxpermatch5*8
								WHEN sp.sporttype = 8 AND sp.bettype = 1 AND ci.maxpermatch8 >= 1 THEN ci.maxpermatch8*8
								WHEN sp.sporttype = 10 AND sp.bettype = 1 AND ci.maxpermatch10 >= 1 THEN ci.maxpermatch10*8
								WHEN sp.sporttype = 11 AND sp.bettype = 1 AND ci.maxpermatch11 >= 1 THEN ci.maxpermatch11*8
								WHEN sp.sporttype = 99 AND sp.bettype = 1 AND ci.maxpermatch99 >= 1 THEN ci.maxpermatch99*8
								WHEN sp.sporttype = 99 AND sp.bettype = 9 AND ci.MaxPerMatch99MP >= 1 THEN ci.MaxPerMatch99MP*8
								----------------Special value-----------------
								WHEN sp.sporttype = 1 AND sp.bettype = 1 AND ci.maxpermatch < 1 THEN ci.maxpermatch
								WHEN sp.sporttype = 1 AND sp.bettype = 9 AND ci.MaxPerMatch1MP < 1 THEN ci.MaxPerMatch1MP
								WHEN sp.sporttype = 2 AND sp.bettype = 1 AND ci.maxpermatch2 < 1 THEN ci.maxpermatch2
								WHEN sp.sporttype = 3 AND sp.bettype = 1 AND ci.maxpermatch3 < 1 THEN ci.maxpermatch3
								WHEN sp.sporttype = 5 AND sp.bettype = 1 AND ci.maxpermatch5 < 1 THEN ci.maxpermatch5
								WHEN sp.sporttype = 8 AND sp.bettype = 1 AND ci.maxpermatch8 < 1 THEN ci.maxpermatch8
								WHEN sp.sporttype = 10 AND sp.bettype = 1 AND ci.maxpermatch10 < 1 THEN ci.maxpermatch10
								WHEN sp.sporttype = 11 AND sp.bettype = 1 AND ci.maxpermatch11 < 1 THEN ci.maxpermatch11
								WHEN sp.sporttype = 99 AND sp.bettype = 1 AND ci.maxpermatch99 < 1 THEN ci.maxpermatch99
								WHEN sp.sporttype = 99 AND sp.bettype = 9 AND ci.MaxPerMatch99MP < 1 THEN ci.MaxPerMatch99MP
						END
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1
	--E-Sport
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,dc.Maxpermatch
			,MaxperBall = NULL
			,MaxPayoutPermatch = CASE WHEN dc.Maxpermatch > = 1 THEN dc.MaxPerMatch*8 ELSE dc.MaxPerMatch END
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustBetSetting_Agent dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1
	--NG
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,Maxpermatch = CASE WHEN sp.Sporttype = 161 AND sp.BetType = 81 THEN ci.maxpermatch161 END
			,MaxperBall = CASE WHEN sp.Sporttype = 161 AND sp.BetType = 81 THEN ci.MaxPerBall161 END
			,MaxPayoutPermatch = NULL
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1

	--Insert for Saba soccer,saba basket ball
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
	SELECT dc.CustID,
		dc.SportType + 9900,
		dc.BetType,
		dc.MinBet,
		dc.MaxBet,
		dc.MaxPerMatch,
		dc.MaxPerNumber,
		dc.MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Agent dc WITH(NOLOCK)
		INNER JOIN #tmpSMA t 
			ON dc.CustID = t.CustID
		LEFT JOIN Dep_CustBetSettingGame_Agent ex WITH(NOLOCK) 
			ON dc.CustID = ex.CustID 
			AND dc.SportType + 9900 = ex.SportType
			AND dc.BetType = ex.BetType
	WHERE dc.SportType IN(1,2) AND dc.BetType = 1
		AND ex.CustID IS NULL

--Member
	INSERT INTO Dep_CustBetSettingGame_Member(
		CustID,
		SportType,
		BetType,
		MinBet,
		MaxBet,
		MaxPerMatch,
		MaxPerNumber,
		MaxPayoutPerMatch
	)
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,Maxpermatch = CASE WHEN sp.Sporttype = 1 AND sp.BetType = 1 THEN ci.maxpermatch 
								WHEN sp.Sporttype = 1 AND sp.BetType = 9 THEN ci.MaxPerMatch1MP 
								WHEN sp.Sporttype = 2 AND sp.BetType = 1 THEN ci.maxpermatch2 
								WHEN sp.Sporttype = 3 AND sp.BetType = 1 THEN ci.maxpermatch3 
								WHEN sp.Sporttype = 5 AND sp.BetType = 1 THEN ci.maxpermatch5 
								WHEN sp.Sporttype = 8 AND sp.BetType = 1 THEN ci.maxpermatch8 
								WHEN sp.Sporttype = 10 AND sp.BetType = 1 THEN ci.maxpermatch10 
								WHEN sp.Sporttype = 11 AND sp.BetType = 1 THEN ci.maxpermatch11 
								WHEN sp.Sporttype = 99 AND sp.BetType = 1 THEN ci.maxpermatch99 
								WHEN sp.Sporttype = 99 AND sp.BetType = 9 THEN ci.MaxPerMatch99MP
							END
			,MaxPerBall = NULL
			,MaxPayoutPermatch = CASE	WHEN sp.sporttype = 1 AND sp.bettype = 1 AND ci.maxpermatch >= 1 THEN ci.maxpermatch*8
								WHEN sp.sporttype = 1 AND sp.bettype = 9 AND ci.MaxPerMatch1MP >= 1 THEN ci.MaxPerMatch1MP*8
								WHEN sp.sporttype = 2 AND sp.bettype = 1 AND ci.maxpermatch2 >= 1 THEN ci.maxpermatch2*8
								WHEN sp.sporttype = 3 AND sp.bettype = 1 AND ci.maxpermatch3 >= 1 THEN ci.maxpermatch3*8
								WHEN sp.sporttype = 5 AND sp.bettype = 1 AND ci.maxpermatch5 >= 1 THEN ci.maxpermatch5*8
								WHEN sp.sporttype = 8 AND sp.bettype = 1 AND ci.maxpermatch8 >= 1 THEN ci.maxpermatch8*8
								WHEN sp.sporttype = 10 AND sp.bettype = 1 AND ci.maxpermatch10 >= 1 THEN ci.maxpermatch10*8
								WHEN sp.sporttype = 11 AND sp.bettype = 1 AND ci.maxpermatch11 >= 1 THEN ci.maxpermatch11*8
								WHEN sp.sporttype = 99 AND sp.bettype = 1 AND ci.maxpermatch99 >= 1 THEN ci.maxpermatch99*8
								WHEN sp.sporttype = 99 AND sp.bettype = 9 AND ci.MaxPerMatch99MP >= 1 THEN ci.MaxPerMatch99MP*8
								----------------Special value-----------------
								WHEN sp.sporttype = 1 AND sp.bettype = 1 AND ci.maxpermatch < 1 THEN ci.maxpermatch
								WHEN sp.sporttype = 1 AND sp.bettype = 9 AND ci.MaxPerMatch1MP < 1 THEN ci.MaxPerMatch1MP
								WHEN sp.sporttype = 2 AND sp.bettype = 1 AND ci.maxpermatch2 < 1 THEN ci.maxpermatch2
								WHEN sp.sporttype = 3 AND sp.bettype = 1 AND ci.maxpermatch3 < 1 THEN ci.maxpermatch3
								WHEN sp.sporttype = 5 AND sp.bettype = 1 AND ci.maxpermatch5 < 1 THEN ci.maxpermatch5
								WHEN sp.sporttype = 8 AND sp.bettype = 1 AND ci.maxpermatch8 < 1 THEN ci.maxpermatch8
								WHEN sp.sporttype = 10 AND sp.bettype = 1 AND ci.maxpermatch10 < 1 THEN ci.maxpermatch10
								WHEN sp.sporttype = 11 AND sp.bettype = 1 AND ci.maxpermatch11 < 1 THEN ci.maxpermatch11
								WHEN sp.sporttype = 99 AND sp.bettype = 1 AND ci.maxpermatch99 < 1 THEN ci.maxpermatch99
								WHEN sp.sporttype = 99 AND sp.bettype = 9 AND ci.MaxPerMatch99MP < 1 THEN ci.MaxPerMatch99MP
						END
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1
	--E-Sport
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,dc.Maxpermatch
			,MaxperBall = NULL
			,MaxPayoutPermatch = CASE WHEN dc.Maxpermatch > = 1 THEN dc.MaxPerMatch*8 ELSE dc.MaxPerMatch END
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustBetSetting_Member dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1
	--NG
	UNION ALL
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,Maxpermatch = CASE WHEN sp.Sporttype = 161 AND sp.BetType = 81 THEN ci.maxpermatch161 END
			,MaxperBall = CASE WHEN sp.Sporttype = 161 AND sp.BetType = 81 THEN ci.MaxPerBall161 END
			,MaxPayoutPermatch = NULL
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN Dep_CustSetting3rd dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND sp.Sporttype = dc.sporttype
			AND sp.BetType = dc.bettype
			AND islive = 0
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSettingGame = 1

	--Insert for Saba soccer,saba basket ball
	INSERT INTO Dep_CustBetSettingGame_Member(
		CustID,
		SportType,
		BetType,
		MinBet,
		MaxBet,
		MaxPerMatch,
		MaxPerNumber,
		MaxPayoutPerMatch
	)
	SELECT dc.CustID,
		dc.SportType + 9900,
		dc.BetType,
		dc.MinBet,
		dc.MaxBet,
		dc.MaxPerMatch,
		dc.MaxPerNumber,
		dc.MaxPayoutPerMatch
	FROM Dep_CustBetSettingGame_Member dc WITH(NOLOCK)
		INNER JOIN #tmpCust t 
			ON dc.CustID = t.CustID
		LEFT JOIN Dep_CustBetSettingGame_Member ex WITH(NOLOCK) 
			ON dc.CustID = ex.CustID 
			AND dc.SportType + 9900 = ex.SportType
			AND dc.BetType = ex.BetType
	WHERE dc.SportType IN(1,2) AND dc.BetType = 1
		AND ex.CustID IS NULL

	--Insert Dep_LicenseeProductSetting --> Bet Setting Game
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,d.ProductSettingID
	FROM Dep_ProductSetting d WITH(NOLOCK)
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
			ON d.ProductSettingID = dl.ProductSettingID
			AND dl.CustID = @srecommend
	WHERE d.ProductID IN(1,3)
		AND d.SettingType IN(10,12)
		AND dl.CustID IS NULL

-------------------------------------Bet Setting -----------------------------------------------------------
--SMA
	INSERT INTO Dep_CustBetSetting_Agent(
		CustID,
		SportType,
		BetType,
		MinBet,
		MaxBet,
		MaxPerMatch
	)
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,dc.MaxPerGameType
	FROM #tmpSMA t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN CustGameType dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND dc.GameTypeID = CASE WHEN sp.Sporttype = 202 AND sp.BetType = 1501 THEN 1 END
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSetting = 1

--Member
	INSERT INTO Dep_CustBetSetting_Member(
		CustID,
		SportType,
		BetType,
		MinBet,
		MaxBet,
		MaxPerMatch
	)
	SELECT t.[CustID]
			,sp.Sporttype
			,sp.BetType
			,dc.minbet
			,dc.maxbet
			,dc.MaxPerGameType
	FROM #tmpCust t
		CROSS JOIN @SportBettype_tbl sp
		INNER JOIN CustGameType dc WITH(NOLOCK)
			ON t.CustID = dc.custid
			AND dc.GameTypeID = CASE WHEN sp.Sporttype = 202 AND sp.BetType = 1501 THEN 1 END
		INNER JOIN custInfo ci WITH(NOLOCK)
			ON t.custid = ci.custid
	WHERE sp.HaveBetSetting = 1

	--Insert Dep_LicenseeProductSetting --> Bet Setting
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,d.ProductSettingID
	FROM Dep_ProductSetting d WITH(NOLOCK)
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
			ON d.ProductSettingID = dl.ProductSettingID
			AND dl.CustID = @srecommend
	WHERE d.ProductID = 8
		AND d.SettingType = 2
		AND dl.CustID IS NULL
--------------------------------------------Enable Status--------------------------------------------------
	CREATE TABLE #AllUsers (CustID int PRIMARY KEY)
	CREATE TABLE #Dep_CustProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32),isfinished BIT DEFAULT(0))
	CREATE TABLE #TempProductStatus(CustID int PRIMARY KEY,bitmapIsHidden binary(32), bitmapIsDisabled binary(32))
	DECLARE @BitOrder_NG TINYINT = 12
	DECLARE @BitOrder_KN TINYINT = 13

	INSERT INTO #AllUsers (CustID) -- Get distinct custID
	SELECT SMA.CustID FROM #tmpSMA SMA WITH (NOLOCK)
	UNION 
	SELECT M.CustID FROM #tmpCust M WITH (NOLOCK)

	INSERT INTO Dep_CustProductStatus (CustID,bitmapIsDisabled,bitmapIsHidden)
	SELECT	 A.custid
			, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF AS bitmapIsDisabled
			, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF  AS bitmapIsHidden
	FROM #AllUsers A
	WHERE NOT EXISTS (SELECT 1 FROM Dep_CustProductStatus WITH (NOLOCK) WHERE CustID = A.CustID)

	--generate Number Game status
	INSERT INTO #Dep_CustProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
	SELECT c.CustID
		,bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder_NG,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder_NG,ci.DisableNumber))
	FROM Dep_CustProductStatus c WITH(NOLOCK)
		INNER JOIN custInfo ci WITH(NOLOCK) ON c.CustID = ci.custid
		INNER JOIN  #AllUsers temp ON temp.CustID = c.custid
	
	--Update Keno status
	UPDATE c 
	SET  bitmapIsHidden = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsHidden,@BitOrder_KN,0))
		,bitmapIsDisabled = (SELECT NewBitmap FROM dbo.f_CustSetting_GenerateProductStatus (c.bitmapIsDisabled,@BitOrder_KN,cg.IsDisabled))
	FROM #Dep_CustProductStatus c
		INNER JOIN CustGameType cg WITH(NOLOCK) 
			ON c.CustID = cg.CustID
	WHERE cg.GameTypeID = 1
		
	SET @BatchSize = 5000

	WHILE 1 = 1 
	BEGIN
		TRUNCATE TABLE #TempProductStatus

		UPDATE TOP (@BatchSize) a WITH (ROWLOCK)
		SET a.isfinished = 1
		OUTPUT DELETED.CustID,DELETED.bitmapIsHidden,DELETED.bitmapIsDisabled INTO #TempProductStatus(CustID,bitmapIsHidden,bitmapIsDisabled)
		FROM #Dep_CustProductStatus a 
		WHERE a.isfinished = 0
		
		IF @@ROWCOUNT = 0 
			BREAK;

		UPDATE c 
		SET  c.bitmapIsHidden = tmp.bitmapIsHidden
			,c.bitmapIsDisabled = tmp.bitmapIsDisabled
		FROM Dep_CustProductStatus c WITH(ROWLOCK, UPDLOCK)
			INNER JOIN #TempProductStatus tmp ON c.CustID = tmp.CustID

		WAITFOR DELAY '00:00:00.050'
	END

	--Insert Dep_LicenseeProductSetting --> Status
	INSERT INTO Dep_LicenseeProductSetting(CustID,ProductSettingID)
	SELECT @srecommend,d.ProductSettingID
	FROM Dep_ProductSetting d WITH(NOLOCK)
		LEFT JOIN Dep_LicenseeProductSetting dl WITH(NOLOCK) 
			ON d.ProductSettingID = dl.ProductSettingID
			AND dl.CustID = @srecommend
	WHERE d.ProductID IN(3,8)
		AND d.SettingType = 4
		AND dl.CustID IS NULL

	DROP TABLE #Dummy
	DROP TABLE #tmpCust
	DROP TABLE #tmpSMA
	DROP TABLE #Dep_CustProductStatus
	DROP TABLE #TempProductStatus
	DROP TABLE #AllUsers
END
GO
-- END STEP 5.1: DEPLOY THIS SP @ DBCUST.CustDB -------

------------------------------------------------------	
-- BEGIN STEP 5.2: Run this SP at replicated DB: DB06, DBTP -----
--------------------------------------------------------------------------------------
PRINT N'Step 5: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';

DECLARE @target VARCHAR(20)
IF @@SERVERNAME IN ('DBCUST','SITDBCUST','DB233','DB-60\DEVDBCUST')
	SET @target = 'DBCUST'
ELSE 
	SET @target = 'REPLICATED'

Print 'Server Name : ' + @target

IF	OBJECT_ID('tempdb..#supers') IS NOT NULL
		DROP TABLE	#supers;
CREATE TABLE #supers (custid int,isfinished bit default(0))

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

INSERT INTO #supers(custid)
SELECT ci.custid
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.CustID <= @max_custid
		AND ci.Enabled=1
		AND cs.site IN('spondemo','Athena000')	
		AND Ci.currency  IN (20)
ORDER BY ci.custid 

DECLARE @super_cnt INT, @index INT = 0

SET @super_cnt = (SELECT COUNT(*) FROM #supers )

DECLARE @msg nvarchar(200) = 'Currently at order %d, SuperID: %d.'

DECLARE @msg_total nvarchar(200) = 'Total of supers: %d.'

RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	
	
	UPDATE TOP (1) #supers
	SET isfinished = 1
		,@srecommend = custid			
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK

	SET @index = @index + 1
	
	RAISERROR (@msg, 0, 1,@index, @srecommend) WITH NOWAIT
	
	EXEC dbo.[Acc_Dep_DynamicCustSetting_09] @srecommend = @srecommend, @max_custid=@max_custid,@target = @target
				
	WAITFOR DELAY '00:00:00.280'			
END	

DROP TABLE #supers		
GO
PRINT N'Step 5: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
