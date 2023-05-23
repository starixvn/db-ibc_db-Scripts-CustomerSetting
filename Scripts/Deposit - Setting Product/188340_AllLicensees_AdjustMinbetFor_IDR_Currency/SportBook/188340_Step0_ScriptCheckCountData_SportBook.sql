/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/05/17
	Task: All licensees - Adjust minbet for IDR currency [redmine : #188340]
	DB: DBCUST/CustDB
	Revisions: Initial Script Collect Cust Setting Need Update
*/


	PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  

	SET NOCOUNT ON
	DECLARE @max_custid			INT

	--SELECT  @max_custid = xxx	 
	
	--Currency apply setting
	CREATE TABLE #Exchange (ExchangeId INT PRIMARY KEY  )

	INSERT INTO #Exchange
	SELECT ExchangeId 
	FROM exchange WITH (NOLOCK)
	WHERE currency IN ('IN','IN2')

	CREATE TABLE #SportType_BetType_ApplyChanged(
		SportType		INT ,
		BetType			INT ,
		PRIMARY KEY CLUSTERED (SportType , BetType)
	)


	-- Collect SportType BetType of SportBook
	INSERT INTO #SportType_BetType_ApplyChanged
	SELECT DISTINCT SportType , Bettype 
	FROM Dep_ProductSetting ps WITH(NOLOCK)   
	INNER JOIN Dep_ProductSettingDetail d WITH(NOLOCK) ON ps.ProductSettingID=d.ProductSettingID    
	WHERE ProductID = 1 AND SettingType IN (10,12)


	CREATE TABLE #tmpSuperBetSetting (
		CustID			INT ,
		SportType		INT ,
		BetType			INT
		PRIMARY KEY CLUSTERED (CustID , SportType , BetType)
	)

	--Collect Super FlowBet Setting Sportbook
	INSERT INTO #tmpSuperBetSetting
	SELECT ca.custid  , ca.SportType , ca.BetType
	FROM Customer ci WITH (NOLOCK) 
		INNER JOIN Dep_CustSuper cs WITH (NOLOCK) ON ci.custid = cs.custid
		INNER JOIN Dep_CustBetSettingGame_Agent ca WITH (NOLOCK)
				ON ci.custid = ca.CustID
		INNER JOIN #SportType_BetType_ApplyChanged sb
				ON ca.SportType = sb.SportType AND ca.BetType = sb.BetType
	WHERE 
		ci.username NOT LIKE '3rdSuper%' 
		AND ci.roleid = 4  
		AND ci.currency IN (SELECT ExchangeId FROM #Exchange)							-- Apply Curreny :IN, IN2
		
	
	SELECT COUNT(1) as 'Count_Super' 
	FROM #tmpSuperBetSetting
	
	SELECT c.RoleID , ca.MinBet, COUNT(1) AS 'Count_SMA'
	--ca.CustID , ca.SportType , ca.BetType
	FROM Dep_CustBetSettingGame_Agent ca WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK)					ON ca.CustID = c.custid
			INNER JOIN #tmpSuperBetSetting	cl							ON cl.CustID = c.srecommend AND ca.SportType  = cl.SportType AND ca.BetType = cl.BetType
	WHERE  c.roleid IN (2,3,4)
	AND c.Enabled = 1
	AND ca.MinBet > 10																	-- with licensee having minbet > 10: will adjust to 10 IDR.
	GROUP BY c.RoleID , ca.MinBet
	ORDER BY c.roleid DESC

	


	DROP TABLE #Exchange
	DROP TABLE #SportType_BetType_ApplyChanged
	DROP TABLE #tmpSuperBetSetting
	
	GO

















