/*
	Created: Tiara	
	Task: Set default Bet setting for customers under 789y Headline- DCS Products- RedmineID: #124311
	DB: DBCUST/CustDB
	Date: 20191223
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

	IF dbo.f_CheckRepTable('CustBetSetting3rd_Member') = 0 RETURN
	IF dbo.f_CheckRepTable('CustBetSetting3rd_Agent') = 0 RETURN


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
	
CREATE TABLE #SportBettypeFilterBetSetting
(
	Productid INT,
	SportType INT,
	Bettype INT
)

INSERT INTO #SportBettypeFilterBetSetting (Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,2) AS F

INSERT INTO #SportBettypeFilterBetSetting(Productid,SportType,Bettype)
SELECT P.Productid,SportType,Bettype
FROM #ProductID P CROSS APPLY dbo.f_CustSetting_SportBetTypeSettingSelect(P.Productid,9) AS F

--SMA Level
CREATE TABLE #SMATemp
(
	CustID INT PRIMARY KEY CLUSTERED,
	roleid TINYINT,
)

INSERT INTO #SMATemp (CustID, roleid)
SELECT DISTINCT CI.CustID, roleid
FROM custInfo CI INNER JOIN CustBetSetting3rd_Agent C WITH (NOLOCK) ON C.CustID = CI.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterBetSetting B WITH (NOLOCK) ON C.SportType = B.SportType AND C.BetType = B.Bettype 
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) 
	OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) 
	OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
	AND roleid IN (2,3,4)
	AND CI.Enabled = 1
	AND CI.custid <= @maxcustid
	AND srecommend = @srecommend
	
--Member Level

CREATE TABLE #MemberTemp
(
	CustID INT PRIMARY KEY CLUSTERED,
)

SELECT DISTINCT CI.CustID, currency
FROM custInfo CI INNER JOIN CustBetSetting3rd_Member C WITH (NOLOCK) ON C.CustID = CI.CustID 
	CROSS JOIN ProductStatusProfile P WITH (NOLOCK) 
	INNER JOIN #SportBettypeFilterBetSetting B WITH (NOLOCK) ON C.SportType = B.SportType AND C.BetType = B.Bettype 
WHERE ((C.MinBet = 0.1 AND C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1) 
	OR (C.MinBet = 0 AND C.MaxBet = 0 AND C.MaxPerMatch = 0) 
	OR (C.MaxBet = 0.1 AND C.MaxPerMatch = 0.1)) 
	AND roleid = 1
	AND CI.Enabled = 1
	AND CI.custid <= @maxcustid
	AND srecommend = @srecommend

DECLARE @Currency INT
SELECT @Currency = currency FROM customer WITH (NOLOCK) WHERE custid = @srecommend
--------------------------------------Bet Setting-------------------------------------------------

--Update AGENT
UPDATE C
SET MinBet= (CASE WHEN S.roleid = 4 THEN ps.DefaultMinBet ELSE X END),
			 MaxBet =(CASE WHEN S.roleid = 4 THEN ps.DefaultMaxBet ELSE X END), 
			MaxPerMatch = (CASE WHEN S.roleid = 4 THEN ps.DefaultMaxPerMatch ELSE X END)
FROM CustBetSetting3rd_Agent C WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #SMATemp S WITH (NOLOCK) ON S.CustID = C.CustID
	CROSS APPLY #SportBettypeFilterBetSetting SB WITH (NOLOCK)
	INNER JOIN ProductBetSetting PS WITH (NOLOCK) ON PS.Sporttype = SB.SportType AND PS.Bettype = SB.Bettype
WHERE PS.Currency = @Currency

--Update MEMBER
UPDATE C
SET MinBet = X, MaxBet = X, MaxPerMatch = X
FROM CustBetSetting3rd_Member C WITH (ROWLOCK, UPDLOCK)
	INNER JOIN #MemberTemp M WITH (NOLOCK) ON M.CustID = C.CustID
	CROSS APPLY #SportBettypeFilterBetSetting SB WITH (NOLOCK)


--Drop all temp tables
DROP TABLE #ProductID
DROP TABLE #SportBettypeFilterBetSetting
DROP TABLE #SMATemp
DROP TABLE #MemberTemp

END
GO
-- END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------
------------------------------------------------------	

-- BEGIN STEP 2: RUN THIS SCRIPT AT ALL REPLICATED SERVERS -----
--------------------------------------------------------------------------------------

DECLARE @max_custid INT, @srecommend INT

--Create Supers temp table:

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
			
			
	waitfor delay '00:00:0.200'
END
GO

-- BEGIN STEP 3: RUN THIS SCRIPT AT DBCUST -----
--------------------------------------------------------------------------------------
PRINT N'Step 2: Start on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.';  
DECLARE @max_custid INT, @srecommend INT

--Create Supers temp table:

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
			
			
	waitfor delay '00:00:0.200'
END
PRINT N'Step 2: End on ' + CAST(GETDATE() AS NVARCHAR(30)) + N'.'; 

--Drop all temp tables
DROP TABLE #supers