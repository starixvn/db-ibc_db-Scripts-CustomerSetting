/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240620@Johnson
	Task: Migrate data for bet setting SB [redmine: #199915]
	DB: DBCUST-CustDB
*/

DECLARE @max_custid INT, @srecommend INT

SELECT @max_custid = xxx

CREATE TABLE #Supers(CustID	INT PRIMARY KEY,
					IsFinished BIT DEFAULT 0			
					)

INSERT INTO #Supers (custid)
SELECT cu.custid
FROM Customer cu WITH (NOLOCK)
	INNER JOIN custinfo ci WITH(NOLOCK) ON ci.custid = cu.custid
	INNER JOIN site s WITH (NOLOCK) ON cu.site = s.site
	INNER JOIN exchange e WITH (NOLOCK)	ON cu.currency = e.ExchangeId
										AND e.IsActive = 1
										AND e.OfferSite IN (0 , 1)
	LEFT JOIN CustSuper cs WITH (NOLOCK) ON cu.custid = cs.custid
WHERE cu.roleid = 4
	AND ci.Enabled = 1
	AND cu.currency = 20
	AND s.isLicensee = 0
	AND s.IsActive = 1
	AND cu.username NOT LIKE '3rdSuper%'
	AND cs.IsInternal = 0
	AND cu.custid NOT IN (SELECT custid FROM Dep_CustSuper WITH (NOLOCK))

CREATE TABLE #tblCust (custid INT PRIMARY KEY, roleid TINYINT)
DECLARE @tmpCust TABLE (custid INT PRIMARY KEY)

INSERT INTO #tblCust(custid,roleid)
SELECT custid, roleid 
FROM custinfo WITH(NOLOCK)
WHERE srecommend IN (SELECT custid FROM #supers)
	AND Enabled = 1
	AND custid > @max_custid

WHILE(1=1)
BEGIN
	;WITH tmp AS (
		SELECT TOP(200) custid
		FROM #tblCust
		WHERE roleid > 1
		ORDER BY roleid DESC
	)
	DELETE tmp
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	INSERT INTO [dbo].[BetSetting_Agent]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,[RepUpdateTime])
	SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,SYSDATETIME()
	FROM CustBetSetting_Agent WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype NOT IN (161,164)
	
	DELETE @tmpCust	
	
	WAITFOR DELAY '00:00:00.280'
END

WHILE(1=1)
BEGIN
	;WITH tmp AS (
		SELECT TOP(200) custid
		FROM #tblCust
		WHERE roleid = 1
		ORDER BY roleid DESC
	)
	DELETE tmp
	OUTPUT DELETED.custid INTO @tmpCust(custid)
	
	IF @@ROWCOUNT = 0
		BREAK;
	
	INSERT INTO [dbo].[BetSetting_Member]
	   ([CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,[RepUpdateTime])
	SELECT [CustID]
	   ,[SportType]
	   ,[BetType]
	   ,[MinBet]
	   ,[MaxBet]
	   ,[MaxPerMatch]
	   ,[MaxPayoutPerMatch]
	   ,SYSDATETIME()
	FROM CustBetSetting_Member WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM @tmpCust)
		AND sporttype NOT IN (161,164)
		
	DELETE @tmpCust	
	
	WAITFOR DELAY '00:00:00.280'
END	