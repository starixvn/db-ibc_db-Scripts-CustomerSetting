/*<info serverAlias="DBSIG-bodb02"></info>*/
/*
	Created: 20221107@Johnson
	Task: Migrate CWL balance data back to DBTXN from SiteDB1 [#RedmineID:#180033]
	DB: DBSIG/bodb02 (sitedb1)
*/

CREATE TABLE #tmp_cust
		(
			custid INT PRIMARY KEY
		)
		
------------------------------------------------
INSERT INTO #tmp_cust (custid)
SELECT DISTINCT custid
FROM CustDB.dbo.Customer WITH (NOLOCK)
WHERE site IN ('Betway')
	and roleid = 1
	
IF NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingCreditGame WITH(NOLOCK) 
				WHERE custid IN(SELECT custid FROM #tmp_cust))
	AND NOT EXISTS (SELECT TOP (1) 1 FROM dbo.BalancePendingDebitGame WITH(NOLOCK)
					WHERE custid IN(SELECT custid FROM #tmp_cust))
BEGIN			
	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDB01tmp.dbo.Winlimit_CreditGame_20221115
	FROM dbo.Winlimit_CreditGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)

	SELECT [custid],[winlostdate],[Winlost],[bettype]
	INTO SiteDB01tmp.dbo.Winlimit_DebitGame_20221115
	FROM dbo.Winlimit_DebitGame WITH(NOLOCK)
	WHERE custid IN (SELECT custid FROM #tmp_cust)	
END
