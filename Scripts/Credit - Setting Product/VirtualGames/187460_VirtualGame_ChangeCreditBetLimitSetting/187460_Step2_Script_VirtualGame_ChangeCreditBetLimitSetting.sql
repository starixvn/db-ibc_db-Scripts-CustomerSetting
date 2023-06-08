/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/05/08
	Task: Virtual Game - Change credit bet limit setting [redmine : #187460]
	DB: DBCUST/CustDB
	Revisions: Initial Script Collect Cust Setting Need Update
*/

 ----- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST và ALL REPLICATED SERVERS -----
 

PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	SET NOCOUNT ON
	DECLARE @max_custid			INT
		,	@SportType			SMALLINT = 245
		,	@target				VARCHAR(20) 

	SELECT @max_custid = xxx

	IF @@SERVERNAME IN ('DBCUST','SITDBCUST','TESTDBCUST')
		SET @target = 'DBCUST'
	ELSE 
		SET @target = 'REPLICATED'
	Print 'Server Name : ' + @target

	   	
	CREATE TABLE #StakeLevel (
		ExchangeId			INT , 
		GameTypeID			INT , 
		StakeLevelID		INT 
	)

	; WITH Cte AS (
	SELECT
		CASE 
			WHEN sl.ExchangeId IN (6,78) THEN ROW_NUMBER() OVER(PARTITION BY sl.ExchangeId , sl.GameTypeID ORDER BY sl.GameTypeID , sl.MaxStake ASC)				-- only EUR,EURO (Euro') will be set at the lowest once
			ELSE						 ROW_NUMBER() OVER(PARTITION BY sl.ExchangeId , sl.GameTypeID ORDER BY sl.GameTypeID , sl.MaxStake DESC)					-- all currencies now will be set at the highest level
		END AS RowN		,
		sl.StakeLevelID , 
		sl.GameTypeID	,
		sl.ExchangeId
	FROM StakeLevel sl WITH (NOLOCK)
	WHERE sl.GameTypeID IN (4601,4602,4605) )

	INSERT INTO #StakeLevel
	SELECT ExchangeId , GameTypeID  , StakeLevelID
	FROM Cte
	where RowN = 1

	-- Collect SuperStakeLevelList 
	CREATE TABLE #SuperStakeLevelList (
		Custid				INT , 
		BetType				INT , 
		StakeLevelList		VARCHAR (200) ,
		ExchangeID			INT ,
		PRIMARY KEY CLUSTERED (Custid  , BetType) 
	)

	INSERT INTO #SuperStakeLevelList (Custid , BetType , StakeLevelList , ExchangeID)
	SELECT ci.custid , ca.BetType , ca.StakeLevelList , ci.currency
	FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) 
				ON ci.site = s.site
	LEFT JOIN custsuper cs WITH (NOLOCK) 
				ON ci.custid = cs.custid
	INNER JOIN CustStakeLevel_Agent ca WITH (NOLOCK)
				ON ci.custid = ca.CustID
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.custid <= @max_custid
		AND ca.StakeLevelList IS NOT NULL
		AND ca.StakeLevelList <> ''
		AND ca.SportType = @SportType
		AND ca.BetType IN (4601,4602,4605) 
	GROUP BY ci.custid , ca.SportType , ca.BetType , ca.StakeLevelList , ci.currency


	UPDATE st SET st.StakeLevelList = sl.StakeLevelID
	FROM #SuperStakeLevelList st
	INNER JOIN #StakeLevel sl  ON sl.ExchangeId = st.ExchangeID AND sl.GameTypeID = st.BetType


	-- For Deployed Info
	CREATE TABLE #CustAffected (
		Custid				INT , 
		BetType				INT , 
		StakeLevelList		VARCHAR (200)  )

	DECLARE @sma_cnt		INT
		,	@mem_cnt		INT
		,	@AffectedList	VARCHAR(MAX) = ''
		,	@batch			INT = 5000
		,	@RoleCheck		SMALLINT

----------------------------CustStakeLevel_Agent----------------------------
	CREATE TABLE #StakeLevel_Agent (
		Custid				INT , 
		BetType				INT , 
		StakeLevelList		VARCHAR (200) ,
		PRIMARY KEY CLUSTERED (Custid  , BetType) 
	)
	
	-- Collect CustStakeLevel_Agent
	INSERT INTO #StakeLevel_Agent
	SELECT ca.CustID , cl.BetType , cl.StakeLevelList  
	FROM CustStakeLevel_Agent ca WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK)			ON ca.CustID = c.custid
			INNER JOIN #SuperStakeLevelList	cl			ON cl.CustID = c.srecommend AND ca.BetType = cl.BetType
	WHERE  ca.SportType = @SportType 
	AND ca.StakeLevelList IS NOT NULL 
	AND ca.StakeLevelList <> ''
	AND c.roleid IN (2,3,4)
	AND c.Enabled = 1

	DECLARE @msg_total_sma NVARCHAR(200) = 'Total of SMA Affected: %d.'

	SET @sma_cnt = (SELECT COUNT(1) FROM #StakeLevel_Agent )
	RAISERROR (@msg_total_sma, 0, 1, @sma_cnt) WITH NOWAIT

	WHILE (1 = 1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@batch) s WITH (ROWLOCK)
		OUTPUT DELETED.custid , DELETED.BetType , DELETED.StakeLevelList 
			INTO #CustAffected (custid , BetType , StakeLevelList )
		FROM #StakeLevel_Agent s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SET @AffectedList =  (	SELECT 
								CustID			as '@C' ,			-- @CustID
								BetType			as '@B' ,			-- @BetType
								StakeLevelList	as '@SL'			-- @StakeLevelList
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList , @RoleCheck = 2 , @target = @target			  -- RUN UPDATE FOR SMA

		WAITFOR DELAY  '00:00:0.050'	
		
		SET @msg_total_sma = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_sma, 0, 1) WITH NOWAIT

	END

----------------------------END_CustStakeLevel_Agent----------------------------


-----------------------------CustStakeLevel_Member------------------------------
	CREATE TABLE #StakeLevel_Member (
		Custid				INT , 
		BetType				INT , 
		StakeLevelList		VARCHAR (200) ,
		PRIMARY KEY CLUSTERED (Custid  , BetType) 
	)

	-- Collect CustStakeLevel_Member
	INSERT INTO #StakeLevel_Member
	SELECT  cm.CustID , cl.BetType , cl.StakeLevelList  
	FROM CustStakeLevel_Member cm WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK) ON cm.CustID = c.custid
			INNER JOIN #SuperStakeLevelList	cl			ON cl.CustID = c.srecommend AND cm.BetType = cl.BetType
	WHERE  cm.SportType = @SportType 
	AND cm.StakeLevelList IS NOT NULL 
	AND cm.StakeLevelList <> ''
	AND c.roleid = 1
	AND c.Enabled = 1

	DECLARE @msg_total_mem NVARCHAR(200) = 'Total of Member Affected: %d.'

	SET @mem_cnt = (SELECT COUNT(1) FROM #StakeLevel_Member )
	RAISERROR (@msg_total_mem, 0, 1, @mem_cnt) WITH NOWAIT
	 
	WHILE (1 = 1)
	BEGIN
		TRUNCATE TABLE #CustAffected

		DELETE TOP (@batch) s WITH (ROWLOCK)
		OUTPUT DELETED.custid , DELETED.BetType , DELETED.StakeLevelList 
			INTO #CustAffected (custid , BetType , StakeLevelList )
		FROM #StakeLevel_Member s

		IF @@ROWCOUNT = 0 
			BREAK ;

		SET @AffectedList =  (	SELECT 
								CustID			as '@C' ,			-- @CustID
								BetType			as '@B' ,			-- @BetType
								StakeLevelList	as '@SL'			-- @StakeLevelList
								FROM #CustAffected
								FOR XML PATH('r'), ROOT ('root')  
							)

		EXEC dbo.Acc_DynamicCustSetting3rd_09 @AffectedList = @AffectedList , @RoleCheck = 1 , @target = @target     -- RUN UPDATE FOR MEMBER

		WAITFOR DELAY  '00:00:0.050'	
		
		SET @msg_total_mem = 'curdt: ' + convert(varchar(50), getdate(), 121)
		RAISERROR (@msg_total_mem, 0, 1) WITH NOWAIT

	END

-----------------------------END_CustStakeLevel_Member-----------------------------

	DROP TABLE #StakeLevel
	DROP TABLE #SuperStakeLevelList
	DROP TABLE #CustAffected
	DROP TABLE #StakeLevel_Agent
	DROP TABLE #StakeLevel_Member


