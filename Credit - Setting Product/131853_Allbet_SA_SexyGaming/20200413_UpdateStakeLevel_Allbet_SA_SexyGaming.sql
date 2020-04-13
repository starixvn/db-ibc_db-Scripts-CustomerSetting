/*
	Created: 20200413@Tiara
	Date: 20200413
	Task: Update betlimit for Allbet, SA, Sexy Gaming [Redmine: #131853]
	DB: DBCUST/CustDB
*/ 
ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
AS
BEGIN
	SET NOCOUNT ON
	
	IF dbo.f_CheckRepTable('CustInfo') = 0 RETURN
	IF dbo.f_CheckRepTable('Customer') = 0 RETURN
	IF dbo.f_CheckRepTable('StakeLevel') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Agent') = 0 RETURN
	IF dbo.f_CheckRepTable('CustStakeLevel_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('ProductSettingDetail') = 0 RETURN	

	CREATE TABLE #supers (CustID INT, Currency INT)

	INSERT INTO #supers(CustID, Currency)

	SELECT ci.custid, ci.currency
	FROM customer ci WITH (NOLOCK) 
		INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
		LEFT JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	WHERE ci.roleid = 4  
		AND ci.username NOT LIKE '3rdSuper%'
		AND cs.isinternal = 0
		AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
		AND s.islicensee = 0
		AND ci.Site NOT IN ('CN88', '789y')
		AND ci.currency IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')

	CREATE TABLE #DirectSMA
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT,
		Currency INT
	)
		
	INSERT INTO #DirectSMA (CustID,roleid, Currency) --Master, Agent
	SELECT DISTINCT ci.custid, ci.roleid, ci.currency
	FROM Custinfo ci WITH (NOLOCK) INNER JOIN #supers s WITH (NOLOCK) ON ci.srecommend = s.custid
	WHERE  EXISTS (SELECT custid from dbo.CustDirectAccount WITH(NOLOCK) WHERE CustID = ci.custid)
		AND ci.Enabled=1
		AND ci.roleid IN (2,3)
	
	INSERT INTO #DirectSMA (CustID,roleid, Currency) --Dummy Master
	SELECT DISTINCT ci.custid, ci.roleid, ci.currency
	FROM Custinfo ci WITH (NOLOCK) INNER JOIN #DirectSMA D WITH (NOLOCK) ON ci.mrecommend = D.custid
	WHERE  ci.Enabled=1
		AND ci.roleid IN (3)
		AND CI.custid != D.CustID

	--Create Stakelevelid that need to be updated for each sport
	CREATE TABLE #StakeLevelID_Update
	(
		StakeLevelID INT,
		GameTypeID INT,
		ExchangeId INT
	)
	
	INSERT INTO #StakeLevelID_Update (StakeLevelID, GameTypeID, ExchangeId)
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel S WITH(NOLOCK)
	WHERE exchangeid = S.ExchangeId
		AND GameTypeID = 2401
		AND MinStake = 100
		AND MaxStake = 50000
	UNION ALL
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel S WITH(NOLOCK)
	WHERE exchangeid = S.ExchangeId
		AND GameTypeID = 3001
		AND MinStake = 2000
		AND MaxStake = 50000
	UNION ALL
	SELECT StakeLevelID, GameTypeID, ExchangeId
	FROM dbo.StakeLevel S WITH(NOLOCK)
	WHERE exchangeid = S.ExchangeId
		AND GameTypeID = 3101
		AND MinStake = 50
		AND MaxStake = 50000

	IF @@ROWCOUNT =0 RETURN	
	--Update Super
	UPDATE C
	SET C.StakeLevelList = ISNULL((C.StakeLevelList+','+CAST(S.StakeLevelID AS VARCHAR(10))),'')
	FROM CustStakeLevel_Agent C WITH (UPDLOCK,ROWLOCK) INNER JOIN #StakeLevelID_Update S WITH (NOLOCK) ON C.BetType = S.GameTypeID
		INNER JOIN #supers D WITH (NOLOCK) ON D.CustID = C.CustID AND D.Currency = S.ExchangeId
	WHERE C.BetType IN (2401, 3001, 3101)

	--Update Direct Master, Agent
	UPDATE C
	SET C.StakeLevelList = ISNULL((C.StakeLevelList+','+CAST(S.StakeLevelID AS VARCHAR(10))),'')
	FROM CustStakeLevel_Agent C WITH (UPDLOCK,ROWLOCK) INNER JOIN #StakeLevelID_Update S WITH (NOLOCK) ON C.BetType = S.GameTypeID
		INNER JOIN #DirectSMA D WITH (NOLOCK) ON D.CustID = C.CustID AND D.Currency = S.ExchangeId
	WHERE C.BetType IN (2401, 3001, 3101)
	
	DROP TABLE #DirectSMA
	DROP TABLE #StakeLevelID_Update
	DROP TABLE #supers

END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT DBCUST SERVERS -----
--------------------------------------------------------------------------------------
PRINT N'Step 10: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'

EXEC dbo.Acc_DynamicCustSetting3rd_09

PRINT N'Step 10: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'