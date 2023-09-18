/*<info serverAlias="DBTXN-CustDB"></info>*/
/*
	Created: 20230918@Eden
	Task: Correct Wrong site( 789y) on DBTXN/SiteDB [#RedmineID:#181595]
	DB: DBTXN/CustDB 
*/

CREATE TABLE #Cust(CustID INT,Site VARCHAR(10))

--> Get wrong data 
INSERT INTO #Cust(CustID)
SELECT c.custid
FROM dbo.vw_Customer c WITH (NOLOCK)
	INNER JOIN dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
WHERE c.site in ('789y')

--> get correct Site from DBCUST
UPDATE t 
SET t.Site = s.site
FROM #cust t
	INNER JOIN dbcust.custdb.dbo.vw_Customer S WITH (NOLOCK) 
		ON t.custid = S.custid

--> Update wrong data
UPDATE c 
SET c.Site = t.site
FROM #cust t
	INNER JOIN dbo.Customer c WITH (ROWLOCK,UPDLOCK) 
		ON t.custid = c.custid

DROP TABLE #cust