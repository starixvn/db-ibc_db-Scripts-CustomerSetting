/*
	Created: Tiara	
	Task: Set default Winloss limit for customers under 789y Headline- DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191230
*/ 

ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]
	@srecommend INT	
	,@maxcustid INT
	,@target VARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON
	
	IF (@target = 'REPLICATED' AND @@SERVERNAME = 'DBCUST') RETURN	-- run at all replicated servers
	IF (@target = 'DBCUST' AND @@SERVERNAME <> 'DBCUST') RETURN -- run at dbtrans only

	IF dbo.f_CheckRepTable('CustWinLossLimit_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustWinLossLimit_Agent') = 0 RETURN
	

	CREATE TABLE #ProductID
(
	Productid INT
)

	INSERT INTO #ProductID(Productid) 
		SELECT 5 UNION ALL
		SELECT 21 UNION ALL
		SELECT 22 UNION ALL
		SELECT 24 UNION ALL
		SELECT 28 UNION ALL
		SELECT 23
	
	CREATE TABLE #SportBettypeFilterSetting
	(
		Productid INT,
		SportType INT,
		Bettype INT
	)

	INSERT INTO #SportBettypeFilterSetting (Productid,SportType,Bettype)
	SELECT P.Productid,SportType,Bettype
	FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,6) AS F


	CREATE TABLE #MemberTemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
	)

	CREATE TABLE #SMATemp
	(
		CustID INT PRIMARY KEY CLUSTERED,
		roleid TINYINT
	)
		
	INSERT INTO #SMATemp (CustID, roleid)
	SELECT custid, roleid
	FROM Custinfo C WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid IN (2,3,4) 
		AND Enabled = 1 
		AND custid <= @maxcustid 
	
	INSERT INTO #MemberTemp (CustID)
	SELECT custid
	FROM Custinfo WITH (NOLOCK)
	WHERE srecommend = @srecommend 
		AND roleid = 1  
		AND Enabled = 1 
		AND custid <= @maxcustid
			

	DECLARE @Currency INT
	SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend

	----------------------------------------Win Loss Limit------------------------------------
	--Update agents
	UPDATE C
	SET C.MaxWinLimit = X, C.MaxLossLimit = X
	FROM CustWinLossLimit_Agent C WITH (ROWLOCK, UPDLOCK) 
		INNER JOIN #SMATemp S WITH (NOLOCK) ON S.CustID = C.CustId
		CROSS APPLY #SportBettypeFilterSetting WITH (NOLOCK)
		CROSS APPLY dbo.LossLimit_GlobalSetting CS WITH(NOLOCK)
	WHERE CS.ExchangeId = @Currency 
		AND C.MaxLossLimit = 0 
		AND C.MaxWinLimit = 0
	
	--Update members
	UPDATE C
	SET C.MaxWinLimit = X, C.MaxLossLimit = X
	FROM CustWinLossLimit_Member C WITH (ROWLOCK, UPDLOCK) 
		INNER JOIN #MemberTemp S WITH (NOLOCK) ON S.CustID = C.CustId
		CROSS APPLY #SportBettypeFilterSetting WITH (NOLOCK)
		CROSS APPLY dbo.LossLimit_GlobalSetting CS WITH(NOLOCK)
	WHERE CS.ExchangeId = @Currency
		AND C.MaxLossLimit = 0 
		AND C.MaxWinLimit = 0
	
	--Drop all temp tables
	DROP TABLE #SMATemp
	DROP TABLE #MemberTemp
	DROP TABLE #ProductID
	DROP TABLE #SportBettypeFilterSetting
	
END
GO

-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------
--Create Supers temp table:
DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20

		
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.280'
END

--Drop all temp tables
DROP TABLE #supers
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 4: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 
DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

CREATE TABLE #supers (custid int,isfinished bit default(0))

INSERT INTO #supers(custid)
SELECT ci.custid
FROM customer ci WITH (NOLOCK) 
	INNER JOIN site s WITH (NOLOCK) ON ci.site = s.site
	INNER JOIN custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.roleid = 4  
			AND ci.username NOT LIKE '3rdSuper%'
			AND ci.site IN ('789y')
			AND ci.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH(NOLOCK))
			AND s.islicensee = 0
			AND ci.currency <> 20
			
-- For deployer info
DECLARE @super_cnt INT, @index INT = 0
DECLARE @msg NVARCHAR(200) = 'Currently at order %d, SuperID: %d.'
DECLARE @msg_total NVARCHAR(200) = 'Total of supers: %d.'

SET @super_cnt = (SELECT COUNT(*) FROM #supers )
RAISERROR (@msg_total, 0, 1, @super_cnt) WITH NOWAIT

WHILE (1 = 1)
BEGIN
	UPDATE TOP (1) #Supers
	SET isfinished = 1
		,@srecommend = custid	
	WHERE isfinished = 0
	
	IF @@ROWCOUNT = 0 BREAK
	
	SET @index = @index + 1
	RAISERROR (@msg, 0, 1, @index, @srecommend) WITH NOWAIT

	EXEC dbo.Acc_DynamicCustSetting3rd_09 @srecommend = @srecommend
			,@maxcustid = @max_custid
			,@target = 'REPLICATED'
						
	waitfor delay '00:00:0.280'
END
PRINT N'Step 4: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

--Drop all temp tables
DROP TABLE #supers
GO
