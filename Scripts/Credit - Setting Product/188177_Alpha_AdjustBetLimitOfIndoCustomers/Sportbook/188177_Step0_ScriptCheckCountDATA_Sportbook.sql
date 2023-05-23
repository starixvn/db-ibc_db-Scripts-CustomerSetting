/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
  Created by: Helios
  Date: 2023/05/16
  Task: Alpha - Adjust bet limit of Indo customers [redmine : #188177]
  DB: DBCUST/CustDB
 
  Revisions: Initial Script Collect Cust Setting Need Update
*/

--DEPLOY THIS @DBCUST.CustDB --------


	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	SET NOCOUNT ON
	DECLARE @max_custid			INT

	SELECT  @max_custid = xxx
	   	
	--Currency apply setting
	CREATE TABLE #Exchange (ExchangeId INT PRIMARY KEY  )

	INSERT INTO #Exchange
	SELECT ExchangeId 
	FROM exchange WITH (NOLOCK)
	WHERE currency IN ('IN', 'IND', 'IDD', 'IDR', 'DDD')									-- currency apply setting


	CREATE TABLE #tmpSuperBetSetting (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	--Collect Super FlowBet Setting Sportbook
	INSERT INTO #tmpSuperBetSetting (CustID , SportType , BetType)
	SELECT ci.custid , ca.SportType , ca.BetType
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	INNER JOIN CustBetSetting_Agent ca WITH (NOLOCK)
				ON ci.custid = ca.CustID
	WHERE 
		s.siteid  IN (487,11)																-- Site apply modified: IBCIndo (Site ID = 487), INDO ( ID = 11)
		AND ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ci.currency IN  (SELECT ExchangeId FROM #Exchange ) 
		AND ca.SportType NOT IN (161,164)													-- Just Apply For Sportbook
	GROUP BY ci.custid , ca.SportType , ca.BetType

	-- For Deployed Info
	CREATE TABLE #CustAffected (
		CustID			INT ,
		SportType		INT ,
		BetType			INT  )

	DECLARE @sma_cnt		INT
		,	@mem_cnt		INT
		,	@AffectedList	VARCHAR(MAX) = ''
		,	@batch			INT = 3000
		,	@RoleCheck		SMALLINT

----------------------------CustBetSetting_Agent----------------------------
	CREATE TABLE #BetSetting_Agent (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)
	
	-- Collect SMA BetSetting
	INSERT INTO #BetSetting_Agent (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType
	FROM CustBetSetting_Agent ca WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK)			ON ca.CustID = c.custid
			INNER JOIN #tmpSuperBetSetting	cl			ON cl.CustID = c.srecommend AND ca.SportType  = cl.SportType AND ca.BetType = cl.BetType
	WHERE  c.roleid IN (2,3,4)
	AND c.Enabled = 1
	AND ca.MaxBet > 1 	AND ca.MaxPerMatch > 1											-- Don't need to update for data rows which Max Bet < 1 or Max Per Match < 1.
	AND ca.MinBet < 26																	-- Apply For SportBook --> Adjust Minbet from (<=)25 to 10
	AND ca.SportType NOT IN (161,164)
	GROUP BY ca.CustID , ca.SportType , ca.BetType

	DECLARE @msg_total_sma NVARCHAR(200) = 'Total of SMA Affected: %d.'

	SET @sma_cnt = (SELECT COUNT(1) FROM #BetSetting_Agent )
	RAISERROR (@msg_total_sma, 0, 1, @sma_cnt) WITH NOWAIT

	SELECT COUNT(1) as 'SMA_Count_Values'
	FROM #BetSetting_Agent

----------------------------CustBetSetting_Member----------------------------
	CREATE TABLE #BetSetting_Member (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)
	
	-- Collect Member BetSetting
	INSERT INTO #BetSetting_Member (CustID , SportType , BetType)
	SELECT ca.CustID , ca.SportType , ca.BetType
	FROM CustBetSetting_Member ca WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK)			ON ca.CustID = c.custid
			INNER JOIN #tmpSuperBetSetting	cl			ON cl.CustID = c.srecommend AND ca.SportType  = cl.SportType AND ca.BetType = cl.BetType
	WHERE  c.roleid = 1
	AND c.Enabled = 1
	AND ca.MaxBet > 1 	AND ca.MaxPerMatch > 1											-- Don't need to update for data rows which Max Bet < 1 or Max Per Match < 1.
	AND ca.MinBet < 26																	-- Apply For SportBook --> Adjust Minbet from (<=)25 to 10
	AND ca.SportType NOT IN (161,164)
	GROUP BY ca.CustID , ca.SportType , ca.BetType


	DECLARE @msg_total_mem  NVARCHAR(200) = 'Total of Member Affected: %d.'

	SET @mem_cnt = (SELECT COUNT(1) FROM #BetSetting_Member )
	RAISERROR (@msg_total_mem , 0, 1, @mem_cnt) WITH NOWAIT

	SELECT COUNT(1) as 'Member_Count_Values'
	FROM #BetSetting_Member

	DROP TABLE #tmpSuperBetSetting
	DROP TABLE #Exchange
	DROP TABLE #BetSetting_Agent
	DROP TABLE #BetSetting_Member
	DROP TABLE #CustAffected


