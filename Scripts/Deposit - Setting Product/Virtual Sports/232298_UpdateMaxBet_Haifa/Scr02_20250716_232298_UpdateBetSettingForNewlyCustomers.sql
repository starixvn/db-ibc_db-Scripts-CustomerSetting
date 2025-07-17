/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250716@Tacy
	Task: [Haifa] - Adjust maxbet & maxpermatch for Virtual Sports [Redmine: #232298]
	DB: DBCust/CustDB
*/
DECLARE @target VARCHAR(20)
		,@max_custid INT
		,@CustList   XML
		,@BatchSize	INT = 1000
		,@srecommend INT = 4359240 -- HAIFASuperRMB

DECLARE @SportType		SMALLINT = 9908
		,@betType		SMALLINT = 1201
		,@MaxBet		MONEY = 3000
		,@MaxPerMatch	MONEY = 10000
		,@MinBet		MONEY = 10

SELECT @max_custid = xxx

CREATE TABLE #Dummy	(CustID INT PRIMARY KEY)
CREATE TABLE #SMAs (CustID INT PRIMARY KEY, RoleID TINYINT)
CREATE TABLE #Members (CustID INT PRIMARY KEY)
CREATE TABLE #BatchCust (CustID INT PRIMARY KEY)

--Dummy line
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
WHERE c.roleid=3 
	AND c.srecommend = @srecommend	
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--SMAs
INSERT INTO #SMAs (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid > @max_custid
	AND c.roleid IN (2,3,4)
	AND c.Enabled=1
	
--Members
INSERT INTO #Members (CustID)
SELECT c.custid
FROM dbo.CustInfo c WITH(NOLOCK)
WHERE mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND c.srecommend = @srecommend
	AND c.custid > @max_custid
	AND (c.username not like '%ClearBal' and c.username not like '%CashOut' and c.username not like '%OddsAdj' and c.username not like '%OddsBoostAdj')
	AND c.roleid = 1
	AND c.Enabled=1	
	
--Update SMAs
UPDATE cs
SET cs.MaxBet	= @MaxBet,
	cs.MaxPerMatch = @MaxPerMatch,
	cs.MinBet = @MinBet,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM dbo.Dep_CustBetSetting_Agent cs WITH(ROWLOCK, UPDLOCK)
WHERE custid IN (SELECT custid FROM #SMAs)
	AND SportType = @SportType
	AND Bettype = @Bettype	
	

WHILE (1=1)
BEGIN	
	DELETE FROM #BatchCust

	DELETE TOP (@BatchSize) T
	OUTPUT deleted.CustID
		INTO #BatchCust(CustID)
	FROM #Members t 
	
	IF @@ROWCOUNT = 0
		BREAK;
		
	UPDATE cs
	SET cs.MaxBet = @MaxBet,
		cs.MaxPerMatch = @MaxPerMatch,
		cs.MinBet = @MinBet,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM dbo.Dep_CustBetSetting_Member cs WITH(ROWLOCK, UPDLOCK)
	WHERE custid IN (SELECT custid FROM #BatchCust)
		AND SportType = @SportType
		AND Bettype = @Bettype	
	
	WAITFOR DELAY '00:00:0.050'
END	

DROP TABLE #Dummy
DROP TABLE #SMAs
DROP TABLE #Members
DROP TABLE #BatchCust
GO