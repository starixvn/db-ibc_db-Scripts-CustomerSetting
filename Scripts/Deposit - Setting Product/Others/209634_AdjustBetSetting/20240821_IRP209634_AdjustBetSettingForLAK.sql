/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240821@Johnson
	Task: [All licensees] - Adjust LAK minbet for SB, NG, VS [Redmine: #209634]
	DB: DBCust/CustDB
*/
CREATE TABLE #Supers(CustID INT PRIMARY KEY, isfinished BIT DEFAULT 0)
CREATE TABLE #tblCust(custid INT PRIMARY KEY, roleid TINYINT)
CREATE TABLE #Dummy(CustID INT PRIMARY KEY)

INSERT INTO #Supers(custid)
SELECT cs.custid
FROM dbo.Dep_CustSuper cs WITH(NOLOCK)
	INNER JOIN bodb_licensee.dbo.Licensees l WITH (NOLOCK) ON l.LicenseeName = cs.site
WHERE  l.IsActive = 1
	AND cs.username NOT LIKE '3rdSuper%'
	AND cs.currency = 93 --LAK
	
INSERT INTO #Dummy(CustID)
SELECT c.CustID 
FROM Customer c WITH(NOLOCK) 
	INNER JOIN #Supers s WITH (NOLOCK) ON s.CustID=c.srecommend
WHERE c.roleid=3 	
	AND (username LIKE '%Acc%' OR username LIKE '%LocalBank%' OR username LIKE '%AFF%' OR username LIKE 'AB88'+'CAS%')

DECLARE @custid INT

WHILE(1=1)
BEGIN
	UPDATE TOP (1) t
	SET isFinished = 1,
		@custid = custid
	FROM #supers t
	WHERE isFinished = 0
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	--downlines < 400
	INSERT INTO #tblCust(custid,roleid)
	SELECT	custid, roleid
	FROM custinfo ci WITH(NOLOCK)
	WHERE srecommend = @custid
		AND  mrecommend NOT IN (SELECT custid FROM #Dummy)
		AND (ci.username not like '%ClearBal' and ci.username not like '%CashOut' and ci.username not like '%OddsAdj')

	--Update SB, NG			
	UPDATE cs
	SET minbet = 30
	FROM Dep_CustBetSettingGame_Agent cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
		AND minbet < 30 
		AND minbet NOT IN (0,0.1)
	
	UPDATE cs
	SET minbet = 30
	FROM Dep_CustBetSettingGameGroup_Member cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.AgentID IN (SELECT custid FROM #tblCust WHERE roleid = 2)
		AND minbet < 30 
		AND minbet NOT IN (0,0.1)	
	
	UPDATE cs
	SET minbet = 30
	FROM Dep_CustBetSettingGame_Member cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.custid IN (SELECT t.custid 
						FROM #tblCust t
							INNER JOIN Dep_CustSettingMode c WITH(NOLOCK) ON c.custid = t.CustID
						WHERE roleid =1	
							AND ISNULL(c.IsGroupedBetLimit,0) = 0
						)
		AND minbet < 30 
		AND minbet NOT IN (0,0.1)
		
	--Update VS
	UPDATE cs
	SET minbet = 30
	FROM Dep_CustBetSetting_Agent cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid IN (2,3,4))
		AND sporttype = 9908
		AND minbet < 30 
		AND minbet NOT IN (0,0.1)
	
	UPDATE cs
	SET minbet = 30
	FROM Dep_CustBetSetting_Member cs WITH(UPDLOCK,ROWLOCK)
	WHERE cs.custid IN (SELECT custid FROM #tblCust WHERE roleid = 1)
		AND sporttype = 9908
		AND minbet < 30 
		AND minbet NOT IN (0,0.1)	
		
	DELETE #tblCust	
END	