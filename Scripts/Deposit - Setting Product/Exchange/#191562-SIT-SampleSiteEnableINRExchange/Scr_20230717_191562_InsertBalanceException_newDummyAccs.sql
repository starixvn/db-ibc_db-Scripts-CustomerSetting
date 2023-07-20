/*<info serverAlias="DBSID-CustDB"></info>*/
/*
	Created: Eden@20230717
	Task: Create Dummy exchange Account for INR - SampleSite [Redmine:#191562]
		Call sp Task_Cust_CheckBalance_Exception_Ins in order to insert Balance exception for new dummy exchange 
	DB: DBSID/CustDB -- all sitedb of deposit
*/
USE CustDB
GO

DECLARE @SiteDBGroupID smallint
--Get Current SiteDBGroupID
IF @@servername <> 'DBSPARE'
BEGIN
	SELECT @SiteDBGroupID = bodb02.dbo.f_Get_SiteDBGroupID()
END

CREATE TABLE #supers (custid INT, currency NVARCHAR(50), Site VARCHAR(20), DummyAgentID INT, DummyAgent varchar(30), DummyExchange varchar(30), DummyExchangeID INT, ErrMsg VARCHAR(200), isfinished bit default(0))
INSERT INTO #supers(custid,currency,Site,DummyAgent)
SELECT ci.custid,ex.currency
	, cs.Site
	, cs.Site + 'ACC' + ex.currency + '01'
FROM customer ci WITH (NOLOCK) 	
	INNER JOIN Dep_custsuper cs WITH (NOLOCK) ON ci.custid = cs.custid
	INNER JOIN exchange ex WITH(NOLOCK) On ex.ExchangeId = ci.currency
WHERE ci.username NOT LIKE '3rdSuper%'
		AND cs.site IN('SampleSite')
		AND Ci.currency IN (61)
		AND ci.roleid = 4
		AND (@@servername = 'DBSPARE' OR cs.SiteDBGroupID = @SiteDBGroupID )--Get data siteDB Only

UPDATE t 
SET t.DummyAgent = ag.username,
	t.DummyAgentID = ag.custid,
	t.DummyExchange =  t.Site + 'Exchange' + t.currency
FROM #supers t 
	INNER JOIN custinfo ag WITH(NOLOCK) 
		ON t.custid = ag.srecommend
WHERE ag.username = t.DummyAgent

IF @@servername <> 'DBSPARE'
BEGIN
UPDATE t 
	SET t.DummyExchangeID = m.custid
	FROM #supers t 
		INNER JOIN DBCUST.custdb.dbo.custinfo m WITH(NOLOCK) --Get realtime (avoid replication latency)
			ON t.custid = m.srecommend
	WHERE m.username = t.DummyExchange
		AND m.recommend = t.DummyAgentID
END
ELSE 
BEGIN
UPDATE t 
	SET t.DummyExchangeID = m.custid
	FROM #supers t 
		INNER JOIN custdb.dbo.custinfo m WITH(NOLOCK)
			ON t.custid = m.srecommend
	WHERE m.username = t.DummyExchange
		AND m.recommend = t.DummyAgentID
END
----------Create Dummy Exchange------------------
DECLARE @DummyExchange VARCHAR(30)
	, @DummyAgentID INT
	, @DummyExchangeID INT
	, @ErrCode INT
	, @ErrMsg NVARCHAR(4000)

WHILE 1 = 1
BEGIN
	UPDATE TOP(1) t
	SET isfinished = 1,
		@DummyExchangeID = t.DummyExchangeID,
		@DummyExchange = t.DummyExchange
	FROM #supers t
	WHERE isfinished = 0
		AND DummyExchangeID IS NOT NULL

	IF @@ROWCOUNT = 0
		BREAK

	IF NOT EXISTS( SELECT 1 FROM bodb02.dbo.Task_Cust_CheckBalance_Exception WITH(NOLOCK) WHERE custid = @DummyExchangeID)
	BEGIN
		--SELECT @DummyExchangeID, @DummyExchange
		EXEC bodb02.dbo.Task_Cust_CheckBalance_Exception_Ins @custid = @DummyExchangeID, @username = @DummyExchange
	END

END

SELECT * 
FROM #supers t 
	LEFT JOIN bodb02.dbo.Task_Cust_CheckBalance_Exception e WITH(NOLOCK) ON t.DummyExchangeID = e.custid

DROP TABLE #supers
