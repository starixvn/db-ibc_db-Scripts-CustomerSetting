/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Helios
	Date: 2023/04/11
	Task: Yibo - Adjust BetLimit For Members With Prefix [redmine : #186718]
	DB: DBCUST/CustDB
	
	Revisions: 
	- Initial Script 
*/


ALTER PROCEDURE [dbo].[Acc_DynamicCustSetting3rd_09]

AS

BEGIN
	SET NOCOUNT ON  

---------------------------------Check Replicate---------------------------------
	IF NOT (dbo.f_CheckRepTable('Dep_CustBetSettingGame_Member') = 1)
		RETURN

---------------------------------COLLECT DATA---------------------------------
CREATE TABLE #Dummy				(CustID INT PRIMARY KEY)	
CREATE TABLE #tmpCust			(CustID INT PRIMARY KEY CLUSTERED, srecommend INT, mrecommend INT, recommend INT,isfinished BIT DEFAULT(0))
CREATE TABLE #tmpSMA			(CustID INT PRIMARY KEY CLUSTERED, RoleID INT, Currency INT, isfinished BIT DEFAULT(0))
CREATE TABLE #tmpCustTemp		(CustID INT PRIMARY KEY, recommend INT)
CREATE TABLE #tmpCustInvid		(CustID INT PRIMARY KEY, recommend INT,isfinished BIT DEFAULT(0))

DECLARE @MaxBet	MONEY , @maxcustid INT
SELECT @MaxBet = 150000 


DECLARE @SportBettype_tbl Table(Sporttype SMALLINT, BetType SMALLINT)
INSERT INTO @SportBettype_tbl(Sporttype,BetType)
SELECT a.SportType,a.BetType
FROM Dep_ProductSettingDetail a WITH(NOLOCK)
	INNER JOIN Dep_ProductSetting b WITH(NOLOCK) ON a.ProductSettingID = b.ProductSettingID
WHERE b.ProductID IN(1) AND SettingType = 10
AND a.SportType IN (1,2)   -- just apply for Soccer & basketball
AND a.BetType = 1
GROUP BY a.SportType,a.BetType

-- Super	
INSERT INTO #tmpSMA(CustID,RoleID, Currency)
SELECT ci.custid, ci.roleid, ci.currency
FROM custInfo ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
WHERE ci.username NOT LIKE '3rdSuper%'
		AND ci.Enabled=1  
		AND (cs.site IN ('Yibo')
		AND ci.currency IN (13))-- RMB
		ORDER BY ci.custid 

INSERT INTO #Dummy(CustID)
SELECT CustID FROM Customer WITH(NOLOCK) 
WHERE srecommend IN (SELECT CustID FROM #tmpSMA)
AND roleid=3 
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

--Existing custMember
INSERT INTO #tmpCust(CustID, srecommend, mrecommend, recommend)
SELECT ci.CustID, ci.srecommend, ci.mrecommend, ci.recommend 
FROM Customer ci WITH (NOLOCK)
	INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
WHERE ci.srecommend IN (SELECT custid FROM #tmpSMA) 
	AND ci.roleid = 1  
	AND c.Enabled = 1 
	AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
	AND (ci.username2 LIKE '%kc221%' OR ci.username2 LIKE '%kc228%')

SET @maxcustid = (SELECT MAX(CustID) FROM #tmpCust)

-- Master, Agent
INSERT INTO #tmpSMA(CustID,RoleID,Currency)
SELECT custid, roleid,Currency
FROM Custinfo WITH (NOLOCK)
WHERE srecommend IN (SELECT custid FROM #tmpSMA) 
AND roleid IN (2,3) 
AND Enabled = 1 
AND mrecommend NOT IN (SELECT custid FROM #Dummy)
AND custid IN (SELECT DISTINCT mrecommend FROM #tmpCust UNION ALL  SELECT DISTINCT recommend FROM #tmpCust)

----member don't existing in Dep_CustBetSettingGame_Member 
INSERT INTO #tmpCustInvid(CustID,recommend)
SELECT ci.CustID,ci.recommend
FROM custInfo ci WITH (NOLOCK)
INNER JOIN #tmpSMA c WITH (NOLOCK) ON ci.recommend = c.CustID AND c.RoleID = 2
INNER JOIN Customer ct WITH (NOLOCK) on ci.CustId = ct.custid
WHERE EXISTS(SELECT TOP 1 1 FROM #tmpCust WITH(NOLOCK) WHERE Custid=ci.CustID)
AND NOT EXISTS(SELECT TOP 1 1 FROM Dep_CustBetSettingGame_Member WITH(NOLOCK) WHERE CustID=ci.custid)
AND ci.roleid = 1  
AND ci.Enabled = 1
AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
AND (ct.username2 LIKE '%kc221%' OR ct.username2 LIKE '%kc228%')

DECLARE @batch int = 1000

--Update existing member Dep_CustBetSettingGame_Member
WHILE EXISTS(SELECT TOP 1 1 FROM #tmpCust WHERE isfinished = 0)
BEGIN
	UPDATE TOP (@batch) #tmpCust 
	SET isfinished = 1
	OUTPUT DELETED.CustID INTO #tmpCustTemp(CustID)
	WHERE isfinished = 0

	IF @@ROWCOUNT=0
		BREAK		

	UPDATE cg SET cg.MaxBet = @MaxBet
	FROM dbo.Dep_CustBetSettingGame_Member cg WITH(ROWLOCK)	
		CROSS APPLY @SportBettype_tbl b
		INNER JOIN #tmpCustTemp  t 
			ON cg.CustID=t.CustID AND cg.SportType=b.Sporttype AND cg.BetType=b.Bettype

	TRUNCATE TABLE #tmpCustTemp
END


---- member don't exist in Dep_CustBetSettingGame_Member

WHILE EXISTS(SELECT TOP 1 1 FROM #tmpCustInvid WHERE isfinished = 0)
BEGIN
	UPDATE TOP (@batch)  a
	SET isfinished = 1
	OUTPUT DELETED.CustID,DELETED.recommend INTO #tmpCustTemp(CustID,recommend)
	FROM #tmpCustInvid a
	WHERE isfinished = 0


	IF @@ROWCOUNT=0
		BREAK		

	--Update Dep_CustSettingMode
	UPDATE c 
	SET IsGroupedBetLimit = 0
	FROM Dep_CustSettingMode c WITH(ROWLOCK,UPDLOCK)
		INNER JOIN #tmpCustTemp t ON c.CustID = t.CustID

	--Insert values for member don't exist in Game_Member from Upline
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
	SELECT t.custID,
		cg.SportType,
		cg.BetType,
		cg.MinBet,
		cg.MaxBet,
		cg.MaxPerMatch,
		cg.MaxPerNumber,
		cg.MaxPayoutPerMatch
	FROM dbo.Dep_CustBetSettingGame_Agent cg WITH(ROWLOCK)	
		INNER JOIN #tmpCustTemp t ON cg.CustID=t.recommend 
	
	TRUNCATE TABLE #tmpCustTemp
END


-- Update MaxBet 
UPDATE a 
SET  a.MaxBet = @MaxBet
FROM Dep_CustBetSettingGame_Member a WITH(ROWLOCK, UPDLOCK)
	CROSS APPLY @SportBettype_tbl b
	INNER JOIN #tmpCustInvid c ON a.CustID = c.CustID AND a.SportType = b.Sporttype AND a.BetType = b.BetType


-- Check MaxCust with NewMaxCust with Prefix kc221 & kc228 

DECLARE @msg NVARCHAR(200) = 'Pass. Currently MaxCustID: %d.'

IF @maxcustid < (
		SELECT MAX(ci.CustID)
		FROM Customer ci WITH (NOLOCK)
			INNER JOIN custInfo c WITH (NOLOCK) ON ci.custid = c.custid
		WHERE ci.srecommend IN (SELECT custid FROM #tmpSMA) 
			AND ci.roleid = 1  
			AND c.Enabled = 1 
			AND ci.mrecommend NOT IN (SELECT custid FROM #Dummy)
			AND (ci.username2 LIKE '%kc221%' OR ci.username2 LIKE '%kc228%')
)
	Print N'Has new member with prefix kc221 & kc228 !'
Else
	RAISERROR (@msg, 0, 1, @maxcustid) WITH NOWAIT

DROP TABLE #Dummy
DROP TABLE #tmpCust
DROP TABLE #tmpSMA
DROP TABLE #tmpCustTemp
DROP TABLE #tmpCustInvid


END
GO
--END STEP 1: DEPLOY THIS SP @DBCUST.CustDB --------

EXEC [Acc_DynamicCustSetting3rd_09]

